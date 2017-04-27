/**
 * ページング情報を保持します。
 * レコード数が増減する場合は必ずサイズの同期を取ってください。
 *
 * @author 植村
 */
public class Pager {

    // ページング対象の全レコード件数
    public Integer size {get; set;}
   
    // 1ページに表示する件数
    public Integer pageSize {
        get;
        set {
            pageSize = value;
            pageNumber = 0;
        }
    }
   
    // 0から始まる
    public Integer pageNumber {get; set;}
   
    /**
     * 最大ページ番号を返します。
     * 0から始まります。
     */
    public Integer getMaxPageNumber() {
        return ((size - 1) / pageSize);
    }
   
    /**
     * 表示用の現在ページ番号を返します。
     * 1から始まります。
     */
    public Integer getDisplayPageNumber() {
        return pageNumber + 1;
    }
   
    /**
     * 表示用の最大ページ番号を返します。
     * 1から始まります。
     */
    public Integer getDisplayMaxPageNumber() {
        return getMaxPageNumber() + 1;
    }
   
    /**
     * 現在のページに表示するレコードの開始インデックスを返します。
     * 0から始まります。
     */
    public Integer getFrom() {
        return pageSize * pageNumber;
    }
   
    /**
     * 現在のページに表示するレコードの終了インデックスを返します。
     * 0から始まります。
     */
    public Integer getTo() {
        return Math.min(pageSize * (pageNumber + 1), size) - 1;
    }
   
    /**
     * 前のページがあるかを返します。
     */
    public Boolean getHasPrev() {
        return pageNumber > 0;
    }
   
    /**
     * 次のページがあるかを返します。
     */
    public Boolean getHasNext() {
        return getDisplayPageNumber() < getDisplayMaxPageNumber();
    }
   
    /**
     * 前のページに移ります。
     */
    public PageReference prev() {
        pageNumber--;
        return null;
    }
   
    /**
     * 次のページに移ります。
     */
    public PageReference next() {
        pageNumber++;
        return null;
    }
   
    /**
     * 最初のページに移ります。
     */
    public PageReference first() {
        pageNumber = 0;
        return null;
    }
   
    /**
     * 最後のページに移ります。
     */
    public PageReference last() {
        pageNumber = getMaxPageNumber();
        return null;
    }
   
    public Pager(Integer size, Integer pageSize) {
        this.size = size;
        this.pageSize = pageSize;
        this.pageNumber = 0;
    }
}