import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_project/details.dart';
import 'package:recipe_project/model/recipe_api.dart';
import 'package:recipe_project/model/recipe_list.dart';
import 'package:recipe_project/navigation/bottomNavBar.dart';

import 'package:recipe_project/widgets/recipe.dart';

import '../User/profile_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isLoading = true;
  late List<RecipeModel> listRecipes;
  late List<RecipeModel> listRecipes2;
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();

    getRecipes();
  }

  Future<void> getRecipes() async {
    try {
      listRecipes = await RecipeAPI.fetchRecipe();
      listRecipes2 = await RecipeAPI.fetchRecipe();
      print('listRecipes: $listRecipes');
      print('listRecipes[0]: ${listRecipes[0]}');
      setState(() {
        isLoading = false;
      });
      print(listRecipes);
    } catch (e, st) {
      listRecipes = [];
      print(e);
      print(st);
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Error"),
              content: Text("Cannot load the data"),
            );
          },
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToDetails(BuildContext context, RecipeModel data) {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => RecipeDetails(model: data))));
  }

  void searchRecipe(String query) {
    final suggestions = listRecipes2.where((recipe) {
      final recipeName = recipe.name.toLowerCase();
      final input = query.toLowerCase();
      return recipeName.contains(input);
    }).toList();
    setState(() => listRecipes = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const thepurple = Color(0xFF733FF1);
    const theblue = Color(0xff202032);
    const thewhite = Colors.white;

    return Scaffold(
      backgroundColor: thewhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theblue,
        actions: [
          FadeIn(
            delay: const Duration(seconds: 1),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Welcome back",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Begum",
                      style: TextStyle(
                        color: thewhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(left: 200, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: theblue),
                  child: const Icon(
                    Icons.logout,
                    color: thewhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Spacer(flex: 1),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Recipe Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: thepurple))),
                  onChanged: searchRecipe,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listRecipes.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: RecipeCard(
                          onTap: () {
                            navigateToDetails(context, listRecipes[index]);
                          },
                          title: listRecipes[index].name,
                          cookTime: listRecipes[index].totalTime,
                          rating: listRecipes[index].rating.toString(),
                          thumbnailUrl: listRecipes[index].images,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: FadeInUp(child: BottomNa()),
    );
  }
}
