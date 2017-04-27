/**
 * Visualforceページに関するユーティリティクラスです。
 *
 * @author k.uemura
 */
public class PageUtils {
    @TestVisible
    private PageUtils() {
    }
    
    public static String getCookie(String name) {
        Cookie cookie = System.currentPageReference().getCookies().get(name);
        if (cookie == null) {
            return null;
        }
        return cookie.getValue();
    }
    
    public static void setCookie(String name, String value, Integer maxAge) {
        Cookie cookie = new Cookie(name, value, null, maxAge, false);
        System.currentPageReference().setCookies(new Cookie[]{cookie});
    }
    
    public static void addFatal(String message) {
        ApexPages.addmessage(new ApexPages.Message(ApexPages.severity.FATAL, message));
    }

    public static void addError(String message) {
        ApexPages.addmessage(new ApexPages.Message(ApexPages.severity.ERROR, message));
    }
    
    public static void addConfirm(String message) {
        ApexPages.addmessage(new ApexPages.Message(ApexPages.severity.CONFIRM, message));
    }
    
    public static void addWarning(String message) {
        ApexPages.addmessage(new ApexPages.Message(ApexPages.severity.WARNING, message));
    }

    public static void addInfo(String message) {
        ApexPages.addmessage(new ApexPages.Message(ApexPages.severity.INFO, message));
    }

    public static String getParameter(String key) {
        return ApexPages.currentPage().getParameters().get(key);
    }
    
    public static void setParameter(String key, String value) {
        ApexPages.currentPage().getParameters().put(key, value);
    }
    
    public static String getReferer() {
        return ApexPages.currentPage().getHeaders().get('Referer');
    }
    
    /**
     * URLパラメータを作成します。
     * 値はURLエンコードされます。
     * 各パラメータはキーの昇順でソートされます。
     */
    public static String toUrlParameters(Map<String, String> urlParameters) {
        String[] keyValues = new String[0];
        String[] keys = new List<String>(urlParameters.keySet());
        keys.sort();
        for (String key : keys) {
            String value = StringUtils.defaultString(urlParameters.get(key));
            keyValues.add(key + '=' + EncodingUtil.urlEncode(value, 'UTF-8'));
        }
        return StringUtils.join(keyValues, '&');
    }
    
    public static PageReference getDetailPage(sObject o) {
        if (o == null || o.Id == null) {
            return null;
        }
        return new PageReference('/' + o.Id);
    }
}