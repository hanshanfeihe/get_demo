import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollScreen extends StatefulWidget {
  const ScrollScreen({Key? key}) : super(key: key);

  @override
  _ScrollScreenState createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  late final ItemScrollController itemScrollController;
  late final ItemPositionsListener itemPositionsListener;
  final ItemScrollController goodsItemScrollController = ItemScrollController();
  final ItemPositionsListener goodsItemPositionsListener =
  ItemPositionsListener.create();
  int currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ScrollablePositionedList.builder(
              itemCount: 5,
              itemBuilder: (context, index) => tabItem(index),
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
            ),
          ),
          Expanded(
              flex: 2,
              child: Stack(
                children:[
                  ScrollablePositionedList.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                    const Divider(height: 1.0),
                    itemBuilder: (context, index) => goodsItem(index),
                    itemScrollController: goodsItemScrollController,
                    itemPositionsListener: goodsItemPositionsListener,
                  ),
                  Positioned(top:20,left: 0,child: Container(
                    color: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8.0),
                    child: Text('$currentIndex'),
                  ))
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemScrollController.jumpTo(index: 0);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.thumb_down),
      ), //
    );
  }

  Widget goodsItem(int index) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          color: Colors.green,
          child: Text('分类：$index'),
        ),
        Container(
          // constraints:
          // BoxConstraints(minHeight: MediaQuery
          //     .of(context)
          //     .size
          //     .height),
          alignment: Alignment.center,
          color: Colors.blueGrey,
          child: ListView.builder(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return SizedBox(
                height: 100.0,
                child: Text(
                  '${index * 10 + i}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
            itemCount: index%2==0?10:3,
            shrinkWrap: true,
          ),
        ),

      ],
    );
  }

  Widget tabItem(int index) {
    return GestureDetector(
      onTap: () {
        // currentIndex = index;
        // setState(() {});
        goodsItemScrollController.jumpTo(index: index);
      },
      child: Container(
        alignment: Alignment.center,
        color: currentIndex == index ? Colors.orange : Colors.white,
        height: 100.0,
        child: Text(
          '$index',
          style: const TextStyle(color: Colors.black45),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    goodsItemPositionsListener.itemPositions.addListener(() {
      if (kDebugMode) {
        print('数组：${goodsItemPositionsListener.itemPositions.value}');
      }
      int index = goodsItemPositionsListener.itemPositions.value
          .where((ItemPosition position) => position.itemTrailingEdge > 0)
          .reduce((ItemPosition min, ItemPosition position) =>
      position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
          .index;
      if (currentIndex !=
          index) {
        currentIndex =
            index;
        setState(() {});
      }
      if (kDebugMode) {
        print('$currentIndex');
      }
    });
    _scrollController.addListener(() {
      if (kDebugMode) {
        print('${_scrollController.position}');
      }
    });
  }
}
