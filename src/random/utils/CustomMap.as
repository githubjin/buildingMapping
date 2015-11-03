/**
 * Created by DaoSui on 2015/11/4.
 */
package random.utils {
import mx.collections.ArrayList;

public class CustomMap {

    private var _data:Object;
    private var _keys:ArrayList;

    public function CustomMap() {
        this._data = new Object();
        this._keys = new ArrayList();
    }

    public function put(key:String, val: Object):void{
        this._data[key] = val;
        var itemIndex:int = this._keys.getItemIndex(key);
        if(itemIndex < 0){
            this._keys.addItem(key);
        }
    }

    public function get(key:String):Object{
       var itemIndex:int = this._keys.getItemIndex(key);
        if(itemIndex < 0){
            return null;
        }
        return _data[key];
    }

    public function count(key: String):void{
        if(!this._data.hasOwnProperty(key)){
            this.put(key, 1);
        }else{
            this.put(key, ((this.get(key) as Number) + 1));
        }
    }


    public function get keys():ArrayList {
        return _keys;
    }


    public function get data():Object {
        return _data;
    }
}
}
