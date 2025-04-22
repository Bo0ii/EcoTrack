import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'pssword_vald_model.dart';
export 'pssword_vald_model.dart';

class PsswordValdWidget extends StatefulWidget {
  const PsswordValdWidget({
    super.key,
    this.isValid,
    this.label,
  });

  final bool? isValid;
  final String? label;

  @override
  State<PsswordValdWidget> createState() => _PsswordValdWidgetState();
}

class _PsswordValdWidgetState extends State<PsswordValdWidget> {
  late PsswordValdModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PsswordValdModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Builder(
          builder: (context) {
            if (widget.isValid ?? false) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/CheckCircle.png',
                  width: 16.0,
                  height: 16.0,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/XCircle.png',
                    width: 14.0,
                    height: 14.0,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          },
        ),
        Expanded(
          child: AnimatedDefaultTextStyle(
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  font: FlutterFlowTheme.of(context).bodySmall,
                  color: widget.isValid!
                      ? FlutterFlowTheme.of(context).success
                      : FlutterFlowTheme.of(context).error,
                  fontSize: 11.0,
                  letterSpacing: 0.0,
                ),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Text(
              valueOrDefault<String>(
                widget.label,
                'No label',
              ),
            ),
          ),
        ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
