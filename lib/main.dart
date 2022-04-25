import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

abstract class Colors {
  static const bg1 = Color(0xFF00232B);
  static const content1 = Color(0xFFFFFFFF);
  static const content2 = Color(0xAAFFFFFF);
  static const shadow3d1 = Color(0xFF000000);
  static const shadow3d2 = Color(0x00FFFFFF);
  static const reallySad = Color(0xFFFF603E);
  static const sad = Color(0xFFFF833E);
  static const neutral = Color(0xFFFFC061);
  static const happy = Color(0xFFFFD43E);
  static const reallyHappy = Color(0xFFFFED4E);
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.bg1,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Window(
                width: 480,
                height: 180,
                child: Picker(),
              ),
              const SizedBox(height: 48),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.content1,
                    decoration: TextDecoration.none,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Design by ',
                      style: TextStyle(color: Colors.content2),
                    ),
                    TextSpan(
                      text: 'BastiUI',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print('https://basti.fr/basti-ui'),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.content1,
                    decoration: TextDecoration.none,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Implementation by ',
                      style: TextStyle(color: Colors.content2),
                    ),
                    TextSpan(
                      text: 'Aloïs Deniel',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => print('https://aloisdeniel.com'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Window extends StatelessWidget {
  const Window({
    Key? key,
    required this.child,
    this.width,
    this.height,
  }) : super(key: key);

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final windowDecoration = BoxDecoration(
      color: Colors.bg1,
      border: Border.all(
        color: Colors.content1,
        width: 4,
      ),
    );
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            transform: Matrix4.translationValues(-18, 14, 0),
            padding: const EdgeInsets.all(48),
            decoration: windowDecoration,
          ),
        ),
        Container(
          width: 480,
          height: 180,
          padding: const EdgeInsets.all(48),
          decoration: windowDecoration,
          child: const Picker(),
        ),
      ],
    );
  }
}

class Picker extends StatefulWidget {
  const Picker({
    Key? key,
    this.selected,
    this.onSelectedChanged,
  }) : super(key: key);

  final FaceMode? selected;
  final ValueChanged<FaceMode?>? onSelectedChanged;

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  FaceMode? selected;

  void select(FaceMode mode) {
    if (mode != selected) {
      setState(() {
        selected = mode;
      });
      widget.onSelectedChanged?.call(mode);
    }
  }

  void deselect() {
    if (selected != null) {
      setState(() {
        selected = null;
      });
      widget.onSelectedChanged?.call(null);
    }
  }

  @override
  void didUpdateWidget(covariant Picker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selected != selected) {
      setState(() {
        selected = widget.selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Smiley(
          mode: FaceMode.reallySad,
          isSelected: selected == FaceMode.reallySad,
          isEnabled: selected == null || selected == FaceMode.reallySad,
          onSelected: select,
          onDeselected: deselect,
        ),
        Smiley(
          mode: FaceMode.sad,
          isSelected: selected == FaceMode.sad,
          isEnabled: selected == null || selected == FaceMode.sad,
          onSelected: select,
          onDeselected: deselect,
        ),
        Smiley(
          mode: FaceMode.neutral,
          isSelected: selected == FaceMode.neutral,
          isEnabled: selected == null || selected == FaceMode.neutral,
          onSelected: select,
          onDeselected: deselect,
        ),
        Smiley(
          mode: FaceMode.happy,
          isSelected: selected == FaceMode.happy,
          isEnabled: selected == null || selected == FaceMode.happy,
          onSelected: select,
          onDeselected: deselect,
        ),
        Smiley(
          mode: FaceMode.reallyHappy,
          isSelected: selected == FaceMode.reallyHappy,
          isEnabled: selected == null || selected == FaceMode.reallyHappy,
          onSelected: select,
          onDeselected: deselect,
        ),
      ],
    );
  }
}

