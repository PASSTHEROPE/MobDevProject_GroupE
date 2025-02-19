import 'package:flutter/material.dart';
import 'package:recipe_project/details.dart';
import '../model/recipe_list.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String rating;
  final String cookTime;
  final String thumbnailUrl;
  final Function() onTap;

  RecipeCard(
      {required this.title,
      required this.cookTime,
      required this.rating,
      required this.thumbnailUrl,
      required this.onTap});

  void navigateToDetails(BuildContext context, RecipeModel data) {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => RecipeDetails(model: data))));
  }

  bool isLoading = true;
  late List<RecipeModel> listRecipes;
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    const thepurple = Color(0xFF733FF1);
    const theblue = Color(0xff202032);
    const thewhite = Colors.white;

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: theblue.withOpacity(1.0),
              offset: Offset(
                0.0,
                20.0,
              ),
              blurRadius: 6.0,
              spreadRadius: -7.5,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 230,
                child: Image.network(thumbnailUrl),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 240,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
