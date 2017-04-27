@IsTest
private class StringUtilsTest {
    
    static testMethod void testIsEmpty() {
        System.assertEquals(true, StringUtils.isEmpty(null));
        System.assertEquals(true, StringUtils.isEmpty(''));
        System.assertEquals(false, StringUtils.isEmpty(' '));
        System.assertEquals(false, StringUtils.isEmpty('a'));
    }
    
    static testMethod void testIsBlank() {
        System.assertEquals(true, StringUtils.isBlank(null));
        System.assertEquals(true, StringUtils.isBlank(''));
        System.assertEquals(true, StringUtils.isBlank(' '));
        System.assertEquals(true, StringUtils.isBlank('　'));
        System.assertEquals(false, StringUtils.isBlank('a'));
    }
    
    static testMethod void testIsNotEmpty() {
        System.assertEquals(false, StringUtils.isNotEmpty(null));
        System.assertEquals(false, StringUtils.isNotEmpty(''));
        System.assertEquals(true, StringUtils.isNotEmpty(' '));
        System.assertEquals(true, StringUtils.isNotEmpty('a'));
    }
    
    static testMethod void testIsNotBlank() {
        System.assertEquals(false, StringUtils.isNotBlank(null));
        System.assertEquals(false, StringUtils.isNotBlank(''));
        System.assertEquals(false, StringUtils.isNotBlank(' '));
        System.assertEquals(true, StringUtils.isNotBlank('a'));
    }
    
    static testMethod void testDefaultString() {
        System.assertEquals('', StringUtils.defaultString(null));
        System.assertEquals('', StringUtils.defaultString(''));
        System.assertEquals('a', StringUtils.defaultString('a'));
    }
    
    static testMethod void testDefaultString2() {
        System.assertEquals('abc', StringUtils.defaultString(null, 'abc'));
        System.assertEquals('', StringUtils.defaultString('', 'abc'));
        System.assertEquals('a', StringUtils.defaultString('a', 'abc'));
    }
    
    static testMethod void testDefaultIfEmpty() {
        System.assertEquals('abc', StringUtils.defaultIfEmpty(null, 'abc'));
        System.assertEquals('abc', StringUtils.defaultIfEmpty('', 'abc'));
        System.assertEquals(' ', StringUtils.defaultIfEmpty(' ', 'abc'));
        System.assertEquals('a', StringUtils.defaultIfEmpty('a', 'abc'));
    }
    
    static testMethod void testDefaultIfBlank() {
        System.assertEquals('abc', StringUtils.defaultIfBlank(null, 'abc'));
        System.assertEquals('abc', StringUtils.defaultIfBlank('', 'abc'));
        System.assertEquals('abc', StringUtils.defaultIfBlank(' ', 'abc'));
        System.assertEquals('a', StringUtils.defaultIfBlank('a', 'abc'));
    }
    
    static testMethod void testLeft() {
        System.assertEquals(null, StringUtils.left(null, 2));
        System.assertEquals('', StringUtils.left('', 2));
        System.assertEquals('', StringUtils.left('123', -1));
        System.assertEquals('', StringUtils.left('123', 0));
        System.assertEquals('12', StringUtils.left('123', 2));
        System.assertEquals('123', StringUtils.left('123', 4));
    }
    
    static testMethod void testRight() {
        System.assertEquals(null, StringUtils.right(null, 2));
        System.assertEquals('', StringUtils.right('', 2));
        System.assertEquals('', StringUtils.right('123', -1));
        System.assertEquals('', StringUtils.right('123', 0));
        System.assertEquals('23', StringUtils.right('123', 2));
        System.assertEquals('123', StringUtils.right('123', 4));
    }
    
