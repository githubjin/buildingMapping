/**
 * Created by DaoSui on 2015/11/4.
 */
package random.utils {
import mx.collections.ArrayList;
import mx.controls.Alert;

import random.valueObject.CoordinateVo;


import random.valueObject.RoomVo;

public class AddressingCalculationUtils {

    // Coordinate 新坐标地址
    private var _coordinates:ArrayList;
    private var sortedCoordinates:ArrayList;


    public function AddressingCalculationUtils() {
        this._coordinates = new ArrayList();
        this.sortedCoordinates = new ArrayList();
    }

    /**
     *  计算路径
     */
    public function calculation(roomVoList: ArrayList):ArrayList{
        var cntMap:CustomMap = new CustomMap();
        var coordinateMap:CustomMap = new CustomMap();

        for(var i:uint=0;i<roomVoList.length;i++){
            var room:RoomVo = roomVoList.getItemAt(i) as RoomVo;
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
            if(number !== 2 && number != 4){
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
     *
     */
    public function sortCoordinates():void{
        var firstC:CoordinateVo = this.coordinates.getItemAt(0) as CoordinateVo;
        this.sortedCoordinates.addItem(firstC);
        this.findNextCoordinate(firstC,true);
        this.sortedCoordinates.addItem(firstC);

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
                    var object:Object = this.compare(c.y, ite.y, c.x, ite.x, preC, preM, ite);
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
                    var object2:Object = this.compare(c.x, ite.x, c.y, ite.y, preC, preM, ite);
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
        this.findNextCoordinate(preC, !b);
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
    private function compare(rcA:uint, iteA:uint, rcB:uint, iteB:uint, preC:CoordinateVo, preM:uint, ite:CoordinateVo):Object{
//        trace("-------------------------------------------------------------");
//        trace("------"+rcA+"------"+rcB+"--------"+iteA+"-----"+iteB+"---------preM:"+preM+"--------------------------");
//        trace("-------------------------------------------------------------");
        var obj : Object = new Object();
        if(rcA == iteA){
            var bt:int = iteB - rcB;
            var btAbs:uint = Math.abs(bt);
            if(btAbs < preM){
                obj.preM = btAbs;
                obj.preC = ite;
            }else if((btAbs == preM) && bt > 0){
                obj.preC = ite;
                obj.preM = btAbs;
            }else{
                obj.preM = preM;
                obj.preC = preC;
            }
        }
        return obj;
    }


    public function get coordinates():ArrayList {
        return _coordinates;
    }
}
}
