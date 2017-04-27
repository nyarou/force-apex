/**
 * 実行時間計測用のクラスです。
 *
 * 次の様に実行すると計測結果がデバッグログに出力されます。
 *
 * StopWatch stopWatch = StopWatch.start();
 *
 * // 計測したい処理
 *
 * stopWatch.dumpToLog('ソート時間の計測');
 * 
 * @author k.uemura
 */
public virtual class StopWatch {
    protected final String TEMPLATE_LOG = '計測結果：${summary}'
        + '\n実行時間：${time}ms'
        + '\n開始終了：${startTime} ～ ${stopTime}';

    protected final String DATETIME_FORMAT = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS';

    private TimeSnapshot start = new TimeSnapshot();

    public static StopWatch start() {
        return new StopWatch();
    }
    
    protected StopWatch() {
    }
    
    public void dumpToLog() {
        dumpToLog(null);
    }
    
    public void dumpToLog(loggingLevel logLevel, String summary) {
        System.debug(logLevel, createLog(summary));
    }

    public void dumpToLog(String summary) {
        System.debug(loggingLevel.DEBUG, createLog(summary));
    }

    public String get() {
        return createLog(null);
    }
    
    protected virtual String createLog(String summary) {
        TimeSnapshot stop = new TimeSnapshot();
        return TEMPLATE_LOG.replace('${summary}', summary == null ? '' : summary)
            .replace('${time}', String.valueOf(stop.currentTime.getTime() - start.currentTime.getTime()))
            .replace('${startTime}', start.currentTime.format(DATETIME_FORMAT))
            .replace('${stopTime}', stop.currentTime.format(DATETIME_FORMAT));
    }

    public virtual class TimeSnapshot {
        public Datetime currentTime = System.now();

        public TimeSnapshot() {
        }
    }
}