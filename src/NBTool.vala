public class NBTool {
    public struct NBSHeader {
        bool oldVersion;
        int8 version;
        int8 vanillaInstrCount;
        short length;
        short layer_count;
        string song_name;
        char[] other;
    }

    public static NBSHeader ToHeader(DataInputStream data_stream) {
        data_stream.set_byte_order (DataStreamByteOrder.LITTLE_ENDIAN); // As specified in https://opennbs.org/nbs

        var header = new NBSHeader();

        stdout.printf("Old Version: %x\n", data_stream.read_int16());
        stdout.printf("NBS Version: %x\n", data_stream.read_byte());
        stdout.printf("Vanilla Instrument Count: %x\n", data_stream.read_byte());
        stdout.printf("Length: %x\n", data_stream.read_int16());
        stdout.printf("Layer Count: %x\n", data_stream.read_int16());
        data_stream.skip(4); // A string in an .nbs file starts off with 32-bits of data(4 bytes) then the text.
        stdout.printf("Song Name: %s\n", data_stream.read_line());

        return header;
    }
}