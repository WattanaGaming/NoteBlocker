public class NBTool {
    public struct NBSHeader {
        short oldVersion;
        char version;
        char vanillaInstrCount;
        short length;
        char[] other;
    }
}