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
        data_stream.skip (4); // 4 bytes(32 bits) must be skipped before reading any string from an NBS file.
        song_data.song_name = data_stream.read_line ();
        data_stream.skip (3); // Dunno why 4 bytes skip doesn't work here.
        song_data.song_author = data_stream.read_line ();

        return song_data;
    }
}
