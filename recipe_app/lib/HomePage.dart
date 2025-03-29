// Importing the dart:convert library for JSON encoding and decoding.
import 'dart:convert';
// Importing Flutter's material design package.
import 'package:flutter/material.dart';
// Importing the RecipeDetailPage for navigation.
import 'package:geeks_for_geeks/RecipeDetailPage.dart';
// Importing the HTTP package for making API requests.
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // API key for accessing the Spoonacular API.
  final String apiKey = "API_KEY";
  // List to store the fetched recipes.
  List recipes = [];

  @override
  void initState() {
    super.initState();
    // Fetching recipe IDs when the widget is initialized.
    fetchRecipeIDs();
  }

  // Function to fetch random recipe IDs from the Spoonacular API.
  Future<void> fetchRecipeIDs() async {
    // API endpoint for fetching random recipes.
    final url = Uri.parse(
        "https://api.spoonacular.com/recipes/random?number=50&apiKey=$apiKey");
    // Making a GET request to the API.
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the response is successful, decode the JSON response.
      List<dynamic> randomRecipes = json.decode(response.body)['recipes'];
      // Extracting recipe IDs from the response.
      List<String> recipeIds =
          randomRecipes.map((recipe) => recipe['id'].toString()).toList();
      fetchRecipes(recipeIds); // Fetching detailed recipes using the IDs.
    } else {
      // Logging an error message if the request fails.
      print("Failed to fetch recipe IDs");
    }
  }

  // Function to fetch detailed recipe information using recipe IDs.
  Future<void> fetchRecipes(List<String> ids) async {
    // API endpoint for fetching detailed recipe information.
    final url = Uri.parse(
        "https://api.spoonacular.com/recipes/informationBulk?ids=${ids.join(',')}&apiKey=$apiKey");
    // Making a GET request to the API.
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        // Updating the state with the fetched recipes.
        recipes = json.decode(response.body);
      });
    } else {
      // Logging an error message if the request fails.
      print("Failed to load recipes");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Building the UI for the HomePage widget.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        backgroundColor: Colors.green,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: recipes.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Showing a loading indicator if recipes are not yet loaded.
          : ListView.builder(
              // Building a list view to display the recipes.
              itemCount: recipes.length, // Number of items in the list.
              itemBuilder: (context, index) {
                final recipe = recipes[
                    index]; // Accessing the recipe at the current index.
                return ListTile(
                  leading:
                      Image.network(recipe['image'], width: 50, height: 50),
                  title: Text(recipe['title']),
                  onTap: () {
                    // Navigating to the RecipeDetailPage when a recipe is tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(
                            recipe:
                                recipe), // Passing the recipe to the detail page.
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
