/**
 * 乱数の生成に関するユーティリティクラスです。
 * @author k.uemura
 */
public class RandomUtils {

    /**
     * 数値の範囲内からランダムな数値を返します。
     */
    public static Integer randomInt(Integer a, Integer b) {
        if (a > b) {
            Integer temp = a;
            a = b;
            b = temp;
        }
        return (Math.random() * (b - a + 1)).intValue() + a;
    }
    
    /**
     * 指定した範囲からn個の整数をランダムに抽出します。
     */
    public  static Integer[] sample(Integer fromN, Integer toN, Integer size) {
        if (fromN > toN) {
            Integer temp = fromN;
            fromN = toN;
            toN = temp;
        }
        if (toN - fromN + 1 <= size) {
            size = toN - fromN + 1;
        }
        Integer[] t = new Integer[toN - fromN + 1];
        for (Integer i = 0; i < t.size(); i++) {
            t[i] = fromN + i;
        }
        Integer[] a = new Integer[0];
        for (Integer i = 0; i < size; i++) {
            Integer x = randomInt(0, t.size() - i - 1);
            a.add(t[x]);
            t[x] = t[t.size() - i - 1];
        }
        return a;
    }
    
    /**
     * 配列の要素をランダムに選んで返します。
     */
    public static Object random(Object[] objs) {
        return objs[(Math.random() * objs.size()).intValue()];
    }
    
    /**
     * 配列の要素をランダムに選んで、指定された範囲内の桁数で文字列を作成して返します。
     * 
     * RandomUtils.randomString(new String[]{'a', 'b', 'c'}, 3, 4) = 'bac', 'ccab'
     */
    public static String randomString(Object[] objs, Integer a, Integer b) {
        String buffer = '';
        Integer len = randomInt(a, b);
        for (Integer i = 0; i < len; i++) {
            buffer += objs[(Math.random() * objs.size()).intValue()];
        }
        return buffer;
    }
    
    /**
     * 引数の文字列内の文字を元に指定された範囲内の桁数で文字列をランダムに作成して返します。
     * 
     * RandomUtils.randomString('abc', 3, 4) = 'bac', 'ccab'
     */
    public static String randomString(String chars, Integer a, Integer b) {
        return randomString(StringUtils.toCharArray(chars), a, b);
    }
    
    /**
     * 引数の文字列内の文字をランダムに返します。
     * 
     * RandomUtils.randomChar('abc') = 'b', 'a'
     */
    public static String randomChar(String chars) {
        return StringUtils.charAt(chars, randomInt(0, chars.length() - 1));
    }
}