# Unterrichtsplaner – Windows App

Native WPF Desktop-App für Windows (.NET 8).

## Voraussetzungen

- Windows 10 oder Windows 11
- [.NET 8 SDK](https://dotnet.microsoft.com/de-de/download/dotnet/8.0)

## Starten (Entwicklung)

```bash
cd Windows-App/Unterrichtsplaner
dotnet run
```

## Als EXE veröffentlichen

```bash
cd Windows-App/Unterrichtsplaner
dotnet publish -c Release -r win-x64 --self-contained -p:PublishSingleFile=true
```

Die EXE liegt dann unter:
`bin\Release\net8.0-windows\win-x64\publish\Unterrichtsplaner.exe`

## Features

- Stundenplan-Ansicht (Mo–Fr, 1.–9. Stunde)
- Farbcodierung nach Fach (Biologie, Chemie, IT)
- Heutiger Tag wird hervorgehoben
- Thema und Notiz pro Unterrichtsstunde bearbeitbar (Klick auf Zelle)
- Status: Geplant / In Arbeit / Fertig
- Automatisches Speichern in `%AppData%\Unterrichtsplaner\daten.json`