class Smiley extends StatefulWidget {
  const Smiley({
    Key? key,
    required this.mode,
    required this.onDeselected,
    required this.onSelected,
    this.isSelected = false,
    this.isEnabled = true,
  }) : super(key: key);

  final bool isEnabled;
  final bool isSelected;
  final FaceMode mode;
  final ValueChanged<FaceMode> onSelected;
  final VoidCallback onDeselected;

  @override
  State<Smiley> createState() => _SmileyState();
}

class _SmileyState extends State<Smiley> {
  bool _isHovered = false;

  bool get isHighlighted => _isHovered || widget.isSelected;

  Color get color {
    switch (widget.mode) {
      case FaceMode.reallySad:
        return Colors.reallySad;
      case FaceMode.sad:
        return Colors.sad;
      case FaceMode.neutral:
        return Colors.neutral;
      case FaceMode.happy:
        return Colors.happy;
      case FaceMode.reallyHappy:
        return Colors.reallyHappy;
    }
  }

  double get top {
    switch (widget.mode) {
      case FaceMode.reallySad:
        return 35;
      case FaceMode.sad:
        return 30;
      case FaceMode.neutral:
        return 24;
      case FaceMode.happy:
        return 18;
      case FaceMode.reallyHappy:
        return 12;
    }
  }

  double get right {
    if (isHighlighted) return 8;
    switch (widget.mode) {
      case FaceMode.reallyHappy:
      case FaceMode.reallySad:
        return 4;
      case FaceMode.happy:
      case FaceMode.sad:
        return 3;
      case FaceMode.neutral:
        return 1;
    }
  }

  Duration get period {
    switch (widget.mode) {
      case FaceMode.reallySad:
        return const Duration(milliseconds: 1600);
      case FaceMode.sad:
        return const Duration(milliseconds: 2400);
      case FaceMode.neutral:
        return const Duration(milliseconds: 3200);
      case FaceMode.happy:
        return const Duration(milliseconds: 4000);
      case FaceMode.reallyHappy:
        return const Duration(milliseconds: 4800);
    }
  }

  @override
  Widget build(BuildContext context) {
    const selectBorderColor = Colors.content1;
    const selectedSize = Head.size + 8 * 2;
    return MouseRegion(
      cursor: _isHovered ? SystemMouseCursors.click : MouseCursor.defer,
      onHover: widget.isEnabled
          ? (_) {
              if (!_isHovered) setState(() => _isHovered = true);
            }
          : null,
      onExit: widget.isEnabled
          ? (_) {
              if (_isHovered) setState(() => _isHovered = false);
            }
          : null,
      child: GestureDetector(
        onTap: widget.isEnabled
            ? () {
                if (widget.isSelected) {
                  widget.onDeselected();
                } else {
                  widget.onSelected(widget.mode);
                }
              }
            : null,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: widget.isEnabled ? 1.0 : 0.5,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color:
                  selectBorderColor.withOpacity(widget.isSelected ? 1.0 : 0.0),
              shape: BoxShape.circle,
            ),
            width: widget.isSelected ? selectedSize : Head.size,
            height: widget.isSelected ? selectedSize : Head.size,
            alignment: Alignment.center,
            child: Stack(
              children: [
                Head(
                  color: color,
                  hasShadow: isHighlighted,
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  right: right,
                  top: top,
                  child: Face(
                    mode: widget.mode,
                    period: period,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Head extends StatelessWidget {
  const Head({
    Key? key,
    required this.hasShadow,
    required this.color,
  }) : super(key: key);

  final bool hasShadow;
  final Color color;

  static const double size = 56;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          width: size,
          height: size,
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: hasShadow ? 1.0 : 0.0,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                width: size,
                height: size,
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  backgroundBlendMode: BlendMode.overlay,
                  gradient: RadialGradient(
                    colors: [
                      Colors.shadow3d1,
                      Colors.shadow3d2,
                    ],
                    stops: [0, 1],
                    center: Alignment.bottomLeft,
                    radius: 1.8,
                  ),
                ),
                width: size,
                height: size,
              ),
            ],
          ),
        )
      ],
    );
  }
}

