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
    private var temList:ArrayList;


    public function AddressingCalculationUtils() {
        this._coordinates = new ArrayList();
        this.temList = new ArrayList();
    }

    /**
     *  计算路径
     */
    public function calculation(roomVoList: ArrayList):void{
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
        Alert.show(JSON.stringify(cntMap.data));
//        Alert.show(JSON.stringify(coordinateMap.data));
        Alert.show(JSON.stringify(this._coordinates));
    }

    /**
     *  获取寻址 方向
     *   向右下 ： x,y交替比较
     *   向左上 ：
     */
    public function getDirection():void{

    }

    public function get coordinates():ArrayList {
        return _coordinates;
    }
}
}
