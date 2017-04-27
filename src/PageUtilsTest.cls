@IsTest
private class PageUtilsTest {
    static testMethod void testNew() {
        PageUtils utils = new PageUtils();
    }
    
    static testMethod void testCookie() {
        System.assertEquals(null, PageUtils.getCookie('key'));
        PageUtils.setCookie('key', 'value', 100000);
        System.assertEquals('value', PageUtils.getCookie('key'));
    }
    
    static testMethod void testAddFatal() {
        System.assertEquals(0, ApexPages.getMessages().size());
        PageUtils.addFatal('message');
        ApexPages.Message[] messages = ApexPages.getMessages();
        System.assertEquals(1, messages.size());
        System.assertEquals('message', messages[0].getSummary());
        System.assertEquals(ApexPages.severity.FATAL, messages[0].getSeverity());
    }
    
    static testMethod void testAddError() {
        System.assertEquals(0, ApexPages.getMessages().size());
        PageUtils.addError('message');
        ApexPages.Message[] messages = ApexPages.getMessages();
        System.assertEquals(1, messages.size());
        System.assertEquals('message', messages[0].getSummary());
        System.assertEquals(ApexPages.severity.ERROR, messages[0].getSeverity());
    }
    
    static testMethod void testAddConfirm() {
        System.assertEquals(0, ApexPages.getMessages().size());
        PageUtils.addConfirm('message');
        ApexPages.Message[] messages = ApexPages.getMessages();
        System.assertEquals(1, messages.size());
        System.assertEquals('message', messages[0].getSummary());
        System.assertEquals(ApexPages.severity.CONFIRM, messages[0].getSeverity());
    }
    
    static testMethod void testAddWarning() {
        System.assertEquals(0, ApexPages.getMessages().size());
        PageUtils.addWarning('message');
        ApexPages.Message[] messages = ApexPages.getMessages();
        System.assertEquals(1, messages.size());
        System.assertEquals('message', messages[0].getSummary());
        System.assertEquals(ApexPages.severity.WARNING, messages[0].getSeverity());
    }
    
    static testMethod void testAddInfo() {
        System.assertEquals(0, ApexPages.getMessages().size());
        PageUtils.addInfo('message');
        ApexPages.Message[] messages = ApexPages.getMessages();
        System.assertEquals(1, messages.size());
        System.assertEquals('message', messages[0].getSummary());
        System.assertEquals(ApexPages.severity.INFO, messages[0].getSeverity());
    }
    
    static testMethod void testParameter() {
        System.assertEquals(null, PageUtils.getParameter('id'));
        PageUtils.setParameter('id', '123');
        System.assertEquals('123', PageUtils.getParameter('id'));
    }
    
    static testMethod void testReferer() {
        System.assertEquals(null, PageUtils.getReferer());
    }
    
    static testMethod void testToUrlParameters() {
        Map<String, String> params = new Map<String, String> {
            'ab' => '123'
            , 'cd' => 'simple'
            , 'bc' => 'xyz'
        };
        System.assertEquals('ab=123&bc=xyz&cd=simple', PageUtils.toUrlParameters(params));
    }
    
   static testMethod void testGetDetailPage() {
       System.assertEquals(null, PageUtils.getDetailPage(null));
       System.assertEquals(null, PageUtils.getDetailPage(new Account()));
   }
}