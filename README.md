# 🛒 Flutter eCommerce App

A full-featured eCommerce app built using **Flutter** with **Provider** for state management, **Clean Architecture** principles, and **Dependency Injection** via `get_it`. This project demonstrates scalable project structure, clean code separation, and modern UI practices.

## Screenshots
![image1](https://github.com/user-attachments/assets/62d72515-e55e-4833-a1a4-c188cb395bde)
![image2](https://github.com/user-attachments/assets/10686c9b-bd43-4b27-9023-f3d03519c336)
![image3](https://github.com/user-attachments/assets/8f2fc8eb-50e9-4c51-91be-049b84e9cf87)

## video
https://github.com/user-attachments/assets/0206bea9-1b10-4bea-98f2-569a261003ae




## 🚀 Features

### 🖼️ Product Listing page
- Fetches products from [RapidAPI](https://rapidapi.com).
- Displays thumbnail, name, price, and a short description.
- Loading indicator shown while fetching data.
- Graceful error handling with user-friendly messages.
- Tap to navigate to product detail screen.

### 🔍 Product Details page
- Displays full image, name, detailed description, and price.
- "Add to Cart" and "Add to Wishlist" functionality.
- Confirmation messages upon successful actions.

### 🛍️ Cart
- Lists all added products with image, name, quantity, and price.
- Ability to increase/decrease quantity or remove items.
- Displays the total cart price formatted using Indian currency style (`₹1,23,456.00`).

### 💖 Wishlist
- Displays wishlisted products.
- Option to move items to cart or remove them.

---

## 🏗️ Architecture

This project uses **Clean Architecture** to promote separation of concerns and maintainability.

## 📁 Project Structure

```plaintext
lib/
├── core/  
│   ├── constants/  
│   │   ├── assets.dart: Holds app-wide asset paths.  
│   │   ├── strings.dart: Stores static string constants.  
│   │   ├── theme.dart: Defines app-wide theme constants.  
│   │   └── urls.dart: Contains URL endpoints.  
│   ├── error/  
│   │   ├── exceptions.dart: Defines custom exceptions.  
│   │   └── failure.dart: Contains failure models for error handling.  
│   ├── messages/  
│   │   └── app_messages.dart: Stores app messages (localization or static).  
│   ├── network/  
│   │   ├── dio_client.dart: Handles network requests via Dio.  
│   │   └── logger_interceptor.dart: Logs network requests and responses.  
│   ├── routing/  
│   │   ├── app_navigations.dart: Manages app navigation logic.  
│   │   └── app_routing.dart: Configures and handles app routes.  
│   ├── secret/  
│   │   └── app_secret.dart: Contains sensitive or secret keys (should be managed securely).  
│   └── usecase/  
│       └── base_usecase.dart: Defines the base class for app use cases.  
│
├── data/  
│   ├── models/  
│   │   └── Defines data models for handling data structures.  
│   ├── repositories_impl/  
│   │   └── Implements repository logic to fetch/process data.  
│   └── sources/  
│       └── Manages local or remote data sources (API, DB, etc.).  
│
├── domain/  
│   ├── entities/  
│   │   └── Defines core business entities.  
│   ├── repositories/  
│   │   └── Defines abstract repositories for data operations.  
│   └── usecases/  
│       └── Contains business logic and application use cases.  
│
├── presentation/  
│   ├── pages/  
│   │   └── Contains the app's screen layouts (UI).  
│   ├── provider/  
│   │   └── Manages state and business logic for presentation.  
│   └── widgets/  
│       └── Defines reusable UI components/widgets.  
│
├── service_locator.dart  // Manages Dependency Injection using 'get_it'.  
└── main.dart  // App entry point and initialization logic.

```
## 🧰 Packages Used

| Package | Usage |
|--------|-------|
| `provider` | State management |
| `get_it` | Dependency injection |
| `dio` | API calls |
| `logger` | Network logs |
| `dartz` | Functional programming (Either, Option) |
| `intl` | Currency & number formatting |
| `shimmer` | Loading UI |
| `lottie` | Animations |
| `cupertino_icons` | iOS-style icons |
| `another_carousel_pro` | Product image carousel |
| `google_nav_bar` | Bottom navigation bar |
| `loading_animation_widget` | Custom loading indicators |
| `flexi_productimage_slider` | Product image slide |


## 🌐 API Integration

This application uses a public API provided via **RapidAPI** to fetch product data.

- **Base URL**:  
  `https://real-time-amazon-data.p.rapidapi.com/`

The API is used to:
- Fetch the product list
- Retrieve product details by product ID

All API interactions are handled using the `dio` package and integrated with clean architecture for proper abstraction, error handling, and scalability.



## ✅ **Requirements**

    Flutter SDK: Latest stable version.

    Java JDK 17 or higher.

    VS Code or Android Studio.

    A valid RapidAPI key for accessing product data


## 🔧 Project Setup

### Prerequisites

Before you begin, make sure you have the following installed:

1. **Flutter SDK** (Version: 3.22.3 or higher)
   - To check if Flutter is installed, run:
     ```bash
     flutter --version
     ```
   - Example output:
     ```
     Flutter 3.22.3 • channel [user-branch] • unknown source
     Framework • revision b0850beeb2 (10 months ago) • 2024-07-16 21:43:41 -0700
     Engine • revision 235db911ba
     Tools • Dart 3.4.4 • DevTools 2.34.3
     ```

2. **Java Development Kit (JDK)** (Version 17 or higher)
   - Ensure that Java 17 is installed on your machine. You can verify it by running:
     ```bash
     java -version
     ```

3. **VS Code** (or any IDE of your choice)
   - Install **VS Code** for Flutter development.
   - Install the **Flutter** and **Dart** plugins in your IDE.

---

### 1. **Clone the Repository**

Once your development environment is ready, clone the repository to your local machine:

```bash
git clone https://github.com/subshegde/E-commerce-App.git
cd E-commerce-App
```

### 2. **API Key Setup**

This project uses a public API via RapidAPI. Add your RapidAPI key in the appropriate header section inside dio_client.dart:
**Using a .env file with the flutter_dotenv package is a better practice for managing secrets. However, for this demo, I’ve kept it simple.**
```bash

headers: {
  'X-RapidAPI-Key': '<YOUR_API_KEY>',
  'X-RapidAPI-Host': 'real-time-amazon-data.p.rapidapi.com',
},
```

### 3. **Install Dependencies**

Run the following command to install the required dependencies:

```bash
flutter pub get

```


### 4. **Run the App**

Start the app by running the following command:
```bash
flutter run
```


### 5. **Checking for Issues with** `flutter doctor`

To ensure your Flutter environment is correctly set up, run the following command:

```bash
flutter doctor
```

# Happy Coding
