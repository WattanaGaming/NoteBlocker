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

        var load_label = new Gtk.Label (null);
        load_label.wrap = true;
        load_label.xalign = 0.5f;
        load_label.yalign = 0.5f;
        load_label.use_markup = true;
        load_label.label = ("<big>Please choose an .NBS file to load.</big>");

        var file_chooser = new Gtk.FileChooserButton("Select file", Gtk.FileChooserAction.OPEN);

        var file_info_text = new Gtk.Label (null);
        file_info_text.xalign = 0;
        file_info_text.yalign = 0;
        file_info_text.label = "File not loaded";

        file_chooser.file_set.connect(() => {
            File file = file_chooser.get_file ();

            // Open file for reading
            var file_stream = file.read ();
            var data_stream = new DataInputStream (file_stream);

            NBTool.SongData header = NBTool.to_song_data (data_stream);

            file_info_text.label = "";
            file_info_text.label += "Song Name: " + header.song_name + "\n";
            file_info_text.label += "Song Author: " + header.song_author + "\n";
            file_info_text.label += "Song Original Author: " + header.song_original_author + "\n";
            file_info_text.label += "Song Description: " + header.song_description + "\n";
            // file_info_text.label += string.printf ("Song Tempo: ", header.song_tempo);
        });


        grid.add (load_label);
        grid.add(file_chooser);
        grid.add(file_info_text);

        this.add(grid);
    }
}
