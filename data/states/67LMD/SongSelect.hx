// Imports
import funkin.backend.utils.CoolUtil;
import openfl.Lib;
// Variables
// WINDOW MOVE VAR
var winx:Int;
var winy:Int;
var char1:FlxSprite;
var char2:FlxSprite;
var titleTxt:FlxText;
var logo:FunkinSprite;
var charBG:FlxSprite;
var bg:FunkinSprite;
var difficultyOptions:Array<FlxSprite> = [];
var transitioning:Bool = false;

function create() {
    CoolUtil.playMusic(Paths.inst("67LMD", "normal"),false,1,true);

    charBG = new FlxSprite().makeGraphic(450, FlxG.height, FlxColor.WHITE);
    charBG.alpha = 0.4;
    charBG.screenCenter(0x01);
    add(charBG);
    // Melon
    char1 = new FlxSprite(FlxG.width - 985,140);
    char1.frames = Paths.getSparrowAtlas("characters/melon");
	char1.animation.addByPrefix("idle", "melon idle");
	char1.animation.play("idle");
    char1.scale.set(0.6,0.6);
    char1.updateHitbox();
	add(char1);
    // Yani
    char2 = new FlxSprite(FlxG.width - 860,140);
    char2.frames = Paths.getSparrowAtlas("characters/yani");
	char2.animation.addByPrefix("idle", "yani idle");
	char2.animation.play("idle");
    char2.scale.set(0.6,0.6);
    char2.updateHitbox();
	add(char2);

    titleBG = new FlxSprite().makeGraphic(FlxG.width, 50, FlxColor.BLACK);
    titleBG.alpha = 0.4;
    add(titleBG);
    titleTxt = new FunkinText(0,5,0,"67LMD", 38, true);
    titleTxt.screenCenter(0x01);
    add(titleTxt);

    playTxt = new FunkinText(0,FlxG.height - 100,0,"PLAY!", 64, true);
    playTxt.screenCenter(0x01);
    playTxt.x = playTxt.x + 10;
    add(playTxt);
    winx = Lib.application.window.x;
	winy = Lib.application.window.y;
    Lib.application.window.fullscreen = false;
	Lib.application.window.resizable = false;
	Lib.application.window.resize(540, 900);
	stream = 1;
	Lib.application.window.resizable = false;
	Lib.current.x = -540;
	Lib.current.y = -900;
	Lib.current.scaleX = 3;
	Lib.current.scaleY = 3;
}

function update(){
	if (controls.BACK && !transitioning)
	{
		CoolUtil.playMenuSFX(2, 10);
        
		FlxG.switchState(new MainMenuState());
	}
    if (FlxG.mouse.justPressed && !transitioning) {
        transitioning = true;
        CoolUtil.playMenuSFX(1,1);
        PlayState.loadSong("67LMD", "normal", false, false);
        FlxTween.tween(char1, {alpha: 0}, 0.7);
        FlxTween.tween(char2, {alpha: 0}, 0.7);
        FlxTween.tween(FlxG.sound.music, {volume: 0}, 1.2, {ease: FlxEase.circIn});
        FlxTween.tween(FlxG.camera, {zoom: 6, alpha: 0}, 1.7, {ease: FlxEase.backIn, onComplete: function(twn:FlxTween){
            FlxG.switchState(new PlayState());
        }});
    }
}
function destroy() {
    Lib.application.window.resizable = true;
	Lib.application.window.resize(1280, 720);
	stream = 1;
	Lib.current.x = 0;
	Lib.current.y = 0;
	Lib.current.scaleX = 1;
	Lib.current.scaleY = 1;
}