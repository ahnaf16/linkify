import 'package:flutter/cupertino.dart';
import 'package:linkify/main.export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Refresher extends StatefulWidget {
  const Refresher({super.key, required this.child, this.onRefresh, this.onLoadMore, this.noIteMsg, this.reverse});

  final VoidFutureCallBack? onRefresh;
  final FutureCallback<bool>? onLoadMore;
  final Widget child;
  final bool? reverse;
  final String? noIteMsg;

  @override
  State<Refresher> createState() => RefresherState();
}

class RefresherState extends State<Refresher> {
  final refCtrl = RefreshController();

  @override
  void dispose() {
    refCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refCtrl,
      reverse: widget.reverse,
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      header: const WaterDropHeader(),
      footer: ClassicFooter(noDataText: widget.noIteMsg),
      physics: kScrollPhysics,
      onRefresh: () async {
        await widget.onRefresh?.call();
        refCtrl.refreshCompleted();
        refCtrl.loadComplete();
      },
      onLoading: () async {
        final noData = await widget.onLoadMore?.call();
        if (noData == true) {
          refCtrl.loadNoData();
        } else {
          refCtrl.loadComplete();
        }
      },
      child: widget.child,
    );
  }
}
