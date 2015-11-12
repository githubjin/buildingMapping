/**
 * Created by DaoSui on 2015/11/2.
 */
package random.utils {
public class Constants {

    [Bindable]
    public static var UNIT_LENGTH:uint = 100;
    public static var CUSTOM_EVENT_LOADED_DEMO_DATA_EVENT:String = "demoDataChange";
    public static var OPERATION_TYPE_CHANGE_EVENT:String = "operationTypeChanged";

    public static var SERVER_URL:String = "http://localhost:8080/bm/";
//    public static var SERVER_URL:String = "http://202.194.67.108:8888/bm/";

    public static var TAG_IMAGES_URL:String = SERVER_URL + "resources/images/";
    public static var TAG_IMAGE_SUFFIX:String = ".png";

    public static var CUSTOM_MOUSE_DOWM_EVENT_TYPE: String = "customMouseDownEventType";
    public static var CUSTOM_MOUSE_MOVE_EVENT_TYPE: String = "customMouseMoveEventType";
    public static var CUSTOM_MOUSE_UP_EVENT_TYPE: String = "customMouseUpEventType";

    public static var RESET_OPERATION_EVENT:String = "resetMergeOperations";

    public static var MERGE:String = "merge";
    public static var SPLIT:String = "split";
    public static var EMPTY:String = "empty";

    public static var DIRECTION_UP:String = "U";
    public static var DIRECTION_DOWN:String = "D";
    public static var DIRECTION_LEFT:String = "L";
    public static var DIRECTION_RIGHT:String = "R";

    //直线方向
    public static var LINE_DIRECTIONS_HORIZONTAL:String = "H";
    public static var LINE_DIRECTIONS_VERTICAL:String = "V";

    // 坐标圆浮动大小
    public static var CUSTOM_RECT_OFFSET_XY:Number = 2;

    public static var FEN_ZI:int = 1;
    public static var FEN_MU:int = 1;

}
}