    static testMethod void testMid() {
        System.assertEquals(null, StringUtils.mid(null, 1, 1));
        System.assertEquals('', StringUtils.mid('', 1, 1));
        System.assertEquals('', StringUtils.mid('123', 4, 1));
        System.assertEquals('', StringUtils.mid('123', 1, -1));
        System.assertEquals('1', StringUtils.mid('123', -1, 1));
        System.assertEquals('123', StringUtils.mid('123', -1, 4));
        System.assertEquals('23', StringUtils.mid('123', 1, 4));
        System.assertEquals('12', StringUtils.mid('123', 0, 2));
        System.assertEquals('2', StringUtils.mid('123', 1, 1));
        System.assertEquals('23', StringUtils.mid('123', 1, 2));
    }
    
    static testMethod void testSubstring() {
        System.assertEquals(null, StringUtils.substring(null, 0));
        System.assertEquals('abc', StringUtils.substring('abc', 0));
        System.assertEquals('', StringUtils.substring('abc', 3));
        System.assertEquals('c', StringUtils.substring('abc', 2));
        System.assertEquals('bc', StringUtils.substring('abc', -2));
        System.assertEquals('abc', StringUtils.substring('abc', -4));
    }
    
    static testMethod void testSubstring2() {
        System.assertEquals(null, StringUtils.substring(null, 0, 3));
        System.assertEquals('', StringUtils.substring('abc', 0, 0));
        System.assertEquals('', StringUtils.substring('abc', 3, 3));
        System.assertEquals('abc', StringUtils.substring('abc', 0, 3));
        System.assertEquals('a', StringUtils.substring('abc', 0, 1));
        System.assertEquals('c', StringUtils.substring('abc', 2, 3));
        System.assertEquals('c', StringUtils.substring('abc', 2, 4));
        System.assertEquals('a', StringUtils.substring('abc', -4, 1));
        System.assertEquals('b', StringUtils.substring('abc', -2, -1));
        System.assertEquals('', StringUtils.substring('abc', 2, 1));
    }
    
    static testMethod void testSubstringBefore() {
        System.assertEquals(null, StringUtils.substringBefore(null, ''));
        System.assertEquals('', StringUtils.substringBefore('abc', ''));
        System.assertEquals('abc', StringUtils.substringBefore('abc', '='));
        System.assertEquals('a', StringUtils.substringBefore('a=a=a', '='));
    }
    
    static testMethod void testSubstringAfter() {
        System.assertEquals(null, StringUtils.substringAfter(null, ''));
        System.assertEquals('abc', StringUtils.substringAfter('abc', ''));
        System.assertEquals('', StringUtils.substringAfter('abc', '='));
        System.assertEquals('a=a', StringUtils.substringAfter('a=a=a', '='));
    }
    
    static testMethod void testSubstringBeforeLast() {
        System.assertEquals(null, StringUtils.substringBeforeLast(null, ''));
        System.assertEquals('abc', StringUtils.substringBeforeLast('abc', ''));
        System.assertEquals('abc', StringUtils.substringBeforeLast('abc', '='));
        System.assertEquals('a=a', StringUtils.substringBeforeLast('a=a=a', '='));
    }
    
    static testMethod void testSubstringAfterLast() {
        System.assertEquals(null, StringUtils.substringAfterLast(null, ''));
        System.assertEquals('', StringUtils.substringAfterLast('abc', ''));
        System.assertEquals('', StringUtils.substringAfterLast('abc', '='));
        System.assertEquals('a', StringUtils.substringAfterLast('a=a=a', '='));
    }
      
    static testMethod void testJoin() {
        System.assertEquals('', StringUtils.join(new String[]{}, ','));
        System.assertEquals('a', StringUtils.join(new String[]{'a'}, ','));
        System.assertEquals('a,b,c', StringUtils.join(new String[]{'a', 'b', 'c'}, ','));
        System.assertEquals('a,,c', StringUtils.join(new String[]{'a', null, 'c'}, ','));
    }
    
    static testMethod void testJoinPerform() {
        String[] datas = createLongList();
        System.assertEquals(datas.size() * 2 - 1, StringUtils.join(datas, ':').length());
    }
    
    static testMethod void testNewJoinPerform() {
        String[] datas = createLongList();
        System.assertEquals(datas.size() * 2 - 1, String.join(datas, ':').length());
    }
    
