import 'package:flutter/material.dart';

// A stateless widget to display recipe details
class RecipeDetailPage extends StatelessWidget {
  // A map to hold the recipe details
  final Map recipe;

  // Constructor to initialize the recipe map
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with title, background color, and styling
      appBar: AppBar(
        title: Text(recipe['title']),
        backgroundColor: Colors.green,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        // Padding around the body content
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Scrollable content for the recipe details
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the recipe image
              Image.network(recipe['image']),
              const SizedBox(height: 10), // Spacing between elements
              // Display the recipe title with styling
              Text(recipe['title'],
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10), // Spacing between elements
              // Display the number of servings
              Text("Servings: ${recipe['servings']}"),
              const SizedBox(height: 10), // Spacing between elements
              // Display the preparation time
              Text("Ready in ${recipe['readyInMinutes']} minutes"),
              // Display the source name of the recipe
              Text("sourceName:${recipe['sourceName']}"),
              // Display whether the recipe is dairy-free
              Text("dairyFree:${recipe['dairyFree']}"),
              // Display whether the recipe is cheap
              Text("cheap:${recipe['cheap']}"),
            ],
          ),
        ),
      ),
    );
  }
}
