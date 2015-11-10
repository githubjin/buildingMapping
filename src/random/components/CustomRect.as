/**
 * Created by Yo on 2015/11/9.
 */
package random.components {
import spark.primitives.Rect;

/**
 *  画矩形拆分房间
 */
public class CustomRect extends Rect {

    private var _xFrom:Number;
    private var _yFrom:Number;
    private var _xTo:Number;
    private var _yTo:Number;

    public function setLetTopCoordinate(x:Number, y:Number):void{
        this.xFrom = x;
        this.yFrom = y;
    }

    public function setRightBottomCoordinate(x:Number, y:Number):void{
        this.xTo = x;
        this.yTo = y;
    }

    public function CustomRect() {
        super();
    }

    public function get xFrom():Number {
        return _xFrom;
    }

    public function set xFrom(value:Number):void {
        _xFrom = value;
    }

    public function get yFrom():Number {
        return _yFrom;
    }

    public function set yFrom(value:Number):void {
        _yFrom = value;
    }

    public function get xTo():Number {
        return _xTo;
    }

    public function set xTo(value:Number):void {
        _xTo = value;
    }

    public function get yTo():Number {
        return _yTo;
    }

    public function set yTo(value:Number):void {
        _yTo = value;
    }
}
}
