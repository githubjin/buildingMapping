/**
 * Created by Yo on 2015/11/10.
 */
package random.events {
import flash.events.Event;

import mx.collections.ArrayList;

import random.valueObject.RoomVo;

public class RoomSplitEvent extends Event {

    public static var EVENT_NAME:String = "ROOM_SPLIT_EVENT";
    public static var OP_TYPE_OK:String = "OK"
    public static var OP_TYPE_CANCEL:String = "CANCEL"

    private var _oprationType:String;
    private var _rooms:ArrayList;
    private var _sourceRoom:RoomVo;


    public function RoomSplitEvent(type:String, bubbles:Boolean, cancelable:Boolean, oprationType:String, rooms:ArrayList, sourceRoom:RoomVo) {
        super(type, bubbles, cancelable);
        _oprationType = oprationType;
        _rooms = rooms;
        this._sourceRoom = sourceRoom;
    }

    public function get oprationType():String {
        return _oprationType;
    }

    public function get rooms():ArrayList {
        return _rooms;
    }


    public function get sourceRoom():RoomVo {
        return _sourceRoom;
    }
}
}
