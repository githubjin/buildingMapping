/**
 * Created by Yo on 2015/11/4.
 */
package random.events {
import flash.events.Event;

public class SignalEvent extends Event {

    private var _signal:String;


    public function SignalEvent(type:String, signal:String) {
        super(type);
        this._signal = signal;
    }


    public function get signal():String {
        return _signal;
    }
}
}
