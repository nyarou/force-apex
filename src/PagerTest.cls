@IsTest
private class PagerTest {
    static testMethod void size() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(31, pager.size);
    }

    static testMethod void pageSize() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(10, pager.pageSize);
    }

    static testMethod void pageNumber() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(0, pager.pageNumber);
        pager.next();
        System.assertEquals(1, pager.pageNumber);
    }

    static testMethod void getMaxPageNumber() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(3, pager.getMaxPageNumber());
    }

    static testMethod void getDisplayPageNumber() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(1, pager.getDisplayPageNumber());
    }

    static testMethod void getDisplayMaxPageNumber() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(4, pager.getDisplayMaxPageNumber());
    }

    static testMethod void getFrom() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(0, pager.getFrom());
        pager.next();
        System.assertEquals(10, pager.getFrom());
        pager.last();
        System.assertEquals(30, pager.getFrom());
    }

    static testMethod void getTo() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(9, pager.getTo());
        pager.next();
        System.assertEquals(19, pager.getTo());
        pager.last();
        System.assertEquals(30, pager.getTo());
    }

    static testMethod void getHasPrev() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(false, pager.getHasPrev());
        pager.next();
        System.assertEquals(true, pager.getHasPrev());
        pager.last();
        System.assertEquals(true, pager.getHasPrev());
    }

    static testMethod void getHasNext() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(true, pager.getHasNext());
        pager.next();
        System.assertEquals(true, pager.getHasNext());
        pager.last();
        System.assertEquals(false, pager.getHasNext());
    }

    static testMethod void prev() {
        Pager pager = new Pager(31, 10);
        pager.next();
        pager.next();
        System.assertEquals(2, pager.pageNumber);
        pager.prev();
        System.assertEquals(1, pager.pageNumber);
    }

    static testMethod void next() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(0, pager.pageNumber);
        pager.next();
        System.assertEquals(1, pager.pageNumber);
    }

    static testMethod void first() {
        Pager pager = new Pager(31, 10);
        pager.next();
        pager.next();
        System.assertEquals(2, pager.pageNumber);
        pager.first();
        System.assertEquals(0, pager.pageNumber);
    }

    static testMethod void last() {
        Pager pager = new Pager(31, 10);
        System.assertEquals(0, pager.pageNumber);
        pager.last();
        System.assertEquals(3, pager.pageNumber);
    }

}