/**
 * Created by DaoSui on 2015/11/2.
 */
package random.valueObject {
import mx.collections.ArrayList;
import mx.controls.Alert;

import random.utils.Constants;

/*{
    "id": "201",
        "name": "201",
        "description": "2,0,1",
        "coordinates": [
    {"x": 0, "y": 0},{"x": 0, "y": 1},{"x": 1, "y": 1},{"x": 1, "y": 0}
]
},*/
public class RoomVo {

    private var _id:String;
    private var _name:String;
    private var _description:String;
    private var _coordinates:ArrayList = new ArrayList();

    private var _x:uint;
    private var _y:uint;
    private var _pathData:String;

    private var _tagImgs:ArrayList = new ArrayList();


    public function RoomVo(id:String, name:String, description:String) {
        this._id = id;
        this._name = name;
        this._description = description;
    }

    public function addCoordinates(arr:Array):void{
        for(var i:uint=0;i<arr.length;i++){
            var d:Object = arr[i];
            if(i == 0){
                this._x = d.x * Constants.UNIT_LENGTH;
                this._y = d.y * Constants.UNIT_LENGTH;
                this._pathData = "M " + d.x * Constants.UNIT_LENGTH + " " + d.y * Constants.UNIT_LENGTH + " ";
            }else{
                this._pathData += "L " + d.x * Constants.UNIT_LENGTH + " " + d.y * Constants.UNIT_LENGTH + " ";
            }
            if(i == (arr.length-1)) {
                this._pathData += "Z";
            }
            this._coordinates.addItem(new CoordinateVo(d.x * Constants.UNIT_LENGTH, d.y * Constants.UNIT_LENGTH));
        }
    }


    public function get id():String {
        return _id;
    }

    public function get name():String {
        return _name;
    }

    public function get description():String {
        return _description;
    }

    public function get coordinates():ArrayList {
        return _coordinates;
    }

    public function get x():uint {
        return _x;
    }

    public function get y():uint {
        return _y;
    }

    public function get pathData():String {
        return _pathData;
    }


    public function get tagImgs():ArrayList {
        return _tagImgs;
    }

    public function set tagImgs(value:ArrayList):void {
        _tagImgs = value;
    }

    public function set coordinates(value:ArrayList):void {
        _coordinates = value;
    }
}
}
