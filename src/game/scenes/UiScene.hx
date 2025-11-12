package game.scenes;

import core.Game;
import core.gameobjects.BitmapText;
import core.gameobjects.NineSlice;
import core.scene.Scene;
import game.ui.UiElement;
import game.ui.UiText;
import game.ui.UiWindow;
import game.util.TextUtil;
import game.world.World;
import kha.Assets;
import kha.graphics2.Graphics;

class UiScene extends Scene {
    var world:World;
    var dayText:BitmapText;
    var timeText:BitmapText;
    public var dollarText:BitmapText;

    var middleTextTime:Float = 0.0;
    var middleText:BitmapText;
    var middleSubtext:BitmapText;

    var windows:Array<UiWindow> = [];

    // TEMP:
    var el:UiElement;
    var ct:Int = 0;

    public var devTexts:Array<BitmapText> = [];

    public function new (world:World) {
        super();
        this.world = world;
    }

    override function create () {
        super.create();
        camera.scale = 2;
        entities.push(dayText = makeBitmapText(4, 4, ''));
        entities.push(timeText = makeBitmapText(4, 14, ''));
        entities.push(dollarText = makeBitmapText(camera.width, 9, ''));
        entities.push(middleText = makeBitmapText(0, 64, ''));
        entities.push(middleSubtext = makeBitmapText(0, 80, ''));

        // entities.push(nineSlice = new NineSlice(0, 0, 16, 16, 3, 3, 13, 13, 250, 100, Assets.images.ui));
        // entities.push(el = new UiElement(0, 0, 16, 16, 3, 3, 13, 13, 250, 100, Assets.images.ui, () -> {
        //     ct++;
        // }));

        final window = new UiWindow(0, 0);
        windows.push(window);
        entities.push(window);

        for (i in 0...8) {
            final text = makeBitmapText(4, 100 + i * 10, '');
            entities.push(text);
            devTexts.push(text);
        }
    }

    override function update (delta:Float) {
        super.update(delta);

        dayText.setText('Day ${world.day + 1}');
        timeText.setText(TextUtil.formatTime(world.time));
        dollarText.setText('$' + world.money);
        dollarText.setPosition(Math.floor(camera.width / camera.scale - dollarText.textWidth - 8), dollarText.y);

        middleTextTime -= delta;
        middleText.setPosition(Math.floor((camera.width / camera.scale - middleText.textWidth) / 2), middleText.y);
        middleText.visible = middleTextTime > 0;

        // for every button
        // el.checkPointer(Math.floor(Game.mouse.position.x / camera.scale), Math.floor(Game.mouse.position.y / camera.scale));
        // el.setIndexFromState();

        // HACK:
        devTexts[devTexts.length - 1].setText(ct + '');
    }

    public function setMiddleText (text:String, time:Float) {
        middleText.setText(text);
        middleTextTime = time;
    }

    // override function render (g2:Graphics, clears:Bool) {
    //     super.render(g2, clears);
    //     for (w in windows) w.render(g2, camera);
    // }
}
