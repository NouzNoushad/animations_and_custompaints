import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CenterColoredBox extends StatelessWidget {
  const CenterColoredBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
            height: 200,
            width: 300,
            child: CenterColoredBoxWidget(
                color: Colors.green, child: Text('Hello'))),
      ),
    );
  }
}

class CenterColoredBoxWidget extends SingleChildRenderObjectWidget {
  const CenterColoredBoxWidget({
    super.key,
    super.child,
    required this.color,
  });
  final Color color;
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCenteredColoredBox(color: color);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCenteredColoredBox renderObject) {
    renderObject.color = color;
  }
}

class RenderCenteredColoredBox extends RenderProxyBox {
  RenderCenteredColoredBox({
    RenderBox? child,
    required Color color,
  })  : _color = color,
        super(child);
  Color _color;

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! BoxParentData) child.parentData = BoxParentData();
  }

  Color get color => _color;
  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    if (child != null) {
      child?.layout(constraints.loosen(), parentUsesSize: true);
      final childParentData = child?.parentData as BoxParentData;
      childParentData.offset =
          Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
        offset & size,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
    if (child != null) {
      final childParentData = child?.parentData as BoxParentData;
      context.paintChild(child!, offset + childParentData.offset);
    }
  }
}
