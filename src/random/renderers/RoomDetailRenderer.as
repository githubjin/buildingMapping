/**
 * Created by Yo on 2015/11/3.
 */
package random.renderers {
import flash.display.GradientType;
import flash.geom.Matrix;

import mx.core.mx_internal;

import spark.components.supportClasses.ItemRenderer;

use namespace mx_internal;

public class RoomDetailRenderer extends ItemRenderer {
    public function RoomDetailRenderer() {
        super();
    }


    override mx_internal function drawBackground():void {
//        super.mx_internal::drawBackground();
        var change:Number = 0;
        // Choose green or red for the background color based on the stock's change value.
        var backgroundColors:Array = (change >= 0 ? [0x00CC00, 0x009900] : [0xCC0000, 0x990000]);

        // Create a matrix to rotate the background gradient 90 degrees.
        var matrix:Matrix = new Matrix();
        matrix.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);

        // Draw the gradient background.
        graphics.beginGradientFill(GradientType.LINEAR, backgroundColors, [1.0, 1.0], [0, 255], matrix);
        graphics.drawRect(data.x+50, data.y+50, 0, 0);
        graphics.endFill();
    }
}
}
