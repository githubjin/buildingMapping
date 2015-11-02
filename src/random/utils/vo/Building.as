/**
 * Created by DaoSui on 2015/11/2.
 */
package random.utils.vo {
import mx.collections.ArrayList;

public class Building {

    private var _id:String;
    private var _name:String;
    private var _unitNum:uint;
    private var _roomNumPerUnit:uint;
    private var _uFloorsNum:uint;
    private var _bFloorsNum:uint;

    private var _rooms:ArrayList;


    public function Building(id:String, name:String, unitNum:uint, roomNumPerUnit:uint, uFloorsNum:uint, bFloorsNum:uint) {
        this._id = id;
        this._name = name;
        this._unitNum = unitNum;
        this._roomNumPerUnit = roomNumPerUnit;
        this._uFloorsNum = uFloorsNum;
        this._bFloorsNum = bFloorsNum;
    }


    public function get id():String {
        return _id;
    }

    public function get unitNum():uint {
        return _unitNum;
    }

    public function get roomNumPerUnit():uint {
        return _roomNumPerUnit;
    }

    public function get uFloorsNum():uint {
        return _uFloorsNum;
    }

    public function get bFloorsNum():uint {
        return _bFloorsNum;
    }

    public function get rooms():ArrayList {
        return _rooms;
    }

    public function get name():String {
        return _name;
    }


    public function set rooms(value:ArrayList):void {
        _rooms = value;
    }
}
}
