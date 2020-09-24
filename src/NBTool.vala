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
        // These are stored, but not used.
        // uint8 auto_save;
        // uint8 auto_save_duration;
        uint8 time_signature;
        int minutes_spent;
        int left_clicks;
        int right_clicks;
        int note_blocks_added;
        int note_blocks_removed;
        string midi_schematic_file_name;
        uint8 loop;
        uint8 max_loop_count;
        short loop_start_tick;
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
        data_stream.skip (2); // These two bytes are stored but not used.
        song_data.time_signature = data_stream.read_byte ();
        song_data.minutes_spent = data_stream.read_int32 ();
        song_data.left_clicks = data_stream.read_int32 ();
        song_data.right_clicks = data_stream.read_int32 ();
        song_data.note_blocks_added = data_stream.read_int32 ();
        song_data.note_blocks_removed = data_stream.read_int32 ();
        song_data.midi_schematic_file_name = get_string (data_stream, "MIDI/Schematic File Name");
        song_data.loop = data_stream.read_byte ();
        song_data.max_loop_count = data_stream.read_byte ();
        song_data.loop_start_tick = data_stream.read_int16 ();


        return song_data;
    }

    private static string get_string(DataInputStream data_stream, string name = "(unnamed)") {
        uint8[] buffer = new uint8[data_stream.read_uint32 ()];
        // If a string in the DataInputStream is empty, it will cause an error.
        // This is a way to better inform the developer about what went wrong.
        try {
            data_stream.read (buffer);
        } finally {
            message(@"Failed reading string from DataInputStream. Is the \"$name\" string empty?");
        }

        return (string) buffer + "\0";
    }
}
