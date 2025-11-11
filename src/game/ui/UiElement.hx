package game.ui;

import core.Game;
import core.gameobjects.NineSlice;
import core.util.Util;
import kha.Image;


// is this more or less performant than a null check?
function noop () {}

typedef UiEvent = Void -> Void;

class UiElement extends NineSlice {
    var baseIndex:Int;

    var disabled:Bool = false;
    var pressed:Bool = false;
    var hovered:Bool = false;

    var onClick:UiEvent;
    var onHover:UiEvent;

    public function new (x:Float, y:Float, sizeX:Int, sizeY:Int,
        topLeftX:Int, topLeftY:Int, bottomRightX:Int, bottomRightY:Int,
        elementSizeX:Int, elementSizeY:Int,
        image:Image,
        ?onClick:UiEvent, ?onHover:UiEvent
    ) {
        super(x, y, sizeX, sizeY, topLeftX, topLeftY, bottomRightX, bottomRightY, elementSizeX, elementSizeY, image);

        this.onClick = onClick ?? noop;
        this.onHover = onHover ?? noop;
    }

    override function update (delta:Float) {}

    // updates state from pointer position 
    public function checkPointer (px:Int, py:Int) {
        if (pointInRect(px, py, x, y, elementSizeX, elementSizeY)) {
            hovered = true;
            if (pressed && Game.mouse.justReleased(0)) {
                onClick();
            }

            if (Game.mouse.justPressed(0)) {
                pressed = true;
            }
        } else {
            hovered = false;
        }

        if (!Game.mouse.pressed(0)) {
            pressed = false;
        }
    }

    public function setIndexFromState () {
        tileIndex = if (disabled) {
            baseIndex + 3;
        } else if (pressed) {
            baseIndex + 2;
        } else if (hovered) {
            baseIndex + 1;
        } else {
            baseIndex;
        }
    }
}
