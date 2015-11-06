/**
 * Created by Yo on 2015/11/3.
 */
package random.events {
import mx.collections.ArrayList;
import mx.controls.Alert;
import mx.managers.PopUpManager;
import mx.utils.ObjectUtil;

import random.utils.AddressingCalculationUtils;
import random.utils.Constants;
import random.utils.RoomReductionUtils;
import random.valueObject.BuildingVo;

import random.valueObject.RoomVo;

import spark.components.Group;
import spark.components.TitleWindow;

public class CustomEventHandler {

    private var roomIdList:ArrayList;
    private var selectedRoomList:ArrayList;
    private var selectedGroupList:ArrayList;

    private var _operationType:String = null;;

    private var _mouseUpEvent:CustomMouseUpEvent;

    private var _buidingData:BuildingVo;

    public function CustomEventHandler() {
        roomIdList = new ArrayList();
        selectedRoomList = new ArrayList();
        selectedGroupList = new ArrayList();
    }

    public function append(customEvent: ICustom):void{
        var id:String = this.getRoomIdentity(customEvent);
//        trace("-------------------------------"+id+"-------------------------------------")
        var itemIndex:int = this.roomIdList.getItemIndex(id);
//        trace("-------------------------------"+JSON.stringify(this.roomIdList)+"-------------------------------------")
//        trace("-------------------------------"+itemIndex+"-------------------------------------")
        if(itemIndex > -1){
            return;
        }
        this.roomIdList.addItem(this.getRoomIdentity(customEvent));
        this.selectedRoomList.addItem(customEvent.itemRendererData);
        this.selectedGroupList.addItem(customEvent.group);
        this.addMouseOverEffect(customEvent.group);
    }

    public function remove(customEvent:ICustom):void{
        var itemIndex:int = this.roomIdList.getItemIndex(this.getRoomIdentity(customEvent));
        this.roomIdList.removeItemAt(itemIndex);
        this.selectedRoomList.removeItemAt(itemIndex);
        var group:Group = this.selectedGroupList.removeItemAt(itemIndex) as Group;
        this.removeMouseOverEffect(group);

    }

    public function removeBebind(customEvent:ICustom):void{
        var itemIndex:int = this.roomIdList.getItemIndex(this.getRoomIdentity(customEvent));
//        Alert.show(itemIndex+":"+this.roomIdList.length);
        if(itemIndex >= 0){
            for(var i:uint=(itemIndex+1);i<this.roomIdList.length;i++){
                this.roomIdList.removeItemAt(i);
                this.selectedRoomList.removeItemAt(i);
                var group:Group = this.selectedGroupList.removeItemAt(i) as Group;
                this.removeMouseOverEffect(group);
            }
        }else{
            this.append(customEvent);
        }
    }

    public function addMouseOverEffect(group:Group):void{
        group.alpha = 1;
//        group.setStyle("color","#5938ff");
    }

    public function removeMouseOverEffect(group:Group):void{
        group.alpha = 0.7;
//        group.setStyle("color","#ffffff");
    }

    public function clean():void{
        this.roomIdList.removeAll();
        this.selectedRoomList.removeAll();
        for(var i:uint=0;i<this.selectedGroupList.length;i++){
            this.removeMouseOverEffect((this.selectedGroupList.getItemAt(i) as Group));
        }
        this.selectedGroupList.removeAll();
    }


    public function getRoomIdentity(customEvent:ICustom):String{
        return customEvent.itemRendererData.id + "_" + customEvent.itemRendererData.x + "_" + customEvent.itemRendererData.y;
    }


    public function get operationType():String {
        return _operationType;
    }

    public function set operationType(value:String):void {
        _operationType = value;
    }

    /**
     *  合并操作 确定新的边界
     */
    public function createNewRoom():void{
        var util:AddressingCalculationUtils = new AddressingCalculationUtils();
        var newRoomCoordinates:ArrayList = util.calculation(this.selectedRoomList);
        for(var i:uint=0;i<this.selectedRoomList.length;i++){
            this.buidingData.rooms.removeItem(this.selectedRoomList.getItemAt(i));
        }
//        Alert.show(JSON.stringify(newRoomCoordinates));
        var roomVo:RoomVo = new RoomVo(ObjectUtil.toString(Math.random()), "newRoom", "new Room");
        roomVo.coordinates = newRoomCoordinates;
        this.buidingData.rooms.addItem(roomVo);
    }

    /**
     *  合并 拆分 重置
     * @param event
     */
    public function operationChangedHandler(event:OperationTypeEvent, callBack:Function):void{
        this.operationType = event.operationType;
        if(operationType == Constants.EMPTY){ // 清理
            this.clean();
        }
        if(operationType == Constants.MERGE) { // 合并操作
            if(this.selectedRoomList.length < 2){
                Alert.show("请选中多个房间进行合并！");
                return;
            }
            this.removeBebind(this._mouseUpEvent);
            this.createNewRoom();
            this.clean();
//            Alert.show(JSON.stringify(this.buidingData));
        }
        if(operationType == Constants.SPLIT){
            if(this.selectedRoomList.length < 1){
                Alert.show("请选中一个房间进行拆分！");
                return;
            }
            if(this.selectedRoomList.length > 1){
                Alert.show("只能选中一个房间进行拆分！");
                return;
            }
            // 还原最小单位
            var roomReductionUtils:RoomReductionUtils = new RoomReductionUtils();
            var reductionCoordinates:ArrayList = roomReductionUtils.reductionCoordinates(this.selectedRoomList.getItemAt(0) as RoomVo);
            if(callBack != null){
                callBack.call(null, Constants.SPLIT,reductionCoordinates);
            }
        }
    }


    public function get mouseUpEvent():CustomMouseUpEvent {
        return _mouseUpEvent;
    }


    public function set mouseUpEvent(value:CustomMouseUpEvent):void {
        _mouseUpEvent = value;
    }

    [Bindable]
    public function get buidingData():BuildingVo {
        return _buidingData;
    }

    public function set buidingData(value:BuildingVo):void {
        _buidingData = value;
    }

}
}
