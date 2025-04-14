import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'nowifi_model.dart';
export 'nowifi_model.dart';

class NowifiWidget extends StatefulWidget {
  const NowifiWidget({super.key});

  @override
  State<NowifiWidget> createState() => _NowifiWidgetState();
}

class _NowifiWidgetState extends State<NowifiWidget> {
  late NowifiModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NowifiModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/jsons/Animation_-_1744065666163.json',
      width: 424.7,
      height: 408.35,
      fit: BoxFit.cover,
      frameRate: FrameRate(120.0),
      repeat: false,
      animate: true,
    );
  }
}
