/**
 * Created by DaoSui on 2015/11/3.
 */
package random.valueObject {
import spark.core.ContentCache;

[Bindable]
public class ImageCacheVo {

    private var _src:String;
    private var _cache:ContentCache;


    public function ImageCacheVo(src:String, cache:ContentCache) {
        this._src = src;
        this._cache = cache;
    }


    public function get src():String {
        return _src;
    }

    public function get cache():ContentCache {
        return _cache;
    }
}
}
