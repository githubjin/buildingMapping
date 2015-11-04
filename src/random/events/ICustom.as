/**
 * Created by DaoSui on 2015/11/3.
 */
package random.events {
import random.valueObject.RoomVo;

import spark.components.Group;

public interface ICustom {

    function get group():Group;
    function get itemRendererData():RoomVo;

}
}
