/**
 * Created by DaoSui on 2015/11/2.
 */
package random.valueObject {
[Bindable]
public class CoordinateVo {
    private var _x:uint;
    private var _y:uint;

    public function CoordinateVo(x:uint, y:uint) {
        this._x = x;
        this._y = y;
    }


    public function get x():uint {
        return _x;
    }

    public function get y():uint {
        return _y;
    }
}
}
