import 'dart:async';
import 'dart:convert';

import 'package:flutter_esp_ble_prov/flutter_esp_ble_prov.dart';
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
  
  // ESP provisioning instance
  EspBleProvisioning? _espProvisioning;
  
  // WiFi networks found by ESP32
  List<WiFiNetwork> _wifiNetworks = [];
  
  // Selected WiFi network
  WiFiNetwork? _selectedNetwork;
  
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
            if (result.device.platformName.contains('ESP32') || 
                result.device.platformName.contains('PROV_')) {
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
      // Create ESP provisioning instance
      _espProvisioning = EspBleProvisioning.getInstance();
      
      // The proof of possession (pop) - typically a code like "abcd1234"
      // This should match what's configured on your ESP32
      final String pop = "abcd1234";
      
      // Connect to the device - the library handles the connection details
      await _espProvisioning!.connect(
        scanResult.device.remoteId.str,
        pop, 
        transport: TransportType.BLE
      );
      
      setState(() {
        _isConnecting = false;
        _statusMessage = 'Connected to ESP32, ready to scan WiFi networks';
      });
    } catch (e) {
      await _disconnectFromDevice();
      setState(() {
        _isConnecting = false;
        _errorMessage = 'Connection error: $e';
        _statusMessage = 'Connection failed';
        _espProvisioning = null;
      });
    }
  }
  
  // Disconnect from ESP32 device
  Future<void> _disconnectFromDevice() async {
    if (_espProvisioning != null) {
      try {
        await _espProvisioning!.disconnect();
      } catch (e) {
        print('Error disconnecting: $e');
      }
    }
    
    setState(() {
      _selectedDevice = null;
      _espProvisioning = null;
      _wifiNetworks = [];
      _selectedNetwork = null;
      if (!_isProvisioningComplete) {
        _statusMessage = 'Disconnected from ESP32';
      }
    });
  }
  
  // Scan for WiFi networks using the ESP32 device
  Future<void> _scanWifiNetworks() async {
    if (_espProvisioning == null || _isWifiScanning) return;
    
    setState(() {
      _isWifiScanning = true;
      _wifiNetworks = [];
      _selectedNetwork = null;
      _statusMessage = 'Scanning for WiFi networks...';
      _errorMessage = null;
    });
    
    try {
      // Scan for available WiFi networks
      final wifiList = await _espProvisioning!.startWiFiScan();
      
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
    if (_espProvisioning == null || _selectedNetwork == null || _isProvisioning) return;
    
    final String ssid = _selectedNetwork!.ssid;
    final String password = _passwordController.text;
    
    setState(() {
      _isProvisioning = true;
      _statusMessage = 'Sending WiFi credentials to ESP32...';
      _errorMessage = null;
    });
    
    try {
      // Send WiFi credentials to ESP32 and apply
      await _espProvisioning!.provisionWiFi(ssid, password);
      
      // Get status and IP address
      final ProvisioningResponse response = await _espProvisioning!.getStatus();
      
      if (response.state == ProvisioningState.Success) {
        setState(() {
          _deviceIp = response.ip;
          _isProvisioning = false;
          _isProvisioningComplete = true;
          _statusMessage = 'WiFi provisioning complete!';
        });
      } else {
        throw Exception('WiFi provisioning failed: ${response.failureReason}');
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
                  trailing: network.auth != 0 ? Icon(Icons.lock_outline) : null,
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
          if (_selectedNetwork != null && _selectedNetwork!.auth != 0) ...[
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
      if (_selectedNetwork!.auth != 0 && _passwordController.text.isEmpty) {
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