public class NBTool {
    public struct SongData {
        // Header
        short old_version;
        uint8 version;
        uint8 vanilla_intrument_count;
        short length;
        short layer_count;
        string song_name;
        string song_author;
        string song_original_author;
        string song_description;
        short song_tempo;
    }

    public static SongData to_song_data (DataInputStream data_stream) {
        // Specifications for the NBS file format can be found at https://opennbs.org/nbs
        debug("Converting DataInputStream to Song Data");
        data_stream.set_byte_order (DataStreamByteOrder.LITTLE_ENDIAN);
        var song_data = new SongData();

        // Note to self: a "short" is 2 bytes(16 bits) long.
        // TODO: Add error handler.
        song_data.old_version = data_stream.read_int16 ();
        song_data.version = data_stream.read_byte ();
        song_data.vanilla_intrument_count = data_stream.read_byte ();
        song_data.length = data_stream.read_int16 ();
        song_data.layer_count = data_stream.read_int16 ();

        song_data.song_name = get_string (data_stream, "Song Name");
        song_data.song_author = get_string (data_stream, "Song Author");
        song_data.song_original_author = get_string (data_stream, "Song Original Author");
        song_data.song_description = get_string (data_stream, "Song Description");

        song_data.song_tempo = data_stream.read_int16 ();

        return song_data;
    }

    private static string get_string(DataInputStream data_stream, string name = "(unnamed)") {
        uint8[] buffer = new uint8[data_stream.read_uint32 ()];
        // If a string in the DataInputStream is empty, it will cause an error.
        // This is a way to better inform other developers about what went wrong.
        try {
            data_stream.read (buffer);
        } finally {
            message(@"Failed reading the string from DataInputStream. Is the \"$name\" string empty?");
        }

        return (string) buffer + "\0";
    }
}
