import 'package:animalsearchapp/provider/dataapi.dart';
import 'package:animalsearchapp/Widgets/imagecontainer.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiFetch api = ApiFetch();
  bool isLoading = true;
  int page = 1;
  // List<PexelsPhoto> ls = context.read<GetApi>().list;
  String query = "";
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scrollControl() async {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange &&
          isLoading) {
        isLoading = false;
        await Provider.of<ApiFetch>(context, listen: false)
            .getPexellistbyScoll(context);
        isLoading = true;
      }
    }

    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    _controller.addListener(scrollControl);
    List<PexelsPhoto>? list = Provider.of<ApiFetch>(context).list;

    return Scaffold(
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
              onSubmitted: (value) {
                Provider.of<ApiFetch>(context, listen: false)
                    .getPexelList(value, context);
              },
            ),
          ),
          Expanded(
            child: Container(
              //  height: height * 0.9,
              child: (list == null)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      itemCount: list.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return ImageContainer(image: list[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
