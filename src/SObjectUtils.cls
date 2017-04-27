public class SObjectUtils {
  
    /**
     * sObjectのプロパティ値を返します。
     * 
     * nestedFieldNameをドット区切りにする事でリレーションを辿って値を返します。
     *
     * [example]
     * Account acc = new Account(Name = 'Account');
     * Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura', Account = acc);
     *
     * SObjectUtils.getProperty(con, 'Firstname') = 'Koichi'
     * SObjectUtils.getProperty(con, 'Account.Name') = 'Account'
     *
     *
     * リレーションを辿る途中にnullのオブジェクトがあった場合はnullを返します。
     * 
     * [example]
     * SObjectUtils.getProperty(null, 'Firstname') = null
     *
     * Contact con = new Contact(Firstname = 'Koichi', Lastname = 'Uemura');
     *
     * SObjectUtils.getProperty(con, 'Account.Name') = null
     *
     * 存在しないフィールドが指定された場合はsObject#getPropertyと同じ様にSObjectExceptionが発行されます。
     */
    public static Object getProperty(sObject sObj, String nestedFieldName) {
        if (sObj == null) {
            return null;
        }
        String[] names = nestedFieldName.split('\\.');
        for (Integer i = 0; i < names.size() - 1; i++) {
            sObj = sObj.getSObject(names[i]);
            if (sObj == null) {
                return null;
            }
        }
        return sObj.get(names[names.size() - 1]);
    }
    
    /**
     * sObjectのリレーション項目のオブジェクトを返します。
     *
     * 詳細な仕様はSObjectUtils.getProperty(sObj, nestedFieldName)とほぼ同じです。
     * 違うのは項目の値を返すのか、オブジェクトを返すのかだけです。
     */
    public static sObject getSObject(sObject sObj, String nestedSObjectName) {
        if (sObj == null) {
            return null;
        }
        String[] names = nestedSObjectName.split('\\.');
        for (Integer i = 0; i < names.size(); i++) {
            sObj = sObj.getSObject(names[i]);
            if (sObj == null) {
                return null;
            }
        }
        return sObj;
    }

    /**
     * sObjectにプロパティ値を設定します。
     * 
     * nestedFieldNameをドット区切りにする事でリレーションを辿って値を設定します。
     *
     * リレーションを辿る途中にnullのオブジェクトがあった場合は値を設定しません。
     *
     * 存在しないフィールドが指定された場合はsObject#setPropertyと同じ様にSObjectExceptionが発行されます。
     * 項目の型と違う型のオブジェクトが設定された場合も同じくSObjectExceptionが発行されます。
     */
    public static void setProperty(sObject sObj, String nestedFieldName, Object value) {
        if (sObj == null) {
            return;
        }
        String[] names = nestedFieldName.split('\\.');
        for (Integer i = 0; i < names.size() - 1; i++) {
            sObj = sObj.getSObject(names[i]);
            if (sObj == null) {
                return;
            }
        }
        sObj.put(names[names.size() - 1], value);
    }
    
    /**
     * sObjectのリレーション項目のオブジェクトを設置します。
     *
     * 詳細な仕様はSObjectUtils.setProperty(sObj, nestedFieldName, value)とほぼ同じです。
     * 違うのは項目の値を設定するのか、オブジェクトを設定するのかだけです。
     */
    public static void setSObject(sObject sObj, String nestedSObjectName, sObject value) {
        if (sObj == null) {
            return;
        }
        String[] names = nestedSObjectName.split('\\.');
        for (Integer i = 0; i < names.size() - 1; i++) {
            sObj = sObj.getSObject(names[i]);
            if (sObj == null) {
                return;
            }
        }
        sObj.putSObject(names[names.size() - 1], value);
    }
    
    /**
     * レコードIDのリストからsObjectのリストを作成します。
     * 削除時などに使ってください。
     */
    public static List<SObject> newSObjects(List<Id> ids) {
        if (ids.isEmpty()) {
            return new List<SObject>();
        }
        List<SObject> records = new List<SObject>();
        SObjectType sObjectType = ids[0].getSObjectType();
        for (Id id : ids) {
            records.add(sObjectType.newSObject(id));
        }
        return records;
    }
    
    /**
     * 指定したフィールドの選択肢を返します。
     */
    public static SelectOption[] getSelectOptions(Schema.SObjectField field) {
        SelectOption[] options = new SelectOption[0];
        for (Schema.PicklistEntry entry : field.getDescribe().getPicklistValues()) {
            options.add(new SelectOption(entry.getValue(), entry.getLabel()));
        }
        return options;
    }
    
    private static final Map<String, Id> recordTypeCacheMap = new Map<String, Id>();
    
    /**
     * レコードタイプの英名を元にレコードタイプのIDを返します。
     *
     * 一度取得したレコードタイプのIdはキャッシュされます。
     */
    public static Id getRecordTypeId(String sObjectType, String developerName) {
        String key = developerName;
        Id recordTypeId = recordTypeCacheMap.get(key);
        if (recordTypeId == null) {
            recordTypeId = [
                select Id
                  from RecordType
                 where DeveloperName = :developerName
                   and SObjectType = :sObjectType
            ].Id;
            recordTypeCacheMap.put(key, recordTypeId);
        }
        return recordTypeId;
    }
    
    public static Boolean equals(Boolean sequentialComparison, sObject[] ls, sObject[] rs, Schema.SObjectField[] fields) {
        if (ls.size() != rs.size()) {
            return false;
        }
        if (sequentialComparison) {
            for (Integer i = 0; i < ls.size(); i++) {
                if (!equals(ls[i], rs[i], fields)) {
                    return false;
                }
            }
        } else {
            Map<Id, sObject> rMap = new Map<Id, sObject>(rs);
            for (sObject l : ls) {
                sObject r = rMap.get(l.Id);
                if (!equals(l, r, fields)) {
                    return false;
                }
            }
        }
        return true;
    }
    
    public static Boolean equals(sObject l, sObject r, Schema.SObjectField[] fields) {
        if (l == null && r == null) {
            return true;
        } else if (l == null) {
            return false;
        } else if (r == null) {
            return false;
        }
        for (Schema.SObjectField field : fields) {
            if (l.get(field) != r.get(field)) {
                return false;
            }
        }
        return true;
    }
}