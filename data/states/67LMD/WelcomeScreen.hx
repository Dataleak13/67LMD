// Imports
import funkin.menus.BetaWarningState;
import funkin.backend.utils.CoolUtil;
import Sys;
// Variables
var leftState:Bool = false;
var bg:FunkinSprite;
var welcomeTxt:FunkinText;
var transitioning:Bool = false;
var devbuild:FunkinText;
var indev:Bool = false;

function create()
{
    if (FlxG.save.data.disablestartwarn) {
        FlxG.switchState(new MainMenuState());
    }
    else {
        bg = new FunkinSprite(0,0,Paths.image("menus/menuContrast"));
        bg.screenCenter(0x11);
        bg.x = bg.x - 1200;
        bg.color = FlxColor.GRAY;
        bg.alpha = 0;
        bg.scale.set(1.2,1.2);
        bg.updateHitbox();
        add(bg);
        
        if (indev) {
            devbuild = new FunkinText(0,20,0,"You are on a development build",40,true);
            devbuild.screenCenter(0x01);
            devbuild.y = devbuild.y - 100;
            devbuild.alpha = 0;
            add(devbuild);
        }
    	welcomeTxt = new FunkinText(0,0,0,"
                      Welcome to 67LMD!
       This is a oneshot mod developed on codename engine.
          Codename engine is currently a WIP meaning
             crashes and more are to be expected.
    
                  We still hope you enjoy!
    
                  (Press ENTER to continue)
        ",36,true);
        welcomeTxt.screenCenter(0x11);
        welcomeTxt.x = welcomeTxt.x - 1200;
        welcomeTxt.alpha = 0;
        add(welcomeTxt);
        // Animate it all in cause i LOVE MAKING STUFF MOVE AJFDKSJLKFDKLS
        if (indev)
            FlxTween.tween(devbuild, {y: devbuild.y + 100, alpha: 1}, 1.3, {ease: FlxEase.backOut});
        FlxTween.tween(welcomeTxt, {x: welcomeTxt.x + 1200, alpha: 1}, 2.1, {ease: FlxEase.expoOut});
        // what the fuck is this shit
        FlxTween.tween(bg, {x: bg.x + 1200, alpha: 1}, 1.9, {ease: FlxEase.expoOut});
    }
}

function update(elapsed:Float) {
	if (controls.ACCEPT && !transitioning || FlxG.mouse.justPressed && !transitioning) {
		transitioning = true;
		CoolUtil.playMenuSFX(1,1);
		FlxG.camera.flash(FlxColor.WHITE, 1);
        if (indev){
            FlxTween.tween(devbuild, {alpha: 0}, 0.7, {ease: FlxEase.circOut});
        }
        FlxTween.tween(bg, {y: bg.y - 900}, 1.2, {ease: FlxEase.backIn});
		FlxTween.tween(welcomeTxt, {y: welcomeTxt.y - 900}, 1.5, {ease: FlxEase.backIn, 
			onComplete: function(tween:FlxTween) {
				FlxG.switchState(new MainMenuState());
		}});
	}
}