import 'package:flutter/material.dart';
import 'package:portfolio/controllers/carouselPageProvider.dart';
import 'package:portfolio/models/shareParams.dart';
import 'package:portfolio/service/carouselService.dart';
import 'package:portfolio/service/share.dart';

class AndroidCarousel extends StatelessWidget {
  const AndroidCarousel({Key? key, required this.carouselPageProvider}) : super(key: key);
  final CarouselPageProvider carouselPageProvider;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(),
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext ctx, int i) {
            List<AndroidCarouselWidget> _carousels = List.generate(
                CarouselService.images.length, (int index) => new AndroidCarouselWidget(carouselPageProvider: carouselPageProvider));
            return _carousels[i];
          },
            childCount: CarouselService.images.length,
          ),
        ),
      ],
    );
  }
}

class AndroidCarouselWidget extends StatefulWidget {
  const AndroidCarouselWidget({Key? key, required this.carouselPageProvider}) : super(key: key);
  final CarouselPageProvider carouselPageProvider;

  @override
  State<AndroidCarouselWidget> createState() => _AndroidCarouselWidgetState();
}

class _AndroidCarouselWidgetState extends State<AndroidCarouselWidget> {
  ShareService _shareService = ShareService();

  PageController _pageCt = PageController();

  Widget _button({
    required BuildContext ctx,
    required IconData icon,
    required Future<void> onPressed(),
    double? left,
    double? right,
  }) => Positioned(
    top: MediaQuery.of(ctx).size.height * 0.4,
    left: left,
    right: right,
    child: Container(
      width: 30.0,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        padding: EdgeInsets.all(0),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black, size: 30),
      ),
    ),
  );

  @override
  void initState() {
    print("carousel page init");
    WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
      Future(() async {
        this.widget.carouselPageProvider.autoSlide(pageCt: this._pageCt,);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    this._pageCt.dispose();
    print("carousel page dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height
            - MediaQuery.of(context).viewPadding.top
            - MediaQuery.of(context).viewPadding.bottom
            - 180.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 30.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height
                      - MediaQuery.of(context).viewPadding.top
                      - MediaQuery.of(context).viewPadding.bottom
                      - 260.0,
                  child: PageView.builder(
                    onPageChanged: (int i) {
                      this.widget.carouselPageProvider.setIndex(index: i);
                    },
                    controller: this._pageCt,
                    itemCount: CarouselService.images.length,
                    itemBuilder: (BuildContext context, int i) => Image(
                      image: NetworkImage(CarouselService.images[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              this._button(
                ctx: context,
                icon: Icons.arrow_left,
                onPressed: () async {
                  this.widget.carouselPageProvider.stopOrPlay(pageCt: this._pageCt, stop: true, changePageTo: "previous");
                },
                left: 5.0,
              ),
              this._button(
                ctx: context,
                icon: Icons.arrow_right,
                onPressed: () async {
                  this.widget.carouselPageProvider.stopOrPlay(pageCt: this._pageCt, stop: true, changePageTo: "next");
                },
                right: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(CarouselService.images.length, (int index) => GestureDetector(
                  onTap: () async {
                    this.widget.carouselPageProvider.stopOrPlay(pageCt: this._pageCt, stop: true, changePageTo: "jump", index: index);
                  },
                  child: Container(
                    height: this.widget.carouselPageProvider.index == index ? 17.0 : 14.0,
                    width: this.widget.carouselPageProvider.index == index ? 17.0 : 14.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: this.widget.carouselPageProvider.index == index ? Color.fromRGBO(0, 0, 0, 1.0) : Color.fromRGBO(128, 128, 128, 1.0),
                      border: Border.all(
                          color: Color.fromRGBO(255, 255, 255, 1.0)
                      ),
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),
                )),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      iconSize: 27.0,
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.only(bottom: 1.0, right: 10.0),
                      onPressed: () => this.widget.carouselPageProvider.stopOrPlay(pageCt: this._pageCt, stop: false),
                      icon: Icon(Icons.play_circle_fill),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(bottom: 1.0, left: 10.0, right: 10.0),
                      iconSize: 27.0,
                      constraints: BoxConstraints(),
                      onPressed: () => this.widget.carouselPageProvider.stopOrPlay(pageCt: this._pageCt, stop: true),
                      icon: Icon(Icons.pause_circle_filled),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(bottom: 1.0, left: 10.0, right: 10.0),
                      iconSize: 27.0,
                      constraints: BoxConstraints(),
                      onPressed: () async {
                        int _currentIndex = this._pageCt.page!.toInt();
                        this.widget.carouselPageProvider.stopOrPlay(pageCt: this._pageCt, stop: true);
                        await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext ctx) => Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {},
                                  child: Text("Kakao"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await _shareService.share(
                                      platform: Platform.text,
                                      params: ShareViaText(body: CarouselService.images[_currentIndex]),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Text"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await _shareService.share(
                                      platform: Platform.email,
                                      params: ShareViaEmail(body: CarouselService.images[_currentIndex]),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Email"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await _shareService.share(platform: Platform.gmail);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Gmail"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await _shareService.copyText(text: CarouselService.images[_currentIndex]);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Copied to clipboard"),
                                    ));
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Copy Link for Photo"),
                                ),
                              ],
                            ),
                          )
                        );
                      },
                      icon: Icon(Icons.share_outlined),
                    ),
                    IconButton(
                      icon: Icon(Icons.save_alt),
                      padding: EdgeInsets.only(bottom: 1.0, left: 10.0, right: 10.0),
                      iconSize: 27.0,
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
