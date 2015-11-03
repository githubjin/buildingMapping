/**
 * Created by Yo on 2015/11/3.
 */
package random.events {
import mx.collections.ArrayList;
import mx.controls.Alert;

import random.utils.AddressingCalculationUtils;

import random.valueObject.RoomVo;

import spark.components.Group;

public class CustomEventHandler {

    private var roomIdList:ArrayList;
    private var dataList:ArrayList;
    private var groupList:ArrayList;

    private var _operationType:String = OperationTypeEvent.OP_MERGE;

    public function CustomEventHandler() {
        roomIdList = new ArrayList();
        dataList = new ArrayList();
        groupList = new ArrayList();
    }

    public function append(customEvent: ICustom):void{
        var id:String = this.getRoomIdentity(customEvent);
        trace("-------------------------------"+id+"-------------------------------------")
        var itemIndex:int = this.roomIdList.getItemIndex(id);
        trace("-------------------------------"+JSON.stringify(this.roomIdList)+"-------------------------------------")
        trace("-------------------------------"+itemIndex+"-------------------------------------")
        if(itemIndex > -1){
            return;
        }
        this.roomIdList.addItem(this.getRoomIdentity(customEvent));
        this.dataList.addItem(customEvent.itemRendererData);
        this.groupList.addItem(customEvent.group);
        this.addMouseOverEffect(customEvent.group);
    }

    public function remove(customEvent:ICustom):void{
        var itemIndex:int = this.roomIdList.getItemIndex(this.getRoomIdentity(customEvent));
        this.roomIdList.removeItemAt(itemIndex);
        this.dataList.removeItemAt(itemIndex);
        var group:Group = this.groupList.removeItemAt(itemIndex) as Group;
        this.removeMouseOverEffect(group);

    }

    public function removeBebind(customEvent:ICustom):void{
        var itemIndex:int = this.roomIdList.getItemIndex(this.getRoomIdentity(customEvent));
//        Alert.show(itemIndex+":"+this.roomIdList.length);
        if(itemIndex > 0){
            for(var i:uint=(itemIndex+1);i<this.roomIdList.length;i++){
                this.roomIdList.removeItemAt(i);
                this.dataList.removeItemAt(i);
                var group:Group = this.groupList.removeItemAt(i) as Group;
                this.removeMouseOverEffect(group);
            }
        }else{
            this.append(customEvent);
        }
    }

    public function addMouseOverEffect(group:Group):void{
        group.alpha = 1;
        group.setStyle("color","#5938ff");
    }

    public function removeMouseOverEffect(group:Group):void{
        group.alpha = 0.7;
        group.setStyle("color","#ffffff");
    }

    public function clean():void{
        this.roomIdList.removeAll();
        this.dataList.removeAll();
        for(var i:uint=0;i<this.groupList.length;i++){
            this.removeMouseOverEffect((this.groupList.getItemAt(i) as Group));
        }
        this.groupList.removeAll();
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
        util.calculation(this.dataList);
    }
}
}
