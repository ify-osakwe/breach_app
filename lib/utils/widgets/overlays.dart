import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicatorOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicatorOverlay({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (isLoading)
          ModalBarrier(color: Colors.transparent, dismissible: false),
        if (isLoading) const Center(child: CupertinoActivityIndicator()),
      ],
    );
  }
}

class LinearLoadingIndicator extends StatelessWidget {
  final bool loading;
  const LinearLoadingIndicator({required this.loading, super.key});
  @override
  Widget build(BuildContext context) {
    //
    return loading
        ? const LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        : const SizedBox.shrink();
  }
}
