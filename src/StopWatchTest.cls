@IsTest
private class StopWatchTest {
    static testMethod void normal() {
        StopWatch sw = StopWatch.start();
        sw.dumpToLog();
        sw.get();
    }
}