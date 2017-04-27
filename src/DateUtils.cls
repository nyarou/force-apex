/**
 * 日付に関するユーティリティクラスです。
 *
 * @author k.uemura
 */
public class DateUtils {

    public static Date valueOf(String dateString, Date defaultDate) {
        return toDate(dateString, defaultDate);
    }

    public static String format(Date d, String format) {
        return Datetime.newInstance(d, Time.newInstance(0, 0, 0, 0)).format(format);
    }

    public static Date toDate(String dateString, Date defaultDate) {
        if (String.isEmpty(dateString)) {
            return defaultDate;
        }
        try {
            return Date.valueOf(dateString.replace('/', '-'));
        } catch (Exception e) {
            return defaultDate;
        }
    }

    public static Date parse(String dateString, Date defaultDate) {
        if (String.isEmpty(dateString)) {
            return defaultDate;
        }
        try {
            return Date.parse(dateString);
        } catch (Exception e) {
            return defaultDate;
        }
    }

    public static Date[] toList(Date fromDate, Date toDate) {
        Date[] dates = new Date[0];
        if (fromDate <= toDate) {
            for (Date d = fromDate; d <= toDate; d = d + 1) {
                dates.add(d);
            }
        } else {
            for (Date d = fromDate; d >= toDate; d = d - 1) {
                dates.add(d);
            }
        }
        return dates;
    }

    public static Date lastDateOfMonth(Date d) {
        if (d == null) {
            return null;
        }
        return firstDateOfMonth(d.addMonths(1)) - 1;
    }

    public static Date firstDateOfMonth(Date d) {
        return changeDay(d, 1);
    }
    
    public static Date changeDay(Date d, Integer day) {
        if (d == null) {
            return null;
        }
        return Date.newInstance(d.year(), d.month(), day);
    }
}