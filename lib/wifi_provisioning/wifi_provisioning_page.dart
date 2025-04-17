import 'dart:async';
import 'dart:convert';

import 'package:espressif_provisioning/espressif_provisioning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class WiFiProvisioningPage extends StatefulWidget {
  const WiFiProvisioningPage({Key? key}) : super(key: key);

  static String routeName = 'WiFiProvisioning';
  static String routePath = '/wifi_provisioning';

  @override
  _WiFiProvisioningPageState createState() => _WiFiProvisioningPageState();
}

class _WiFiProvisioningPageState extends State<WiFiProvisioningPage> {
  // BLE scan results
  final List<ScanResult> _scanResults = [];
  
  // ESP32 device (when found)
  ScanResult? _selectedDevice;
  
  // EspProv instance for WiFi provisioning
  EspProv? _espProv;
  
  // WiFi networks found by ESP32
  List<WiFiAccessPoint> _wifiNetworks = [];
  
  // Selected WiFi network
  WiFiAccessPoint? _selectedNetwork;
  
  // WiFi password controller
  final TextEditingController _passwordController = TextEditingController();
  
  // Page state
  bool _isScanning = false;
  bool _isConnecting = false;
  bool _isProvisioning = false;
  bool _isProvisioningComplete = false;
  bool _isWifiScanning = false;
  String _statusMessage = 'Ready to scan for ESP32 devices';
  String? _errorMessage;
  
