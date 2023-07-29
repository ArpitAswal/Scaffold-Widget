import "package:flutter/material.dart";
import "package:scaffoldwidget/screens.dart";

class BottomNavigation extends StatefulWidget {

  BottomNavigation({super.key,});

  final int index= _BottomNavigationState()._currentIndex;
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _currentIndex=1;

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      currentIndex: _currentIndex,//initial index, which screen should be render when the app is open
      type: BottomNavigationBarType.fixed,
      elevation: 12,
      backgroundColor: Colors.greenAccent[100],//set the background color of bottomnaviagionbar
      fixedColor: Colors.red, // The fixedColor property is used for the color of the active icon. either it exist or selectedItemColor
      //selectedItemColor: Colors.red,
      unselectedItemColor: Colors.blue,// It set the color of icons and labels of unselected items
      showSelectedLabels: true, // whether the label text is shown for selected bottom navigation bar item
      // showUnselectedLabels: false,// whether the label text is shown for unselected bottom navigation bar items
      iconSize:24, // all icon size of items
      selectedFontSize: 18, //It set the font size of selected bottom navigation bar item
      unselectedFontSize: 14, // It set the size of unselected bottom navigation bar items
      // we can also set text style of labels by selectedLableStyle and unselectedLabelStyle

      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Video Call",
          icon: Icon(Icons.videocam),
        ),
        BottomNavigationBarItem(
          label: "Account",
          icon: Icon(Icons.account_circle),
        ),
      ],
      onTap: (int itemIndex){
        setState(() {
          _currentIndex = itemIndex;
        });
        debugPrint("$_currentIndex");
      },
    );
  }
}


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,//Drawer background Color
      elevation: 30.0,
      shadowColor: Colors.purple, //Drawer shadow color
      surfaceTintColor: Colors.pinkAccent ,//Other than DrawerHeader space color
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.elliptical(40.0,40.0))),//shape of drawer
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
              }
          ),
           ListTile(
            title: const Text("Inbox"),
            leading: const Icon(Icons.mail),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Screen1()));
            },
          ),
          const Divider( height: 0.1,),
           ListTile(
            title: const Text("Primary"),
            leading: const Icon(Icons.inbox),
               onTap:() {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const Screen2()));
               }),
           ListTile(
            title: const Text("Social"),
            leading: const Icon(Icons.people),
               onTap:() {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const Screen3()));
               }),
           ListTile(
            title: const Text("Promotions"),
            leading: const Icon(Icons.local_offer),
               onTap:() {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => const Screen4()));
               })
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate{

  List<String> suggestion=[
    "Africa",
    "Brazil",
    "Chile",
    "Denmark",
    "England",
    "France",
    "Ghana",
    "Hungary",
    "India",
    "Japan",
    "Kenya",
    "Libya",
    "Mexico",
    "Netherlands",
    "Oman"
    "Poland",
    "Qatar",
    "Russia",
    "SouthKorea",
    "Thailand",
    "Uruguay",
    "Vietnam",
    "wales",
    "Yemen",
    "Zimbabwe"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
  return [ IconButton(onPressed: (){
     if(query.isEmpty){
       close(context, null);//close searchbar
     }
     else{
       query="";
       Navigator.pop(context);
     }
    }, icon: const Icon(Icons.clear))
  ];}

  @override
  Widget? buildLeading(BuildContext context) {
  return IconButton(onPressed: (){
     close(context, null);//close searchbar
   }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child:Text(query,style:const TextStyle(fontSize: 60,fontWeight: FontWeight.w500))
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  List<String> searchResult= suggestion.where((suggestion){
    final result =suggestion.toLowerCase();
    final input =query.toLowerCase();
    return result.contains(input);
  }).toList();

   return ListView.builder(
       itemCount: searchResult.length,
       itemBuilder: (context,index){
     final suggest=searchResult[index];
     return ListTile(
       title:Text(suggest),
       onTap: (){
         query=suggest;
       showResults(context);
         },
     );
   });
  }

}
