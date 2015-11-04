/**
 * Created by Yo on 2015/11/3.
 */
package random.events {
import flash.events.Event;

import random.valueObject.RoomVo;

import spark.components.Group;

public class CustomMouseUpEvent extends Event implements ICustom{

    private var _group:Group;
    private var _itemRendererData:RoomVo


    public function CustomMouseUpEvent(type:String, bubbles:Boolean, cancelable:Boolean, group:Group, itemRendererData:RoomVo) {
        super(type, bubbles, cancelable);
        _group = group;
        _itemRendererData = itemRendererData;
    }


    public function get group():Group {
        return _group;
    }

    public function get itemRendererData():RoomVo {
        return _itemRendererData;
    }
}
}
