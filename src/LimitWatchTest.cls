@IsTest
private class LimitWatchTest {
    static testMethod void normal() {
        LimitWatch lw = LimitWatch.start();
        lw.dumpToLog();
    }
}