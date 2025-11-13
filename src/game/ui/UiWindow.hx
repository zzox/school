package game.ui;

import core.Types;
import core.gameobjects.BitmapText;
import core.gameobjects.GameObject;
import core.system.Camera;
import game.ui.UiElement;
import game.ui.UiText;
import kha.Assets;
import kha.graphics2.Graphics;

typedef ChildElements = {
    var el:UiElement;
    // var el:GameObject;
    var x:Int;
    var y:Int;
}
// TODO: combine these somehow
typedef OChildElements = {
    // var el:UiElement;
    var el:GameObject;
    var x:Int;
    var y:Int;
}

// a collection of gameobjects all rendered to a relative position
class UiWindow {
    public var x:Int;
    public var y:Int;

    public var width:Int = 0;
    public var height:Int = 0;

    // parent will close when set to true
    public var closed:Bool = false;

    public var heldPos:Null<IntVec2>;

    public var children:Array<ChildElements> = [];
    public var grabbable:Null<UiElement>;
    public var cancel:Null<UiElement>;
    var oChildren:Array<OChildElements> = [];

    var text:BitmapText;
    var temp:Int = 0;

    public function new (x:Int, y:Int) {
        final topbar = new UiElement(0, 0, 16, 16, 3, 3, 13, 13, 100, 16, 8, Assets.images.ui);
        final bottomBg = new UiElement(0, 0, 16, 16, 3, 3, 13, 13, 100, 100, 0, Assets.images.ui);
        final button = new UiElement(0, 0, 16, 16, 3, 3, 13, 13, 48, 24, 4, Assets.images.ui, () -> {
            temp++;
        });
        final xButton = new XButton(() -> { closed = true; });

        addChild(0, 0, topbar);
        addChild(0, 16, bottomBg);
        addChild(100 - 14, 2, xButton);
        addChild(4, 50, button);

        grabbable = topbar;

        text = makeBitmapText(0, 0, '');

        oChildren = [{ x: 24, y: 70, el: text }];

        this.x = x;
        this.y = y;
    }

    public function update () {
        text.setText(temp + '');
    }

    public function render (g2:Graphics, cam:Camera) {
        for (c in children) {
            c.el.x = x + c.x;
            c.el.y = y + c.y;
            c.el.render(g2, cam);
        }
        for (c in oChildren) {
            c.el.x = x + c.x;
            c.el.y = y + c.y;
            c.el.render(g2, cam);
        }
    }

    function addChild (x:Int, y:Int, el:UiElement) {
        children.push({ x: x, y: y, el: el });
        width = Std.int(Math.max(width, x + el.elementSizeX));
        height = Std.int(Math.max(height, y + el.elementSizeY));
    }
}

// TODO: move to ui utils file
class XButton extends UiElement {
    public function new (callback:UiEvent) {
        super(0, 0, 16, 16, 3, 3, 13, 13, 12, 12, 12, Assets.images.ui, callback);
    }
}
