import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FetchPage extends StatefulWidget {
  const FetchPage({Key? key}) : super(key: key);

  @override
  State<FetchPage> createState() => _FetchPageState();
}

class _FetchPageState extends State<FetchPage> {
  TextEditingController apiTxt = TextEditingController();

  var jsonList = [];
  var formattedData = "Enter Url and click GetData!";

  final url = "https://jsonplaceholder.typicode.com/posts";
  fetchPosts(urlEntered) async{
    try{
      final response = await get(Uri.parse(urlEntered));
      final jsonData = jsonDecode(response.body);
      var encoder = new JsonEncoder.withIndent("     ");

      setState(() {
        //jsonList = jsonData as List;
        formattedData = encoder.convert(jsonData);
      });
    }
    catch(er){
      print(er);
      setState(() {
        formattedData = "Something is Wrong, check Internet connection or API url!";
      });
    }
  }

  @override
  void initState() {
    // fetchPosts(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            controller: apiTxt,
          ),
          const SizedBox(height: 7,),
          ElevatedButton(onPressed: ()async{
            fetchPosts(apiTxt.text);
          }, child: const Text("GetData")),
          Text(formattedData.toString())
        ],
      ),
    );
  }
}
