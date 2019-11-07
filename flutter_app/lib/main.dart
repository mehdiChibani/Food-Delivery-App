import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/fooditem.dart';
import 'bloc/cardListBloc.dart';
import 'package:badges/badges.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueGrey);
    return BlocProvider(
        blocs: [Bloc((i) => CardListBloc())],
        child: MaterialApp(
          title: 'Food Delivery',
          home: Home(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              FirstHalf(),
              SizedBox(height: 45,),
              for(var foodItem in fooditemList.foodItems)
                ItemContainer(foodItem:foodItem)
            ],
          ),
        ),
      ),
    ));
  }
}
class ItemContainer extends StatelessWidget{
  final FoodItem foodItem;
  ItemContainer({
    @required this.foodItem
});
  final CardListBloc bloc=BlocProvider.getBloc<CardListBloc>();
  addToCart(FoodItem foodItem){
    bloc.addTolist(foodItem);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        print('tapped');
        addToCart(foodItem);
        final snackBar=SnackBar(
          content: Text("${foodItem.title} added to Cart"),
          duration: Duration(microseconds: 1000),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        hotel:foodItem.hotel,
        itemName:foodItem.title,
        itemPrice:foodItem.price,
        imgUrl:foodItem.imgUrl,
        leftAligned:(foodItem.id%2==0)?true:false
      ),
    );
  }

}
class Items extends StatelessWidget{
  final String hotel;
  final String itemName;
  final double itemPrice;
  final String imgUrl;
  final bool leftAligned;
  Items({
    @required this.imgUrl,
    @required this.hotel,
    @required this.itemName,
    @required this.itemPrice,
    @required this.leftAligned,

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double containerPadding=45;
    double containerBorderRaduis=10;

    return Column(
children: <Widget>[
  Container(
    padding: EdgeInsets.only(
      left: leftAligned ? 0:containerPadding,
      right: leftAligned ? containerPadding:0,
    ),
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity ,
          height: 200,
          decoration:BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(
            left: leftAligned? Radius.circular(0):Radius.circular(containerBorderRaduis),
            right: leftAligned? Radius.circular(containerBorderRaduis):Radius.circular(0),
          ),
              child: Image.network(imgUrl,fit: BoxFit.fill,),

        )
        ),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.only(
            left: leftAligned?20:0,
            right: leftAligned ?0:20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(itemName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    ),

                    ),

                  ),
                  Text("\$$itemPrice",
                    style:TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    )
                  )
                ],
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15
                    ),
                    children: [
                      TextSpan(text: "by : "),
                      TextSpan(text: hotel,style: TextStyle(
                        fontWeight: FontWeight.w700
                      ))
                    ]
                  ),
                ),
              ),
              SizedBox(height: containerPadding,)
            ],
          ),
        )
      ],
    ),
    )

    ],
    );
  }

}

class FirstHalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        CustomAppBar(),
        SizedBox(
          height: 30,
        ),
        title(),
        SizedBox(
          height: 30,
        ),
        SearchBar(),
        SizedBox(
          height: 30,
        ),
        Categories(),
      ],
    );
  }

  Widget Categories() {
    return Container(
      height: 185,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: true,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Pizza",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Rolls",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
          CategoryListItem(
            categoryIcon: Icons.bug_report,
            categoryName: "Burgers",
            availability: 12,
            selected: false,
          ),
        ],
      ),
    );
  }

  Widget SearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.black45,
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search...",
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                hintStyle: TextStyle(color: Colors.black87)),
          ),
        )
      ],
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "food",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        Text("Delivery",
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 30))
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final CardListBloc bloc=BlocProvider.getBloc<CardListBloc>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context,snapshot){
              List<FoodItem> foodItems=snapshot.data;
              int lenght=foodItems!=null?foodItems.length:0;
              return buildGestureDetector(lenght,context,foodItems);
            }
          )
        ],
      ),
    );
  }
  GestureDetector buildGestureDetector(int lenght,BuildContext context,List<FoodItem> foodItems){
    return GestureDetector(
      onTap: (){},
      child:

      Container(
        margin: EdgeInsets.only(right: 30),
        child:  Badge(
          badgeContent: Text(lenght.toString()),
          child: Icon(Icons.shopping_basket,size: 35,),
        )
      ),
    );
  }
}
class CategoryListItem extends StatelessWidget{
  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;
  CategoryListItem({
    @required this.availability,
  @required this.categoryIcon,
  @required this.selected,
  @required this.categoryName
});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 20), 
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected? Color(0xfffeb324):Colors.white,
        border: Border.all(
          color: selected? Colors.transparent:Colors.grey[200],
          width: 1.5
        ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100],
              blurRadius: 15,
              offset: Offset(25,0),
              spreadRadius: 5
      )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration:   BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected ? Colors.transparent:Colors.grey,
                width: 1.5

              )
            ),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          )
        ],
      ),
      
    );
  }

}