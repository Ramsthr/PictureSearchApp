import 'package:animalsearchapp/imagecontainer.dart';
import 'package:flutter/material.dart';
import 'dataapi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiFetch api = ApiFetch();
  bool isLoading = false;
  int page = 1;
  List<String> ls = [];
  String query = "";
  ScrollController _controller = ScrollController();
  TextEditingController _searchController = TextEditingController();

  _scrollController() async {
    List<String>? list = await api.getquery(query, page + 1);
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (list != null) {
        setState(() {
          page++;
          ls.addAll(list);
        });
      }
    }
  }

  void _handlePosition(ScrollPosition position) {
    position.isScrollingNotifier.addListener(_scrollController);
  }

  @override
  void initState() {
    // _controller = ScrollController(onDetach: _handlePosition);
    _controller.addListener(_scrollController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          String? s = await api.get();
          List<String>? first = await api.getquery("dog", page);
          setState(() {
            if (first != null) {
              ls = first;
            }
            isLoading = false;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text("Animal Search App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search...",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                setState(() {
                  isLoading = true;
                });
                List<String>? lists = await api.getquery(value, 1);
                setState(() {
                  query = value;
                  page = 1;
                  if (lists != null) {
                    ls = lists;
                  }
                  isLoading = false;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              //  height: height * 0.9,
              child: (isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      itemCount: ls.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 40,
                      ),
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return ImageContainer(image: ls[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