  // Connection status
  String? _deviceIp;
  
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }
  
  @override
  void dispose() {
    _passwordController.dispose();
    _disconnectFromDevice();
    super.dispose();
  }
  
  // Check and request necessary permissions
  Future<void> _checkPermissions() async {
    bool hasBluetoothPermission = await Permission.bluetooth.isGranted && 
                                  await Permission.bluetoothScan.isGranted && 
                                  await Permission.bluetoothConnect.isGranted;
    
    if (!hasBluetoothPermission) {
      await Permission.bluetooth.request();
      await Permission.bluetoothScan.request();
      await Permission.bluetoothConnect.request();
    }
    
    bool hasLocationPermission = await Permission.location.isGranted;
    if (!hasLocationPermission) {
      await Permission.location.request();
    }
  }
  
  // Start scanning for BLE devices
  Future<void> _startScan() async {
    if (_isScanning) return;
    
    setState(() {
      _scanResults.clear();
      _selectedDevice = null;
      _isScanning = true;
      _statusMessage = 'Scanning for ESP32 devices...';
      _errorMessage = null;
    });
    
    try {
      FlutterBluePlus.startScan(
        timeout: Duration(seconds: 10),
        androidUsesFineLocation: true,
      );
      
      FlutterBluePlus.scanResults.listen((results) {
        setState(() {
          _scanResults.clear();
          for (ScanResult result in results) {
            if (result.device.platformName.contains('ESP32')) {
              _scanResults.add(result);
            }
          }
        });
      });
      
      await Future.delayed(Duration(seconds: 10));
      
      await FlutterBluePlus.stopScan();
      
      setState(() {
        _isScanning = false;
        if (_scanResults.isEmpty) {
          _statusMessage = 'No ESP32 devices found';
        } else {
          _statusMessage = 'Found ${_scanResults.length} ESP32 devices';
        }
      });
    } catch (e) {
      setState(() {
        _isScanning = false;
        _errorMessage = 'Error scanning for devices: $e';
        _statusMessage = 'Scan failed';
      });
    }
  }
  
  // Connect to selected ESP32 device
  Future<void> _connectToDevice(ScanResult scanResult) async {
    if (_isConnecting) return;
    
    setState(() {
      _selectedDevice = scanResult;
      _isConnecting = true;
      _statusMessage = 'Connecting to ${scanResult.device.platformName}...';
      _errorMessage = null;
    });
    
    try {
      await scanResult.device.connect(timeout: Duration(seconds: 15));
      
      List<BluetoothService> services = await scanResult.device.discoverServices();
      
      // Create ESP provisioning client
      // Default proof of possession (pop) is often "abcd1234"
      _espProv = EspProv(
        transport: BleTransport(scanResult.device),
        security: Security1(pop: 'abcd1234'),
      );
      
      // Establish session
      bool established = await _espProv!.establishSession();
      
      if (established) {
        setState(() {
          _isConnecting = false;
          _statusMessage = 'Connected to ESP32, ready to scan WiFi networks';
        });
      } else {
        throw Exception('Failed to establish provisioning session');
      }
    } catch (e) {
      _disconnectFromDevice();
      setState(() {
        _isConnecting = false;
        _errorMessage = 'Connection error: $e';
        _statusMessage = 'Connection failed';
        _espProv = null;
      });
    }
  }
  
  // Disconnect from ESP32 device
  Future<void> _disconnectFromDevice() async {
    if (_selectedDevice != null) {
      try {
        await _selectedDevice!.device.disconnect();
      } catch (e) {
        print('Error disconnecting: $e');
      }
    }
    
    setState(() {
      _selectedDevice = null;
      _espProv = null;
      _wifiNetworks = [];
      _selectedNetwork = null;
      if (!_isProvisioningComplete) {
        _statusMessage = 'Disconnected from ESP32';
      }
    });
  }
  
  // Scan for WiFi networks using the ESP32 device
  Future<void> _scanWifiNetworks() async {
    if (_espProv == null || _isWifiScanning) return;
    
    setState(() {
      _isWifiScanning = true;
      _wifiNetworks = [];
      _selectedNetwork = null;
      _statusMessage = 'Scanning for WiFi networks...';
      _errorMessage = null;
    });
    
    try {
      final wifiList = await _espProv!.startScanWiFi();
      
      setState(() {
        _isWifiScanning = false;
        _wifiNetworks = wifiList;
        if (_wifiNetworks.isEmpty) {
          _statusMessage = 'No WiFi networks found';
        } else {
          _statusMessage = 'Found ${_wifiNetworks.length} WiFi networks';
        }
      });
    } catch (e) {
      setState(() {
        _isWifiScanning = false;
        _errorMessage = 'Error scanning WiFi networks: $e';
        _statusMessage = 'WiFi scan failed';
      });
    }
  }
  
  // Provision WiFi credentials to the ESP32 device
  Future<void> _provisionWifi() async {
    if (_espProv == null || _selectedNetwork == null || _isProvisioning) return;
    
    final String ssid = _selectedNetwork!.ssid;
    final String password = _passwordController.text;
    
    setState(() {
      _isProvisioning = true;
      _statusMessage = 'Sending WiFi credentials to ESP32...';
      _errorMessage = null;
    });
    
    try {
      // Send WiFi credentials to ESP32
      await _espProv!.sendWifiConfig(ssid: ssid, password: password);
      
      // Apply the configuration
      await _espProv!.applyWifiConfig();
      
      // Wait for connection and get status
      bool connected = false;
      int retries = 0;
      
      while (!connected && retries < 20) {
        await Future.delayed(Duration(seconds: 1));
        
        try {
          final status = await _espProv!.getStatus();
          
          if (status.state == WifiConnectionState.Connected) {
            connected = true;
            setState(() {
              _deviceIp = status.ip;
              _isProvisioning = false;
              _isProvisioningComplete = true;
              _statusMessage = 'WiFi provisioning complete!';
            });
          } else if (status.state == WifiConnectionState.ConnectionFailed) {
            final reason = status.failedReason;
            throw Exception('WiFi connection failed: ${reason == WifiConnectFailedReason.AuthError ? 'Invalid password' : 'Network not found'}');
          }
        } catch (e) {
          if (retries >= 19) {
            throw e;
          }
        }
        
        retries++;
      }
      
      if (!connected) {
        throw Exception('Timed out waiting for WiFi connection');
      }
      
    } catch (e) {
      setState(() {
        _isProvisioning = false;
        _errorMessage = 'Error provisioning WiFi: $e';
        _statusMessage = 'WiFi provisioning failed';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: Text(
            'WiFi Provisioning',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            if (_selectedDevice != null && !_isProvisioningComplete)
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: _scanWifiNetworks,
              ),
          ],
          centerTitle: true,
          elevation: 2,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xA3C6FEFF),
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white
              ],
              stops: [0.0, 0.4, 0.6, 0.7, 0.95],
              begin: AlignmentDirectional(-1.0, -0.98),
              end: AlignmentDirectional(1.0, 0.98),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x34090F13),
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: FlutterFlowTheme.of(context).titleMedium,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _statusMessage,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        if (_errorMessage != null) ...[
                          SizedBox(height: 8),
                          Text(
                            _errorMessage!,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).error,
                            ),
                          ),
                        ],
                        if (_deviceIp != null) ...[
                          SizedBox(height: 8),
                          Text(
                            'Device IP: $_deviceIp',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Main content section
                  Expanded(
                    child: _buildMainContent(),
                  ),
                  
                  // Bottom action button
                  _buildActionButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMainContent() {
    if (_isProvisioningComplete) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: FlutterFlowTheme.of(context).success,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'WiFi Provisioning Complete!',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall,
            ),
            SizedBox(height: 10),
            Text(
              'Your ESP32 device is now connected to WiFi.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyLarge,
            ),
          ],
        ),
      );
    }
    
    if (_isScanning || _isConnecting || _isProvisioning || _isWifiScanning) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitWave(
              color: FlutterFlowTheme.of(context).primary,
              size: 50.0,
            ),
            SizedBox(height: 20),
            Text(
              _isScanning ? 'Scanning for ESP32 devices...' :
              _isConnecting ? 'Connecting to ESP32...' :
              _isWifiScanning ? 'Scanning for WiFi networks...' :
              'Provisioning WiFi...',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyLarge,
            ),
          ],
        ),
      );
    }
    
    if (_selectedDevice != null && _wifiNetworks.isNotEmpty) {
      // Show WiFi networks list
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select WiFi Network:',
            style: FlutterFlowTheme.of(context).titleMedium,
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _wifiNetworks.length,
              itemBuilder: (context, index) {
                final network = _wifiNetworks[index];
                final isSelected = _selectedNetwork?.ssid == network.ssid;
                
                return ListTile(
                  title: Text(network.ssid),
                  subtitle: Text('Signal: ${network.rssi} dBm'),
                  leading: Icon(Icons.wifi, 
                    color: isSelected ? 
                      FlutterFlowTheme.of(context).primary : 
                      FlutterFlowTheme.of(context).secondaryText,
                  ),
                  trailing: network.auth ? Icon(Icons.lock_outline) : null,
                  selected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedNetwork = network;
                    });
                  },
                );
              },
            ),
          ),
          if (_selectedNetwork != null && _selectedNetwork!.auth) ...[
            SizedBox(height: 20),
            Text(
              'WiFi Password:',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter WiFi password',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ],
        ],
      );
    }
    
    if (_selectedDevice != null) {
      // Connected to ESP32 but no WiFi networks scanned yet
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_find,
              color: FlutterFlowTheme.of(context).primary,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Connected to ESP32',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineSmall,
            ),
            SizedBox(height: 10),
            Text(
              'Ready to scan for WiFi networks',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyLarge,
            ),
          ],
        ),
      );
    }
    
    // Show ESP32 device list or initial state
    return _scanResults.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bluetooth_searching,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  'No ESP32 Devices Found',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineSmall,
                ),
                SizedBox(height: 10),
                Text(
                  'Make sure your ESP32 device is powered on and in Bluetooth mode',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyLarge,
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select ESP32 Device:',
                style: FlutterFlowTheme.of(context).titleMedium,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _scanResults.length,
                  itemBuilder: (context, index) {
                    final result = _scanResults[index];
                    return ListTile(
                      title: Text(result.device.platformName),
                      subtitle: Text(result.device.remoteId.str),
                      leading: Icon(Icons.bluetooth),
                      onTap: () => _connectToDevice(result),
                    );
                  },
                ),
              ),
            ],
          );
  }
  
  Widget _buildActionButton() {
    if (_isProvisioningComplete) {
      return FFButtonWidget(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'Done',
        options: FFButtonOptions(
          width: double.infinity,
          height: 50,
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
            color: Colors.white,
          ),
          elevation: 3,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }
    
    if (_isScanning || _isConnecting || _isProvisioning || _isWifiScanning) {
      return FFButtonWidget(
        onPressed: null,
        text: 'Please wait...',
        options: FFButtonOptions(
          width: double.infinity,
          height: 50,
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: FlutterFlowTheme.of(context).secondaryBackground,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
          elevation: 0,
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primaryBackground,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
          disabledColor: FlutterFlowTheme.of(context).secondaryBackground,
          disabledTextColor: FlutterFlowTheme.of(context).secondaryText,
        ),
      );
    }
    
    if (_selectedDevice != null && _selectedNetwork != null) {
      if (_selectedNetwork!.auth && _passwordController.text.isEmpty) {
        return FFButtonWidget(
          onPressed: null,
          text: 'Enter WiFi Password',
          options: FFButtonOptions(
            width: double.infinity,
            height: 50,
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color: FlutterFlowTheme.of(context).secondaryBackground,
            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
            elevation: 0,
            borderSide: BorderSide(
              color: FlutterFlowTheme.of(context).primaryBackground,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
            disabledColor: FlutterFlowTheme.of(context).secondaryBackground,
            disabledTextColor: FlutterFlowTheme.of(context).secondaryText,
          ),
        );
      }
      
      return FFButtonWidget(
        onPressed: _provisionWifi,
        text: 'Provision WiFi',
        options: FFButtonOptions(
          width: double.infinity,
          height: 50,
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
            color: Colors.white,
          ),
          elevation: 3,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }
    
    if (_selectedDevice != null) {
      return FFButtonWidget(
        onPressed: _scanWifiNetworks,
        text: 'Scan WiFi Networks',
        options: FFButtonOptions(
          width: double.infinity,
          height: 50,
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
            color: Colors.white,
          ),
          elevation: 3,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }
    
    return FFButtonWidget(
      onPressed: _startScan,
      text: 'Scan for ESP32 Devices',
      options: FFButtonOptions(
        width: double.infinity,
        height: 50,
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
          fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
          color: Colors.white,
        ),
        elevation: 3,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// BLE Transport implementation for Espressif Provisioning
class BleTransport implements ProvTransport {
  final BluetoothDevice device;
  BluetoothService? service;
  
  BleTransport(this.device);
  
  @override
  Future<void> disconnect() async {
    await device.disconnect();
  }
  
  @override
  Future<void> connect(Duration? timeout) async {
    await device.connect(timeout: timeout);
    List<BluetoothService> services = await device.discoverServices();
    service = services.firstWhere(
      (s) => s.serviceUuid.toString().toUpperCase().contains("FFFF"),
      orElse: () => throw Exception("Provisioning service not found"),
    );
  }
  
  @override
  Future<List<int>> sendReceive(String endpoint, List<int> data) async {
    if (service == null) {
      throw Exception("BLE Service not found. Please connect first.");
    }
    
    // Find the characteristic for this endpoint
    final endpointUuid = _getCharacteristicUuidForEndpoint(endpoint);
    final char = service!.characteristics.firstWhere(
      (c) => c.characteristicUuid.toString().toUpperCase() == endpointUuid,
      orElse: () => throw Exception("Characteristic for endpoint $endpoint not found"),
    );
    
    // Write data to the characteristic
    await char.write(data, withoutResponse: false);
    
    // Read response
    List<int> response = await char.read();
    return response;
  }
  
  String _getCharacteristicUuidForEndpoint(String endpoint) {
    // Map endpoints to characteristic UUIDs
    const Map<String, String> endpointToUuid = {
      "prov-scan": "0000FF50-0000-1000-8000-00805F9B34FB",
      "prov-session": "0000FF51-0000-1000-8000-00805F9B34FB",
      "prov-config": "0000FF52-0000-1000-8000-00805F9B34FB",
      "proto-ver": "0000FF53-0000-1000-8000-00805F9B34FB",
      "custom-data": "0000FF54-0000-1000-8000-00805F9B34FB",
    };
    
    return endpointToUuid[endpoint] ?? 
      throw Exception("Unknown endpoint: $endpoint");
  }
} 