enum FaceMode {
  reallySad,
  sad,
  neutral,
  happy,
  reallyHappy,
}

class Face extends StatelessWidget {
  const Face({
    Key? key,
    required this.mode,
    this.color = Colors.bg1,
    this.period = const Duration(seconds: 2),
  }) : super(key: key);

  final Color color;
  final FaceMode mode;
  final Duration period;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          BlinkingEyes(
            period: period,
            color: color,
            eyeBrow: mode == FaceMode.reallySad,
          ),
          Positioned(
            bottom: () {
              switch (mode) {
                case FaceMode.reallyHappy:
                  return -8.0;
                case FaceMode.happy:
                  return -8.0;
                case FaceMode.neutral:
                  return -6.0;
                case FaceMode.sad:
                  return -4.0;
                case FaceMode.reallySad:
                  return -2.0;
              }
            }(),
            child: Mouth(
              color: color,
              mode: () {
                switch (mode) {
                  case FaceMode.reallyHappy:
                    return MouthMode.smilingOpened;
                  case FaceMode.happy:
                    return MouthMode.smiling;
                  case FaceMode.neutral:
                    return MouthMode.neutral;
                  case FaceMode.sad:
                  case FaceMode.reallySad:
                    return MouthMode.sad;
                }
              }(),
            ),
          )
        ],
      ),
    );
  }
}

enum MouthMode {
  sad,
  neutral,
  smiling,
  smilingOpened,
}

class Mouth extends LeafRenderObjectWidget {
  const Mouth({
    Key? key,
    required this.mode,
    this.color = Colors.bg1,
  }) : super(key: key);

  final MouthMode mode;
  final Color color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMouth(
      color: color,
      mode: mode,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMouth renderObject) {
    renderObject
      ..color = color
      ..mode = mode;
  }
}

class RenderMouth extends RenderBox {
  RenderMouth({
    required Color color,
    required MouthMode mode,
  })  : _color = color,
        _mode = mode;

  Color get color => _color;
  Color _color;
  set color(Color value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  MouthMode get mode => _mode;
  MouthMode _mode;
  set mode(MouthMode value) {
    if (_mode != value) {
      _mode = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    size = constraints.constrain(const Size(16, 8));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()..color = color;
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    switch (mode) {
      case MouthMode.smilingOpened:
        final arc = Path();
        arc.moveTo(0, 0);
        arc.arcToPoint(
          const Offset(16, 0),
          radius: const Radius.circular(8),
          clockwise: false,
        );
        arc.close();
        context.canvas.drawPath(
          arc,
          paint,
        );
        break;
      case MouthMode.smiling:
        final arc = Path();
        arc.moveTo(2, 0);
        arc.arcToPoint(
          const Offset(14, 0),
          radius: const Radius.circular(6),
          clockwise: false,
        );

        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 4;
        context.canvas.drawPath(
          arc,
          paint,
        );
        break;
      case MouthMode.neutral:
        context.canvas.drawRect(
          const Rect.fromLTWH(0, 2, 16, 4),
          paint,
        );
        break;
      case MouthMode.sad:
        final arc = Path();
        arc.moveTo(2, 8);
        arc.arcToPoint(
          const Offset(14, 8),
          radius: const Radius.circular(6),
          clockwise: true,
        );
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 4;
        context.canvas.drawPath(
          arc,
          paint,
        );
        break;
    }
    context.canvas.restore();
  }
}

class BlinkingEyes extends StatefulWidget {
  const BlinkingEyes({
    Key? key,
    required this.color,
    this.eyeBrow = false,
    this.period = const Duration(seconds: 2),
    this.blinking = const Duration(milliseconds: 500),
  }) : super(key: key);

  final Color color;
  final Duration period;
  final bool eyeBrow;
  final Duration blinking;

  @override
  State<BlinkingEyes> createState() => _BlinkingEyesState();
}

class _BlinkingEyesState extends State<BlinkingEyes>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: widget.period,
  );
  Animation<double> get openingAnimation => CurvedAnimation(
        parent: controller,
        curve: EyeCurve(widget.period, widget.blinking),
      );

