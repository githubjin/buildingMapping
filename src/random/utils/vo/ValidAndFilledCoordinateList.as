/**
 * Created by DaoSui on 2015/11/8.
 */
package random.utils.vo {
import mx.collections.ArrayList;

import random.valueObject.RoomVo;

public class ValidAndFilledCoordinateList {

    private var _validCoordinates:ArrayList;
    private var _filledCoordinates:ArrayList;
    private var _sourceRoom:RoomVo;


    public function ValidAndFilledCoordinateList(validCoordinates:ArrayList, filledCoordinates:ArrayList, sourceRoom:RoomVo) {
        _validCoordinates = validCoordinates;
        _filledCoordinates = filledCoordinates;
        this._sourceRoom = sourceRoom;
    }

    public function get validCoordinates():ArrayList {
        return _validCoordinates;
    }

    public function set validCoordinates(value:ArrayList):void {
        _validCoordinates = value;
    }

    public function get filledCoordinates():ArrayList {
        return _filledCoordinates;
    }

    public function set filledCoordinates(value:ArrayList):void {
        _filledCoordinates = value;
    }


    public function get sourceRoom():RoomVo {
        return _sourceRoom;
    }

    public function set sourceRoom(value:RoomVo):void {
        _sourceRoom = value;
    }
}
}
