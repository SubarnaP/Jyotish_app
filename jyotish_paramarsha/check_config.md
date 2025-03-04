# Project Setup Checklist

## Flutter Doctor Requirements
- [ ] Flutter SDK
- [ ] Android Studio / VS Code
- [ ] Android SDK
- [ ] Xcode (for macOS)
- [ ] VS Code Extensions
- [ ] Connected Devices

## Android Testing
1. Run in Android Studio Emulator:
```bash
flutter run -d android
```

Verify:
- [ ] App launches successfully
- [ ] Login screen appears
- [ ] Navigation works
- [ ] Notifications permission request shows
- [ ] No layout issues on different screen sizes

## iOS Testing (requires macOS)
1. Run in iOS Simulator:
```bash
flutter run -d ios
```

Verify:
- [ ] App launches successfully
- [ ] Login screen appears
- [ ] Navigation works
- [ ] Notifications permission request shows
- [ ] No layout issues on different screen sizes

## Common Issues to Check
- [ ] All dependencies resolved (flutter pub get)
- [ ] No conflicting package versions
- [ ] Assets loading correctly
- [ ] Localization working
- [ ] Theme applying correctly
- [ ] Notifications working on both platforms

## Performance Checks
Run:
```bash
flutter run --profile
```

Check:
- [ ] App startup time
- [ ] Navigation smoothness
- [ ] Animation performance
- [ ] Memory usage
