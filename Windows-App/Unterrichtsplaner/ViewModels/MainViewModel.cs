using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Text.Json;
using Unterrichtsplaner.Models;

namespace Unterrichtsplaner.ViewModels;

public class MainViewModel : INotifyPropertyChanged
{
    private Dictionary<string, PlanEintrag> _daten = [];
    private readonly string _savePath;
    public event PropertyChangedEventHandler? PropertyChanged;

    public MainViewModel()
    {
        _savePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "Unterrichtsplaner", "daten.json");
        Laden();
    }

    public PlanEintrag Eintrag(string fach, string klasse)
    {
        var key = $"{fach}_{klasse}";
        return _daten.TryGetValue(key, out var e) ? e : new PlanEintrag { Fach = fach, Klasse = klasse };
    }

    public void Speichern(PlanEintrag eintrag)
    {
        _daten[eintrag.Key] = eintrag;
        Persistieren();
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(nameof(Eintrag)));
    }

    private void Laden()
    {
        try { if (File.Exists(_savePath)) { var json = File.ReadAllText(_savePath); _daten = JsonSerializer.Deserialize<Dictionary<string, PlanEintrag>>(json) ?? []; } }
        catch { _daten = []; }
    }

    private void Persistieren()
    {
        try { Directory.CreateDirectory(Path.GetDirectoryName(_savePath)!); File.WriteAllText(_savePath, JsonSerializer.Serialize(_daten, new JsonSerializerOptions { WriteIndented = true })); }
        catch { }
    }
}
