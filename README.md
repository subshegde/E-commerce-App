# 🛒 Flutter eCommerce App

A full-featured eCommerce app built using **Flutter** with **Provider** for state management, **Clean Architecture** principles, and **Dependency Injection** via `get_it`. This project demonstrates scalable project structure, clean code separation, and modern UI practices.

![image1](https://github.com/user-attachments/assets/62d72515-e55e-4833-a1a4-c188cb395bde)
![image2](https://github.com/user-attachments/assets/10686c9b-bd43-4b27-9023-f3d03519c336)
![image3](https://github.com/user-attachments/assets/8f2fc8eb-50e9-4c51-91be-049b84e9cf87)


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
│   │   ├── assets.dart
│   │   ├── strings.dart
│   │   ├── theme.dart
│   │   └── urls.dart
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failure.dart
│   ├── messages/
│   │   └── app_messages.dart
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── logger_interceptor.dart
│   ├── routing/
│   │   ├── app_navigations.dart
│   │   └── app_routing.dart
│   └── usecase/
│       └── base_usecase.dart
│
├── data/
│   ├── models/
│   ├── repositories_impl/
│   └── sources/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
├── presentation/
│   ├── pages/
│   ├── provider/
│   └── widgets/
│
├── service_locator.dart  // Dependency Injection (get_it)
└── main.dart 
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


