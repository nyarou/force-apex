/**
 * SOQLのビルダーです。
 *
 * 以下は使用例です。
 *
 * example:
 *   String whereClause = new Query()
 *       .addAnd('Name like \'%?%\'', name)
 *       .addAnd('Key__c = \'?\'', key)
 *       .addAnd('Checkbox__c = ?', checkbox)
 *       .addAnd('Decimal__c >= ?', numFrom)
 *       .addAnd('Decimal__c <= ?', numTo)
 *       .addAnd('Picklist__c = \'?\'', picklist)
 *       .addAnd('Date__c = ?', dateVal)
 *       .addAnd('Datetime__c = ?', datetimeVal)
 *       .build();
 *
 * 値がnullであれば条件に追加されません。
 *
 * example:
 *   System.assertEquals('B = 2'
 *       , new Query()
 *           .addAnd('A = ?', null)
 *           .addAnd('B = ?', 2)
 *           .expression());
 *
 * 変数をバインドする場合は以下のように指定してください。
 *
 * example:
 *   String whereClause = new Query()
 *       .addAnd('Date__c = :targetDate', targetDate)
 *       .expression();
 *
 * 固定の条件を追加する場合は以下のように指定してください。
 *
 * example:
 *   String whereClause = new Query()
 *       .addAnd('Date__c = TODAY')
 *       .expression();
 *
 * 値にシングルクォートが含まれる場合は自動でエスケープされます。
 *
 * example:
 *   System.assertEquals('Name = \'\\\'Name\\\'\''
 *       , new Query()
 *           .addAnd('Name = \'?\'', '\'Name\'')
 *           .expression());
 *
 * ネストした条件を追加する場合は以下のように指定してください。
 *
 * example:
 *   System.assertEquals('A = 1 and (B = 2 or C = 3)'
 *       , new Query()
 *           .addAnd('A = ?', 1)
 *           .addAnd(new Query()
 *               .addOr('B = ?', 2)
 *               .addOr('C = ?', 3))
 *           .expression());
 *
 *   System.assertEquals('A = 1'
 *       , new Query()
 *           .addAnd('A = ?', 1)
 *           .addAnd(new Query()
 *               .addOr('B = ?', null)
 *               .addOr('C = ?', null))
 *           .expression());
 *
 * 文字列の組立方法には2種類あります。
 *  - buildを使うと条件が一つも無い時を除き、" where "付きで出力されます。
 *  - expressionを使うと" where "は付与されません。
 *
 * @author k.uemura
 */
public class Query {
    private Fields fields {get; set;}
    private String fromType {get; set;}
    private Conditions conds {get; set;}
    private String orderBy {get; set;}
    private Integer limitNumber {get; set;}
    private Integer offsetNumber {get; set;}

    public Query() {
        fields = new Fields();
        conds = new Conditions();
    }

    public Query addFields(Fields fields) {
        fields.addFields(fields);
        return this;
    }

    public Query addFields(SObjectType sObjectType) {
        fields.addFields(sObjectType);
        return this;
    }

    public Query addFields(String fieldsString) {
        fields.addFields(fieldsString);
        return this;
    }

    public Query addField(String fieldString) {
        fields.addField(fieldString);
        return this;
    }

    public Query addField(SObjectField field) {
        fields.addField(field);
        return this;
    }

    public Query addField(SObjectField parent1, SObjectField field) {
        fields.addField(parent1, field);
        return this;
    }

    public Query addField(SObjectField parent1, SObjectField parent2, SObjectField field) {
        fields.addField(parent1, parent2, field);
        return this;
    }

    public Query addField(SObjectField parent1, SObjectField parent2, SObjectField parent3, SObjectField field) {
        fields.addField(parent1, parent2, parent3, field);
        return this;
    }

    public Query addField(SObjectField parent1, SObjectField parent2, SObjectField parent3, SObjectField parent4, SObjectField field) {
        fields.addField(parent1, parent2, parent3, parent4, field);
        return this;
    }

    public Query addFrom(String t) {
        fromType = t;
        return this;
    }

    public Query addFrom(SObjectType t) {
        fromType = t.getDescribe().getName();
        return this;
    }

    public Query addAnd(String exp) {
        conds.addAnd(exp);
        return this;
    }

    public Query addOr(String exp) {
        conds.addOr(exp);
        return this;
    }

    public Query addAnd(String exp, Object val) {
        conds.addAnd(exp, val);
        return this;
    }

    public Query addOr(String exp, Object val) {
        conds.addOr(exp, val);
        return this;
    }

    public Query addAnd(Query nestedCondition) {
        conds.addAnd(nestedCondition.conds);
        return this;
    }

    public Query addOr(Query nestedCondition) {
        conds.addOr(nestedCondition.conds);
        return this;
    }

    public Query addOrderBy(String orderBy) {
        this.orderBy = orderBy;
        return this;
    }

    public Query addLimit(Integer limitNumber) {
        this.limitNumber = limitNumber;
        return this;
    }

    public Query addOffset(Integer offsetNumber) {
        this.offsetNumber = offsetNumber;
        return this;
    }

    public String expression() {
        return conds.toString();
    }

    public String build() {
        String[] parts = new String[0];
        String fieldsString = fields.toString();
        if (String.isNotEmpty(fieldsString)) {
            parts.add('select ' + fieldsString);
        }
        if (String.isNotEmpty(fromType)) {
            parts.add('from ' + fromType);
        }
        String whereString = conds.toString();
        if (String.isNotEmpty(whereString)) {
            parts.add('where ' + whereString);
        }
        if (String.isNotEmpty(orderBy)) {
            parts.add('order by ' + orderBy);
        }
        if (limitNumber != null) {
            parts.add('limit ' + limitNumber);
        }
        if (offsetNumber != null) {
            parts.add('offset ' + offsetNumber);
        }
        return String.join(parts, ' ');
    }

