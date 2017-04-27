/**
 * 実行時間とガバナ制限計測用のクラスです。
 *
 * 次の様に実行すると計測結果がデバッグログに出力されます。
 *
 * StopWatch stopWatch = LimitWatch.start();
 *
 * // 計測したい処理
 *
 * stopWatch.dumpToLog('ソート時間の計測');
 * 
 * @author k.uemura
 */
public virtual class LimitWatch extends StopWatch {
    protected String TEMPLATE_LOG = '計測結果：${summary}'
        + '\n実行時間：${time}ms'
        + '\n開始終了：${startTime} ～ ${stopTime}'
        + '\nガバナ制限種類：増加数, 初期値, 現在値, 限界値'
        + '\n${body}';

    // private static Map<String, String> TYPE_LABEL_MAP = new Map<String, String> {
    //     'AggregateQueries' => '集計クエリ数'
    //     , 'Callouts' => 'コールアウト数'
    //     , 'ChildRelationshipsDescribes' => '子リレーション取得数'
    //     , 'CpuTime' => 'CPU時間'
    //     , 'DMLRows' => 'DML処理行数'
    //     , 'DMLStatements' => 'DML実行数'
    //     , 'EmailInvocations' => 'Email実行数'
    //     , 'FieldSetsDescribes' => 'フィールドセット取得数'
    //     , 'FieldsDescribes' => 'Fields取得数'
    //     , 'FutureCalls' => '非同期コール数'
    //     , 'HeapSize' => 'ヒープサイズ'
    //     , 'PicklistDescribes' => '選択肢取得数'
    //     , 'Queries' => 'SOQL発行数'
    //     , 'QueryLocatorRows' => 'クエリロケータ行数'
    //     , 'QueryRows' => 'SOQL取得行数'
    //     , 'RecordTypesDescribes' => 'レコードタイプ取得数'
    //     , 'ScriptStatements' => 'Apex実行行数'
    //     , 'SoslQueries' => 'SOQL発行数'
    // };

    protected TimeSnapshot start = new TimeSnapshot();

    public static LimitWatch start() {
        return new LimitWatch();
    }
    
    protected LimitWatch() {
    }
    
    override protected String createLog(String summary) {
        TimeSnapshot stop = new TimeSnapshot();
        return TEMPLATE_LOG.replace('${summary}', summary == null ? '' : summary)
            .replace('${time}', String.valueOf(stop.currentTime.getTime() - start.currentTime.getTime()))
            .replace('${startTime}', start.currentTime.format(DATETIME_FORMAT))
            .replace('${stopTime}', stop.currentTime.format(DATETIME_FORMAT))
            .replace('${body}', ''
                + createLine('DMLStatements', start.DMLStatements, stop.DMLStatements, Limits.getLimitDMLStatements())
                + '\n' + createLine('DMLRows', start.DMLRows, stop.DMLRows, Limits.getLimitDMLRows())
                
                + '\n' + createLine('Queries', start.Queries, stop.Queries, Limits.getLimitQueries())
                + '\n' + createLine('QueryRows', start.QueryRows, stop.QueryRows, Limits.getLimitQueryRows())
                + '\n' + createLine('AggregateQueries', start.AggregateQueries, stop.AggregateQueries, Limits.getLimitAggregateQueries())
                + '\n' + createLine('QueryLocatorRows', start.QueryLocatorRows, stop.QueryLocatorRows, Limits.getLimitQueryLocatorRows())
                + '\n' + createLine('SoslQueries', start.SoslQueries, stop.SoslQueries, Limits.getLimitSoslQueries())
                
                + '\n' + createLine('ScriptStatements', start.ScriptStatements, stop.ScriptStatements, Limits.getLimitScriptStatements())
                + '\n' + createLine('HeapSize', start.HeapSize, stop.HeapSize, Limits.getLimitHeapSize())
                + '\n' + createLine('CpuTime', start.CpuTime, stop.CpuTime, Limits.getLimitCpuTime())
                
                + '\n' + createLine('EmailInvocations', start.EmailInvocations, stop.EmailInvocations, Limits.getLimitEmailInvocations())
                + '\n' + createLine('FutureCalls', start.FutureCalls, stop.FutureCalls, Limits.getLimitFutureCalls())
                + '\n' + createLine('Callouts', start.Callouts, stop.Callouts, Limits.getLimitCallouts())
                
                + '\n' + createLine('FieldsDescribes', start.FieldsDescribes, stop.FieldsDescribes, Limits.getLimitFieldsDescribes())
                + '\n' + createLine('PicklistDescribes', start.PicklistDescribes, stop.PicklistDescribes, Limits.getLimitPicklistDescribes())
                + '\n' + createLine('ChildRelationshipsDescribes', start.ChildRelationshipsDescribes, stop.ChildRelationshipsDescribes, Limits.getLimitChildRelationshipsDescribes())
                + '\n' + createLine('RecordTypesDescribes', start.RecordTypesDescribes, stop.RecordTypesDescribes, Limits.getLimitRecordTypesDescribes())
                + '\n' + createLine('FieldSetsDescribes', start.FieldSetsDescribes, stop.FieldSetsDescribes, Limits.getLimitFieldSetsDescribes()));
    }
    
    private static String createLine(String name, Integer start, Integer stop, Integer limitSize) {
        return String.valueOf(name).leftPad(30, ' ')
            + '：'
            + String.valueOf(stop - start).leftPad(8, ' ')
            + ', '
            + String.valueOf(start).leftPad(8, ' ')
            + ', '
            + String.valueOf(stop).leftPad(8, ' ')
            + ', '
            + String.valueOf(limitSize).leftPad(8, ' ');
    }
    
    public class TimeSnapshot extends StopWatch.TimeSnapshot {
        public Integer aggregateQueries = Limits.getAggregateQueries();
        public Integer callouts = Limits.getCallouts();
        public Integer childRelationshipsDescribes = Limits.getChildRelationshipsDescribes();
        public Integer cpuTime = Limits.getCpuTime();
        public Integer dmlRows = Limits.getDMLRows();
        public Integer dmlStatements = Limits.getDMLStatements();
        public Integer emailInvocations = Limits.getEmailInvocations();
        public Integer fieldSetsDescribes = Limits.getFieldSetsDescribes();
        public Integer fieldsDescribes = Limits.getFieldsDescribes();
        public Integer futureCalls = Limits.getFutureCalls();
        public Integer heapSize = Limits.getHeapSize();
        public Integer picklistDescribes = Limits.getPicklistDescribes();
        public Integer queries = Limits.getQueries();
        public Integer queryLocatorRows = Limits.getQueryLocatorRows();
        public Integer queryRows = Limits.getQueryRows();
        public Integer recordTypesDescribes = Limits.getRecordTypesDescribes();
        public Integer scriptStatements = Limits.getScriptStatements();
        public Integer soslQueries = Limits.getSoslQueries();
        
        public TimeSnapshot() {
        }
    }
}