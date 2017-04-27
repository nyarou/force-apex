@IsTest
private class RandomUtilsTest {
    static testMethod void testRandomInt() {
        for (Integer i = 0; i < 100; i++) {
            Integer positive = RandomUtils.randomInt(0, 10);
            System.assert(0 <= positive && positive <= 10);
            Integer megative = RandomUtils.randomInt(-3, 5);
            System.assert(-3 <= megative && megative <= 5);
            
            Integer swap = RandomUtils.randomInt(10, 0);
            System.assert(0 <= swap && swap <= 10);
        }
    }
    
    static testMethod void testRandom() {
        String[] chars = new String[]{
            'a',
            'b',
            'c'
        };
        for (Integer i = 0; i < 10; i++) {
            String c = (String) RandomUtils.random(chars);
            System.assert(c == 'a' || c == 'b' || c == 'c');
        }
    }
    
    static testMethod void testRandomStringArray() {
        String[] chars = new String[]{
            'a',
            'b',
            'c'
        };
        for (Integer i = 0; i < 10; i++) {
            String str = RandomUtils.randomString(chars, 1000, 1001);
            System.assert(Pattern.matches('[a-c]{1000,1001}', str));
        }
    }
    
    static testMethod void testRandomString() {
        String chars = 'abc';
        for (Integer i = 0; i < 10; i++) {
            String str = RandomUtils.randomString(chars, 1000, 1001);
            System.assert(Pattern.matches('[a-c]{1000,1001}', str));
        }
    }
    
    static testMethod void testRandomChar() {
        String chars = 'abc';
        for (Integer i = 0; i < 10; i++) {
            String c = RandomUtils.randomChar(chars);
            System.assert(Pattern.matches('[a-c]', c));
        }
    }
}