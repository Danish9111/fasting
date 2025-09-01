import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            ArcProgress(
              progress: .5,
              elapsedTime: "06:25:38",
              nextFastTime: "Today 06:00 AM",
              planLabel: "14-10",
            ),
            SizedBox(height: 20),
            WaterTrackerCard(),
            SizedBox(height: 20),
            DailySummaryCard(),
          ],
        ),
      ),
    );
  }
}
///////////////
//////////////
///
/////

class ArcProgress extends StatelessWidget {
  final double progress; // 0.0 -> 1.0
  final String elapsedTime;
  final String nextFastTime;
  final String planLabel;

  const ArcProgress({
    super.key,
    required this.progress,
    required this.elapsedTime,
    required this.nextFastTime,
    required this.planLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          painter: _ArcPainter(progress),
          size: const Size(250, 250),
          child: SizedBox(
            width: 250,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Time Since Last Fast",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 6),
                Text(
                  elapsedTime,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Your next fast begins on",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                Text(nextFastTime, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(planLabel, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              const Icon(CupertinoIcons.pencil, size: 14),
            ],
          ),
        ),
      ],
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  _ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 18.0;
    final radius = (size.width / 2) - strokeWidth;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    // leave gap at bottom (~70°)
    const gapAngle = math.pi / 3; // 60°
    const startAngle = math.pi / 2 + (gapAngle / 2); // start just after bottom
    const sweepAngle = 2 * math.pi - gapAngle;

    // Base groove effect = draw two shadows (light + dark)
    final shadowPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    final highlightPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    // Actual groove base (slightly darker)
    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = const Color(0xFF6EBF43)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Groove illusion: first light highlight arc (top-left side)
    canvas.drawArc(rect, startAngle, sweepAngle, false, shadowPaint);
    canvas.drawArc(rect, startAngle, sweepAngle, false, highlightPaint);

    // Then real background canal
    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    // Then progress arc
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class FastingProgress extends StatelessWidget {
  final double percent; // e.g. 0.65 means 65% complete
  final String elapsedTime; // e.g. "06:25:38"
  final String nextFastTime; // e.g. "Today 06:00 AM"
  final String planLabel; // e.g. "14-10"

  const FastingProgress({
    super.key,
    required this.percent,
    required this.elapsedTime,
    required this.nextFastTime,
    required this.planLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 110,
          lineWidth: 18,
          percent: percent,
          animation: true,
          animationDuration: 800,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey.shade200,
          progressColor: const Color(0xFF6EBF43), // your green
          startAngle: 220, // rotates the "cut" so it matches your groove
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Time Since Last Fast",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                elapsedTime,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Your next fast begins on",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              Text(
                nextFastTime,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // bottom pill with icon
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                planLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.edit, size: 14),
            ],
          ),
        ),
      ],
    );
  }
}

class FastingTrackerCard extends StatelessWidget {
  const FastingTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 15.0,
                    percent: 0.7, // Adjust this value to change progress
                    backgroundColor: Colors.grey.shade300,
                    linearGradient: const LinearGradient(
                      colors: [
                        Colors.green,
                        Color.fromARGB(255, 142, 230, 144),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    animateFromLastPercent: true,
                    curve: Curves.easeOutCubic,
                    animation: true,
                    animationDuration: 1000,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Time Since Last Fast',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      '06:25:38',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your next fast begins on',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Today 06:00 AM',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Chip(
                      label: Text('14-10', style: TextStyle(fontSize: 12)),
                      backgroundColor: Colors.grey,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.sentiment_satisfied_alt,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Start fast',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Today, 06:00',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Start Fasting'),
                  ),
                ),
                Column(
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.share, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'End fast',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      'Today, 22:00',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WaterTrackerCard extends StatelessWidget {
  const WaterTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Water Tracker',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '1250 mL',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        '/ 2500 mL',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '50% completed',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    FloatingActionButton.small(
                      onPressed: () {},
                      heroTag: 'decrement',
                      backgroundColor: Colors.grey[200],
                      elevation: 0,
                      child: const Icon(Icons.remove, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    // Grooved water drop icon
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Transform.rotate(
                              angle:
                                  -10 *
                                  3.14159 /
                                  180, // Rotate slightly for the drop effect
                              child: Icon(
                                Icons.water_drop,
                                color: Colors.grey.shade300,
                                size: 80,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Transform.rotate(
                              angle: -10 * 3.14159 / 180,
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.blue.shade800,
                                      Colors.blue.shade400,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ).createShader(
                                    Rect.fromLTWH(
                                      0,
                                      bounds.height * 0.5,
                                      bounds.width,
                                      bounds.height * 0.5,
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.water_drop,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton.small(
                      onPressed: () {},
                      heroTag: 'increment',
                      backgroundColor: Colors.grey[200],
                      elevation: 0,
                      child: const Icon(Icons.add, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Daily Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  '89.5',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                const Text(
                  ' kg',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                        size: 14,
                      ),
                      Text(
                        '-2.5 kg',
                        style: TextStyle(color: Colors.green.shade800),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.edit, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            LinearPercentIndicator(
              lineHeight: 8.0,
              percent: 0.7, // Adjust this value based on progress
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.green,
              barRadius: const Radius.circular(5),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Starting: 100.0 kg',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Goal: 76.0 kg',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
