import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:scaffoldwidget/scaffold.dart';
import 'package:scaffoldwidget/screens.dart';
//import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Scaffold Widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum MenuItem{
  item1,item2,item3,item4
}
class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin {

  late TabController _tabController;
  final List<Tab> toptab = <Tab>[
    const Tab(icon: Icon(Icons.groups)),// first tab icon
    const Tab(text: 'Chats'),// second tab name
    const Tab(text: "Status"),// third tab name
    const Tab(text: "Calls"),// fourth tab name
  ];

  //  int _currentIndex=0;
   final List<Widget> screens= <Widget>[
     const Screen1(),
     const Screen2(),
     const Screen3()
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

    /* Tahe Scaffold is a widget in Flutter used to implements the basic material design visual layout structure. It is quick enough
 to create a general-purpose mobile application and contains almost everything we need to create a functional and responsive
 Flutter apps. This widget is able to occupy the whole device screen. In other words, we can say that it is mainly responsible
  for creating a base to the app screen on which the child widgets hold on and render on the screen. It provides many widgets
  or APIs for showing Drawer, SnackBar, BottomNavigationBar, AppBar, FloatingActionButton, and many more.*/

    return WillPopScope(
      onWillPop: exit,
      child: Scaffold(
        primary: true,// It is used to tell whether the Scaffold will be displayed at the top of the screen or not. Its default value is true that means the height of the appBar extended by the height of the screen's status bar.
         // extendBodyBehindAppBar: true,//body widget can be behind the appbar at top of the screen
        appBar: AppBar(//It is a horizontal bar that is mainly displayed at the top of the Scaffold widget. It is the main part of the Scaffold widget and displays at the top of the screen. Without this property, the Scaffold widget is incomplete. It uses the appBar widget that itself contains various properties like elevation, title, brightness, etc.
          backgroundColor: Colors.white,//Background color of horizontal Bar i.e, AppBar
          elevation:15,//This property is used to raise the app bar using shadow, you need to pass the double value which determines the height of elevation of app bar.
          title: Text(widget.title),//This widget displays after the leading widget from the left side of app bar. Normally, it is used to show the title of the active screen of the app. You can pass any widget into it, normally, Text() widget is passed to show textual title on app bar.
          centerTitle: true,//It define whether the title should be placed in center or not.
         // leading: const Icon(Icons.account_circle),//You need to pass the widget into this parameter and it will be placed on the start-left side of an appbar. If there is any drawer into the same scaffold where app bar is implemented, the menu icon will automatically appear. The back button will appear in the same way when there is a back routing history of your app.
          //automaticallyImplyLeading: false,//By default, its value is true.  Make it false, if you don't want automatic placement of menu or back icons at leading.
          shadowColor: Colors.blue,// Shadow color of scaffold widget
          actions: [
           //You need to pass the list of widget into this parameter of AppBar class. The widgets will be displayed at the right side of app bar. Normally, quick action buttons are placed on this property.
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
          PopupMenuButton(
              onSelected: (value){
                if(value==MenuItem.item1){
                  //do some operation or navigate to other screen
                }
                else if(value==MenuItem.item2){
                  //do some operation or navigate to other screen
                }
                else if(value==MenuItem.item3){
                  //do some operation or navigate to other screen
                }
                else if(value==MenuItem.item4){
                  //do some operation or navigate to other screen
                }},
              itemBuilder: (context)=>[
            const PopupMenuItem(value: MenuItem.item1,child: Text('Item1')),
            const PopupMenuItem(value: MenuItem.item2,child: Text('Item2')),
            const PopupMenuItem(value: MenuItem.item3,child: Text('Item3')),
            const PopupMenuItem(value: MenuItem.item4,child: Text('Item4')),
          ])
          ],//Here we can use multiple widgets they will align at the right side of appbar horizontally
          bottom: TabBar( // It is create extra screen and we can traverse each other from appbar
            tabs: toptab,
            indicatorColor: Colors.white,
            controller: _tabController,
          ),
          bottomOpacity: 1.0,//A value 1.0 is fully opaque and 0.0 is fully transparent.It is used to animate the opacity when the appbar is scrolled
        //Transparent AppBar
          /*backgroundColor:Colors.transparent,
          elevation:0*/
        ),

//drawer: It is a slider panel that is displayed at the side of the body. Usually, it is hidden on the mobile devices, but the user can swipe it left to right or right to left to access the drawer menu. It uses the Drawer widget properties slides in a horizontal direction from the Scaffold edge to show navigation links in the application. An appropriate icon for the drawer is set automatically in an appBar property. The gesture is also set automatically to open the drawer. See the following code.
        drawer:  const DrawerWidget(),

//endDrawer: It is similar to a drawer property, but they are displayed at the right side of the screen by default. It can be swiped right to left or left to right.
  //action property of appbar and endDrawer can't be exist together in one screen
       /*
           endDrawer:  Drawer(
           backgroundColor: Colors.white,//Drawer background Color
           elevation: 30.0,
           shadowColor: Colors.purple, //Drawer shadow color
           surfaceTintColor: Colors.pinkAccent ,//Other than DrawerHeader space color
           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.elliptical(40.0,40.0))),//shape of drawer
           clipBehavior: Clip.antiAlias,//clip the content if space is not available for required content
           width: 260,//width of drawer
           semanticLabel: "Left Drawer",
           child: Column(
             children: <Widget>[
               UserAccountsDrawerHeader(
                   accountName: const Text("Arpit Aswal"),
                   accountEmail: const Text("arpitaswal@gmail.com"),
                   currentAccountPicture: const CircleAvatar(//owner account profile, here we can describe widgets
                     backgroundColor: Colors.yellow,
                     child: Icon(Icons.person,size: 40,),
                   ),
                   arrowColor: Colors.blue,
                   //currentAccountPictureSize: Size.square(72),//default size of currentAccountPicture
                   //otherAccountsPicturesSize: Size.square(40),//default size of otherAccountsPictures
                   // margin: EdgeInsets.only(bottom: 8.0),//default margin
                   otherAccountsPictures: const [ //other accounts profile, here we can describe list of widgets
                     CircleAvatar(
                       backgroundColor: Colors.yellow,
                       child: Icon(Icons.group,size: 30,),
                     ),
                     CircleAvatar(
                       backgroundColor: Colors.yellow,
                       child: Icon(Icons.groups,size: 30,),
                     ),
                   ],
                   onDetailsPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const Screen3()));
                   }
               ),
               const ListTile(
                 title: Text("Inbox"),
                 leading: Icon(Icons.mail),
               ),
               const Divider( height: 0.1,),
               const ListTile(
                 title: Text("Primary"),
                 leading: Icon(Icons.inbox),
               ),
               const ListTile(
                 title: Text("Social"),
                 leading: Icon(Icons.people),
               ),
               const ListTile(
                 title: Text("Promotions"),
                 leading: Icon(Icons.local_offer),
               )
             ],
           ),
         ),
*/

        //Draggable FloatingActionButton
         floatingActionButton: DraggableFab(//It makes this button to draggable in screen
          child: FloatingActionButton(//It is a button displayed at the bottom right corner and floating above the body. It is a circular icon button that floats over the content of a screen at a fixed place to promote a primary action in the application. While scrolling the page, its position cannot be changed. It uses the FloatingActionButton widget properties using Scaffold.floatingActionButton.
              elevation: 8.0,// it spread the shadow of button
              tooltip:"Increment",// this text is shown when the mouse cursor is above this button
              backgroundColor: Colors.tealAccent,
              foregroundColor: Colors.redAccent,
              hoverColor: Colors.purple,
              splashColor: Colors.yellow,// when we click on the button it change the color button into this color
              isExtended: true,// If it is set to true then the button becomes an extended floating action button.
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              onPressed: (){
                debugPrint('I am Floating Action Button');
              },
              child: const Icon(Icons.add)
          ),
        ),

       // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,// it set the position of floating action button

      // Add multiple FloatingActionButton in scaffold
       /*
              floatingActionButton: Wrap( //will break to another line on overflow
          direction: Axis.horizontal, //use vertical to show  on vertical axis
          children: <Widget>[
            Container(
                    margin: const EdgeInsets.all(10),
                    child: FloatingActionButton(
                      foregroundColor: Colors.white,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      onPressed: (){
                        //action code for button 1
                      },
                      child: const Icon(Icons.add),
                    )
            ),

            Container(
                    margin:const EdgeInsets.all(10),
                    child: FloatingActionButton(
                      foregroundColor: Colors.white,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      onPressed: (){
                        //action code for button 2
                      },
                      backgroundColor: Colors.deepPurpleAccent,
                      child: const Icon(Icons.add_call),
                    )
            ),

            Container(
                    margin:const EdgeInsets.all(10),
                    child: FloatingActionButton(
                      foregroundColor: Colors.white,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      onPressed: (){
                        //action code for button 3
                      },
                      backgroundColor: Colors.deepOrangeAccent,
                      child: const Icon(Icons.add_alert),
                    )
            ),

            // Add more buttons here
          ],),

         */

      //Speed Dial Expandable Floating Action Menu
      /*
          floatingActionButton: SpeedDial( //Speed dial menu
          tooltip: "Menu",
          icon: Icons.menu, //icon on Floating action button
          activeIcon: Icons.close, //icon when menu is expanded on button
          backgroundColor: Colors.deepOrangeAccent, //background color of button
          foregroundColor: Colors.white, //font color, icon color in button
          activeBackgroundColor: Colors.deepPurpleAccent, //background color when menu is expanded
          activeForegroundColor: Colors.white,
          visible: true,//use to get the button hidden on scroll.
          closeManually: false, // If true tapping on speed dial's children will not close dial anymore
          curve: Curves.easeInOut,
          overlayColor: Colors.black,//The color of the background overlay
          overlayOpacity: 0.5,//The opacity of the background overlay when the dial is open
          onOpen: () => print('OPENING DIAL'), // action when menu opens
          onClose: () => print('DIAL CLOSED'), //action when menu closes
          elevation: 8.0, //shadow elevation of button

          children: [
            SpeedDialChild( //speed dial child
              child: const Icon(Icons.accessibility),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'First Menu Child',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD'),
              onLongPress: () => print('FIRST CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              label: 'Second Menu Child',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () => print('SECOND CHILD'),
              onLongPress: () => print('SECOND CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: const Icon(Icons.keyboard_voice),
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              label: 'Third Menu Child',
              labelStyle: const TextStyle(fontSize: 18.0),
              onTap: () => print('THIRD CHILD'),
              onLongPress: () => print('THIRD CHILD LONG PRESS'),
            ),

            //add more menu item childs here
          ],
        ),
      */

        // It is a list of buttons that are displayed at the bottom of the Scaffold widget. These property items are always visible; even we have scroll the body of the Scaffold. It is always wrapped in a ButtonBar widget. They are rendered below the body but above the bottomNavigationBar.
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
         Row(
           children: [
             const Expanded(child: Text('https://www.javatpoint.com/flutter-interview-questions',style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue,decorationColor: Colors.blue),)),
             TextButton(onPressed: (){}, child: const Icon(Icons.ads_click)),
           ],
         )
        ],

        //This property is like a menu that displays a navigation bar at the bottom of the Scaffold. It can be seen in most of the mobile applications. This property allows the developer to add multiple icons or texts in the bar as items. It should be rendered below the body and persistentFooterButtons.
          bottomNavigationBar:  BottomNavigation(),

        // resizeToAvoidBottomInset: If it is true, the body and the Scaffold's floating widgets should adjust their size themselves to avoid the onscreen keyboard. The bottom property defines the onscreen keyboard height.
        resizeToAvoidBottomInset: true,

        body:  //It will display the main content in the Scaffold. It signifies the place below the appBar and behind the floatingActionButton & drawer. The widgets inside the body are positioned at the top-left of the available space by default.

         // for TabBar screens

        TabBarView(
        controller: _tabController,
        children: const[
          Screen1(),
          Screen2(),
          Screen3(),
          Screen4()
        ]
        ),

   // BottomNavigationBar screens
        // we create simple BottomNavigationBar but the problem is that the state of the widget is lost on changing the tab,if we have text in textfield on one screen then text will be vanished because we chnage the screen and its preserved state is destroyed so can handle this-
        //To maintain the state of each BottomNavigationBarItem we will make use of IndexedStack which is basically a Stack that shows a single child from a list of children.

        //   IndexedStack(index:0, children: [FadeTransition(opacity: fadeAnimation, child: screens[BottomNavigation().index])],)
      ),
    );
  }

  Future<bool> exit() async{
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:const Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:const Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialog had returned null, then return false
  }

}
