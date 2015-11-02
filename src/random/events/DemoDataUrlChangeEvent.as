/**
 * Created by DaoSui on 2015/11/2.
 */
package random.events {
import flash.events.Event;

public class DemoDataUrlChangeEvent extends Event {

    private var _dataName:String;

    public function DemoDataUrlChangeEvent(type:String, dataName:String) {
        super(type);
        this._dataName = dataName;
    }

    public function get dataName():String {
        return _dataName;
    }
}
}
