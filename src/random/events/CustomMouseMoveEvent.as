/**
 * Created by Yo on 2015/11/3.
 */
package random.events {
import flash.events.Event;

public class CustomMouseMoveEvent extends Event {
    public function CustomMouseMoveEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }
}
}
