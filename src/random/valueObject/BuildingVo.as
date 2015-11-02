/**
 * Created by DaoSui on 2015/11/2.
 */
package random.valueObject {
import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

[Bindable]
public class BuildingVo {

    private var _unitNum:uint;
    private var  _roomNumPerUnit:uint;
    private var  _uFloorsNum:uint;
    private var  _bFloorsNum:uint;
    private var  _id:String;
    private var  _name:String;
    private var _rooms:ArrayList = new ArrayList();


    public function BuildingVo(jsonData:Object) {
        this._unitNum = jsonData.unitNum;
        this._roomNumPerUnit = jsonData.roomNumPerUnit;
        this._uFloorsNum = jsonData.uFloorsNum;
        this._bFloorsNum = jsonData.bFloorsNum;
        this._id = jsonData.id;
        this._name = jsonData.name;
        this.addRooms(jsonData.rooms);
    }

    public function addRooms(rooms: Array):void {
       for each(var r: Object in rooms){
           var roomVo:RoomVo = new RoomVo(r.id, r.name, r.description);
           roomVo.addCoordinates(r.coordinates);
           this._rooms.addItem(roomVo);
       }
    }

    public function cleanRooms():void{
        this._rooms.removeAll();
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

    public function get id():String {
        return _id;
    }

    public function get name():String {
        return _name;
    }

    public function get rooms():ArrayList {
        return _rooms;
    }
}
}