  @override
  void initState() {
    super.initState();
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: openingAnimation,
      builder: (context, _) => Eyes(
        color: widget.color,
        eyeBrow: widget.eyeBrow,
        opening: openingAnimation.value,
      ),
    );
  }
}

class EyeCurve extends Curve {
  const EyeCurve(this.period, this.blinking);

  final Duration period;
  final Duration blinking;

  @override
  double transformInternal(double t) {
    final blinkingDuration = blinking.inMilliseconds / period.inMilliseconds;
    final startBlinking = 1.0 - blinkingDuration;
    if (t >= 1 || t < startBlinking) {
      return 1;
    }
    final relativeTime = (t - startBlinking) / blinkingDuration;
    if (relativeTime < 0.5) {
      return 1 - Curves.easeOut.transform(relativeTime * 2);
    }

    return Curves.easeIn.transform((relativeTime - 0.5) * 2);
  }
}

class Eyes extends LeafRenderObjectWidget {
  const Eyes({
    Key? key,
    this.color = Colors.bg1,
    this.opening = 1,
    this.eyeBrow = false,
  }) : super(key: key);

  final Color color;
  final double opening;
  final bool eyeBrow;
  static const radius = 4.0;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderEyes(
      color: color,
      opening: opening,
      eyeBrow: eyeBrow,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderEyes renderObject) {
    renderObject
      ..opening = opening
      ..eyeBrow = eyeBrow
      ..color = color;
  }
}

class RenderEyes extends RenderBox {
  RenderEyes(
      {required Color color, required double opening, required bool eyeBrow})
      : _opening = opening,
        _eyeBrow = eyeBrow,
        _color = color;

  Color get color => _color;
  Color _color;
  set color(Color value) {
    if (_color != value) {
      _color = value;
      markNeedsPaint();
    }
  }

  bool get eyeBrow => _eyeBrow;
  bool _eyeBrow;
  set eyeBrow(bool value) {
    if (_eyeBrow != value) {
      _eyeBrow = value;
      markNeedsPaint();
    }
  }

  double get opening => _opening;
  double _opening;
  set opening(double value) {
    if (_opening != value) {
      _opening = value;
      markNeedsPaint();
    }
  }

  @override
  void performLayout() {
    size = constraints.constrain(const Size(40, Eyes.radius * 2));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()..color = color;
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    if (opening < 1) {
      context.canvas.clipRect(
        Rect.fromCenter(
          center: size.center(Offset.zero),
          width: size.width,
          height: Eyes.radius * 2 * opening,
        ),
      );
    }
    final leftCenter = Offset(Eyes.radius, size.height / 2);
    context.canvas.drawCircle(
      leftCenter,
      min(size.width, Eyes.radius),
      paint,
    );
    final rightCenter = Offset(size.width - Eyes.radius, size.height / 2);
    context.canvas.drawCircle(
      rightCenter,
      min(size.width, Eyes.radius),
      paint,
    );
    context.canvas.restore();

    if (eyeBrow) {
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 4.0;
      context.canvas.save();
      context.canvas.translate(offset.dx, offset.dy);

      final closing = 1 - opening;
      context.canvas.drawLine(
        leftCenter + Offset(5, -6 + 2 * closing),
        leftCenter + Offset(-7 + 2 * closing, -9),
        paint,
      );

      context.canvas.drawLine(
        rightCenter + Offset(-5, -6 + 2 * closing),
        rightCenter + Offset(7 - 2 * closing, -9),
        paint,
      );
      context.canvas.restore();
    }
  }
}
