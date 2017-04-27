/**
 * Queryのテストクラスです。
 *
 * @author k.uemura
 */
@IsTest
private class QueryTest {

    /**
     * 全ての型を検証します。
     */
    static testMethod void allType() {
        System.assertEquals(''
                + 'Name like \'%Name%\''
                + ' and Key__c like \'%Key__c%\''
                + ' and Checkbox__c = true'
                + ' and Decimal__c >= 0'
                + ' and Decimal__c <= 10'
                + ' and Picklist__c = \'picklist\''
                + ' and Date__c = 2015-11-12'
                + ' and Datetime__c = 2015-11-12T16:45:50+0900'
            , new Query()
                .addAnd('Name like \'%?%\'', 'Name')
                .addAnd('Key__c like \'%?%\'', 'Key__c')
                .addAnd('Checkbox__c = ?', true)
                .addAnd('Decimal__c >= ?', 0)
                .addAnd('Decimal__c <= ?', 10)
                .addAnd('Picklist__c = \'?\'', 'picklist')
                .addAnd('Date__c = ?', Date.newInstance(2015, 11, 12))
                .addAnd('Datetime__c = ?', Datetime.newInstance(2015, 11, 12, 16, 45, 50))
                .expression());
    }

    /**
     * 全ての条件がnullの場合を検証します。
     */
    static testMethod void allNull() {
        System.assertEquals(''
            , new Query()
                .addAnd('Name like \'%?%\'', null)
                .addAnd('Key__c like \'%?%\'', null)
                .addAnd('Checkbox__c = ?', null)
                .addAnd('Decimal__c >= ?', null)
                .addAnd('Decimal__c <= ?', null)
                .addAnd('Picklist__c = \'?\'', null)
                .addAnd('Date__c = ?', null)
                .addAnd('Datetime__c = ?', null)
                .expression());
    }

    /**
     * 最初の条件がnullの場合を検証します。
     */
    static testMethod void firstNull() {
        System.assertEquals(''
                + 'B = 2'
            , new Query()
                .addAnd('A = ?', null)
                .addAnd('B = ?', 2)
                .expression());
    }

    /**
     * 2つ目の条件がnullの場合を検証します。
     */
    static testMethod void secondNull() {
        System.assertEquals(''
                + 'A = 1'
            , new Query()
                .addAnd('A = ?', 1)
                .addAnd('B = ?', null)
                .expression());
    }

    /**
     * or条件を追加した場合を検証します。
     */
    static testMethod void addOr() {
        System.assertEquals(''
                + 'A = 1'
                + ' or B = 2'
            , new Query()
                .addOr('A = ?', 1)
                .addOr('B = ?', 2)
                .expression());
    }

    /**
     * ネストしていない条件が追加された場合を検証します。
     */
    static testMethod void nonnested() {
        System.assertEquals(''
                + 'A = 1'
                + ' and B = 2'
                + ' and C = 3'
            , new Query()
                .addAnd('A = ?', 1)
                .addAnd('B = ?', 2)
                .addAnd('C = ?', 3)
                .expression());
    }

    /**
     * 一つ目にネストした条件が追加された場合を検証します。
     */
    static testMethod void nestedFirst() {
        System.assertEquals(''
                + '(A = 1 and B = 2)'
                + ' and C = 3'
            , new Query()
                .addAnd(new Query()
                    .addAnd('A = ?', 1)
                    .addAnd('B = ?', 2))
                .addAnd('C = ?', 3)
                .expression());

        System.assertEquals(''
                + '(A = 1 and B = 2)'
                + ' or C = 3'
            , new Query()
                .addOr(new Query()
                    .addAnd('A = ?', 1)
                    .addAnd('B = ?', 2))
                .addOr('C = ?', 3)
                .expression());
    }

    /**
     * 二つ目にネストした条件が追加された場合を検証します。
     */
    static testMethod void nestedSecond() {
        System.assertEquals(''
                + 'A = 1'
                + ' and (B = 2 and C = 3)'
            , new Query()
                .addAnd('A = ?', 1)
                .addAnd(new Query()
                    .addAnd('B = ?', 2)
                    .addAnd('C = ?', 3))
                .expression());

        System.assertEquals(''
                + 'A = 1'
                + ' or (B = 2 and C = 3)'
            , new Query()
                .addOr('A = ?', 1)
                .addOr(new Query()
                    .addAnd('B = ?', 2)
                    .addAnd('C = ?', 3))
                .expression());
    }

    /**
     * 空のネストした条件が追加された場合を検証します。
     */
    static testMethod void nestedEmpty() {
        System.assertEquals(''
                + 'A = 1'
            , new Query()
                .addAnd('A = ?', 1)
                .addAnd(new Query()
                    .addAnd('B = ?', null)
                    .addAnd('C = ?', null))
                .expression());
    }

    /**
     * 固定の条件が追加された場合を検証します。
     */
    static testMethod void fixed() {
        System.assertEquals(''
                + 'A = 1'
            , new Query()
                .addAnd('A = 1')
                .expression());
        System.assertEquals(''
                + 'A = 1'
                + ' and B = 2'
            , new Query()
                .addAnd('A = 1')
                .addAnd('B = 2')
                .expression());
        System.assertEquals(''
                + 'A = 1'
                + ' and B = 2'
            , new Query()
                .addAnd('A = 1')
                .addAnd('B = ?', 2)
                .expression());

        System.assertEquals(''
                + 'A = 1'
            , new Query()
                .addOr('A = 1')
                .expression());
        System.assertEquals(''
                + 'A = 1'
                + ' or B = 2'
            , new Query()
                .addOr('A = 1')
                .addOr('B = 2')
                .expression());
        System.assertEquals(''
                + 'A = 1'
                + ' or B = 2'
            , new Query()
                .addOr('A = 1')
                .addOr('B = ?', 2)
                .expression());

        System.assertEquals(''
                + 'A = :v'
            , new Query()
                .addAnd('A = :v')
                .expression());
    }

    /**
     * シングルクォートが含まれる場合を検証します。
     */
    static testMethod void escapeSingleQuotes() {
        System.assertEquals(''
                + 'Name like \'\\\'Name\\\'\''
            , new Query()
                .addAnd('Name like \'?\'', '\'Name\'')
                .expression());
    }
    
    /**
     * 条件がない状態でbuildを使って構築した場合を検証します。
     */
    static testMethod void buildEmpty() {
        System.assertEquals(''
            , new Query()
                .addAnd('A = ?', null)
                .build());
    }
    
    /**
     * buildを使って構築した場合を検証します。
     */
    static testMethod void buildNotEmpty() {
        System.assertEquals(''
                + 'where A = 2'
            , new Query()
                .addAnd('A = ?', 2)
                .build());
    }
}