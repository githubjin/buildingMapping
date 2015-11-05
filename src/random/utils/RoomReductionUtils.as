/**
 * Created by Yo on 2015/11/5.
 */
package random.utils {
import mx.collections.ArrayList;

import random.valueObject.CoordinateVo;

import random.valueObject.RoomVo;

import spark.components.Alert;

public class RoomReductionUtils {

    // 记录扩充之后的坐标
    private var newCoordinateList:ArrayList = new ArrayList();

    public function RoomReductionUtils() {
    }

    /*-----------------------------------------------------------拆分-----------------------------------------------------------------------*/

    /**
     *  由要拆分的房间坐标，还原所有的最小单元表格表格
     */
    public function reductionCoordinates(roomVo:RoomVo):ArrayList {
        // 清理
        newCoordinateList.removeAll();
        // 确认是否是闭合坐标
        var coordinates:ArrayList = createCloseCoordinates(roomVo.coordinates);
//        Alert.show(JSON.stringify(coordinates));
        //  确认 x,y轴坐标的方位
        var xScope:Array = obtainXorYScope(coordinates, "x");
        var yScope:Array = obtainXorYScope(coordinates, "y");
        // 确定两个临近有效坐标之间的存在坐标
        for(var i:uint = 0; i < (coordinates.length - 1); i++) {
            var coorA:CoordinateVo = coordinates.getItemAt(i) as CoordinateVo;
            var coorB:CoordinateVo = coordinates.getItemAt(i+1) as CoordinateVo;
            newCoordinateList.addItem(coorA);
            getCoordinatesBetween(coorA, coorB, xScope, yScope);
        }
//        Alert.show(JSON.stringify(xScope));
//        Alert.show(JSON.stringify(yScope));
//        Alert.show(JSON.stringify(newCoordinateList));

        return newCoordinateList;
    }

    /**
     *  获取两个坐标之间存在的 x 或 y 坐标
     * @return
     */
    private function getCoordinatesBetween(ca:CoordinateVo, cb:CoordinateVo, xScope:Array, yScope:Array):void{
        // true : X 轴方向
        // false Y 轴方向
        var b:Boolean = true;
        if(ca.x == cb.x){
            b = false;
        }
        if(b){
            searchInScope(ca.x, cb.x, xScope, ca.y, b);
        }else{
            searchInScope(ca.y, cb.y, yScope, ca.x, b);
        }
    }

    /**
     *
     * @param m
     * @param n
     * @param scope
     * @param xORy
     * @param b true X轴方向 false Y轴方向
     * @return
     */
    private function searchInScope(m:int, n:int, scope:Array, xORy:int, b:Boolean):void {
        var i:int = scope.indexOf(m);
        var j:int = scope.indexOf(n);
        if(Math.abs(i-j) == 1){
            return;
        }
        // m < n
        if(i < j){
            for(var k:int=(i+1);k<j;k++){
                if(b){
                    newCoordinateList.addItem(new CoordinateVo(scope[k], xORy));
                }else{
                    newCoordinateList.addItem(new CoordinateVo(xORy, scope[k]));
                }
            }
        }else if(i > j){
            for(var l:int=(i-1);l>j;l--){
                if(b){
                    newCoordinateList.addItem(new CoordinateVo(scope[l], xORy));
                }else{
                    newCoordinateList.addItem(new CoordinateVo(xORy, scope[l]));
                }
            }
        }
    }

    /**
     *  检测是否是闭合的坐标集合，不是得话使其闭合
     * @param coordinates
     * @return
     */
    private function createCloseCoordinates(coordinates:ArrayList):ArrayList{
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
    private function checkRoomIsExistsAndAppend(room:RoomVo, rooms:ArrayList):Boolean {
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
    private function obtainXorYScope(coordinates:ArrayList, field: String):Array {
        var ax : Array = new Array();
        for(var i:uint=0;i<coordinates.length;i++){
            var c:Object = coordinates.getItemAt(i);
            if(ax.indexOf(c[field]) < 0){
                ax.push(c[field]);
            }
        }
        /*for(var c:Object in coordinates) {
            if(ax.indexOf(c[field]) < 0){
                ax.push(c[field]);
            }
        }*/
        return ax.sort();
    }

}
}
