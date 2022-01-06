import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio/service/carouselService.dart';

class CarouselPageProvider with ChangeNotifier {
  bool _isPlaying = true;
  bool get isPlaying => this._isPlaying;
  set isPlaying(bool p) => throw "Setter Error";

  int _index = 0;
  int get index => this._index;

  void setIndex({required int index}) {
    this._index = index;
    this.notifyListeners();
  }

  Future<void> autoSlide({required PageController pageCt}) async {
    Future.delayed(
      Duration(seconds: 2),
      () async {
        if (this._isPlaying) {
          if (this._index == CarouselService.images.length - 1) {
            pageCt.jumpToPage(0);
          } else {
            await pageCt.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInToLinear);
          }
          await this.autoSlide(pageCt: pageCt);
        } else {
          return;
        }
      }
    );
  }

  Future<void> stopOrPlay({
    required PageController pageCt,
    required bool stop,
    String? changePageTo,
    int? index,
  }) async {
    if (stop) {
      this._isPlaying = false;
    } else {
      this._isPlaying = true;
      this.autoSlide(pageCt: pageCt);
    }
    if (changePageTo == "previous") {
      await pageCt.previousPage(duration: Duration(seconds: 1), curve: Curves.linear);
    } else if (changePageTo == "next") {
      await pageCt.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
    } else if (changePageTo == "jump" && index != null) {
      pageCt.jumpToPage(index);
    }
    this.setIndex(index: pageCt.page!.ceil());
    this.notifyListeners();
  }
}