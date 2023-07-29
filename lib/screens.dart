import "package:flutter/material.dart";
import "package:scaffoldwidget/scaffold.dart";

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 1",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with TickerProviderStateMixin {

  late TabController _tabController;
  final List<Tab> toptab = <Tab>[
    const Tab(icon: Icon(Icons.groups,size: 30,)),// first tab icon
    const Tab(text: 'Chats'),// second tab name
    const Tab(text: "Status"),// third tab name
    const Tab(text: "Calls"),// fourth tab name
  ];

  late Animation<double> fadeAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    _tabController = TabController(
      length: 4, //No of screen
      initialIndex: 0, // starting screen
      vsync: this,
    )..addListener(() {
      setState(() {});
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    fadeAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    fadeAnimation.isDismissed;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: false,// AppBar displayed 0%, if it is true displayed 100% at once
              pinned: false,// AppBar pinned to top when we scroll down if it is true
              floating: true,// AppBar appears immediately when we try to scroll up at any time if it is true otherwise if it is false appbar will appear when we at top element
               title: const Text('SliverAppBar Widget',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color:Colors.brown),),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network("https://cdn.pixabay.com/photo/2018/03/04/09/51/space-3197611_640.jpg",fit: BoxFit.cover,filterQuality: FilterQuality.high,),
              ),
              expandedHeight: 160,
              backgroundColor: Colors.blueAccent,
             // leading: const DrawerWidget(),//IconButton
              actions: <Widget>[
                IconButton(
                    icon: const Icon(Icons.camera),
                    onPressed: (){
                      //code to execute when this button is pressed
                    }
                ),

                IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: (){
                      //code to execute when this button is pressed
                      showSearch(context: context, delegate: MySearchDelegate());
                    }
                ),
              ],
              bottom: TabBar( // It is create extra screen and we can traverse each other from appbar
                tabs: toptab,
                indicatorColor: Colors.blue,
                labelColor: Colors.red,
                unselectedLabelColor: Colors.brown,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(
                  tileColor: (index % 2 == 0) ? Colors.white : Colors.green[50],
                  title: Center(
                    child: Text('$index',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 50,
                            color: Colors.greenAccent[400]) //TextStyle
                    ), //Text
                  ), //Center
                ), //ListTile
                childCount: 51,
              ), //SliverChildBuildDelegate
            ) //SliverList
          ], //<Widget>[]
        ) //CustonScrollView
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 3",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  const Screen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 4",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
