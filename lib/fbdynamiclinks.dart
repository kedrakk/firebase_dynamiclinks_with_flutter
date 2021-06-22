import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FBDyanmicLinks extends StatefulWidget {
  const FBDyanmicLinks({ Key? key }) : super(key: key);

  @override
  _FBDyanmicLinksState createState() => _FBDyanmicLinksState();
}

class _FBDyanmicLinksState extends State<FBDyanmicLinks> {

  String name="";
  String age="";
  var link="";

  @override
    void initState() {
      this.initDynamicLinks(context);
      super.initState();
    }

  initDynamicLinks(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3)); 
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    setState(() {
      link=deepLink!=null?deepLink.toString():"no link";
    });
    final queryParams = deepLink!.queryParameters;
    if (queryParams.length > 0) {
      var userName = queryParams['userId'];
      name=queryParams['name']??"";
      age=queryParams["age"]??"";
      setState(() {});
    }
    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) 
      async {
      var deepLink = dynamicLink?.link;
      debugPrint('DynamicLinks onLink $deepLink');
    }, onError: (e) async {
      debugPrint('DynamicLinks onError $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dynamic Links"),),
      body: Center(
        child: Text(link),
      ),
    );
  }
}