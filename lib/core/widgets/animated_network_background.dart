import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AnimatedNetworkBackground extends StatefulWidget {
  final Widget child;

  const AnimatedNetworkBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedNetworkBackground> createState() => _AnimatedNetworkBackgroundState();
}

class _AnimatedNetworkBackgroundState extends State<AnimatedNetworkBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Node> _nodes = [];
  final Random _random = Random();
  Size _lastSize = Size.zero;
  Offset? _touchPosition;

  static const int _nodeCount = 28;
  static const double _maxConnectionDistance = 120.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(_updateNodes);
    _controller.repeat();
  }

  void _initNodes(Size size) {
    if (size == _lastSize || size.width == 0 || size.height == 0) return;
    _lastSize = size;
    _nodes.clear();

    for (int i = 0; i < _nodeCount; i++) {
      _nodes.add(_Node(
        position: Offset(
          _random.nextDouble() * size.width,
          _random.nextDouble() * size.height,
        ),
        velocity: Offset(
          (_random.nextDouble() - 0.5) * 0.45,
          (_random.nextDouble() - 0.5) * 0.45,
        ),
        radius: 1.8 + _random.nextDouble() * 1.6,
        baseOpacity: 0.35 + _random.nextDouble() * 0.35,
      ));
    }
  }

  void _updateNodes() {
    if (_lastSize == Size.zero || _nodes.isEmpty) return;

    setState(() {
      for (var node in _nodes) {
        // Move node
        node.position += node.velocity;

        // Subtle attraction to touch point if active
        if (_touchPosition != null) {
          final delta = _touchPosition! - node.position;
          final dist = delta.distance;
          if (dist < 130 && dist > 0) {
            final force = (130 - dist) / 130 * 0.15;
            node.position += Offset(delta.dx / dist * force, delta.dy / dist * force);
          }
        }

        // Screen boundary wrap-around
        double x = node.position.dx;
        double y = node.position.dy;

        if (x < -10) x = _lastSize.width + 10;
        if (x > _lastSize.width + 10) x = -10;
        if (y < -10) y = _lastSize.height + 10;
        if (y > _lastSize.height + 10) y = -10;

        node.position = Offset(x, y);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final themeColor = isDark ? AppColors.darkAccentBlue : AppColors.iconPrimaryLight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initNodes(size);

        return Listener(
          onPointerDown: (event) {
            setState(() {
              _touchPosition = event.localPosition;
            });
          },
          onPointerMove: (event) {
            setState(() {
              _touchPosition = event.localPosition;
            });
          },
          onPointerUp: (_) {
            setState(() {
              _touchPosition = null;
            });
          },
          onPointerCancel: (_) {
            setState(() {
              _touchPosition = null;
            });
          },
          child: Stack(
            children: [
              // Animated Background Network Mesh
              CustomPaint(
                size: size,
                painter: _NetworkPainter(
                  nodes: _nodes,
                  color: themeColor,
                  isDark: isDark,
                  maxDistance: _maxConnectionDistance,
                ),
              ),

              // Foreground Content
              widget.child,
            ],
          ),
        );
      },
    );
  }
}

class _Node {
  Offset position;
  Offset velocity;
  final double radius;
  final double baseOpacity;

  _Node({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.baseOpacity,
  });
}

class _NetworkPainter extends CustomPainter {
  final List<_Node> nodes;
  final Color color;
  final bool isDark;
  final double maxDistance;

  _NetworkPainter({
    required this.nodes,
    required this.color,
    required this.isDark,
    required this.maxDistance,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()..style = PaintingStyle.fill;

    final lineOpacityScale = isDark ? 0.25 : 0.15;
    final nodeOpacityScale = isDark ? 0.45 : 0.28;

    // Draw connecting mesh lines
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final nodeA = nodes[i];
        final nodeB = nodes[j];
        final dx = nodeA.position.dx - nodeB.position.dx;
        final dy = nodeA.position.dy - nodeB.position.dy;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < maxDistance) {
          final alpha = (1.0 - (distance / maxDistance)) * lineOpacityScale;
          linePaint.color = color.withAlpha((alpha * 255).clamp(0, 255).toInt());
          canvas.drawLine(nodeA.position, nodeB.position, linePaint);
        }
      }
    }

    // Draw nodes
    for (var node in nodes) {
      nodePaint.color = color.withAlpha((node.baseOpacity * nodeOpacityScale * 255).clamp(0, 255).toInt());
      canvas.drawCircle(node.position, node.radius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NetworkPainter oldDelegate) => true;
}
