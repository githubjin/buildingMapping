/**
 * Created by DaoSui on 2015/11/2.
 */
package random.utils.vo {
import mx.collections.ArrayList;

public class Room {

    private var _id: String;
    private var _name: String;
    private var _description: String;
    private var _coordinates: ArrayList;
    private var _unitId: String;
    private var _floor:int;


    public function Room(id:String, name:String, description:String, unitId:String, floor:int) {
        this._id = id;
        this._name = name;
        this._description = description;
        this._unitId = unitId;
        this._floor = floor;
    }


    public function get id():String {
        return _id;
    }

    public function get name():String {
        return _name;
    }

    public function get description():String {
        return _description;
    }

    public function get coordinates():ArrayList {
        return _coordinates;
    }

    public function get unitId():String {
        return _unitId;
    }

    public function get floor():int {
        return _floor;
    }

    public function set coordinates(value:ArrayList):void {
        _coordinates = value;
    }
}
}
