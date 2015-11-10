/**
 * Created by DaoSui on 2015/11/2.
 */
package random.valueObject {
[Bindable]
public class CoordinateVo {
    private var _x:Number;
    private var _y:Number;

    public function CoordinateVo(x:Number, y:Number) {
        this._x = x;
        this._y = y;
    }


    public function get x():Number {
        return _x;
    }

    public function get y():Number {
        return _y;
    }
}
}
