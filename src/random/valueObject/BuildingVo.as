/**
 * Created by DaoSui on 2015/11/2.
 */
package random.valueObject {
import mx.collections.ArrayCollection;
import mx.collections.ArrayList;
import mx.controls.Alert;

import random.utils.Constants;

import spark.core.ContentCache;
[Bindable]
public class BuildingVo {

    private var _unitNum:uint;
    private var  _roomNumPerUnit:uint;
    private var  _uFloorsNum:uint;
    private var  _bFloorsNum:uint;
    private var  _id:String;
    private var  _name:String;
    private var _rooms:ArrayList = new ArrayList();

    // 楼层
    private var _floors:ArrayList = new ArrayList();
    // 单元
    private var _units:ArrayList = new ArrayList();

    //image cache
    private var _imgCache:ContentCache;


    public function BuildingVo(jsonData:Object, imgCache: ContentCache) {
        this._unitNum = jsonData.unitNum;
        this._roomNumPerUnit = jsonData.roomNumPerUnit;
        this._uFloorsNum = jsonData.uFloorsNum;
        this._bFloorsNum = jsonData.bFloorsNum;
        this._id = jsonData.id;
        this._name = jsonData.name;
        this._imgCache = imgCache;
        this.addRooms(jsonData.rooms);
        this.initFloors();
        this.iniUnits();

    }

    private function initFloors():void{
        this.floors.removeAll();
        for(var i:uint=0;i<this._uFloorsNum;i++){
            this.floors.addItem((this.uFloorsNum - i) + "F");
        }

        for(var k:uint=0;k<this._bFloorsNum;k++){
            this.floors.addItem(("-" + (k+1)) + "F");
        }

    }

    private function  iniUnits():void{
        this.units.removeAll();
        for(var i:uint=this._unitNum;i>0;i--){
//            this.units.addItem(i+"单元");
            this.units.addItem({name:(i+"单元"), roomNumber: this.roomNumPerUnit, unitNum: this.unitNum});
        }
    }

    public function addRooms(rooms: Array):void {
       for each(var r: Object in rooms){
           var roomVo:RoomVo = new RoomVo(r.id, r.name, r.description);
           roomVo.addCoordinates(r.coordinates);
           if(r.tags){
               for each (var tag:String in r.tags){
                   roomVo.tagImgs.addItem(new ImageCacheVo((Constants.TAG_IMAGES_URL + tag + Constants.TAG_IMAGE_SUFFIX), this._imgCache));
               }
           }
           this._rooms.addItem(roomVo);
       }
    }

    public function cleanRooms():void{
        this._rooms.removeAll();
    }


    public function get unitNum():uint {
        return _unitNum;
    }

    public function get roomNumPerUnit():uint {
        return _roomNumPerUnit;
    }

    public function get uFloorsNum():uint {
        return _uFloorsNum;
    }

    public function get bFloorsNum():uint {
        return _bFloorsNum;
    }

    public function get id():String {
        return _id;
    }

    public function get name():String {
        return _name;
    }

    public function get rooms():ArrayList {
        return _rooms;
    }


    public function get imgCache():ContentCache {
        return _imgCache;
    }

    public function get floors():ArrayList {
        return _floors;
    }

    public function set floors(value:ArrayList):void {
        _floors = value;
    }

    public function get units():ArrayList {
        return _units;
    }

    public function set units(value:ArrayList):void {
        _units = value;
    }
}
}
