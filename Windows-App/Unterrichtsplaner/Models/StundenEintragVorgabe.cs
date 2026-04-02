namespace Unterrichtsplaner.Models;

public record StundenEintragVorgabe(int Stunde, string Wochentag, string Fach, string Klasse, string Raum, string Woche);

public static class StundenDaten
{
    public static readonly StundenEintragVorgabe[] Eintraege =
    [
        new(1, "MO", "Biologie", "R6a", "207",    "AB"),
        new(2, "MO", "IT",       "W10", "PC-RS",  "AB"),
        new(3, "DI", "Chemie",   "R7b", "207",    "AB"),
        new(4, "MI", "Biologie", "R6a", "Wi MNT", "AB"),
        new(5, "DO", "IT",       "W10", "PC-RS",  "AB"),
        new(6, "FR", "Chemie",   "R7b", "207",    "AB"),
        new(7, "MO", "Biologie", "R6a", "207",    "AB"),
        new(1, "DI", "IT",       "W10", "PC-RS",  "AB"),
        new(2, "MI", "Chemie",   "R7b", "207",    "AB"),
        new(3, "DO", "Biologie", "R6a", "Wi MNT", "AB"),
    ];
}
