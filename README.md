# Etflix Movie App

A simple iOS application that fetches and displays a list of movies using the OMDb API. The app includes features for searching, filtering, and marking movies as favorites.

## Features

- Splash screen displaying the app logo.
- Main screen with a list of movies, including poster images, titles, and release dates.
- Movie details screen with additional information about the selected movie.
- Search functionality to filter movies by title.
- Favorite movies functionality using `UserDefaults`.

## Assumptions

- The app uses SwiftUI for the UI and Combine for handling asynchronous data and state management.
- The OMDb API requires an API key, which should be obtained from [OMDb API](http://www.omdbapi.com/apikey.aspx).
- The `MovieModel` model includes properties like `id`, `title`, `year`, `poster`, and `isFavourite`.

## Setup Instructions

### Prerequisites

- Xcode 15 or later
- Swift 5.8 or later

### Steps to Run the Project

1. **Clone the Repository**

   - git clone [https://github.com/yourusername/movie-app.git](https://github.com/matrecode/Etflix.git)
   - cd Etflix

    - Open the .xcodeproj or .xcworkspace file in Xcode and Run it

