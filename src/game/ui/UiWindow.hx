package game.ui;

import core.Types;
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

    public var heldPos:Null<IntVec2>;

    public var children:Array<ChildElements> = [];
    public var grabbable:Null<UiElement>;
    public var cancel:Null<UiElement>;
    var oChildren:Array<OChildElements> = [];

    public function new (x:Int, y:Int) {

        final topbar = new UiElement(0, 0, 16, 16, 3, 3, 13, 13, 100, 16, Assets.images.ui);
        final bottomBg = new UiElement(0, 0, 16, 16, 3, 3, 13, 13, 100, 100, Assets.images.ui);

        children = [{ x: 0, y: 0, el: topbar }, { x: 0, y: 16, el: bottomBg }];

        grabbable = topbar;

        oChildren = [{ x: 24, y: 50, el: makeBitmapText(0, 0, (Math.random() + '').split('.')[1].substr(0, 4)) }];
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
}
