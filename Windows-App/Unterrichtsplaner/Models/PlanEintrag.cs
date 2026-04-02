using System.Text.Json.Serialization;

namespace Unterrichtsplaner.Models;

public class PlanEintrag
{
    public string Fach { get; set; } = "";
    public string Klasse { get; set; } = "";
    public string? Thema { get; set; }
    public string? Notiz { get; set; }
    public PlanStatus Status { get; set; } = PlanStatus.Geplant;

    [JsonIgnore]
    public string Key => $"{Fach}_{Klasse}";
}
