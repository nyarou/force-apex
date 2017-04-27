/**
 * 文字のエンコーディングに関するユーティリティクラスです。
 *
 * @author k.uemura
 */
public class EncodingUtils {

    /**
     * マイクロソフトの標準Shift_JIS(Windows-31J, MS932)をUTF-8に変換します。
     */
    public static String decodeWindows31J(Blob b) {
        if (b == null) {
            return null;
        }
        String[] results = new String[0];
        for (String subHex : StringUtils.devide(EncodingUtil.convertToHex(b), 30000)) {
            results.add(subHex.replaceAll('[0-9a-fA-F]{2}', '%$0'));
        }
        return EncodingUtil.urlDecode(String.join(results, ''), 'MS932');
    }
   
    /**
     * UTF-8をマイクロソフトの標準Shift_JIS(Windows-31J, MS932)に変換します。
     */
    public static Blob encodeWindows31J(String s) {
        if (s == null) {
            return null;
        }
        String urlEncoded = EncodingUtil.urlEncode(s, 'MS932');
        String[] subs = new String[0];
        Matcher m = Pattern.compile('((?:%..)*)([^%]*)').matcher(urlEncoded);
        while (m.find()) {
            String encoded = m.group(1);
            String unencoded = m.group(2);
            if (String.isNotEmpty(encoded)) {
                subs.add(encoded.remove('%'));
            }
            if (String.isNotEmpty(unencoded)) {
                subs.add(EncodingUtil.convertToHex(Blob.valueOf(unencoded.replace('+', ' '))));
            }
        }
        return EncodingUtil.convertFromHex(String.join(subs, ''));
    }
}