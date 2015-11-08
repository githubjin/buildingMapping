/**
 * Created by DaoSui on 2015/11/8.
 */
package random.utils.vo {
import mx.collections.ArrayList;

public class ValidAndFilledCoordinateList {

    private var _validCoordinates:ArrayList;
    private var _filledCoordinates:ArrayList;


    public function ValidAndFilledCoordinateList(validCoordinates:ArrayList, FilledCoordinates:ArrayList) {
        _validCoordinates = validCoordinates;
        _filledCoordinates = FilledCoordinates;
    }

    public function get validCoordinates():ArrayList {
        return _validCoordinates;
    }

    public function set validCoordinates(value:ArrayList):void {
        _validCoordinates = value;
    }

    public function get filledCoordinates():ArrayList {
        return _filledCoordinates;
    }

    public function set filledCoordinates(value:ArrayList):void {
        _filledCoordinates = value;
    }
}
}
