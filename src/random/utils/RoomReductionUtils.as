/**
 * Created by Yo on 2015/11/5.
 */
package random.utils {
import mx.collections.ArrayList;

import random.valueObject.CoordinateVo;

import random.valueObject.RoomVo;

import spark.components.Alert;

public class RoomReductionUtils {
    public function RoomReductionUtils() {
    }

    /*-----------------------------------------------------------拆分-----------------------------------------------------------------------*/

    /**
     *  由要拆分的房间坐标，还原所有的最小单元表格表格
     */
    public static function reductionCoordinates(roomVo:RoomVo):void {

        // 最小单元房间列表
        var minRoomList:ArrayList = new ArrayList();

        var coordinates:ArrayList = createCloseCoordinates(roomVo.coordinates);
        var xScope:Array = obtainXorYScope(coordinates, "x");
        var yScope:Array = obtainXorYScope(coordinates, "y");

        for(var i:uint = 0; i < (coordinates.length - 1); i++) {
            var coorA:CoordinateVo = coordinates.getItemAt(i) as CoordinateVo;
            var coorB:CoordinateVo = coordinates.getItemAt(i+1) as CoordinateVo;
        }
        Alert.show(JSON.stringify(xScope));
        Alert.show(JSON.stringify(yScope));
    }

    /**
     *  获取两个坐标之间存在的 x 或 y 坐标
     * @return
     */
    private static function getCoordinatesBetween(ca:CoordinateVo, cb:CoordinateVo, xScope:Array, yScope):Array{
        // true : X 轴方向
        // false Y 轴方向
        var b:Boolean = true;
        if(ca.x == cb.x){
            b = false;
        }
        if(b){

        }else{

        }
    }

    /**
     *  检测是否是闭合的坐标集合，不是得话使其闭合
     * @param coordinates
     * @return
     */
    private static function createCloseCoordinates(coordinates:ArrayList):ArrayList{
        var ac:Object = coordinates.getItemAt(0);
        var bc:Object = coordinates.getItemAt((coordinates.length - 1));
        if(!(ac.x == bc.x && ac.y == bc.y)){
            coordinates.addItem(ac);
        }
        return coordinates;
    }

    /**
     * 判断房间是否存在
     * @param room
     * @param rooms
     * @return
     */
    private static function checkRoomIsExistsAndAppend(room:RoomVo, rooms:ArrayList):Boolean {
        for(var r:Object in rooms) {
            if(r.id == room.id) {
                return true;
            }
        }
        return false;
    }

    /**
     *  获取所有可能的 y 值
     * @return
     */
    private static function obtainXorYScope(coordinates:ArrayList, field: String):Array {
        var ax : Array = new Array();
        for(var c:Object in coordinates) {
            if(ax.indexOf(c[field]) < 0){
                ax.push(c[field]);
            }
        }
        return ax.sort();
    }

}
}
