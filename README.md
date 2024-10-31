# rekrutacja solvro mobile 2024
This app will show you cocktails, their photos, ingredients and intructions to prepare them. <br>
I really like the outcome, and I hope you will like it too :) 

## User experience
When you open an app, you will encounter a loading page. If there is no internet connection - you will be prompted to turn it on.
<img src="assets/github/LoadingScreen.jpg" alt="Demo of the loading screen" width="200"/>

<br>

Then you will be placed in the main page of the app. Yes, it's an infinite scroller! Just scroll it down to get more cocktails :)
<img src="assets/github/MainMenu.jpg" alt="Demo of the main screen" width="200"/>

<br>

You can easily change the displayed grid clicking on the button in the right bottom corner (just above the text input). <br>
Here is the setting for one image in the row:<br>
<img src="assets/github/Grid1.jpg" alt="Demo of the main screen" width="200"/><br>
And here is the setting for 2 images in the row:<br>
<img src="assets/github/Grid2.jpg" alt="Demo of the main screen" width="200"/><br>
And by default you begin with 3 images in the row. So whenever you are on a bigger machine or just on a little phone, you can easily enhance your browsing experience :)

But that's not all!<br>
You are also granted with the filter window<br>
<img src="assets/github/FilterWindow.jpg" alt="Demo of the filter window" width="200"/><br>
Here you can filter various details of your cocktail and also you can easily sort it. And once you click again on the filter button, you will get what you wanted :) <br>
You can also find your cocktail recipe by searching it by name easily in the text field in the bottom of the screen: <br>
<img src="assets/github/Orange_search.jpg" alt="Demo of the search" width="200"/><br>
And once you find it what you wanted, just click on the cocktail to see all the details and information how to prepare it.<br>
<img src="assets/github/Cocktail_view.jpg" alt="Demo of the cocktail detailed view" width="200"/><br>
Now you are ready to prepare the best cocktail in your life!

# Specification
 - Project done entirely in flutter in dart.

### Implemented:
- listing and displaying cocktails and their details
- searching / filtring / sorting cocktails
- fetching and caching cocktails from the CocktailApi
- Infinite Scroll
- Debouncing when searching
- Caching requests (see Services/DataCacher (for cocktails and ingredients and Services/DataManagerSingleton for request with their unique id to Cocktails)
- Caching cocktail and ingredient images using CachedNetworkImageProvider utility.
- custom cocktail grid with its animation
- And many more!

There is also limited responsiveness ( sorry I ran out of time, my bad :(

# Troubleshoot
If at any point, any error occured, feel free to share in the issues tab.
