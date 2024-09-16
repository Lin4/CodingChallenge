# CodingChallenge
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
## Screenshots 
![image2](https://github.com/user-attachments/assets/ebef936f-64b4-41fe-b8ee-0808315a05b9)
![image1](https://github.com/user-attachments/assets/2b921db4-2b58-4b17-af04-097c5afb445b)
![image3](https://github.com/user-attachments/assets/d3564b9d-b3ed-4cf0-adf6-b0b3cd37a5b2)
![image6](https://github.com/user-attachments/assets/09f97f88-b302-4589-8727-8c01a4313a7d)
![image4](https://github.com/user-attachments/assets/e82a4919-2735-4c38-be13-14fad9ba5a9a)


