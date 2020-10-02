[GtkTemplate (ui = "/com/github/sergius02/xana/ui/application_window.ui")]
public class Xana.ApplicationWindow : Gtk.ApplicationWindow {

    [GtkChild]
    public Gtk.Button button_go_back;

    [GtkChild]
    public Gtk.Button button_go_forward;

    [GtkChild]
    private Gtk.Button button_go_home;

    [GtkChild]
    public Gtk.Button button_refresh;

    [GtkChild]
    public Gtk.Button button_stop_refresh;

    [GtkChild]
    public Gtk.Entry entry_url_to_go;

    [GtkChild]
    public Gtk.MenuButton button_tools;

    [GtkChild]
    private Gtk.Popover popover_tools;

    [GtkChild]
    public Gtk.Image image_webqr;

    [GtkChild]
    private Gtk.Entry entry_url_to_qr;

    [GtkChild]
    private Gtk.Button button_url_to_qr;

    [GtkChild]
    private Gtk.ModelButton modelbutton_about;

    [GtkChild]
    private Gtk.Button button_increase_zoom;

    [GtkChild]
    private Gtk.Button button_decrease_zoom;

    [GtkChild]
    private Gtk.Button button_reset_zoom;

    private Xana.Notebook notebook;

    public ApplicationWindow (Xana.Application application) {
        this.application = application;

        this.notebook = new Xana.Notebook (this);
        add (notebook);

        button_go_home.clicked.connect (() => {
            notebook.to_home ();
        });

        button_tools.popover = popover_tools;
        
        button_tools.clicked.connect (() => {
            application.generate_qr (image_webqr, entry_url_to_go.text);
            entry_url_to_qr.text = entry_url_to_go.text;
        });

        button_url_to_qr.clicked.connect (() => {
            application.generate_qr (image_webqr, entry_url_to_qr.text);
        });

        button_decrease_zoom.clicked.connect (() => {
            button_reset_zoom.label = "%.0f%%".printf (notebook.decrease_zoom () * 100);
        });
        
        button_increase_zoom.clicked.connect (() => {
            button_reset_zoom.label = "%.0f%%".printf (notebook.increase_zoom () * 100);
        });
    
        button_reset_zoom.clicked.connect (() => {
            button_reset_zoom.label = "%.0f%%".printf (notebook.reset_zoom () * 100);
        });

        modelbutton_about.clicked.connect ( () => {
            Xana.AboutDialog about_dialog = new Xana.AboutDialog (this);
            about_dialog.present ();
        });

        entry_url_to_go.activate.connect (() => {
            string uri = entry_url_to_go.get_text ();

            if (uri.contains ("http") || uri.contains ("https")){
                notebook.load (uri);
            }
            else {
                notebook.load ("http://" + uri);
            }
        });
    }

    public void update_navigation_buttons () {
        this.button_go_back.clicked.connect (notebook.back);
        this.button_go_back.sensitive = notebook.can_go_back ();

        this.button_go_forward.clicked.connect (notebook.forward);
        this.button_go_forward.sensitive = notebook.can_go_forward ();

        this.button_refresh.clicked.connect (notebook.reload);
        this.button_stop_refresh.clicked.connect (notebook.stop_reload);

        this.entry_url_to_go.text = notebook.current_uri ();
    }

}
