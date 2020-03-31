import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageAdd extends StatefulWidget {
  final int maxCrossCount;
  final double space;
  final List images;
  final VoidCallback addImage;
  final int maxImageCount;
  final ValueChanged<List> valueChanged;
  final VoidCallback onStart;
  final VoidCallback onCancled;
  final VoidCallback onComplete;

  ImageAdd(@required this.images,
      {this.maxCrossCount = 3,
      this.space = 10,
      this.addImage,
      this.maxImageCount = 6,
      @required this.valueChanged,
      this.onStart,
      this.onCancled,
      this.onComplete});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageAddState();
  }
}

class ImageAddState extends State<ImageAdd> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: widget.maxCrossCount,
        mainAxisSpacing: widget.space,
        crossAxisSpacing: widget.space,
        childAspectRatio: 1,
        children: [...widget.images, 0].take(3).map((value) {
          if (value == 0) {
            return GestureDetector(
              onTap: () {
                if (widget.addImage != null) {
                  widget.addImage();
                }
              },
              child: Container(
                color: Colors.black12,
                child: Icon(
                  Icons.add,
                  size: 50,
                ),
              ),
            );
          } else {
            var index = widget.images.indexOf(value);
            return LongPressDraggable(
              data: index,
              child: DragTarget<int>(
                onAccept: (data) {
                  final temp = widget.images[data];
                  widget.images[data] = widget.images[index];
                  widget.images[index] = temp;
                  setState(() {});
                  widget.valueChanged(widget.images);
                },
                onWillAccept: (data) {
                  return true;
                },
                builder: (context, candidateData, rejectedData) {
                  return DragImage(
                    imagePath: value,
                  );
                },
              ),
              feedback: Container(
                width: (MediaQuery.of(context).size.width - 40) / 3,
                height: (MediaQuery.of(context).size.width - 40) / 3,
                child: DragImage(
                  imagePath: value,
                ),
              ),
              onDragStarted: () {
                //开始拖动
                widget.onStart();
              },
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                //拖动取消
                var screenHeight = MediaQuery.of(context).size.height;
                var top = (MediaQuery.of(context).size.width - 40) / 6;
                if (offset.dy + top > screenHeight - 100){
                  // 删除
                  setState(() {
                    widget.images.removeAt(index);
                    widget.valueChanged(widget.images);
                  });
                }
                widget.onCancled();
              },
              onDragCompleted: () {
                //拖动完成
                widget.onComplete();
              },
              childWhenDragging: Container(
                color: Colors.black12,
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}

class DragImage extends StatefulWidget {
  final File imagePath;

  DragImage({@required this.imagePath});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DragImageState();
  }
}

class DragImageState extends State<DragImage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Image.file(
        widget.imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
