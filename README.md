# 📈 Stock Market Tracker

A modern Flutter stock market application that allows users to explore stocks & stock news, manage a virtual investment portfolio, track transactions, and monitor portfolio performance using real-time market data.

---

## 📱 Features

### Authentication
- Firebase Authentication
- User registration and login
- Automatic login
- Secure logout

### Home
- Portfolio overview
- Market overview
- Recent transactions
- Trending stocks

### Stock Explorer
- Search stocks
- Market selection (US, Germany, Turkey)
- Category filtering
- Watchlist support

### Stock Details
- Real-time stock information
- Interactive price charts
- Multiple chart periods
- Stock statistics
- Add/Remove watchlist

### Trading
- Buy stocks
- Sell stocks
- Portfolio management
- Trading fee calculation
- Cash balance management

### News Explorer
- Search news
- Category filtering

### News Details
- News title
- News image
- source
- affected stocks
- go to news source

### Portfolio
- Current holdings
- Portfolio value
- Profit/Loss calculation
- Portfolio performance chart
- Transaction history

### Profile
- User information
- Cash balance
- Deposit virtual cash
- Settings
- Security & Privacy
- Premium page

---

## 🛠 Technologies

### Frontend
- Flutter
- Dart

### Backend
- Firebase Authentication
- Cloud Firestore

### APIs
- Twelve Data API
- Finnhub API

### Packages
- fl_chart
- firebase_auth
- cloud_firestore
- firebase_core
- flutter_dotenv
- http
- intl

---

## 📂 Project Structure

```
lib/
│
├── models/
├── screens/
├── widgets/
├── services/
├── utils/
├── firebase_options.dart
└── main.dart
```

---

## 📊 Architecture

The project follows a service-oriented architecture.

- Authentication handled by `AuthService`
- Firestore operations handled by `UserService`
- Stock API handled by `StockService`
- News API handled by `NewsService`
- Portfolio calculations handled by `PortfolioService`
- Portfolio chart generation handled by `PortfolioChartService`
- Currency conversion handled by `CurrencyService`
- Market selection handled by `MarketService`
- Location handled by `LocationService`

---

## ✨ Highlights

- Real-time stock quotes
- Historical stock charts
- Real-time news
- Portfolio value tracking
- Historical portfolio chart generation
- Transaction history
- Watchlist management
- Country-based market selection
- Currency conversion
- Responsive Material Design UI

---

## 🔒 Environment Variables

Create a `.env` file in the project root.

```env
TWELVE_DATA_API_KEY=YOUR_API_KEY
```

---

## 🚀 Getting Started

### Install dependencies

```bash
flutter pub get
```

### Run the application

```bash
flutter run
```

---

## 📸 Screenshots

<img height="700" alt="2" src="https://github.com/user-attachments/assets/0402d01a-e2f5-434d-bcec-93d4f23e3732" />
<img height="700" alt="1" src="https://github.com/user-attachments/assets/c3be191c-882b-4690-b6c4-a5aa40a4a304" />


---

## 👨‍💻 Development Team

- Deniz Gözcü
- Emir Yalcinkaya
- Ada Ugur Abur
- Batu Kerem Yildirim

Software Engineering Students

University of Europe for Applied Sciences (UE Potsdam)
