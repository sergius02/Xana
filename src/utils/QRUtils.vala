public class QRUtils {
    
    public static void create_web_qr (Gtk.Image image_qr, string qr_content, string cache_folder) {
        string command = "qrencode"; // Base command
            command += " -s 4"; // QR image size
            command += " -t PNG"; // QR format image
            if (Gtk.Settings.get_default ().gtk_application_prefer_dark_theme) {
                command += " --foreground=fafafa"; // QR foreground color dark theme
                command += " --background=3D3D3D"; // QR background color dark theme
            } else {
                command += " --foreground=000000"; // QR foreground color light theme
                command += " --background=F5F5F5"; // QR background color light theme
            }
            command += " -o " + cache_folder + "/site_qr.png "; // QR result path
            command += qr_content; // QR content
            try {
                Process.spawn_command_line_sync (command);
                image_qr.set_from_file (cache_folder + "/site_qr.png");
                image_qr.visible = true;
            } catch (GLib.Error error) {
                printerr (error.message);
            }
    }

}