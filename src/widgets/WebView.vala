public class Xana.WebView : WebKit.WebView {

    private Xana.ApplicationWindow application;
    private Gtk.Label tab_label;
    private string home;

    construct {
        web_context = new Xana.WebContext ();
    }

    public WebView (Xana.ApplicationWindow application) {
        this.application = application;
        this.home = "https://duckduckgo.com/";

        get_settings ().enable_developer_extras = true;

        load_changed.connect (update_progress);
        notify["uri"].connect (update_progress);
        notify["estimated-load-progress"].connect (update_progress);
        notify["is-loading"].connect (update_progress);
    }

    private void update_progress () {
        // I don't like this
        if (is_loading) {
            tab_label.label = (_("Loading"));
            application.button_refresh.visible = false;
            application.button_stop_refresh.visible = true;
            bind_property ("estimated-load-progress", application.entry_url_to_go, "progress-fraction");
        } else {
            tab_label.set_label (get_title ().substring (0, 10));
            application.button_refresh.visible = true;
            application.button_stop_refresh.visible = false;
            application.entry_url_to_go.progress_fraction = 0;
        }

        application.entry_url_to_go.text = uri;
        application.button_go_back.sensitive = can_go_back ();
        application.button_go_forward.sensitive = can_go_forward ();
    }

    public void load_home () {
        load_uri (home);
    }

    public void set_tab_label (Gtk.Label tab_label) {
        this.tab_label = tab_label;
    }

}
