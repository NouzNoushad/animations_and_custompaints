import 'package:flutter/material.dart';

class LifeCycleFlutter extends StatefulWidget {
  LifeCycleFlutter({super.key, required this.count});
  int count;

  @override
  State<LifeCycleFlutter> createState() => _LifeCycleFlutterState();
}

class _LifeCycleFlutterState extends State<LifeCycleFlutter> {
  Color color = Colors.purple;

  @override
  void initState() {
    print('Init state called');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('Did change dependencies called');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant LifeCycleFlutter oldWidget) {
    print('Did update widget called');
    if (widget.count != oldWidget.count) {
      print('Count changed');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('Deactivate called');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Dispose called');
    super.dispose();
  }

  onCountChanged() {
    setState(() {
      print('state changed');
      widget.count++;
    });
  }

  void onColorChange() {
    setState(() {
      color = color == Colors.purple ? Colors.pink : Colors.purple;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build called');
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onColorChange();
          onCountChanged();
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
          child: ColorWidget(
        color: color,
        onColorChange: onColorChange,
        child: Builder(builder: (cxt) {
          return Container(
            height: 300,
            width: 300,
            color: ColorWidget.of(cxt)!.color,
            child: GlobalCounter(
              count: widget.count,
              onCountChanged: onCountChanged,
              child: Builder(builder: (cxt2) {
                return Center(
                  child: Text(
                    GlobalCounter.of(cxt2)!.count.toString(),
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      )),
    );
  }
}

class ColorWidget extends InheritedWidget {
  const ColorWidget({
    super.key,
    required super.child,
    required this.color,
    required this.onColorChange,
  });

  final Color color;
  final void Function() onColorChange;

  static ColorWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorWidget>();
  }

  @override
  bool updateShouldNotify(ColorWidget oldWidget) {
    return oldWidget.color != color;
  }
}

class GlobalCounter extends InheritedWidget {
  const GlobalCounter({
    super.key,
    required super.child,
    required this.count,
    required this.onCountChanged,
  });
  final int count;
  final onCountChanged;

  static GlobalCounter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalCounter>();
  }

  @override
  bool updateShouldNotify(covariant GlobalCounter oldWidget) {
    return count != oldWidget.count;
  }
}
