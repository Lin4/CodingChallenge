# SwiftUI MVVM Weather App


## This repository contains a simple yet comprehensive weather app developed using SwiftUI with the MVVM-C (Model-View-ViewModel-Coordinator) architecture pattern. It leverages the OpenWeatherMap API to provide users with up-to-date weather information for cities in the United States, alongside robust error handling, dependency injection, and clean architecture principles.

## Getting Started

- This app focuses on several core functionalities:

### Search for Weather: 
Users can search for any U.S. city and view current weather details such as temperature, humidity, and weather conditions.

### Auto-complete City Search:
As the user starts typing a city name, a dropdown list of cities that begin with the entered letters is displayed. The user can then select a specific city from this list, and upon selection, they are navigated to the detailed view of that city's weather information.

 ###Image Caching"
 In the weather app I used Core Data for weather data caching, users can bookmark a city's weather details directly from the weather detail view by tapping a bookmark button. This action allows users to save their favorite cities for easy access in the future. Bookmarked cities are then displayed on the home view, providing quick access to their weather information. Users can also unbookmark cities if they choose to remove them from their list of favorites.
 
### Location-Based Weather:
 Users can give location access permission, allowing the app to display weather for their current location by default.
 
### Weather Icon:
 The app downloads and displays the weather condition as an icon from OpenWeatherMap.
 
### Error Handling & Edge Cases:
 The app gracefully handles unexpected errors and edge cases.
 
### Dependency Injection: 
It uses DI for each architecture component to improve maintainability and testability.

### Unit Testing:
 Unit tests are included to ensure the functionality of the ViewModel and Model layers.    
