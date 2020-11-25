import 'package:flutter/material.dart';
import './tab_item_icon.dart';

class TabItem extends StatefulWidget {
  final TabItemIcon tabItemIcon;
  final bool isSelected;
  final int index;
  final Duration duration;
  final double jumpHeight;
  final double tabWidth;

  final void Function(int index) onTabChange;
  TabItem({
    @required this.duration,
    @required this.tabWidth,
    this.tabItemIcon,
    @required this.jumpHeight,
    @required this.onTabChange,
    @required this.index,
    @required this.isSelected,
  }) : super(key: Key(index.toString()));
  @override
  TabItemState createState() => TabItemState();
}

class TabItemState extends State<TabItem> with SingleTickerProviderStateMixin {
  Animation<Color> colorAnim;
  Animation<Offset> transAnim;
  AnimationController animationController;
  final Duration subDuration = const Duration(milliseconds: 200);

  @override
  void didUpdateWidget(TabItem oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected)
        animationController.forward();
      else
        animationController.reverse();
    }
    if (widget.duration != oldWidget.duration) {
      animationController.duration = widget.duration;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration - subDuration,
    );

    transAnim = Tween(
      begin: Offset(0, 0),
      end: Offset(0, -widget.jumpHeight),
    ).animate(animationController);
    colorAnim = ColorTween(
      begin: widget.tabItemIcon.startColor ?? Colors.black,
      end: widget.tabItemIcon.endColor ?? Colors.white,
    ).animate(animationController);
    if (widget.isSelected) animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () => widget.onTabChange(widget.index),
        child: Container(
          width: widget.tabWidth,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (_, __) => Container(
                  child: Transform.translate(
                    offset: transAnim.value,
                    child: widget.tabItemIcon.buildWidget != null
                        ? widget.tabItemIcon.buildWidget(context, colorAnim)
                        : Icon(
                            widget.tabItemIcon.iconData,
                            size: 30,
                            color: colorAnim.value,
                          ),
                  ),
                ),
              ),
              widget.tabItemIcon.titleWidget == null ? SizedBox() : widget.tabItemIcon.titleWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
