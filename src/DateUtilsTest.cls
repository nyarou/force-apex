@IsTest
private class DateUtilsTest {
    static testMethod void testValueOfDefault() {
        Date expected = System.today();
        System.assertEquals(expected, DateUtils.valueOf(null, expected));
        System.assertEquals(expected, DateUtils.valueOf('', expected));
        System.assertEquals(expected, DateUtils.valueOf('2012-1-32', expected));

        System.assertEquals(Date.valueOf('2012-01-06'), DateUtils.valueOf('2012-01-06', expected));
        System.assertEquals(Date.valueOf('2012-01-06'), DateUtils.valueOf('2012-1-6', expected));
        System.assertEquals(Date.valueOf('2012-01-06'), DateUtils.valueOf('2012/01/06', expected));
    }


    static testMethod void testFormat() {
        Date expected = System.today();
        System.assertEquals('121231', DateUtils.format(Date.newInstance(2012, 12, 31), 'yyMMdd'));
        System.assertEquals('120101', DateUtils.format(Date.newInstance(2012, 1, 1), 'yyMMdd'));
    }

    static testMethod void testParseDefault() {
        Date expected = System.today();
        System.assertEquals(expected, DateUtils.parse(null, expected));
        System.assertEquals(expected, DateUtils.parse('', expected));
        System.assertEquals(expected, DateUtils.parse('xyz', expected));

        System.assertEquals(Date.newInstance(2012, 1, 31), DateUtils.parse(Date.newInstance(2012, 1, 31).format(), expected));
    }

    static testMethod void testToList() {
        {
            Date[] dates = DateUtils.toList(Date.newInstance(2012, 4, 17), Date.newInstance(2012, 4, 19));
            System.assertEquals(3, dates.size());
            System.assertEquals(Date.newInstance(2012, 4, 17), dates[0]);
            System.assertEquals(Date.newInstance(2012, 4, 18), dates[1]);
            System.assertEquals(Date.newInstance(2012, 4, 19), dates[2]);
        }

        {
            Date[] dates = DateUtils.toList(Date.newInstance(2012, 4, 19), Date.newInstance(2012, 4, 17));
            System.assertEquals(3, dates.size());
            System.assertEquals(Date.newInstance(2012, 4, 19), dates[0]);
            System.assertEquals(Date.newInstance(2012, 4, 18), dates[1]);
            System.assertEquals(Date.newInstance(2012, 4, 17), dates[2]);
        }

        {
            Date[] dates = DateUtils.toList(Date.newInstance(2012, 4, 17), Date.newInstance(2012, 4, 17));
            System.assertEquals(1, dates.size());
            System.assertEquals(Date.newInstance(2012, 4, 17), dates[0]);
        }
    }

    static testMethod void testlastDateOfMonth() {
        System.assertEquals(null, DateUtils.lastDateOfMonth(null));
        System.assertEquals(Date.newInstance(2012, 4, 30), DateUtils.lastDateOfMonth(Date.newInstance(2012, 4, 1)));
        System.assertEquals(Date.newInstance(2012, 4, 30), DateUtils.lastDateOfMonth(Date.newInstance(2012, 4, 30)));
        System.assertEquals(Date.newInstance(2012, 10, 31), DateUtils.lastDateOfMonth(Date.newInstance(2012, 10, 11)));
        System.assertEquals(Date.newInstance(2012, 10, 31), DateUtils.lastDateOfMonth(Date.newInstance(2012, 10, 31)));
        System.assertEquals(Date.newInstance(2012, 12, 31), DateUtils.lastDateOfMonth(Date.newInstance(2012, 12, 31)));
        System.assertEquals(Date.newInstance(2013, 1, 31), DateUtils.lastDateOfMonth(Date.newInstance(2013, 1, 1)));
        System.assertEquals(Date.newInstance(2012, 2, 29), DateUtils.lastDateOfMonth(Date.newInstance(2012, 2, 1)));
        System.assertEquals(Date.newInstance(2013, 2, 28), DateUtils.lastDateOfMonth(Date.newInstance(2013, 2, 1)));
    }

    static testMethod void testfirstDateOfMonth() {
        System.assertEquals(null, DateUtils.lastDateOfMonth(null));
        System.assertEquals(Date.newInstance(2012, 4, 1), DateUtils.firstDateOfMonth(Date.newInstance(2012, 4, 1)));
        System.assertEquals(Date.newInstance(2012, 4, 1), DateUtils.firstDateOfMonth(Date.newInstance(2012, 4, 30)));
        System.assertEquals(Date.newInstance(2012, 10, 1), DateUtils.firstDateOfMonth(Date.newInstance(2012, 10, 11)));
        System.assertEquals(Date.newInstance(2012, 10, 1), DateUtils.firstDateOfMonth(Date.newInstance(2012, 10, 31)));
        System.assertEquals(Date.newInstance(2012, 12, 1), DateUtils.firstDateOfMonth(Date.newInstance(2012, 12, 31)));
        System.assertEquals(Date.newInstance(2013, 1, 1), DateUtils.firstDateOfMonth(Date.newInstance(2013, 1, 1)));
        System.assertEquals(Date.newInstance(2012, 2, 1), DateUtils.firstDateOfMonth(Date.newInstance(2012, 2, 29)));
        System.assertEquals(Date.newInstance(2013, 2, 1), DateUtils.firstDateOfMonth(Date.newInstance(2013, 2, 28)));
    }
    
    static testMethod void testGetChangeDay() {
        System.assertEquals(null, DateUtils.changeDay(null, 1));
        System.assertEquals(Date.newInstance(2012, 4, 3), DateUtils.changeDay(Date.newInstance(2012, 4, 1), 3));
        System.assertEquals(Date.newInstance(2012, 1, 31), DateUtils.changeDay(Date.newInstance(2012, 1, 1), 31));
        System.assertEquals(Date.newInstance(2012, 1, 1), DateUtils.changeDay(Date.newInstance(2012, 1, 31), 1));
    }
}