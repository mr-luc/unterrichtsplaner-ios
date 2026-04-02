using System;
using System.Windows;
using Unterrichtsplaner.Models;

namespace Unterrichtsplaner.Views;

public partial class EditEintragWindow : Window
{
    private readonly PlanEintrag _original;
    public PlanEintrag? Result { get; private set; }

    public EditEintragWindow(PlanEintrag eintrag)
    {
        InitializeComponent();
        _original = eintrag;
        FachText.Text = eintrag.Fach;
        KlasseText.Text = eintrag.Klasse;
        ThemaBox.Text = eintrag.Thema ?? "";
        NotizBox.Text = eintrag.Notiz ?? "";
        foreach (PlanStatus s in Enum.GetValues<PlanStatus>())
            StatusBox.Items.Add(s.DisplayName());
        StatusBox.SelectedIndex = (int)eintrag.Status;
    }

    private void SaveClicked(object sender, RoutedEventArgs e)
    {
        Result = new PlanEintrag
        {
            Fach = _original.Fach, Klasse = _original.Klasse,
            Thema = string.IsNullOrWhiteSpace(ThemaBox.Text) ? null : ThemaBox.Text.Trim(),
            Notiz = string.IsNullOrWhiteSpace(NotizBox.Text) ? null : NotizBox.Text.Trim(),
            Status = (PlanStatus)StatusBox.SelectedIndex
        };
        DialogResult = true;
    }

    private void CancelClicked(object sender, RoutedEventArgs e) => DialogResult = false;
}
