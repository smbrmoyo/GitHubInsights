# GitHub Insights

Welcome to **GitHub Insights** – an app built for iOS using SwiftUI. This project highlights my proficiency in integrating the GitHub API, creating custom UI components, working with SwiftUI's declarative syntax, building reusable generic views and functions, and following a clean architectural design (MVVM). The app also integrates continuous delivery using **Fastlane** and contains unit tests to ensure code reliability.

---

## Highlights

- **GitHub API Integration**: Fetch data from GitHub repositories, including trending repositories and repository activities. The app handles pagination and showcases efficient data fetching using Swift’s `async/await`.
- **Custom UI Components**: For example, a RefreshableScrollView that supports efficient pagination using a lazy loading mechanism, ensuring both memory and data efficiency. It also dynamically displays content or a ProgressView based on the loading state and can trigger data refresh when scrolled to the bottom.
- **Generics**: Extensive use of generic views and functions, ensuring reusability and flexibility throughout the app.
- **MVVM Architecture**: The app follows the **MVVM** pattern, providing a clear separation of concerns and making the app scalable and maintainable.
- **Repository Pattern**: The app uses the **Repository Pattern** to manage network requests, ensuring loose coupling between the view models and network logic.
- **Dependency Injection**: The use of **Dependency Injection** allowing for the flexibility of real or mock repositories, improving testability and modularity.
- **Unit Testing**: Comprehensive unit tests for the ViewModel layer, ensuring correct behavior of business logic and API interactions.
- **Fastlane Integration**: Automated deployment workflows using **Fastlane** for continuous integration and deployment. Fastlane is used to streamline the process of building, testing, and deploying the app.

---

## Screenshots

<p>
  <img src="./img/Login.png" width="200">
  <img src="./img/Home.jpg" width="200">
  <img src="./img/Kategorien.jpg" width="200">
  <img src="./img/Dashboard.jpg" width="200">
  <img src="./img/Gästeliste.jpg" width="200">
</p>

---

## Setup and Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/smbrmoyo/GitHubInsights.git
   cd GitHubInsights
