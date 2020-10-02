[GtkTemplate (ui = "/com/github/sergius02/xana/ui/notebook_tabs.ui")]
public class Xana.Notebook : Gtk.Notebook {

    [GtkChild]
    private Gtk.Button button_add_tab;

    private Xana.ApplicationWindow application;

    public Notebook (Xana.ApplicationWindow application) {
        // I added a ViewPort in the Gtk.Notebook because if it's empty (in the notebook_tabs.ui) 
        // it provokes a page!=null assertion error.
        remove_page (0); // I don't need it, removed

        this.application = application;

        new_tab ();

        button_add_tab.clicked.connect (() => {
            new_tab ();
            show_all ();
            set_current_page (get_n_pages () - 1);
        });

        switch_page.connect_after (() => {
            application.update_navigation_buttons ();
        });
    }

    private void new_tab () {
        Gtk.Box tab_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

        Gtk.Label tab_label = new Gtk.Label ("New tab");
        Gtk.Button tab_button_close = new Gtk.Button.from_icon_name ("window-close-symbolic", Gtk.IconSize.BUTTON);
        tab_button_close.relief = Gtk.ReliefStyle.NONE;

        tab_box.pack_start (tab_label);
        tab_box.pack_start (tab_button_close);

        tab_box.show_all ();

        Xana.WebView web_view = new Xana.WebView (application, tab_label);
        append_page (web_view, tab_box);

        tab_button_close.clicked.connect (() => {
            // Little tricky, but it works. Probably must be other method to do this
            reorder_child (web_view, -1); // Move the tab to the end, reordening every tab
            remove_page (-1); // And then close the last tab
        });

        web_view.load_home ();
    }

    public void load (string uri) {
        get_current_webview ().load_uri (uri);
    }

    public void to_home () {
        get_current_webview ().load_home ();
    }

    public void back () {
        get_current_webview ().go_back ();
    }

    public bool can_go_back () {
        return get_current_webview ().can_go_back ();
    }

    public bool can_go_forward () {
        return get_current_webview ().can_go_forward ();
    }

    public void forward () {
        get_current_webview ().go_forward ();
    }

    public void reload () {
        get_current_webview ().reload ();
    }

    public void stop_reload () {
        get_current_webview ().stop_loading ();
    }

    public string current_uri () {
        return get_current_webview ().uri;
    }

    private double zoom () {
        return get_current_webview ().zoom_level;
    }

    public double increase_zoom () {
        if (zoom () < 4) {
            return do_zoom (0.1);
        }
        return zoom ();
    }

    public double decrease_zoom () {
        if (zoom () > 0.2) {
            return do_zoom (-0.1);
        }
        return zoom ();
    }

    public double do_zoom (double zoom_change) {
        get_current_webview ().zoom_level += zoom_change;
        return get_current_webview ().zoom_level;
    }

    public double reset_zoom () {
        get_current_webview ().zoom_level = 1.0;
        return get_current_webview ().zoom_level;
    }

    private Xana.WebView get_current_webview () {
        return get_nth_page (get_current_page ()) as Xana.WebView;
    }

}
