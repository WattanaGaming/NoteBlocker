public class NoteBlocker.MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Gtk.Application application) {
        Object(
            application: application
        );
    }

    construct {
        title = "NoteBlocker(Prototype build)";
        window_position = Gtk.WindowPosition.CENTER;
        set_default_size(800, 450);

        var grid = new Gtk.Grid ();
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.row_spacing = 6;

        var loadLabel = new Gtk.Label (null);
        loadLabel.wrap = true;
        loadLabel.xalign = 0.5f;
        loadLabel.yalign = 0.5f;
        loadLabel.use_markup = true;
        loadLabel.label = ("<big>Please choose an .NBS file to load.</big>");

        var fileChooser = new Gtk.FileChooserButton("Select file", Gtk.FileChooserAction.OPEN);

        var fileInfo = new Gtk.Label (null);
        fileInfo.xalign = 0;
        fileInfo.yalign = 0;
        fileInfo.label = "File not loaded";

        fileChooser.file_set.connect(() => {
            File file = fileChooser.get_file();

            // Open file for reading
            var file_stream = file.read ();
            var data_stream = new DataInputStream (file_stream);

            NBTool.NBSHeader header = NBTool.ToHeader(data_stream);
        });


        grid.add (loadLabel);
        grid.add(fileChooser);
        grid.add(fileInfo);

        this.add(grid);
    }
}
