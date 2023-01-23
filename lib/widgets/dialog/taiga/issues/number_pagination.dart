import 'package:flutter/material.dart';

class NumberPagination extends StatefulWidget {
  final int currentPage;
  final int totalPage;
  final ValueChanged<int> onPageChanged;
  const NumberPagination({
    Key? key,
    required this.onPageChanged,
    required this.currentPage,
    required this.totalPage,
  }) : super(key: key);

  @override
  State<NumberPagination> createState() => _NumberPaginationState();
}

class _NumberPaginationState extends State<NumberPagination> {
  late int currentPage = widget.currentPage;
  late int totalPage = widget.totalPage;

  @override
  void didUpdateWidget(covariant NumberPagination oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentPage != widget.currentPage ||
        oldWidget.totalPage != widget.totalPage) {
      setState(() {
        currentPage = widget.currentPage;
        totalPage = widget.totalPage;
      });
    }
  }

  void _updatePage(int page) {
    setState(() {
      currentPage = page;
    });
    widget.onPageChanged(page);
  }

  List<Widget> _buildPageItemList() {
    List<Widget> widgetList = [];
    widgetList.add(_PageControlButton(
      enable: currentPage > 1,
      title: '« Prev',
      onTap: () {
        _updatePage(currentPage - 1);
      },
    ));

    int page = currentPage - 5;
    page = page < 1 ? 1 : page;
    for (; page <= currentPage; page++) {
      widgetList.add(_PageItem(
        page: page,
        isChecked: page == currentPage,
        onTap: (page) {
          _updatePage(page);
        },
      ));
    }

    int endPage = page + 4;

    endPage = endPage > totalPage ? totalPage : endPage;
    for (; page <= endPage; page++) {
      widgetList.add(_PageItem(
        page: page,
        isChecked: page == currentPage,
        onTap: (page) {
          _updatePage(page);
        },
      ));
    }

    widgetList.add(_PageControlButton(
      enable: currentPage < totalPage,
      title: 'Next »',
      onTap: () {
        _updatePage(currentPage + 1);
      },
    ));
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ..._buildPageItemList(),
      ],
    );
  }
}

class _PageControlButton extends StatefulWidget {
  final bool enable;
  final String title;
  final VoidCallback onTap;
  const _PageControlButton(
      {Key? key,
      required this.enable,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  _PageControlButtonState createState() => _PageControlButtonState();
}

class _PageControlButtonState extends State<_PageControlButton> {
  Color normalTextColor = const Color(0xFF0175C2);
  late Color textColor = widget.enable ? normalTextColor : Colors.grey;

  @override
  void didUpdateWidget(_PageControlButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enable != widget.enable) {
      setState(() {
        textColor = widget.enable ? normalTextColor : Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.enable ? widget.onTap : null,
        onHover: (b) {
          if (!widget.enable) return;
          setState(() {
            textColor = b ? normalTextColor.withAlpha(200) : normalTextColor;
          });
        },
        child: _ItemContainer(
            backgroundColor: const Color(0xFFF3F3F3),
            child: Text(
              widget.title,
              style: TextStyle(color: textColor, fontSize: 14),
            )));
  }
}

class _PageItem extends StatefulWidget {
  final int page;
  final bool isChecked;
  final ValueChanged<int> onTap;
  const _PageItem(
      {Key? key,
      required this.page,
      required this.isChecked,
      required this.onTap})
      : super(key: key);

  @override
  __PageItemState createState() => __PageItemState();
}

class __PageItemState extends State<_PageItem> {
  Color normalBackgroundColor = const Color(0xFFF3F3F3);
  Color normalHighlightColor = const Color(0xFF0175C2);

  late Color backgroundColor = normalBackgroundColor;
  late Color highlightColor = normalHighlightColor;

  @override
  void didUpdateWidget(covariant _PageItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isChecked != widget.isChecked) {
      if (!widget.isChecked) {
        setState(() {
          backgroundColor = normalBackgroundColor;
          highlightColor = normalHighlightColor;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onHover: (b) {
          if (widget.isChecked) return;
          setState(() {
            backgroundColor =
                b ? const Color(0xFFEAEAEA) : normalBackgroundColor;
            highlightColor = b ? const Color(0xFF077BC6) : normalHighlightColor;
          });
        },
        onTap: () {
          widget.onTap(widget.page);
        },
        child: _ItemContainer(
          backgroundColor: widget.isChecked ? highlightColor : backgroundColor,
          child: Text(
            widget.page.toString(),
            style: TextStyle(
                color: widget.isChecked ? Colors.white : highlightColor,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ));
  }
}

class _ItemContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  const _ItemContainer(
      {Key? key, required this.child, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(4)),
      child: child,
    );
  }
}