    private static String[] createLongList() {
        String[] datas = new String[] {
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            , '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
        };
        datas.addAll(datas);
        datas.addAll(datas);
        datas.addAll(datas);
        datas.addAll(datas);
        datas.addAll(datas);
        datas.addAll(datas);
        return datas;
    }
    
    static testMethod void testRepeat() {
        System.assertEquals('', StringUtils.repeat('a', -1));
        System.assertEquals('', StringUtils.repeat('a', 0));
        System.assertEquals('aaa', StringUtils.repeat('a', 3));
        System.assertEquals('abcabc', StringUtils.repeat('abc', 2));
    }
    
    static testMethod void testLeftPad() {
        System.assertEquals(null, StringUtils.leftPad(null, 0, 'a'));
        System.assertEquals('zzz', StringUtils.leftPad('', 3, 'z'));
        System.assertEquals('bat', StringUtils.leftPad('bat', 3, 'yz'));
        System.assertEquals('yzbat', StringUtils.leftPad('bat', 5, 'yz'));
        System.assertEquals('yzyzybat', StringUtils.leftPad('bat', 8, 'yz'));
        System.assertEquals('bat', StringUtils.leftPad('bat', 1, 'yz'));
        System.assertEquals('bat', StringUtils.leftPad('bat', -1, 'yz'));
        System.assertEquals('  bat', StringUtils.leftPad('bat', 5, null));
        System.assertEquals('  bat', StringUtils.leftPad('bat', 5, ''));
    }
    
    static testMethod void testRightPad() {
        System.assertEquals(null, StringUtils.rightPad(null, 0, 'a'));
        System.assertEquals('zzz', StringUtils.rightPad('', 3, 'z'));
        System.assertEquals('bat', StringUtils.rightPad('bat', 3, 'yz'));
        System.assertEquals('batyz', StringUtils.rightPad('bat', 5, 'yz'));
        System.assertEquals('batyzyzy', StringUtils.rightPad('bat', 8, 'yz'));
        System.assertEquals('bat', StringUtils.rightPad('bat', 1, 'yz'));
        System.assertEquals('bat', StringUtils.rightPad('bat', -1, 'yz'));
        System.assertEquals('bat  ', StringUtils.rightPad('bat', 5, null));
        System.assertEquals('bat  ', StringUtils.rightPad('bat', 5, ''));
    }
    
    static testMethod void testPadPerform() {
        StringUtils.leftPad('12', 10000, '0');
        StringUtils.leftPad('name=', 10000, ' ');
    }
    
    static testMethod void testCharAt() {
        System.assertEquals(null, StringUtils.charAt(null, 0));
        System.assertEquals('', StringUtils.charAt('', 0));
        System.assertEquals(null, StringUtils.charAt('abc', -1));
        System.assertEquals(null, StringUtils.charAt('abc', 3));
        System.assertEquals('a', StringUtils.charAt('abc', 0));
        System.assertEquals('c', StringUtils.charAt('abc', 2));
    }
    
    static testMethod void testToCharArray() {
        System.assertEquals(null, StringUtils.toCharArray(null));
        System.assertEquals(0, StringUtils.toCharArray('').size());
        System.assertEquals(2, StringUtils.toCharArray('12').size());
        System.assertEquals('1', StringUtils.toCharArray('12')[0]);
        System.assertEquals('2', StringUtils.toCharArray('12')[1]);
    }

    static testMethod void testPartition() {
        System.assertEquals(new String[]{'', '', ''}, StringUtils.partition(null, ''));
        System.assertEquals(new String[]{'', '', ''}, StringUtils.partition('', null));
        System.assertEquals(new String[]{'', '', ''}, StringUtils.partition('abc', ''));
        System.assertEquals(new String[]{'a', 'b', 'c'}, StringUtils.partition('abc', 'b'));
        System.assertEquals(new String[]{'', 'ab', 'c'}, StringUtils.partition('abc', 'ab'));
        System.assertEquals(new String[]{'a', 'bc', ''}, StringUtils.partition('abc', 'bc'));
        System.assertEquals(new String[]{'a', 'b', 'bc'}, StringUtils.partition('abbc', 'b'));
        System.assertEquals(new String[]{'abc', '', ''}, StringUtils.partition('abc', 'd'));
    }
    
