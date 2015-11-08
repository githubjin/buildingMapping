/**
 * Created by DaoSui on 2015/11/8.
 */
package random.utils {
public class CalculationUtils {
    public function CalculationUtils() {
    }

    public static function getStageCoordinateOffset(stageX:Number, stageY:Number, componentX:Number,
                                                    componentY:Number, localX:Number, localY:Number, callback:Function):void {
        var offsetX:Number = stageX - (componentX + localX);
        var offsetY:Number = stageY - (componentY + localY);

        callback.call(null, offsetX, offsetY);
    }
}
}
