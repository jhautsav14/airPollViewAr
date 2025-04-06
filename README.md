# ar_ttt5

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Here's a comprehensive **README.md** for your **Air Pollution Tracker** GitHub repository:

---

# 🌍 Air Pollution Tracker

A Flutter application that monitors real-time air quality data, displays AQI levels, and provides detailed pollutant information with an interactive AR experience.

![App Screenshot](assets/screenshots/app_preview.png) *(Replace with your actual screenshot)*

## ✨ Features

- **Real-time Air Quality Data** - Fetches and displays current pollution levels
- **AQI Visualization** - Color-coded AQI scale (1-5) with qualitative indicators
- **Pollutant Breakdown** - Detailed concentration levels for:
  - SO₂, NO₂, PM₁₀, PM₂.₅, O₃, and CO
- **Interactive Charts** - Visualize pollutant data with dynamic line charts
- **Augmented Reality** - AR view to visualize air quality in your environment
- **Educational Content** - Complete AQI reference guide with health implications

## 📊 AQI Reference Table

| Level | Index | Quality    | Color  | Health Implications              |
|-------|-------|------------|--------|-----------------------------------|
| 1     | 0-50  | Good       | 🟢 Green | Air quality is satisfactory       |
| 2     | 51-100| Fair       | 🟢 Light Green | Acceptable quality               |
| 3     | 101-150| Moderate  | 🟡 Yellow | Sensitive groups affected         |
| 4     | 151-200| Poor      | 🟠 Orange | Health effects for everyone       |
| 5     | 201-300| Very Poor | 🔴 Red | Health warnings of emergency conditions |

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/air-pollution-tracker.git
   cd air-pollution-tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screens

| Home Screen | AQI Dashboard | AR View |
|-------------|---------------|---------|
| ![Home](assets/screenshots/home.png) | ![Dashboard](assets/screenshots/dashboard.png) | ![AR](assets/screenshots/ar.png) |

## 🧰 Technologies Used

- **Flutter** - Cross-platform framework
- **GetX** - State management and navigation
- **fl_chart** - Data visualization
- **ARCore/ARKit** - Augmented Reality integration
- **OpenWeatherMap API** - Air quality data source

## 🌐 API Configuration

1. Get your API key from [OpenWeatherMap](https://openweathermap.org/api)
2. Create `.env` file:
   ```env
   OPEN_WEATHER_API_KEY=your_api_key_here
   ```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:
1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

## 📬 Contact

Utsav Kumar



---

### 🎨 Assets Needed
Replace placeholder images with actual screenshots:
1. `assets/screenshots/app_preview.png`
2. `assets/screenshots/home.png`
3. `assets/screenshots/dashboard.png`
4. `assets/screenshots/ar.png`

