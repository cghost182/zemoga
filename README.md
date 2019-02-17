# Posts inbox - Zemoga iOS Test


Greetings and thank you for taking the time to check my Coding Test attempt.

## Getting Started

The project has a minimalistic approach, I opted to use a cocoapods library called 'SwipeCellKit' -  https://github.com/SwipeCellKit/SwipeCellKit in order to delete a post with a short or long swipe to the left.

The architecture I used was MVVM, even though the viewModels don't implement heavy calculations, this would keep the code simpler to implement unit tests and easy to extend.

## Prerequisites

You must open the workspace and in the terminal run the 'pod install' command in oder to include correctly the libraries.

## Extra points

### 1. Animations:

When swiping from all posts to favorite posts.
When deleting all posts the delete button will dissapear and when all the posts are reloaded the button will appear again.

### 2. Unit tests:

For the requestsManager getting all the posts and to validate one particular post content

### 3. post Comments:

The comments will be displayed in the detailed view ( only the body )



