/**
 * Created by Yo on 2015/11/3.
 */
package random.events {
import flash.events.Event;

public class CustomMouseUpEvent extends Event {
    public function CustomMouseUpEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }
}
}
