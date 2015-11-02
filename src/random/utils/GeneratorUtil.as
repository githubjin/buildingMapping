/**
 * Created by DaoSui on 2015/11/2.
 */
package random.utils {
import mx.collections.ArrayList;

import random.events.GenerateStartEvent;
import random.utils.vo.Building;
import random.utils.vo.Coordinate;
import random.utils.vo.Room;

public class GeneratorUtil {
    public function GeneratorUtil() {
    }

    /**
     *
     * @param e
     * @return
     */
    public static function generateBuilding(e:GenerateStartEvent):Building {

        var building:Building = new Building("",e.buildingName,
                e.unitNum,e.roomNumberPerUnit,e.floorNumber,e.undergroundFloorNumber);
        building.rooms = generateRooms(building);
        return building;

    }

    private static function generateRooms(building:Building):ArrayList{
        var list:ArrayList = new ArrayList();
        var unitNumber:uint = building.unitNum;
        var roomNumberPerUnit:uint = building.roomNumPerUnit;
        var ufloorNum:uint = building.uFloorsNum;
        var bFloorsNum:uint = building.bFloorsNum;

        var rows:int = ufloorNum + bFloorsNum;
        var columns:int = unitNumber * roomNumberPerUnit;

        for(var r:int=rows;r>0;r--){
            for(var c:int=columns;c>0;c--){
                var roomName:String = generateRoomNumber(r,c,bFloorsNum,ufloorNum,roomNumberPerUnit);
                var room:Room =  new Room(roomName,roomName,roomName,"",generateFloor(r,ufloorNum));
                room.coordinates = generateCoordinates(r, c);
                list.addItem(room);
            }
            bFloorsNum--;
        }

        return list;
    }

    private static function generateCoordinates(rowNum:uint, columnNum:uint):ArrayList{
        var list: ArrayList = new ArrayList();
        var c0:Coordinate = new Coordinate(columnNum - 1, rowNum - 1);
        var c1:Coordinate = new Coordinate(columnNum, rowNum - 1);
        var c2:Coordinate = new Coordinate(columnNum, rowNum);
        var c3:Coordinate = new Coordinate(columnNum - 1, rowNum);
        list.addItem(c0);
        list.addItem(c1);
        list.addItem(c2);
        list.addItem(c3);
        list.addItem(c0);
        return list;
    }

    private static function generateRoomNumber(r:int,c:int,bFloorsNum:int,ufloorNum:uint,roomNumberPerUnit:uint):String{
        var roomName:String = "";
        if(bFloorsNum > 0){
            roomName += ("-" + bFloorsNum + (c>9?c:("0"+c)));
        }else{
            var n:uint = c%roomNumberPerUnit + 1;
            roomName += ("" + (ufloorNum - r + 1) + (n>9?n:("0"+n)));
        }
        return roomName;
    }

    private static function generateFloor(r:int,ufloorNum:int):int{
        var f:int = r - ufloorNum;
        if(f > 0){
            return -f;
        }else{
            return (-f + 1);
        }
    }
}
}
