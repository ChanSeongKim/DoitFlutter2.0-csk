import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'memo.dart';
import 'memoAdd.dart';
import 'memoDetail.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MemoPage();

}

class _MemoPage extends State<MemoPage> {
  FirebaseDatabase? _database ;
  DatabaseReference? reference;
  String _databaseURL = 'https://example-e5233-default-rtdb.firebaseio.com/';
  List<Memo> memos = new List.empty(growable: true);

  //광고 클래스 및 광고가 지금 로드되었는지 확인하는 함수
  BannerAd? _banner;
  bool _loadingBanner = false ;


  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('memo');

    reference!.onChildAdded.listen((event){
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
      }

    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadingBanner){
      _loadingBanner = true ;
      _createBanner(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 앱'),
      ),
      body:
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Container(
                child: Center(
                  child: memos.length == 0
                      ? CircularProgressIndicator()
                      : GridView.builder (
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2
                    ),
                    itemBuilder: (context, index){
                      return Card(
                        child: GridTile(
                          child: Container(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: SizedBox(
                              child: GestureDetector(
                                onTap:() async {
                                  //여기에 메모 상세보기 화면으로 이동 추가 예정
                                  Memo? memo = await Navigator.of(context).push(
                                      MaterialPageRoute<Memo>(
                                          builder: (BuildContext context) =>
                                              MemoDetailPage(reference!, memos[index])
                                      )
                                  );
                                  if( memo != null){
                                    setState(() {
                                      memos[index].title = memo.title;
                                      memos[index].content = memo.content;
                                    });
                                  }
                                },

                                onLongPress: () {
                                  //여기에 길게 클릭시 메모 삭제 기능 추가 예정
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(memos[index].title),
                                          content: Text('삭제하시겠습니까?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                reference!
                                                    .child(memos[index].key!)
                                                    .remove()
                                                    .then((_){
                                                  setState(() {
                                                    memos.removeAt(index);
                                                    Navigator.of(context).pop();
                                                  });
                                                }
                                                );// then
                                              },
                                              child: Text('예'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('아니요'),
                                            ),
                                          ],
                                        );

                                      }
                                  );

                                },
                                child: Text(memos[index].content),
                              ), ),
                          )     ,
                          header: Text(memos[index].title),
                          footer: Text(memos[index].createTime.substring(0,10)),

                        ),
                      );
                    },
                    itemCount: memos.length,
                  ),
                ),

              ),
              if(_banner != null)
                Container(
                  color: Colors.green,
                  width: _banner!.size.width.toDouble(),
                  height: _banner!.size.height.toDouble(),
                  child: AdWidget(ad: _banner!),
                ),
            ],
          ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MemoAddPage( reference!)));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _createBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
          Orientation.portrait,
          MediaQuery.of(context).size.width.truncate(),
        );
    if( size == null) {
      return ;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: const AdRequest(),
      adUnitId: BannerAd.testAdUnitId, // 하단배너 광고 ID
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _banner = ad as BannerAd? ;
          });

        },
        onAdFailedToLoad: (Ad ad, LoadAdError error){
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _banner?.dispose();
  }

}