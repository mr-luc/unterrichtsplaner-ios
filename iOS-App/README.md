# Unterrichtsplaner – iOS App

Native SwiftUI App für iPhone und iPad (iOS 17+).

## Voraussetzungen

- macOS mit Xcode 15 oder neuer
- iOS 17+ Deployment Target (wegen SwiftData)

## Projekt öffnen

```bash
open iOS-App/Unterrichtsplaner.xcodeproj
```

## Struktur

```
iOS-App/
├── UnterrichtsplanerApp.swift   # App-Einstiegspunkt (@main)
├── ContentView.swift             # Haupt-View
├── Models/
│   ├── Stundenplan.swift           # SwiftData @Model
│   ├── PlanEintrag.swift
│   ├── PlanStatus.swift
│   ├── StundenKonfiguration.swift
│   └── StundenEintragVorgabe.swift
├── Services/
│   ├── PlanRepository.swift
│   └── WochenService.swift
└── Views/
    ├── StundenplanGridView.swift
    ├── EditEintragSheet.swift
    └── ...
```

## CI/CD

GitHub Actions baut die App automatisch beim Push auf `main`.

> **Hinweis:** Das Xcode-Projekt (`Unterrichtsplaner.xcodeproj`) muss im
> Ordner `iOS-App/` committed sein, damit der CI-Build funktioniert.
> Aus Xcode heraus: **File → Save** stellt sicher, dass alle Änderungen
> in der `.xcodeproj`-Datei gespeichert sind.
