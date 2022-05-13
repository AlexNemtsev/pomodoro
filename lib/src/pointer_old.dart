import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'blocs/controller.dart';
import 'pomodoro_timers_old.dart';
import 'constants.dart';

class Pointer extends StatefulWidget {
  Pointer({required this.timers, required this.controller});
  final Timers timers;
  final Controller controller;

  @override
  _PointerState createState() => _PointerState();
}

class _PointerState extends State<Pointer> {
  double percent = 100;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: 100.0,
        stream: widget.controller.percent,
        builder: (context, AsyncSnapshot<double> snapshot) {
          return SfRadialGauge(
            axes: [
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.75,
                axisLineStyle: const AxisLineStyle(
                    thicknessUnit: GaugeSizeUnit.factor, thickness: 0.02),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: snapshot.data!,
                    color: Colors.teal,
                    width: 2,
                    // enableAnimation: true,
                    // animationDuration: 1200,
                    // animationType: AnimationType.ease,
                  ),
                ],
                // В этом блоке живёт текстовое отображение таймера
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    angle: 180,
                    widget: StreamBuilder(
                      initialData: <String, String>{'min': '00', 'sec': '00'},
                      stream: widget.controller.timeString,
                      builder: (context,
                          AsyncSnapshot<Map<String, String>> snapshot) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: 150.0,
                                  child: Text(
                                    snapshot.data!['min'].toString(),
                                    style: kDisplayTextStyle,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    ':',
                                    style: kDisplayTextStyle,
                                  ),
                                ),
                                Container(
                                  width: 150.0,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data!['sec'].toString(),
                                    style: kDisplayTextStyle,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Pomo: ${widget.controller.counter}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Encode Sans SC',
                                // fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
