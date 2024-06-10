
import 'package:flutter/material.dart';
import '../Const/const.dart';
import '../Const/route.dart';
import '../model/SearchCategoricModel/searchCategoric.dart';
import '../Skeleton/PostListSkeleton.dart';
import '../Skeleton/SearchUserSkeleton.dart';
import '../model/SearchJobModel/SearchJobModel.dart';
import '../model/SearchUserModel/SearchModelUser.dart';
import '../network/SearchNetwork/SearchNetWork.dart';
import '../user_profile/user_profile.dart';
import '../widget/postlist_widget.dart';
import 'linkSearchPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List tab = ["লিংক", "পিপল", "ক্যাটাগরি"];

  String userKeyWord = "";

  var selectColor = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List tabPage = [
      FutureBuilder<SearchJobModel?>(
          future: SearchNetWork().getSearchLink(keyword: userKeyWord, type: 1),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting) {
              return postListSkeleton(size, true);
            } else if (ss.hasData) {
              var dataList = ss.data!.msg;
              return ListView.builder(
                  itemCount: dataList!.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = dataList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Card(
                        shadowColor: Colors.grey,
                        elevation: 5,
                        child: PostListWidget(
                          hedarText: data.jobTitle!,
                          procolpo: data.category!,
                          postTime: data.createdAt!,
                          postName: data.createdByName!,
                          connectId: data.jobId!,
                          discription: data.description!,
                          audio: "",
                          video: '',
                          image: [],
                          home: true,
                          ownerId: data.createdBy!,
                          shareLink: data.sharelink!, userID: data.createdBy!,
                        ),
                      ),
                    );
                  });
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text("No data")),
              );
            }
          }),

      FutureBuilder<SearchUserModel?>(
          future: SearchNetWork().getSearchUser(keyword: userKeyWord, type: 2),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting) {
              return searchUserSkeleton(size);
            } else if (ss.hasData) {
              var dataList = ss.data!.msg;
              return ListView.builder(
                  itemCount: dataList!.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = dataList[index];
                    return InkWell(
                        onTap: () {
                          newPage(
                              context: context,
                              child: UserProfilePage(
                                id: data['user_id']!,
                              ));
                        },
                        child: LinkSearchPageWidget(
                          name: data["full_name"]!,
                          tagline: data["profile_tagline"]!,
                          proPic: data["pic"] ?? "",
                          userId: data['user_id']!,
                        ));
                  });
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text("No data")),
              );
            }
          }),
      //LinkSearchPage(),
      FutureBuilder<ScarchCategoricModel?>(
          future:
              SearchNetWork().getSearchCateGory(keyword: userKeyWord, type: 3),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (ss.hasData) {
              var dataList = ss.data!.msg;
              return ListView.builder(
                  itemCount: dataList!.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = dataList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("$media${data.image}"),
                      ),
                      title: Text(data.catName!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: 'IrabotiMJ')),
                    );
                  });
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(child: Text("No data")),
              );
            }
          }),
    ];
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            )),
        title: Text('খুজুন',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: 'IrabotiMJ')),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: size.height,
                width: size.width,
                child: Image.asset(
                  "assets/backgroundImage.png",
                  fit: BoxFit.cover,
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.2))),
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          setState(() {
                            userKeyWord = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //new commet this code
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < tab.length; i++)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectColor = i;
                                    });
                                  },
                                  child: Container(
                                    height: size.height * 0.07,
                                    width: size.width * 0.3,
                                    color: selectColor == i
                                        ? Colors.red
                                        : Colors.transparent,
                                    child: Center(
                                      child: Text("${tab[i]}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: selectColor == i
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'IrabotiMJ')),
                                    ),
                                  ),
                                ),
                              )
                            // ElevatedButton(
                            //     onPressed: (){
                            //       selectColor=i;
                            //
                            // },
                            //     child: Text("${tab[i]}",
                            //         textAlign: TextAlign.start,
                            //         style: TextStyle(
                            //             color: Colors.black, fontSize: 18, fontFamily: 'IrabotiMJ')),
                            //   style: ButtonStyle(
                            //
                            //   padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
                            //    backgroundColor: MaterialStateProperty.all(selectColor==i?Colors.red:Colors.transparent),
                            //
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: tabPage[selectColor],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
