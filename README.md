# MyMovies - iOS App

## Overview

MyMovies is a mobile application designed to allow users to explore, discover, and save their favorite movies. It fetches movie information from the Moviedb API and allows users to maintain a favorites list stored locally using CoreData. The application is built using UIKit & Swift, focusing on programmatic UI design and leveraging URLSession for network requests.

## ScreenShots

<p align="center">
      <img width="400" alt="Screenshot 2024-03-15 at 14 29 09" src="https://github.com/IhorLeshko/MyMovies/assets/88483745/a3682ecf-1ebe-42db-87d5-d0bdc2216d0d" align="left">
      <img width="400" alt="Screenshot 2024-03-15 at 14 29 21" src="https://github.com/IhorLeshko/MyMovies/assets/88483745/fabf31d1-018a-44fe-9d48-22c9d8f7fb83" align="left">
</p>

## Technology Stack

- **Swift**: The primary programming language used for developing the iOS app.
- **UIKit**: Used for constructing and managing the app's user interface programmatically, providing a rich set of tools to create fully custom views without the use of Storyboards.
- **CoreData**: Provides local data storage capabilities. CoreData is used to persist user-related data like the favorites list, allowing for offline access and data persistence across application launches.
- **URLSession**: Utilized for network requests to fetch data from the Moviedb API. URLSession supports both data tasks for fetching raw data.

## Architecture

The application employs an MVVM architecture, ensuring a separation of the user interface from the business logic and model. This architecture aids in making the codebase more maintainable and scalable.
In this project, communication between ViewModel and View is implemented using callbacks. 

## Code Structure

- **Controllers**: Houses the UIViewController subclasses such as [`FavouritesVC`](MyMovies/Controllers/FavouritesVC.swift) and [`MovieDetailsVC`](MyMovies/Controllers/MovieDetailsVC.swift), managing the app's various screens.

- **CoreData/Entities**: Contains the CoreData entity definitions such as [`Movie`](MyMovies/CoreData/Entities/Movie+CoreDataClass.swift) and [`Movie+CoreDataProperties`](MyMovies/CoreData/Entities/Movie+CoreDataProperties.swift).

- **CoreData**: Includes [`CoreManager`](MyMovies/CoreData/CoreManager.swift) for handling all CoreData operations, including fetching and saving favorite movies.

- **ViewModel**: Features the ViewModel classes like [`FavouritesVCViewModel`](MyMovies/ViewModel/FavouritesVCViewModel.swift) that bridge the view and model, handling the presentation logic and state management.

- **Preview Helpers**: Contains SwiftUI preview providers such as [`SwiftUIPreviewView`](MyMovies/Preview Helpers/SwiftUIPreviewView.swift) and [`SwiftUIPreviewVC`](MyMovies/Preview Helpers/SwiftUIPreviewVC.swift) for leveraging SwiftUI previews in a UIKit project.

## Getting Started

To get started with MyMovies, you'll need Xcode installed on your macOS system. Clone the repository, open the project in Xcode, and run it on your preferred simulator or physical iOS device.

For more detailed setup instructions and contributing guidelines, please refer to the documentation provided within the repository.

## Conclusion

MyMovies is an iOS application built using modern Swift technologies, showcasing the utilization of UIKit, CoreData, URLSession, and MVVM within a programmatic UI design approach. It offers users a platform to explore and save movies, demonstrating efficient data fetching and local data persistence strategies.