    static testMethod void testScan() {
        System.assertEquals(new List<String[]>(), StringUtils.scan(null, ''));
        System.assertEquals(new List<String[]>(), StringUtils.scan('', (String) null));
        {
            List<String[]> result = new List<String[]>();
            result.add(new String[] {'<b>'});
            result.add(new String[] {'</b>'});
            result.add(new String[] {'<p>'});
            result.add(new String[] {'</p>'});
            result.add(new String[] {'<br />'});
            System.assertEquals(result, StringUtils.scan('<b>test</b><p>test</p><br />', '<[^>]+>'));
        }
        {
            List<String[]> result = new List<String[]>();
            result.add(new String[] {'Tel:090-1234-5678', '090-1234-5678', '090', '1234', '5678'});
            result.add(new String[] {'Tel:080-9876-5432', '080-9876-5432', '080', '9876', '5432'});
            System.assertEquals(result, StringUtils.scan('Tel:090-1234-5678\nTel:080-9876-5432', 'Tel:((\\d+)-(\\d+)-(\\d+))'));
        }
    }
    
    static testMethod void testDevide() {
        System.assertEquals(null, StringUtils.devide(null, 2));
        System.assertEquals(new String[]{}, StringUtils.devide('', 2));
        System.assertEquals(new String[]{'abc'}, StringUtils.devide('abc', 0));
        System.assertEquals(new String[]{'abc'}, StringUtils.devide('abc', -1));
        System.assertEquals(new String[]{'a', 'b', 'c'}, StringUtils.devide('abc', 1));
        System.assertEquals(new String[]{'ab', 'c'}, StringUtils.devide('abc', 2));
        System.assertEquals(new String[]{'abc'}, StringUtils.devide('abc', 4));
        System.assertEquals(new String[]{'012', '345', '67'}, StringUtils.devide('01234567', 3));
        System.assertEquals(new String[]{'012', '345', '678'}, StringUtils.devide('012345678', 3));
        System.assertEquals(new String[]{'012', '345', '678', '9'}, StringUtils.devide('0123456789', 3));
    }
    
    static testMethod void testFormat() {
        System.assertEquals(null, StringUtils.format(null, new String[] {'b'}));
        System.assertEquals('a{0}c', StringUtils.format('a{0}c', (String[]) null));
        System.assertEquals('a{0}c', StringUtils.format('a{0}c', new String[] {}));
        System.assertEquals('ac', StringUtils.format('a{0}c', new String[] {null}));
        System.assertEquals('abc', StringUtils.format('a{0}c', new String[] {'b'}));
        System.assertEquals('abc', StringUtils.format('a{0}c', new String[] {'b', 'd'}));
    }
    
    static testMethod void testFormatParam1() {
        System.assertEquals(null, StringUtils.format(null, 'b'));
        System.assertEquals('ac', StringUtils.format('a{0}c', (String) null));
        System.assertEquals('abc', StringUtils.format('a{0}c', 'b'));
    }
    
    static testMethod void testFormatParam2() {
        System.assertEquals(null, StringUtils.format(null, 'b', 'd'));
        System.assertEquals('ac', StringUtils.format('a{0}c{1}', null, null));
        System.assertEquals('abcd', StringUtils.format('a{0}c{1}', 'b', 'd'));
    }
    
    static testMethod void testFormatParam3() {
        System.assertEquals(null, StringUtils.format(null, 'b', 'd', 'e'));
        System.assertEquals('ac', StringUtils.format('a{0}c{1}', null, null, null));
        System.assertEquals('abcde', StringUtils.format('a{0}c{1}{2}', 'b', 'd', 'e'));
    }
}