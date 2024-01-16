import 'package:flutter/material.dart';

class ThumbnailCard extends StatefulWidget {
  const ThumbnailCard({
    super.key,
    required this.image,
    this.title,
    this.onTap,
    this.onDelete,
    this.onFocus,
    this.onTitleChanged,
  });

  final String? title;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final ImageProvider image;
  final Function(bool hasFocus)? onFocus;
  final Function(String changedValue)? onTitleChanged;

  @override
  State<ThumbnailCard> createState() => _ThumbnailCardState();
}

class _ThumbnailCardState extends State<ThumbnailCard> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
    _focusNode.addListener(() => widget.onFocus?.call(_focusNode.hasFocus));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            width: 200,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: 3,
                    child: SizedBox(
                      width: 200,
                      height: 150,
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: Image(
                          image: widget.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                          flex: 4,
                          child: TextFormField(
                            focusNode: _focusNode,
                            onChanged: widget.onTitleChanged,
                            initialValue: widget.title,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              filled: _focusNode.hasFocus,
                            ),
                          )),
                      Flexible(
                        child: IconButton(
                          onPressed: widget.onDelete,
                          hoverColor: Colors.red,
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