    public class Fields {
        private String[] fields {get; set;}

        // TODO 子リレーション

        public Fields() {
            fields = new String[0];
        }

        public Fields addFields(Fields fields) {
            this.fields.addAll(fields.fields);
            return this;
        }

        public Fields addFields(SObjectType sObjectType) {
            Map<String, SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
            String[] keys = new List<String>(fieldMap.keySet());
            keys.sort();
            for (String key : keys) {
                SObjectField field = fieldMap.get(key);
                DescribeFieldResult result = field.getDescribe();
                if (!result.isAccessible()) {
                    continue;
                }
                fields.add(result.getName());
            }
            return this;
        }

        public Fields addFields(String fieldsString) {
            String[] fields = fieldsString.split('\\s*,\\s*', 0);
            fields.addAll(fields);
            return this;
        }

        public Fields addField(String fieldString) {
            fields.add(fieldString);
            return this;
        }

        public Fields addField(SObjectField field) {
            addField(new SObjectField[] {field});
            return this;
        }

        public Fields addField(SObjectField parent1, SObjectField field) {
            addField(new SObjectField[] {parent1, field});
            return this;
        }

        public Fields addField(SObjectField parent1, SObjectField parent2, SObjectField field) {
            addField(new SObjectField[] {parent1, parent2, field});
            return this;
        }

        public Fields addField(SObjectField parent1, SObjectField parent2, SObjectField parent3, SObjectField field) {
            addField(new SObjectField[] {parent1, parent2, parent3, field});
            return this;
        }

        public Fields addField(SObjectField parent1, SObjectField parent2, SObjectField parent3, SObjectField parent4, SObjectField field) {
            addField(new SObjectField[] {parent1, parent2, parent3, parent4, field});
            return this;
        }

        private void addField(SObjectField[] relationshipField) {
            String[] names = new String[0];
            for (Integer i = 0; i < relationshipField.size() - 1; i++) {
                names.add(relationshipField[i].getDescribe().getRelationshipName());
            }
            names.add(relationshipField[relationshipField.size() - 1].getDescribe().getName());
            fields.add(String.join(names, '.'));
        }

        public override String toString() {
            return String.join(fields, ', ');
        }
    }
    
    private abstract class Condition {
        public String logicalOperator {get; set;}
    }

    private class FixedExpression extends Condition {
        private String exp {get; set;}

        public FixedExpression(String logicalOperator, String exp) {
            this.logicalOperator = logicalOperator;
            this.exp = exp;
        }

        public override String toString() {
            return exp;
        }
    }

    private class Expression extends Condition {
        private String exp {get; set;}
        private Object val {get; set;}

        public Expression(String logicalOperator, String exp, Object val) {
            this.logicalOperator = logicalOperator;
            this.exp = exp;
            this.val = val;
        }

        public override String toString() {
            if (exp.contains(':')) {
                return exp;
            } else {
                return exp.replace('?', String.escapeSingleQuotes(getValueString()));
            }
        }

        private String getValueString() {
            if (val == null) {
                return null;
            }
            if (val instanceof String) {
                return (String) val;
            } else if (val instanceof Decimal) {
                return String.valueOf((Decimal) val);
            } else if (val instanceof Boolean) {
                return String.valueOf((Boolean) val);
            } else if (val instanceof Date) {
                return String.valueOf((Date) val);
            } else if (val instanceof Datetime) {
                return ((Datetime) val).format('yyyy-MM-dd\'T\'HH:mm:ssZ');
            } else {
                return null;
            }
        }
    }

    private class Conditions extends Condition {
        private Condition[] conds {get; set;}

        public Conditions() {
            conds = new Condition[0];
        }

        public override String toString() {
            String[] parts = new String[0];
            for (Condition cond : conds) {
                if (!parts.isEmpty()) {
                    parts.add(cond.logicalOperator);
                }
                if (cond instanceof Conditions) {
                    parts.add('(' + cond.toString() + ')');
                } else {
                    parts.add(cond.toString());
                }
            }
            return String.join(parts, ' ');
        }

        public void addAnd(String exp) {
            addExpression('and', exp);
        }

        public void addOr(String exp) {
            addExpression('or', exp);
        }

        private void addExpression(String logicalOperator, String exp) {
            conds.add(new FixedExpression(logicalOperator, exp));
        }

        public void addAnd(String exp, Object val) {
            addExpression('and', exp, val);
        }

        public void addOr(String exp, Object val) {
            addExpression('or', exp, val);
        }

        private void addExpression(String logicalOperator, String exp, Object val) {
            if (val == null
                    || val instanceof String && String.isEmpty((String) val)) {
                return;
            }
            conds.add(new Expression(logicalOperator, exp, val));
        }

        public void addAnd(Conditions nestedConditions) {
            addExpression('and', nestedConditions);
        }

        public void addOr(Conditions nestedConditions) {
            addExpression('or', nestedConditions);
        }

        private void addExpression(String logicalOperator, Conditions nestedConditions) {
            if (nestedConditions == null
                    || nestedConditions.conds.isEmpty()) {
                return;
            }
            nestedConditions.logicalOperator = logicalOperator;
            conds.add(nestedConditions);
        }
    }
}