/**
 * Created by DaoSui on 2015/11/2.
 */
package random.events {
import flash.events.Event;

public class GenerateStartEvent extends Event {

    private var _buildingName:String;
    private var _unitNum:uint;
    private var _roomNumberPerUnit:uint;
    private var _floorNumber:uint;
    private var _undergroundFloorNumber:uint;


    public function GenerateStartEvent(type:String, buildingName:String, unitNum:uint, roomNumberPerUnit:uint, floorNumber:uint, undergroundFloorNumber:uint) {
        super(type);
        this._buildingName = buildingName;
        this._unitNum = unitNum;
        this._roomNumberPerUnit = roomNumberPerUnit;
        this._floorNumber = floorNumber;
        this._undergroundFloorNumber = undergroundFloorNumber;
    }


    public function get buildingName():String {
        return _buildingName;
    }

    public function get unitNum():uint {
        return _unitNum;
    }

    public function get roomNumberPerUnit():uint {
        return _roomNumberPerUnit;
    }

    public function get floorNumber():uint {
        return _floorNumber;
    }

    public function get undergroundFloorNumber():uint {
        return _undergroundFloorNumber;
    }
}
}
