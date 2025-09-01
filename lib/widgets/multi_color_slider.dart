import 'package:flutter/material.dart';

/// Custom Slider with segmented solid colors
class MultiColorSlider extends StatefulWidget {
  final List<Color> colors;
  final double value;
  final ValueChanged<double> onChanged;
  final double trackHeight;

  const MultiColorSlider({
    super.key,
    required this.colors,
    required this.value,
    required this.onChanged,
    this.trackHeight = 8,
  });

  @override
  State<MultiColorSlider> createState() => _MultiColorSliderState();
}

class _MultiColorSliderState extends State<MultiColorSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: widget.trackHeight,
        thumbColor: Colors.white,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        trackShape: SegmentedTrackShape(colors: widget.colors),
        thumbSize: WidgetStatePropertyAll(Size(5, 5)),
      ),
      child: Slider(value: widget.value, onChanged: widget.onChanged),
    );
  }
}

/// Painter class that draws solid color segments on the slider track
class SegmentedTrackShape extends SliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 2;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  final List<Color> colors;

  SegmentedTrackShape({required this.colors});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    bool isEnabled = true,
    bool isDiscrete = true,
    required TextDirection textDirection,
  }) {
    final rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    // Draw a single rounded rectangle as the track background (optional: use a neutral color for gaps)
    final bgPaint = Paint()..color = Colors.grey.shade300;
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(4)),
      bgPaint,
    );

    // Draw colored stripes inside the rounded rectangle, no segment rounding
    final sectionWidth = rect.width / colors.length;
    for (int i = 0; i < colors.length; i++) {
      final left = rect.left + i * sectionWidth;
      final right = left + sectionWidth;
      final colorRect = Rect.fromLTRB(left, rect.top, right, rect.bottom);
      final paint = Paint()..color = colors[i];
      // Only round the corners for the first and last color
      RRect rrect;
      if (i == 0) {
        rrect = RRect.fromRectAndCorners(
          colorRect,
          topLeft: const Radius.circular(4),
          bottomLeft: const Radius.circular(4),
        );
      } else if (i == colors.length - 1) {
        rrect = RRect.fromRectAndCorners(
          colorRect,
          topRight: const Radius.circular(4),
          bottomRight: const Radius.circular(4),
        );
      } else {
        rrect = RRect.fromRectAndRadius(colorRect, Radius.zero);
      }
      context.canvas.drawRRect(rrect, paint);
    }
  }
}
