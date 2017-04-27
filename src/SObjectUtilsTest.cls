@IsTest
private class SObjectUtilsTest {
    static testMethod void testGetProperty() {
        {
            Account acc = new Account(Name = 'Account');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Account = acc);
            System.assertEquals('Koichi', SObjectUtils.getProperty(con, 'Firstname'));
            System.assertEquals('Account', SObjectUtils.getProperty(con, 'Account.Name'));
        }
        {
            System.assertEquals(null, SObjectUtils.getProperty(null, 'Firstname'));
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura');
            System.assertEquals(null, SObjectUtils.getProperty(con, 'Account.Name'));
        }
    }
    
    static testMethod void testGetPropertyNotExistField() {
            Account acc = new Account(Name = 'Account');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Account = acc);
            try {
                SObjectUtils.getProperty(con, 'NotExistField');
                System.assert(false);
            } catch (SObjectException e) {
                System.assert(true);
            }
            try {
                SObjectUtils.getProperty(con, 'NotExistSObject.Name');
                System.assert(false);
            } catch (SObjectException e) {
                System.assert(true);
            }
    }
    
    static testMethod void testGetSObject() {
        {
            Account acc = new Account(Name = 'Account');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Account = acc);
            System.assertEquals(acc , SObjectUtils.getSObject(con, 'Account'));
        }
        {
            System.assertEquals(null, SObjectUtils.getProperty(null, 'Account'));
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura');
            System.assertEquals(null, SObjectUtils.getSObject(con, 'Account.Owner'));
        }
//        {
//            Account acc = new Account(Name = 'Account');
//            insert acc;
//            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', AccountId = acc.Id);
//            insert con;
//            con = [
//                select Account.Owner.Name
//                     , Account.Owner.Id
//                  from Contact
//                 where Id = :con.Id
//            ];
//            System.assertEquals(UserInfo.getUserId(), SObjectUtils.getSObject(con, 'Account.Owner').Id);
//        }
    }
    
    static testMethod void testSetProperty() {
        {
            Account acc = new Account(Name = 'Account');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Account = acc);
            SObjectUtils.setProperty(con, 'Firstname', 'Masato');
            System.assertEquals('Masato', con.Firstname);
            SObjectUtils.setProperty(con, 'Account.Name', 'Trio');
            System.assertEquals('Trio', con.Account.Name);
        }
        {
            SObjectUtils.setProperty(null, 'Firstname', 'Masato');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura');
            SObjectUtils.setProperty(con, 'Account.Name', 'Trio');
        }
    }
    
    static testMethod void testSetPropertyNotExistField() {
            Account acc = new Account(Name = 'Account');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Account = acc);
            try {
                SObjectUtils.setProperty(con, 'NotExistField', 'abc');
                System.assert(false);
            } catch (SObjectException e) {
                System.assert(true);
            }
            try {
                SObjectUtils.setProperty(con, 'NotExistSObject.Name', 'abc');
                System.assert(false);
            } catch (SObjectException e) {
                System.assert(true);
            }
    }
    
    static testMethod void testSetPropertyInvalidType() {
            Account acc = new Account(Name = 'Account');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Account = acc);
            try {
                SObjectUtils.setProperty(acc, 'Name', 5);
                System.assert(false);
            } catch (SObjectException e) {
                System.assert(true);
            }
    }
    
    static testMethod void testSetSObject() {
        {
            Account acc = new Account(Name = 'Account');
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura');
            SObjectUtils.setSObject(con, 'Account', acc);
            System.assertEquals(acc, con.Account);
        }
        {
            SObjectUtils.setSObject(null, 'Account', null);
            
            Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura');
            SObjectUtils.setSObject(con, 'Account', null);
        }
    }
    
    static testMethod void testGetSelectOptions() {
        SelectOption[] options = SObjectUtils.getSelectOptions(Contact.LeadSource);
    }

    static testMethod void testEqualsSObject() {
        Contact l = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Title = '下っ端');
        Contact r = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Title = '会長');
        Contact[] ls = new Contact[]{l};
        Contact[] rs = new Contact[]{r};
        System.assertEquals(true, SObjectUtils.equals(true, ls, rs, new Schema.SObjectField[] {
            Contact.Firstname
            , Contact.Lastname
        }));
        System.assertEquals(false, SObjectUtils.equals(true, ls, rs, new Schema.SObjectField[] {
            Contact.Firstname
            , Contact.Lastname
            , Contact.Title
        }));
        
        System.assertEquals(false, SObjectUtils.equals(true, new Contact[]{l}, new Contact[]{r, r}, new Schema.SObjectField[] {
            Contact.Firstname
        }));
    }

    static testMethod void testEqualsSObjectFields() {
        Contact l = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Title = '下っ端');
        Contact r = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Title = '会長');
        System.assertEquals(true, SObjectUtils.equals(l, r, new Schema.SObjectField[] {
            Contact.Firstname
            , Contact.Lastname
        }));
        System.assertEquals(false, SObjectUtils.equals(l, r, new Schema.SObjectField[] {
            Contact.Firstname
            , Contact.Lastname
            , Contact.Title
        }));
        
        System.assertEquals(true, SObjectUtils.equals((sObject) null, (sObject) null, new Schema.SObjectField[] {
            Contact.Firstname
        }));
        System.assertEquals(false, SObjectUtils.equals(l, null, new Schema.SObjectField[] {
            Contact.Firstname
        }));
        System.assertEquals(false, SObjectUtils.equals(null, r, new Schema.SObjectField[] {
            Contact.Firstname
        }));
    }
    
    static testMethod void testNewSObjects() {
        System.assertEquals(0, SObjectUtils.newSObjects(new Id[0]).size());
    }
}