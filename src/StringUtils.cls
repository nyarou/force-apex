/**
 * 文字列に関するユーティリティクラスです。
 * @author k.uemura
 */
public class StringUtils {

    /*
     * Java apache-commons-lang StringUtils
     */
     
    public static boolean isEmpty(String s) {
        return String.isEmpty(s);
    }
    
    public static boolean isBlank(String s) {
        return String.isBlank(s);
    }
    
    public static boolean isNotEmpty(String s) {
        return String.isNotEmpty(s);
    }
    
    public static boolean isNotBlank(String s) {
        return String.isNotBlank(s);
    }
    
    public static String defaultString(String s) {
        return defaultString(s, '');
    }
    
    public static String defaultString(String s, String defaultString) {
        if (s == null) {
            return defaultString;
        }
        return s;
    }
    
    public static String defaultIfEmpty(String s, String defaultString) {
        if (String.isEmpty(s)) {
            return defaultString;
        }
        return s;
    }

    public static String defaultIfBlank(String s, String defaultString) {
        if (String.isBlank(s)) {
            return defaultString;
        }
        return s;
    }
    
    public static String left(String s, Integer len) {
        if (String.isEmpty(s)) {
            return s;
        }
        return s.left(len);
    }
    
    public static String right(String s, Integer len) {
        if (s == null) {
            return s;
        }
        return s.right(len);
    }
    
    public static String mid(String s, Integer pos, Integer len) {
        if (s == null) {
            return s;
        }
        return s.mid(pos, len);
    }
    
    public static String substring(String s, Integer starti) {
        if (s == null) {
            return null;
        }
        if (starti < 0) {
            starti = s.length() + starti;
        }
        if (starti < 0) {
            starti = 0;
        }
        if (starti > s.length()) {
            return '';
        }
        return s.substring(starti);
    }
    
    public static String substring(String s, Integer starti, Integer endi) {
        if (s == null) {
            return null;
        }
        if (endi < 0) {
            endi = s.length() + endi;
        }
        if (starti < 0) {
            starti = s.length() + starti;
        }
        if (endi > s.length()) {
            endi = s.length();
        }
        if (starti > endi) {
            return '';
        }
        if (starti < 0) {
            starti = 0;
        }
        if (endi < 0) {
            endi = 0;
        }
        return s.substring(starti, endi);
    }
    
    public static String substringBefore(String s, String separator) {
        if (s == null) {
            return null;
        }
        return s.substringBefore(separator);
    }
    
    public static String substringAfter(String s, String separator) {
        if (s == null) {
            return null;
        }
        return s.substringAfter(separator);
    }
    
    public static String substringBeforeLast(String s, String separator) {
        if (s == null) {
            return null;
        }
        return s.substringBeforeLast(separator);
    }
    
    public static String substringAfterLast(String s, String separator) {
        if (s == null) {
            return null;
        }
        return s.substringAfterLast(separator);
    }

    public static String join(Object[] l, String token) {
        if (l == null) {
            return null;
        }
        return String.join(l, token);
    }
    
    public static String repeat(String s, Integer count) {
        if (s == null) {
            return s;
        }
        return s.repeat(count);
    }
    
    public static String leftPad(String s, Integer size, String padStr) {
        if (s == null) {
            return null;
        }
        padStr = defaultIfEmpty(padStr, ' ');
        return s.leftPad(size, padStr);
    }
    
    public static String rightPad(String s, Integer size, String padStr) {
        if (s == null) {
            return null;
        }
        padStr = defaultIfEmpty(padStr, ' ');
        return s.rightPad(size, padStr);
    }
    
    public static String charAt(String s, Integer index) {
        if (String.isEmpty(s)) {
            return s;
        }
        if (index < 0 || s.length() <= index) {
            return null;
        }
        return s.substring(index, index + 1);
    }
    
    public static String[] toCharArray(String s) {
        if (s == null) {
            return null;
        }
        if (s == '') {
            return new String[0];
        }
        return s.split('(?<=.{1})');
    }
    
    /*
     * Ruby String
     */
    
    public static String[] partition(String s, String separetor) {
        if (s == null) {
            return new String[]{'', '', ''};
        }
        if (String.isEmpty(separetor)) {
            return new String[]{'', '', ''};
        }
        String[] splitted = s.split(Pattern.quote(separetor), 2);
        if (splitted.size() == 2) {
            return new String[]{splitted[0], separetor, splitted[1]};
        } else {
            return new String[]{splitted[0], '', ''};
        }
    }
    
    public static List<String[]> scan(String text, String regex) {
        if (regex == null) {
            return new List<String[]>();
        }
        return scan(text, Pattern.compile(regex));
    }
    
    public static List<String[]> scan(String text, Pattern regex) {
        if (text == null) {
            return new List<String[]>();
        }
        if (regex == null) {
            return new List<String[]>();
        }
        List<String[]> matchedResult = new List<String[]>();
        Matcher m = regex.matcher(text);
        while (m.find()) {
            String[] matchedStrings = new String[0];
            for (Integer i = 0; i <= m.groupCount(); i++) {
                matchedStrings.add(m.group(i));
            }
            matchedResult.add(matchedStrings);
        }
        return matchedResult;
    }
    
    /*
     * オリジナル
     */
    
    public static String[] devide(String s, Integer substringLength) {
        if (s == null) {
            return null;
        }
        if (s == '') {
            return new String[0];
        }
        if (substringLength <= 0) {
            substringLength = s.length();
        }
        String[] l = new String[0];
        while (s.length() > substringLength) {
            l.add(s.left(substringLength));
            s = s.substring(substringLength);
        }
        l.add(s);
        return l;
    }

    public static String[] splitByLength(String s, Integer substringLength) {
        return devide(s, substringLength);
    }
    
    
    /*
     * Apex String拡張
     */
    
    public static String format(String s, String param1) {
        if (s == null) {
            return null;
        }
        return format(s, new String[] {param1});
    }
    
    public static String format(String s, String param1, String param2) {
        if (s == null) {
            return null;
        }
        return format(s, new String[] {param1, param2});
    }
    
    public static String format(String s, String param1, String param2, String param3) {
        if (s == null) {
            return null;
        }
        return format(s, new String[] {param1, param2, param3});
    }
    
    public static String format(String s, String[] params) {
        if (s == null) {
            return null;
        }
        if (params == null) {
            return s;
        }
        String[] copyParams = new String[0];
        for (String param : params) {
            copyParams.add(defaultString(param));
        }
        return String.format(s, copyParams);
    }
}