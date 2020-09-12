public class NoteBlocker.MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Gtk.Application application) {
        Object(
            application: application
        );
    }

    construct {
        title = "NoteBlocker(Dummy version)";
        window_position = Gtk.WindowPosition.CENTER;
        set_default_size(800, 450);

        var grid = new Gtk.Grid ();
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.row_spacing = 6;

        var label = new Gtk.Label (null);
        label.wrap = true;
        label.xalign = 0.5f;
        label.yalign = 0.5f;
        label.use_markup = true;
        label.label = ("<big>You picked the wrong branch!</big>\n\nYou are seeing this message because you have compiled this app from the master branch, which contains a dummy version of the app. If you want to help develop or test the app, please compile from the development branch.");

        grid.add (label);

        this.add(grid);
    }
}
