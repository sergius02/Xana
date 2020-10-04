[GtkTemplate (ui = "/com/github/sergius02/xana/ui/settings_view.ui")]
public class Xana.SettingsView : Gtk.Box{

    [GtkChild]
    private Gtk.Switch switch_dark_mode;

    public SettingsView () {
        switch_dark_mode.valign = Gtk.Align.CENTER;
        switch_dark_mode.bind_property ("active", Gtk.Settings.get_default (), "gtk_application_prefer_dark_theme");
        Application.xana_settings.bind ("dark-mode", switch_dark_mode, "active", GLib.SettingsBindFlags.DEFAULT);
    }

}