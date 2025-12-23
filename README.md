# Sleep Tracker 🌙

A comprehensive Flutter application for tracking sleep patterns and analyzing how various activities impact your sleep quality.

## Features

### ✅ Core Features (Completed)

- **Sleep Session Tracking**: Record sleep sessions with start/end times and quality ratings
- **Factor Management**: Track activities and factors that affect sleep (customizable)
- **Dashboard**: View last sleep session and weekly sleep trends
- **Analysis**: Analyze how specific factors correlate with sleep quality and duration
- **Profile Management**: Manage user profile with persistent data
- **Settings**: Customize app preferences including dark mode and sleep reminders

### 🎯 Key Improvements Made

#### Bug Fixes & Enhancements

1. **Quality Rating Validation**: Fixed sleep session quality rating to be properly validated (1-5 range)
2. **Weekly Data Aggregation**: Implemented proper weekly sleep data calculation from database instead of static data
3. **Auto-load Factors**: FactorsBloc now automatically loads factors on initialization
4. **Profile Persistence**: Added UserRepository for persistent profile storage and management
5. **Loading States**: Improved UI with proper loading indicators in Dashboard

#### New Features Added

1. **UserRepository**: Complete user profile management with persistent storage
2. **ProfileCubit**: BLoC for managing profile state and updates
3. **Data Export**: CSV export functionality for sleep data (foundation implemented)
4. **Default User Initialization**: Automatic creation of default user on first app launch
5. **Better Error Handling**: Improved error states in Analysis and Profile pages

## Architecture

The project follows Clean Architecture with BLoC pattern for state management:

```
lib/
├── main.dart                    # App entry point with initialization
├── src/
│   ├── controllers/            # BLoC & Cubit (State Management)
│   │   ├── analysis/
│   │   ├── dashboard/
│   │   ├── factors/
│   │   ├── profile/            # NEW: Profile management
│   │   └── sleep_session/
│   ├── models/
│   │   ├── database/           # Drift database (SQLite)
│   │   └── repositories/       # Data layer
│   ├── utils/
│   │   ├── app_router.dart     # Go Router navigation
│   │   └── service_locator.dart # GetIt dependency injection
│   └── views/
│       ├── pages/              # Screen pages
│       └── widgets/            # Reusable components
```

## Technology Stack

- **Framework**: Flutter 3.9+
- **State Management**: Flutter BLoC 8.1.5
- **Database**: Drift (SQLite) 2.17.0
- **Routing**: Go Router 13.2.4
- **DI**: GetIt 7.7.0

## Project Setup

### Prerequisites

- Flutter SDK 3.9.0 or higher
- Dart SDK 3.9.0 or higher

### Installation

1. Clone the repository
2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Generate Drift database code:

   ```bash
   dart run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Database Schema

### Tables

- **Users**: User profile information
- **SleepSessions**: Sleep session records with duration and quality
- **Factors**: Sleep affecting factors (coffee, exercise, stress, etc.)
- **SleepSessionFactors**: Junction table linking sessions with factors

## State Management Flow

```
Views (UI)
    ↓
BLoC/Cubit (State Management)
    ↓
Repositories (Business Logic)
    ↓
Database (Data Storage)
```

## Recent Improvements Summary

| Component          | Improvement                                           |
| ------------------ | ----------------------------------------------------- |
| SleepSessionCubit  | Added quality rating validation (1-5 range)           |
| DashboardCubit     | Added loading state, improved data watching           |
| SleepRepository    | Implemented proper weekly data aggregation            |
| FactorsBloc        | Auto-initialization on creation                       |
| Profile Management | Complete UserRepository + ProfileCubit implementation |
| Main.dart          | Added async initialization for default user setup     |
| Error Handling     | Better error states in Analysis and Profile pages     |

## Usage Examples

### Starting a Sleep Session

1. Tap the center sleep button in the bottom navigation
2. Select activities/factors that happened today
3. Tap "Mulai Tidur"
4. When waking up, tap "Saya Sudah Bangun"
5. Rate your sleep quality (1-5 stars)

### Viewing Analysis

- Navigate to "Analisis" tab to see factor correlations
- See how each activity impacts your sleep duration and quality

### Managing Profile

- Go to "Profil" → "Edit Profil" to update personal information
- Customize app settings in "Pengaturan Aplikasi"

## Code Quality

✅ No compilation errors
✅ Proper null safety
✅ Consistent naming conventions
✅ Clean architecture principles
✅ Comprehensive error handling

## Future Enhancements

- [ ] Data export to CSV files with file picker
- [ ] Sleep goal tracking
- [ ] Notifications for sleep reminders
- [ ] Advanced analytics with charts
- [ ] Multi-user support (authentication)
- [ ] Cloud synchronization
- [ ] Wearable device integration

## License

This project is part of an academic course (PAPB - Programming for Android and iOS).

## Author

Sleep Tracker - A Flutter project demonstrating modern mobile app development practices.
