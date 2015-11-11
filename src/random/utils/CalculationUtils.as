/**
 * Created by DaoSui on 2015/11/8.
 */
package random.utils {
import mx.collections.ArrayList;

import random.components.CustomRect;

import random.valueObject.CoordinateVo;
import random.valueObject.RoomVo;

public class CalculationUtils {
    public function CalculationUtils() {
    }

    /**
     * 获取两个多边形的交点
     * @param sourceCoors 需要拆分的房间坐标
     * @param rect 圈方位的矩形对象
     * @param minX 房间的最小X坐标
     * @param minY 房间的最小Y坐标
     */
    public static function calculationPolygonIntersection(sourceCoors:ArrayList, rect:CustomRect, minX:Number, minY:Number):void{
        var validCoordinatesSubtractMinXY:ArrayList = getValidCoordinatesSubtractMinXY(sourceCoors, minX, minY);
        var rectCoordinates:ArrayList = generateRectCoordinates(rect);
        var map:CustomMap = new CustomMap();
        for(var i:int=0;i<validCoordinatesSubtractMinXY.length - 1;i++){
            var c1:CoordinateVo = validCoordinatesSubtractMinXY.getItemAt(i) as CoordinateVo;
            var c2:CoordinateVo = validCoordinatesSubtractMinXY.getItemAt(i + 1) as CoordinateVo;
            for(var j:int=0;j<rectCoordinates.length - 1;j++){
                var c3:CoordinateVo = rectCoordinates.getItemAt(j) as CoordinateVo;
                var c4:CoordinateVo = rectCoordinates.getItemAt(j + 1) as CoordinateVo;
                var c5:CoordinateVo = segmentsIntr(c1, c2, c3, c4) as CoordinateVo;
                trace(JSON.stringify(c1));
                trace(JSON.stringify(c2));
                trace(JSON.stringify(c3));
                trace(JSON.stringify(c4));
                if(c5 != null){
                    map.put((c5.x + "_" + c5.y), c5);
                }
                trace("---------------------------------"+JSON.stringify(c5));
            }
        }
        trace(JSON.stringify(map));
    }

    /**
     *  将外部坐标转换为内部做白哦
     * @param coors
     * @param minX
     * @param minY
     * @return
     */
    public static function getValidCoordinatesSubtractMinXY(coors:ArrayList, minX:Number, minY:Number):ArrayList{
        var sub:ArrayList = new ArrayList();
        coors.toArray().forEach(function(item:Object, index:int, arr:Array):void{
            sub.addItem(new CoordinateVo((item.x - minX), (item.y - minY)));
        });
        return sub;
    }

    /**
     *  求坐标舞台偏移量
     * @param stageX
     * @param stageY
     * @param componentX
     * @param componentY
     * @param localX
     * @param localY
     * @param callback
     */
    public static function getStageCoordinateOffset(stageX:Number, stageY:Number, componentX:Number,
                                                    componentY:Number, localX:Number, localY:Number, callback:Function):void {
        var offsetX:Number = stageX - (componentX + localX);
        var offsetY:Number = stageY - (componentY + localY);

        callback.call(null, offsetX, offsetY);
    }

    /**
     *  球两直线交点
     * @param a
     * @param b
     * @param c
     * @param d
     */
    public static function segmentsIntr(a:CoordinateVo, b:CoordinateVo, c:CoordinateVo, d:CoordinateVo):Object{

        /** 1 解线性方程组, 求线段交点. **/
        // 如果分母为0 则平行或共线, 不相交
        var denominator:Number = (b.y - a.y)*(d.x - c.x) - (a.x - b.x)*(c.y - d.y);
        if (denominator==0) {
            return false;
        }

        // 线段所在直线的交点坐标 (x , y)
        var x:Number = ( (b.x - a.x) * (d.x - c.x) * (c.y - a.y)
                + (b.y - a.y) * (d.x - c.x) * a.x
                - (d.y - c.y) * (b.x - a.x) * c.x ) / denominator ;
        var y:Number = -( (b.y - a.y) * (d.y - c.y) * (c.x - a.x)
                + (b.x - a.x) * (d.y - c.y) * a.y
                - (d.x - c.x) * (b.y - a.y) * c.y ) / denominator;

        /** 2 判断交点是否在两条线段上 **/
        // 交点在线段1上                                                 // 且交点也在线段2上
        if ((x - a.x) * (x - b.x) <= 0 && (y - a.y) * (y - b.y) <= 0 && (x - c.x) * (x - d.x) <= 0 && (y - c.y) * (y - d.y) <= 0){

            // 返回交点p
            return new CoordinateVo(x, y);
        }
        //否则不相交
        return null;
    }

    /**
     * 判断坐标是否在多边形内
     * @param x
     * @param y
     * @param coords
     * @return
     */
    public static function isPointInPolygon(x:Number, y:Number, coords:Array):Boolean {
        var wn:int = 0;
        for (var shiftP:Boolean, shift:Boolean = coords[1] > y, i:int = 3; i < coords.length; i += 2) {
            shiftP = shift;
            shift = coords[i] > y;
            if (shiftP != shift) {
                var n:int = (shiftP ? 1 : 0) - (shift ? 1 : 0);
                // dot product for vectors (c[0]-x, c[1]-y) . (c[2]-x, c[3]-y)
                if (n * ((coords[i - 3] - x) * (coords[i - 0] - y) - (coords[i - 2] - y) * (coords[i - 1] - x)) > 0){
                    wn += n;
                }
            }
        }
        return wn != 0;
    }

    /**
     *  确认点是否在多边形内
     * @param x
     * @param y
     * @param coordinates
     * @return
     */
    public static function isPointInPolygonAdapter(x:Number, y:Number, coordinates:ArrayList,minX:Number, minY:Number):Boolean{
        var coors:ArrayList = new ArrayList();
        coordinates.toArray().forEach(function(item:Object, index:int, arr:Array):void{
            coors.addItem(item.x - minX);
            coors.addItem(item.y - minY);
        });
        if(coors.getItemAt(0) != coors.getItemAt(coors.length - 2) || coors.getItemAt(1) != coors.getItemAt(coors.length - 1)){
            coors.addItem(coors.getItemAt(0));
            coors.addItem(coors.getItemAt(1));
        }
        return isPointInPolygon(x, y, coors.toArray());
    }

    /**
     *  根据矩形对角两个坐标，计算完整坐标
     * @param rect
     * @return
     */
    public static function generateRectCoordinates(rect:CustomRect):ArrayList{
        var coors:ArrayList = new ArrayList();
        coors.addItem(new CoordinateVo(rect.xFrom, rect.yFrom));
        coors.addItem(new CoordinateVo(rect.xFrom, rect.yTo));
        coors.addItem(new CoordinateVo(rect.xTo, rect.yTo));
        coors.addItem(new CoordinateVo(rect.xTo, rect.yFrom));
        coors.addItem(new CoordinateVo(rect.xFrom, rect.yFrom));
        return coors;
    }

    /**
     *  添加最小x y坐标还原到外部坐标
     * @param rect
     * @param minX
     * @param minY
     * @return
     */
    public static function generateRectCoordintesWithMinXY(rect:CustomRect, minX:int, minY:int):ArrayList{
        var coors:ArrayList = new ArrayList();
        coors.addItem(new CoordinateVo(rect.xFrom + minX, rect.yFrom + minY));
        coors.addItem(new CoordinateVo(rect.xFrom + minX, rect.yTo + minY));
        coors.addItem(new CoordinateVo(rect.xTo + minX, rect.yTo + minY));
        coors.addItem(new CoordinateVo(rect.xTo + minX, rect.yFrom + minY));
        coors.addItem(new CoordinateVo(rect.xFrom + minX, rect.yFrom + minY));
        return coors;
    }

    /**
     *  矩形转换为 房间
     * @param rects
     * @return
     */
    public static function convertRectToRooms(rects:ArrayList, minX:int, minY:int):ArrayList{
        var rooms:ArrayList = new ArrayList();
        rects.toArray().forEach(function (item:CustomRect, index:int, arr:Array):void {
            var coordinates:ArrayList = CalculationUtils.generateRectCoordintesWithMinXY(item, minX, minY);
            var rId:String = Math.random()+ " 房";
            var r:RoomVo = new RoomVo(rId, rId, rId);
            r.coordinates = coordinates;
            r.x = item.xFrom;
            r.y = item.yFrom;
            rooms.addItem(r);
        });
        return rooms;
    }

    /**
     * 根据坐标求面积
     * @param coordinates
     * @return
     */
    public static function caculationArea(coordinates:ArrayList):Number{
        var area:Number = 0;
        for(var i:int=0;i<(coordinates.length - 1);i++){
            var a:Object = coordinates.getItemAt(i);
            var b:Object = coordinates.getItemAt((i+1));
            area += ((b.x-a.x)*(a.y+b.y));
        }
        return Math.abs(area/2);
    }

}
}
