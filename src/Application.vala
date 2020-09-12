public class NoteBlocker.Application : Gtk.Application {
    public Application () {
        Object (
            application_id: "com.github.wattanagaming.noteblocker",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var MainWin = new NoteBlocker.MainWindow(this);
        MainWin.show_all ();
    }

    public static int main (string[] args) {
        return new NoteBlocker.Application ().run (args);
    }
}
