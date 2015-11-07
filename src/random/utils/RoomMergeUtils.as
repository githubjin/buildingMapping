/**
 * Created by DaoSui on 2015/11/4.
 */
package random.utils {
import mx.collections.ArrayList;
import mx.controls.Alert;

import random.utils.vo.Coordinate;
import random.utils.vo.Room;

import random.valueObject.CoordinateVo;


import random.valueObject.RoomVo;

public class RoomMergeUtils {

    // Coordinate 新坐标地址
    private var _coordinates:ArrayList;
    private var sortedCoordinates:ArrayList;

    /**
     *  记录方向 当一个坐标存在两种可能的路径时，选择与上上个方向同向的坐标
     *   U R D L
     */
    private var directions:ArrayList;


    public function RoomMergeUtils() {
        this._coordinates = new ArrayList();
        this.sortedCoordinates = new ArrayList();
        this.directions = new ArrayList();
    }

    /**
     *  计算路径
     */
    public function calculation(roomVoList: ArrayList):ArrayList{
        var cntMap:CustomMap = new CustomMap();
        var coordinateMap:CustomMap = new CustomMap();

        for(var i:uint=0;i<roomVoList.length;i++){
            var room:RoomVo = roomVoList.getItemAt(i) as RoomVo;
            // 避免不必和的房间路径
            var coordinateVo:CoordinateVo = room.coordinates.getItemAt(0) as CoordinateVo;
            var coordinateVo2:CoordinateVo = room.coordinates.getItemAt((room.coordinates.length - 1)) as CoordinateVo;
            if(coordinateVo.x != coordinateVo2.x || coordinateVo.y != coordinateVo2.y){
                room.coordinates.addItem(coordinateVo);
            }
           /* if(i == 0){
                this._coordinates.addItem(new CoordinateVo(room.x, room.y));
            }*/
            var j:uint = 0;
            while((room.coordinates.length - 1) > j){
                var c:CoordinateVo = room.coordinates.getItemAt(j) as CoordinateVo;
                var key :String = c.x + "_" + c.y;
                cntMap.count(key);
                coordinateMap.put(key, c);
                j++;
            }
            j = 0;
        }
        for(var m:int=0;m<cntMap.keys.length;m++){
            var k:String = cntMap.keys.getItemAt(m) as String;
            var number:Number = (cntMap.get(k) as Number);
            if(number !== 2 && number != 4 && number < 4){
                this._coordinates.addItem(coordinateMap.get(k));
            }
        }
//        Alert.show(JSON.stringify(cntMap.data));
//        Alert.show(JSON.stringify(coordinateMap.data));
        this.sortCoordinates();
//        Alert.show(JSON.stringify(this._coordinates));
//        Alert.show(JSON.stringify(this.sortedCoordinates));
        return this.sortedCoordinates;

    }

    /**
     * 新房间的坐标排序，画笔的绘画路径
     */
    public function sortCoordinates():void{
        if(this.coordinates.length == 4){
           this.rectangularMerge();
        }else{
            //确定第一个坐标
//            Alert.show(JSON.stringify(this.coordinates));
            this.putMinXCoordinateToFirst();
//            Alert.show(JSON.stringify(this.coordinates));
            var firstC:CoordinateVo = this.coordinates.getItemAt(0) as CoordinateVo;
            this.sortedCoordinates.addItem(firstC);
            this.directions.addItem(Constants.DIRECTION_LEFT);
            this.findNextCoordinate(firstC,true);
            this.sortedCoordinates.addItem(firstC);
        }

    }

    /**
     * 合并后是矩形的房间 坐标排序
     */
    private function rectangularMerge():void{

        var sumX:int = 0;
        var sumY:int = 0;
        var toArray:Array = this.coordinates.toArray();
        toArray.forEach(function(item:CoordinateVo, index:int, arr:Array):void{
            sumX += item.x;
            sumY += item.y;
        });
        var averageX:int = sumX / 2;
        var averageY:int = sumY / 2;
        var map:CustomMap = new CustomMap();
        var itemAt:CoordinateVo = this.coordinates.getItemAt(0) as CoordinateVo;
        toArray.forEach(function(item:CoordinateVo, index:int, arr:Array):void{
            if(index != 0){
                if((itemAt.x + item.x) == averageX && (itemAt.y + item.y) == averageY){
                    map.put("diagonal", item);
                }else{
                    if(map.get("a2") == null){
                        map.put("a2", item);
                    }else{
                        map.put("a4", item);
                    }
                }
            }
        });
        this.sortedCoordinates.addItem(itemAt);
        this.sortedCoordinates.addItem(map.get("a2"));
        this.sortedCoordinates.addItem(map.get("diagonal"));
        this.sortedCoordinates.addItem(map.get("a4"));
    }

    /**
     *  将X值最小的坐标放到列表头
     */
    private function putMinXCoordinateToFirst():void{
        var firstCoordinate:Object = this.coordinates.getItemAt(0);
        if(firstCoordinate.x == firstCoordinate.y && firstCoordinate.x == 0){
            return;
        }
        var minX:int = -100;
        var maxY:int = 0;
        var minCoorIndex:int = 0;
        this.coordinates.toArray().forEach(function(item:Object,index:int,arr:Array):void{
            if(minX == -100){
                minX = item.x
                maxY = item.y;
            }else{
                if(item.x < minX){
                    minX = item.x;
                    maxY = item.y;
                    minCoorIndex = index;
                }else if(item.x == minX){
//                    if(item.y < minY){
                    if(item.y > maxY){
                        maxY = item.y;
                        minCoorIndex = index;
                    }
                }
            }
        });
        if(minCoorIndex > 0){
            var object:Object = this.coordinates.removeItemAt(minCoorIndex);
            var toArray:Array = this.coordinates.toArray();
            toArray.push(object);
            toArray.reverse();
            this.coordinates.removeAll();
            var that:* = this;
            toArray.forEach(function(item:Object,index:int,arr:Array):void{
                that.coordinates.addItem(item);
            });
        }

    }

    /**
     *  b :true 比较 y
     *  b: false 比较 x
     * @param c
     * @param b
     */
    public function findNextCoordinate(c: CoordinateVo, b:Boolean):void{
        var itemIndex:int = this.coordinates.getItemIndex(c);
        // 之前的距离值
        var preM:uint = 1000;
        // 之前的 坐标
        var preC:CoordinateVo = null;

        /*if(c.x == 700 && c.y == 100){
            trace("");
        }*/


        for(var i:uint=0;i<this.coordinates.length;i++){
            if(itemIndex == i){
                continue;
            }
            if(this.sortedCoordinates.getItemIndex(this.coordinates.getItemAt(i)) >= 0){
                continue;
            }
            var ite:CoordinateVo = this.coordinates.getItemAt(i) as CoordinateVo;
            if(b){
                if(c.y == ite.y){
                    var object:Object = this.compare(c.y, ite.y, c.x, ite.x, preC, preM, ite, c);
                    preM = object.preM;
                    preC = object.preC;
                }
                /* if(c.y == ite.y) {
                     var absX:Number = Math.abs(c.x - ite.x);
                     if(absX < preM){
                         preM = absX;
                         preC = ite;
                     }
                 }*/
            }else{
                if(c.x == ite.x){
                    var object2:Object = this.compare(c.x, ite.x, c.y, ite.y, preC, preM, ite, c);
                    preM = object2.preM;
                    preC = object2.preC;
                }
               /* if(c.x == ite.x){
                    var absY:Number = Math.abs(c.y - ite.y);
                    if(absY < preM){
                        preM = absY;
                        preC = ite;
                    }
                }*/
            }
        }
        if(preC == null){
            return;
        }
        this.sortedCoordinates.addItem(preC);
        // 记录坐标添加方向
        this.logAddDirections();
        this.findNextCoordinate(preC, !b);
    }

    /**
     * 记录坐标添加方向
     */
    private function logAddDirections():void {
        if(this.sortedCoordinates.length < 2){
            return;
        }
        var length:int = this.sortedCoordinates.length;
        var p:CoordinateVo = this.sortedCoordinates.getItemAt((length - 1)) as CoordinateVo;
        var gp:CoordinateVo = this.sortedCoordinates.getItemAt((length - 2)) as CoordinateVo;
        this.directions.addItem(this.getDirectionWithTowCoordinates(gp, p));
        /*if(p.x == gp.x) {
            if(p.y > gp.y){
                this.directions.addItem(Constants.DIRECTION_DOWN);
            }else{
                this.directions.addItem(Constants.DIRECTION_UP);
            }
        }
        if(p.y == gp.y) {
            if(p.x > gp.x){
                this.directions.addItem(Constants.DIRECTION_RIGHT);
            }else{
                this.directions.addItem(Constants.DIRECTION_LEFT);
            }
        }*/
    }

    /**
     *  比较坐标获取分歧时，获取正确的路径
     * @param rcA
     * @param iteA
     * @param rcB
     * @param iteB
     * @param preC
     * @param preM
     * @param ite
     * @return
     */
    private function compare(rcA:uint, iteA:uint, rcB:uint, iteB:uint, preC:CoordinateVo, preM:uint, ite:CoordinateVo, startPoint: CoordinateVo):Object{
//        trace("-------------------------------------------------------------");
//        trace("------"+rcA+"------"+rcB+"--------"+iteA+"-----"+iteB+"---------preM:"+preM+"--------------------------");
//        trace("-------------------------------------------------------------");
        var obj : Object = new Object();
        if(rcA == iteA){
            var bt:int = iteB - rcB;
            var btAbs:uint = Math.abs(bt);
            if(btAbs < preM  && this.isSameDirectionWithGrandCoordinate(startPoint, ite)){
                obj.preM = btAbs;
                obj.preC = ite;
//            }else if((btAbs == preM) && bt > 0){ // 存在两种选择
            }else if((btAbs == preM) && this.isSameDirectionWithGrandCoordinate(startPoint, ite)){ // 存在两种选择
                obj.preC = ite;
                obj.preM = btAbs;
            }else{
                obj.preM = preM;
                obj.preC = preC;
            }
        }
        return obj;
    }

    /**
     * 检测是否与祖父节点方向相同
     * @param startPoint
     * @param ite
     * @return
     */
    private function isSameDirectionWithGrandCoordinate(startPoint: CoordinateVo, ite:CoordinateVo):Boolean {
        /*var directionG:String = "";
        if(this.directions.length - 2 < 0){
            var lineDirection:String = this.getLineDirection(startPoint, ite);

            directionG = this.getDirectionWithTowCoordinates();
        }else{
            directionG = this.directions.getItemAt((this.directions.length - 2)) as String;
        }*/

        /**
         *  (0,200),(100,200),(200,200)
         */
        if(startPoint.x == ite.x){
            var countX:int = this.countCoordinateOneSide(startPoint, ite, "x", "y");
            if(countX % 2 == 0){
                return false;
            }
        }
        if(startPoint.y == ite.y){
            var countY:int = this.countCoordinateOneSide(startPoint, ite, "y", "x");
            if(countY % 2 == 0){
                return false;
            }
        }
        return true;
//        trace("-------------"+ite.x+"------"+ite.y+"---------------"+this.sortedCoordinates.getItemIndex(ite)+"-----------------------------------------");
        /*var directionG:String = this.directions.getItemAt((this.directions.length - 2)) as String;
        var directionWithTowCoordinates:String = this.getDirectionWithTowCoordinates(startPoint, ite);
        return directionWithTowCoordinates == directionG;*/
    }

    private function countCoordinateOneSide(startPoint: CoordinateVo, ite:CoordinateVo, fieldA:String, fieldB:String):int{
        var count:int = 0;
//        if(startPoint[fieldA] == ite[fieldA]){
            if(startPoint[fieldB] > ite[fieldB]){
                this.coordinates.toArray().forEach(function(coor:CoordinateVo, index:int, arr:Array):void{
                    if(coor[fieldA] == startPoint[fieldA] && startPoint[fieldB] > coor[fieldB]){
                        count++;
                    }
                });
            }else if(startPoint[fieldB] < ite[fieldB]){
                this.coordinates.toArray().forEach(function(coor:CoordinateVo, index:int, arr:Array):void{
                    if(coor[fieldA] == startPoint[fieldA] && startPoint[fieldB] < coor[fieldB]){
                        count++;
                    }
                });
            }
//        }
        return count;
    }

    private function getDirectionWithTowCoordinates(startPoint: CoordinateVo, endPoint: CoordinateVo):String{
        if(endPoint.x == startPoint.x) {
            if(endPoint.y > startPoint.y){
                return Constants.DIRECTION_DOWN;
            }else{
                return Constants.DIRECTION_UP;
            }
        }
        if(endPoint.y == startPoint.y) {
            if(endPoint.x > startPoint.x){
                return Constants.DIRECTION_RIGHT;
            }else{
                return Constants.DIRECTION_LEFT;
            }
        }
        return "";
    }

    /*private function findPreCoordinateAndGetDirection(startPoint: CoordinateVo, lineDirection:String):String{
        var b:Boolean = Constants.LINE_DIRECTIONS_HORIZONTAL == lineDirection;
        var dynimacField:String = "y";
        var staticField:String = "x";
        if(b){
            dynimacField = "x";
            staticField = "y";
        }
        var
    }*/

    /**
     *  获取俩坐标间的直线方向
     * @param startPoint
     * @param endPoint
     * @return
     */
    private function getLineDirection(startPoint: CoordinateVo, endPoint: CoordinateVo):String {
        if(startPoint.x == endPoint.x){
            return Constants.LINE_DIRECTIONS_VERTICAL;
        }
        if(startPoint.y == endPoint.y){
            return Constants.LINE_DIRECTIONS_HORIZONTAL;
        }
        return "";
    }


    public function get coordinates():ArrayList {
        return _coordinates;
    }

}
}
