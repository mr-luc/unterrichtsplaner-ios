namespace Unterrichtsplaner.Models;

public record StundeZeit(int Nummer, string Von, string Bis, bool PauseDanach);

public static class StundenKonfiguration
{
    public static readonly StundeZeit[] Alle =
    [
        new(1, "07:30", "08:15", false),
        new(2, "08:15", "09:00", true),
        new(3, "09:15", "10:00", false),
        new(4, "10:00", "10:45", true),
        new(5, "11:05", "11:50", false),
        new(6, "11:50", "12:35", true),
        new(7, "13:15", "14:00", false),
        new(8, "14:00", "14:45", false),
        new(9, "14:45", "15:30", false),
    ];

    public static readonly string[] Tage = ["MO", "DI", "MI", "DO", "FR"];
}
