using System;
using System.Globalization;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using Unterrichtsplaner.Models;
using Unterrichtsplaner.ViewModels;
using Unterrichtsplaner.Views;

namespace Unterrichtsplaner;

public partial class MainWindow : Window
{
    private readonly MainViewModel _vm = new();

    public MainWindow()
    {
        InitializeComponent();
        var kw = ISOWeek.GetWeekOfYear(DateTime.Today);
        var de = new System.Globalization.CultureInfo("de-DE");
        WochenInfo.Text = $"KW {kw} \u00b7 {DateTime.Today.ToString("dddd, d. MMMM yyyy", de)}";
        BuildGrid();
    }

    private void BuildGrid()
    {
        var grid = StundenplanGrid;
        grid.Children.Clear();
        grid.RowDefinitions.Clear();
        grid.ColumnDefinitions.Clear();

        grid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(84) });
        for (int i = 0; i < 5; i++)
            grid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });

        grid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(44) });

        foreach (var s in StundenKonfiguration.Alle)
        {
            grid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(74) });
            if (s.PauseDanach)
                grid.RowDefinitions.Add(new RowDefinition { Height = new GridLength(22) });
        }

        for (int d = 0; d < StundenKonfiguration.Tage.Length; d++)
            AddDayHeader(grid, d + 1, StundenKonfiguration.Tage[d]);

        int row = 1;
        foreach (var stunde in StundenKonfiguration.Alle)
        {
            AddTimeCell(grid, row, stunde);
            for (int d = 0; d < StundenKonfiguration.Tage.Length; d++)
            {
                var tag = StundenKonfiguration.Tage[d];
                var vorgabe = StundenDaten.Eintraege
                    .FirstOrDefault(e => e.Stunde == stunde.Nummer && e.Wochentag == tag);
                AddStundeCell(grid, row, d + 1, vorgabe);
            }
            row++;
            if (stunde.PauseDanach) { AddPauseRow(grid, row); row++; }
        }
    }

    private void AddDayHeader(Grid grid, int col, string tag)
    {
        var today = DateTime.Today.DayOfWeek;
        var tagMap = new[] { "", "MO", "DI", "MI", "DO", "FR", "", "" };
        bool isToday = (int)today < tagMap.Length && tagMap[(int)today] == tag;
        var border = new Border
        {
            Margin = new Thickness(3, 6, 3, 6),
            CornerRadius = new CornerRadius(8),
            Background = isToday
                ? new SolidColorBrush(Color.FromArgb(50, 110, 86, 207))
                : new SolidColorBrush(Color.FromRgb(45, 45, 47))
        };
        border.Child = new TextBlock
        {
            Text = tag,
            Foreground = isToday
                ? new SolidColorBrush(Color.FromRgb(110, 86, 207))
                : new SolidColorBrush(Color.FromRgb(245, 245, 247)),
            FontSize = 13, FontWeight = FontWeights.SemiBold,
            HorizontalAlignment = HorizontalAlignment.Center,
            VerticalAlignment = VerticalAlignment.Center
        };
        Grid.SetRow(border, 0); Grid.SetColumn(border, col);
        grid.Children.Add(border);
    }

    private static void AddTimeCell(Grid grid, int row, StundeZeit stunde)
    {
        var sp = new StackPanel { HorizontalAlignment = HorizontalAlignment.Center, VerticalAlignment = VerticalAlignment.Center };
        sp.Children.Add(new TextBlock { Text = stunde.Nummer.ToString(), Foreground = new SolidColorBrush(Color.FromRgb(245, 245, 247)), FontSize = 16, FontWeight = FontWeights.SemiBold, HorizontalAlignment = HorizontalAlignment.Center });
        sp.Children.Add(new TextBlock { Text = stunde.Von, Foreground = new SolidColorBrush(Color.FromRgb(134, 134, 139)), FontSize = 10, HorizontalAlignment = HorizontalAlignment.Center });
        sp.Children.Add(new TextBlock { Text = stunde.Bis, Foreground = new SolidColorBrush(Color.FromRgb(134, 134, 139)), FontSize = 10, HorizontalAlignment = HorizontalAlignment.Center });
        Grid.SetRow(sp, row); Grid.SetColumn(sp, 0);
        grid.Children.Add(sp);
    }

    private void AddStundeCell(Grid grid, int row, int col, StundenEintragVorgabe? vorgabe)
    {
        if (vorgabe == null)
        {
            var empty = new Border { Margin = new Thickness(3), CornerRadius = new CornerRadius(8), Background = new SolidColorBrush(Color.FromRgb(30, 30, 32)) };
            Grid.SetRow(empty, row); Grid.SetColumn(empty, col);
            grid.Children.Add(empty); return;
        }
        var eintrag = _vm.Eintrag(vorgabe.Fach, vorgabe.Klasse);
        var fachColor = GetFachColor(vorgabe.Fach);
        var border = new Border
        {
            Margin = new Thickness(3), CornerRadius = new CornerRadius(8),
            Background = GetFachBackground(vorgabe.Fach), BorderBrush = GetFachBorder(vorgabe.Fach),
            BorderThickness = new Thickness(1), Cursor = Cursors.Hand, Tag = vorgabe
        };
        border.MouseLeftButtonUp += CellClicked;
        border.MouseEnter  += (s, _) => { if (s is Border b) b.Opacity = 0.80; };
        border.MouseLeave  += (s, _) => { if (s is Border b) b.Opacity = 1.00; };
        var innerGrid = new Grid();
        innerGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(3) });
        innerGrid.ColumnDefinitions.Add(new ColumnDefinition { Width = new GridLength(1, GridUnitType.Star) });
        var accent = new Border { Background = new SolidColorBrush(fachColor), CornerRadius = new CornerRadius(7, 0, 0, 7) };
        Grid.SetColumn(accent, 0); innerGrid.Children.Add(accent);
        var content = new StackPanel { Margin = new Thickness(8, 6, 8, 6), VerticalAlignment = VerticalAlignment.Center };
        content.Children.Add(new TextBlock { Text = vorgabe.Fach, Foreground = new SolidColorBrush(fachColor), FontSize = 12, FontWeight = FontWeights.SemiBold });
        content.Children.Add(new TextBlock { Text = $"{vorgabe.Klasse} \u00b7 {vorgabe.Raum}", Foreground = new SolidColorBrush(Color.FromRgb(245, 245, 247)), FontSize = 11, Margin = new Thickness(0, 1, 0, 0) });
        if (!string.IsNullOrEmpty(eintrag.Thema))
            content.Children.Add(new TextBlock { Text = eintrag.Thema, Foreground = new SolidColorBrush(Color.FromRgb(174, 174, 178)), FontSize = 10, TextTrimming = TextTrimming.CharacterEllipsis, Margin = new Thickness(0, 2, 0, 0) });
        content.Children.Add(new TextBlock { Text = eintrag.Status.Icon() + " " + eintrag.Status.DisplayName(), Foreground = GetStatusBrush(eintrag.Status), FontSize = 10, Margin = new Thickness(0, 3, 0, 0) });
        Grid.SetColumn(content, 1); innerGrid.Children.Add(content);
        border.Child = innerGrid;
        Grid.SetRow(border, row); Grid.SetColumn(border, col);
        grid.Children.Add(border);
    }

    private static void AddPauseRow(Grid grid, int row)
    {
        var tb = new TextBlock { Text = "\u00b7 Pause \u00b7", Foreground = new SolidColorBrush(Color.FromRgb(58, 58, 60)), FontSize = 10, HorizontalAlignment = HorizontalAlignment.Center, VerticalAlignment = VerticalAlignment.Center };
        Grid.SetRow(tb, row); Grid.SetColumn(tb, 0); Grid.SetColumnSpan(tb, 6);
        grid.Children.Add(tb);
    }

    private void CellClicked(object sender, MouseButtonEventArgs e)
    {
        if (sender is Border { Tag: StundenEintragVorgabe vorgabe })
        {
            var eintrag = _vm.Eintrag(vorgabe.Fach, vorgabe.Klasse);
            var dialog = new EditEintragWindow(eintrag) { Owner = this };
            if (dialog.ShowDialog() == true && dialog.Result != null)
            { _vm.Speichern(dialog.Result); BuildGrid(); }
        }
    }

    private static Color GetFachColor(string fach) => fach switch
    { "Biologie" => Color.FromRgb(52, 168, 83), "Chemie" => Color.FromRgb(8, 145, 178), "IT" => Color.FromRgb(110, 86, 207), _ => Color.FromRgb(134, 134, 139) };

    private static Brush GetFachBackground(string fach) => fach switch
    { "Biologie" => new SolidColorBrush(Color.FromArgb(24, 52, 168, 83)), "Chemie" => new SolidColorBrush(Color.FromArgb(24, 8, 145, 178)), "IT" => new SolidColorBrush(Color.FromArgb(24, 110, 86, 207)), _ => new SolidColorBrush(Color.FromRgb(45, 45, 47)) };

    private static Brush GetFachBorder(string fach) => fach switch
    { "Biologie" => new SolidColorBrush(Color.FromArgb(64, 52, 168, 83)), "Chemie" => new SolidColorBrush(Color.FromArgb(64, 8, 145, 178)), "IT" => new SolidColorBrush(Color.FromArgb(64, 110, 86, 207)), _ => new SolidColorBrush(Color.FromArgb(32, 255, 255, 255)) };

    private static Brush GetStatusBrush(PlanStatus status) => status switch
    { PlanStatus.Geplant => new SolidColorBrush(Color.FromRgb(134, 134, 139)), PlanStatus.InArbeit => new SolidColorBrush(Color.FromRgb(255, 159, 10)), PlanStatus.Fertig => new SolidColorBrush(Color.FromRgb(48, 209, 88)), _ => new SolidColorBrush(Color.FromRgb(134, 134, 139)) };
}
