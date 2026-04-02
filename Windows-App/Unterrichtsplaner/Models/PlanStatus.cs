namespace Unterrichtsplaner.Models;

public enum PlanStatus
{
    Geplant,
    InArbeit,
    Fertig
}

public static class PlanStatusExtensions
{
    public static string DisplayName(this PlanStatus s) => s switch
    {
        PlanStatus.Geplant  => "Geplant",
        PlanStatus.InArbeit => "In Arbeit",
        PlanStatus.Fertig   => "Fertig",
        _ => s.ToString()
    };

    public static string Icon(this PlanStatus s) => s switch
    {
        PlanStatus.Geplant  => "\u25cb",
        PlanStatus.InArbeit => "\u25b6",
        PlanStatus.Fertig   => "\u2713",
        _ => "\u25cb"
    };
}
