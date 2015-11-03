/**
 * Created by Yo on 2015/11/3.
 */
package random.events {
import flash.events.Event;

import spark.components.Group;

public class CustomMouseDownEvent extends Event {

    private var _group:Group;
    private var _itemRendererData:Object;


    public function CustomMouseDownEvent(type:String, bubbles:Boolean, cancelable:Boolean, group:Group, itemRendererData:Object) {
        super(type, bubbles, cancelable);
        _group = group;
        _itemRendererData = itemRendererData;
    }

    public function get group():Group {
        return _group;
    }

    public function get itemRendererData():Object {
        return _itemRendererData;
    }


}
}
