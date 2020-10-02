public class Xana.AboutDialog : Gtk.AboutDialog {

    public AboutDialog (Gtk.ApplicationWindow application) {

        set_transient_for (application);

        try {
            this.set_logo (new Gdk.Pixbuf.from_resource ("/com/github/sergius02/xana/img/xana.svg"));
        } catch (GLib.Error error) {
            printerr (error.message);
        }

        program_name = "Xana";
        version = "1.0.0-alpha";
        website = "https://github.com/sergius02/Xana";
        website_label = "Fork me on Github!";
        license_type = Gtk.License.GPL_3_0;
        comments = "A web browser made by and for developers 🤓️";
        authors = {"Sergio Fernández Celorio"};
        response.connect ((response_id) => {
            if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
                hide_on_delete ();
            }
        });

    }

}