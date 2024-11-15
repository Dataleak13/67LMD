/*
 * Written by Dataleak
 */
// Imports
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;
import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import funkin.backend.utils.CoolUtil;
import funkin.options.Options;
// Variables
var bg:FunkinSprite;
var optionsBG:FlxSprite;
var logo:FunkinSprite;
var options:FlxSprite;
var char:FlxSprite;
var titleTxt:FlxText;
var transitioning:Bool = false;

var menuOptions:Array<FlxSprite> = [];

function create(){
    FlxG.mouse.visible = true;
    FlxG.camera.y -= 900;
    if (FlxG.music == null) {
        CoolUtil.playMenuSong(true);
    }
    bg = new FunkinSprite(0,0,Paths.image("menus/menuDesat"));
    bg.screenCenter(0x11);
    bg.color = FlxColor.CYAN;
    bg.antialiasing = Options.antialiasing;
    add(bg);

    logo = new FunkinSprite(0,0,Paths.image('menus/epictitle'));
    logo.scale.set(0.6,0.6);
    logo.updateHitbox();
    logo.screenCenter(0x11);
    logo.y = logo.y - 60;
    logo.antialiasing = Options.antialiasing;
    add(logo);

    optionsBG = new FlxSprite().makeGraphic(FlxG.width, 160, FlxColor.BLACK);
    optionsBG.alpha = 0.4;
    optionsBG.y = FlxG.height - 160;
    add(optionsBG);

    menuOptions = new FlxTypedGroup();
	menuOptions.visible = true;
	add(menuOptions);
    
    titleBG = new FlxSprite().makeGraphic(FlxG.width, 50, FlxColor.BLACK);
    titleBG.alpha = 0.4;
    add(titleBG);
    titleTxt = new FunkinText(0,5,0,"67LMD", 38, true);
    titleTxt.screenCenter(0x01);
    titleTxt.antialiasing = Options.antialiasing;
    add(titleTxt);


    freeplay = new FlxSprite(10, FlxG.height - 140);
	freeplay.frames = Paths.getSparrowAtlas("menus/mainmenu/freeplay");
	freeplay.animation.addByPrefix("idle", "freeplay basic");
	freeplay.animation.addByPrefix("select", "freeplay white");
	freeplay.animation.play("idle");
    freeplay.updateHitbox();
    freeplay.antialiasing = Options.antialiasing;
	menuOptions.add(freeplay);

    credits = new FlxSprite(0, FlxG.height - 140);
	credits.frames = Paths.getSparrowAtlas("menus/mainmenu/credits");
	credits.animation.addByPrefix("idle", "credits basic");
	credits.animation.addByPrefix("select", "credits white");
	credits.animation.play("idle");
    credits.updateHitbox();
    credits.screenCenter(0x01);
    credits.x += 15;
    credits.antialiasing = Options.antialiasing;
	menuOptions.add(credits);

    options = new FlxSprite(FlxG.width - 450, FlxG.height - 140);
	options.frames = Paths.getSparrowAtlas("menus/mainmenu/options");
	options.animation.addByPrefix("idle", "options basic");
	options.animation.addByPrefix("select", "options white");
	options.animation.play("idle");
    options.updateHitbox();
	menuOptions.add(options);
    transitioning = true;
    FlxTween.tween(FlxG.camera, {y: FlxG.camera.y + 900}, 2.1, {ease: FlxEase.backInOut, onComplete: function(twn:FlxTween){
        transitioning = false;
    }});
}

function update(){
    // the handler for options or somethin idk
    for (i in 0...menuOptions.length){
        if (FlxG.mouse.overlaps(menuOptions.members[i]) && !transitioning) {
            menuOptions.members[i].animation.play("select");
            menuOptions.members[i].scale.set(0.7,0.7);
            menuOptions.members[i].updateHitbox();
            titleTxt.screenCenter(0x01);
            switch(i){
                case 0:
                    titleTxt.text = "Play the song!";
                    menuOptions.members[0].scale.set(0.6,0.6);
                    menuOptions.members[0].updateHitbox();
                case 1:
                    titleTxt.text = "See who made this possible!";
                case 2:
                    titleTxt.text = "Change all your settings right here!";
            }
            if (FlxG.mouse.justPressed) {
                CoolUtil.playMenuSFX(1,1);
                transitioning = true;
                FlxTween.tween(FlxG.sound.music, {volume: 0}, 1.3, {ease: FlxEase.circOut});
                FlxTween.tween(FlxG.camera, {y: FlxG.camera.y + 900}, 1.9, {ease: FlxEase.backIn, onComplete: function (twn:FlxTween){
                    switch(i){
                        case 0:
                            FlxG.switchState(new FreeplayState());
                        case 1:
                            FlxG.switchState(new CreditsMain());
                        case 2:
                            FlxG.switchState(new OptionsMenu());
                    }
                }});
            }
        }
        else if (!FlxG.mouse.overlaps(menuOptions.members[i])) {
            menuOptions.members[i].animation.play("idle");
            menuOptions.members[i].scale.set(0.8,0.8);
            menuOptions.members[i].updateHitbox();
            menuOptions.members[0].x = 15;
        }
    }

    if (controls.SWITCHMOD && !transitioning) {
		openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }

    if (FlxG.keys.justPressed.SEVEN && !transitioning) {
		openSubState(new EditorPicker());
        persistentUpdate = false;
        persistentDraw = true;
    }
}
function beatHit(curBeat:Int){
    if (Options.camZoomOnBeat){
        if (curBeat % 4 == 1) {
            FlxTween.tween(FlxG.camera, {zoom: 1.05}, (0.3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoIn, onComplete: function(twn:FlxTween){
                FlxTween.tween(FlxG.camera, {zoom: 1}, (0.3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoOut});
            }});
        }
        else if (curBeat % 4 == 3) {
            FlxTween.tween(FlxG.camera, {zoom: 1.05}, (0.3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoIn, onComplete: function(twn:FlxTween){
                FlxTween.tween(FlxG.camera, {zoom: 1}, (0.3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoOut});
            }});
        }
    }
}