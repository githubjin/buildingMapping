/**
 * Created by Yo on 2015/11/5.
 */
package random.utils {
import mx.collections.ArrayList;

import random.utils.vo.ValidAndFilledCoordinateList;

import random.valueObject.CoordinateVo;

import random.valueObject.RoomVo;

import spark.components.Alert;

public class RoomReductionUtils {

//    z轴间距
    public static var SPACING_X:Number = 0;
    //    y轴间距
    public static var SPACING_Y:Number = 0;

    // 记录扩充之后的坐标
    private var newCoordinateList:ArrayList = new ArrayList();

    public function RoomReductionUtils() {
    }

    /*-----------------------------------------------------------拆分-----------------------------------------------------------------------*/

    /**
     *  由要拆分的房间坐标，还原所有的最小单元表格表格
     */
    public function reductionCoordinates(roomVo:RoomVo):ValidAndFilledCoordinateList {
        // 清理
        newCoordinateList.removeAll();
        // 确认是否是闭合坐标
        var coordinates:ArrayList = createCloseCoordinates(roomVo.coordinates);
//        Alert.show(JSON.stringify(coordinates));
        //  确认 x,y轴坐标的方位
        var xScope:Array = obtainXorYScope(coordinates, "x");
        var yScope:Array = obtainXorYScope(coordinates, "y");
        // 获取最小间距
        getSpacingBetweenXY(xScope, yScope);
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
        var resultData:ValidAndFilledCoordinateList = new ValidAndFilledCoordinateList(coordinates, newCoordinateList, roomVo);
        return resultData;
    }

    /**
     *  x,y 轴间的徐iixoajianju
     */
    private function getSpacingBetweenXY(xScope:Array, yScope:Array):void{
        SPACING_X = xScope[1] - xScope[0];
        SPACING_Y = yScope[1] - yScope[0];
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
        /*ax = ax.sort();
        var minGap:int =10000;
        for(var k:int=0;k<(ax.length - 1);k++){
            var gap:int = Math.abs(ax[k+1] - ax[k]);
            if(gap < minGap){
                minGap = gap;
            }
        }
        var tArr:Array = new Array();
        ax.forEach(function(item:int, index:int, arr:Array):void{
            if(arr.indexOf((item + minGap))<0){
                tArr.push((item + minGap));
            }
        });
        tArr.forEach(function(item:int,index:int,arr:Array):void{
            ax.push(item);
        });
        return ax.sort();*/

        return this.fillGapBetweenCoordinates(ax.sort(sortFunction), new Array(), this.getMinGap(ax.sort(sortFunction)));
//        return ax.sort(sortFunction);
    }

    private function getMinGap(ax:Array):int{
        var minGap:int =10000;
//        var preGap:int = 0;
        for(var k:int=0;k<(ax.length - 1);k++){
            var gap:int = Math.abs(ax[k+1] - ax[k]);
            if(gap < minGap && gap != 1){
//                preGap = minGap;
                minGap = gap;
            }
        }
        return minGap;
    }

    private function fillGapBetweenCoordinates(ax:Array, exceptArr:Array, minGap:int):Array{
       /* var minGap:int =10000;
//        var preGap:int = 0;
        for(var k:int=0;k<(ax.length - 1);k++){
            var gap:int = Math.abs(ax[k+1] - ax[k]);
            if(gap < minGap && gap != 1){
//                preGap = minGap;
                minGap = gap;
            }
        }*/
        var tArr:Array = new Array();
        ax.forEach(function(item:int, index:int, arr:Array):void{
            var val:int = item as Number;
//            trace("---------------------------- value:" + val + " index:"+index + " arr:" + JSON.stringify(arr) + " indexOf:" + arr.indexOf((val + minGap)) + " arr[length-1]:" + arr[(arr.length - 1)] + " [item + minGap]:" + (val + minGap) + " -----------------------------------------");
            if(arr.indexOf((val + minGap))<0 && arr[(arr.length - 1)] > (val + minGap)){
                tArr.push((val + minGap));
            }
        });
        //删除无用的
        exceptArr.forEach(function(item:int, index:int, arr:Array):void{
            var i:int = tArr.indexOf(item);
            tArr.splice(i,1);
        });
        if(tArr.length == 0){
            return ax.sort(sortFunction);
        }else{
            if(tArr.length == 1 && exceptArr.indexOf(tArr[0]) >= 0){
                return ax.sort(sortFunction);
            }
            tArr.forEach(function(item:int,index:int,arr:Array):void{
//                if(ax.indexOf(item + 1) < 0 && ax.indexOf(item - 1) < 0){
                if(isAppendable(minGap, ax, item)){
                    ax.push(item);
                }else{
                    exceptArr.push(item);
                }
            });
            return this.fillGapBetweenCoordinates(ax.sort(sortFunction), exceptArr, minGap);
        }
    }

    private function isAppendable(minGap:int, ac:Array, item:int):Boolean{
        for(var i:int=1;i<(minGap/Constants.FEN_MU * Constants.FEN_ZI);i++){
            var i2:int = ac.indexOf((item + i));
            if(i2 > 0){
                return false;
            }
        }
        return true;
    }

    private function sortFunction(a:int, b:int):int {
        return a - b;
    }
}
}
