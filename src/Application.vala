public class Xana.Application : Gtk.Application {

    public static Settings xana_settings = new Settings ("com.github.sergius02.xana");

    public string cache_folder;
    public Gtk.CssProvider css_provider;

    public Application () {
        Object (
            application_id: "com.github.sergius02.xana",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        create_cache_folder ();

        this.css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource ("/com/github/sergius02/xana/css/xana.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_USER);

        var main_window = new Xana.ApplicationWindow (this);

        add_window (main_window);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new Xana.Application ();
        return app.run (args);
    }

    private string create_cache_folder () {
        this.cache_folder = GLib.Path.build_filename (GLib.Environment.get_user_cache_dir (), application_id);
        try {
            File file = File.new_for_path (cache_folder);
            if (!file.query_exists ()) {
                file.make_directory ();
            }

            return cache_folder;
        } catch (Error e) {
            warning (e.message);
        }

        return "";
    }

    public void generate_qr (Gtk.Image image_qr, string qr_contet) {
        QRUtils.create_web_qr (image_qr, qr_contet, cache_folder);
    }

}
