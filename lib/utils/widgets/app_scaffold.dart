import 'package:breach/utils/widgets/overlays.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? appBarContent;
  final Widget? bottomSheet;
  final FloatingActionButton? actionButton;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final double? toolbarHeight;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? fabLocation;
  final FloatingActionButtonAnimator? fabAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool isLoading;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.appBarContent,
    this.bottomSheet,
    this.actionButton,
    this.backgroundColor,
    this.padding,
    this.toolbarHeight,
    this.floatingActionButton,
    this.fabLocation,
    this.fabAnimator,
    this.persistentFooterButtons,
    this.isLoading = false,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.primary = true,
    this.centerTitle = false,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoScaffold(
          body: Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor:
                    backgroundColor ?? Theme.of(context).colorScheme.surface,
                extendBody: extendBody,
                extendBodyBehindAppBar: extendBodyBehindAppBar,
                appBar:
                    appBar ??
                    AppBar(
                      toolbarHeight: toolbarHeight ?? 45,
                      backgroundColor:
                          backgroundColor ??
                          Theme.of(context).scaffoldBackgroundColor,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      centerTitle: centerTitle,
                      title: appBarContent,
                    ),
                body: Padding(
                  padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
                  child: body,
                ),
                bottomSheet: bottomSheet == null
                    ? null
                    : Padding(
                        padding:
                            padding ?? EdgeInsets.symmetric(horizontal: 20),
                        child: bottomSheet,
                      ),
                floatingActionButton: actionButton ?? floatingActionButton,
                floatingActionButtonLocation: fabLocation,
                floatingActionButtonAnimator: fabAnimator,
                persistentFooterButtons: persistentFooterButtons,
                drawer: drawer,
                onDrawerChanged: onDrawerChanged,
                endDrawer: endDrawer,
                onEndDrawerChanged: onEndDrawerChanged,
                drawerScrimColor: drawerScrimColor,
                bottomNavigationBar: bottomNavigationBar,
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                primary: primary,
                drawerDragStartBehavior: drawerDragStartBehavior,
                drawerEdgeDragWidth: drawerEdgeDragWidth,
                drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
                endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
                restorationId: restorationId,
              );
            },
          ),
        ),
        LoadingIndicatorOverlay(isLoading: isLoading),
      ],
    );
  }
}
