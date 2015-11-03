/**
 * Created by DaoSui on 2015/11/4.
 */
package random.events {
import flash.events.Event;

public class OperationTypeEvent extends Event {

    public static var OP_MERGE:String = "merge";
    public static var OP_SPLIT:String = "split";

    private var _operationType:String;

    public function OperationTypeEvent(type:String, operationType:String) {
        super(type);
        this._operationType = operationType;
    }


    public function get operationType():String {
        return _operationType;
    }
}
}
