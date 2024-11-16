import funkin.game.HealthIcon;
import flixel.ui.FlxBar.FlxBarFillDirection;
import flixel.ui.FlxBar;

var timeBar:FlxBar;
var melonIcon:HealthIcon;
var bfIcon:HealthIcon;
var yaniIcon:HealthIcon;
var newicon = true;
function create() {
    missesTxt.visible = false;
    accuracyTxt.visible = false;
    scoreTxt.x = scoreTxt.x - 220;
    bfIcon = new HealthIcon("bf",false);
    bfIcon.cameras = [camHUD];
    bfIcon.scale.set(0.8,0.8);
    bfIcon.setPosition(FlxG.width - 310, 130);
    insert(strumLines, bfIcon);
    
    yaniIcon = new HealthIcon("yani",false);
    yaniIcon.cameras = [camHUD];
    yaniIcon.scale.set(0.8,0.8);
    yaniIcon.setPosition(FlxG.width - 1130, 130);
    insert(strumLines, yaniIcon);
    
    melonIcon = new HealthIcon("melon",false);
    melonIcon.cameras = [camHUD];
    melonIcon.scale.set(0.8,0.8);
    melonIcon.screenCenter(0x01);
    melonIcon.y = 130;
    insert(strumLines, melonIcon);

    timeBar = new FlxBar(0, 0, FlxBarFillDirection.RIGHT_TO_LEFT, FlxG.width, 15, strumLines, "length", 0, 158000, false);
	timeBar.cameras = [camHUD];
	timeBar.numDivisions = 158000;
	timeBar.flipX = true;
	timeBar.createColoredEmptyBar(0x60000000, false);
	timeBar.createColoredFilledBar(0xFFffffff, false);
	add(timeBar);

    introLength = 0;
    //doIconBop = false;
    health = 0.1;
    iconP1.visible = false;
    iconP2.visible = false;
    if (FlxG.save.data.hideicons) {
        melonIcon.visible = false;
        yaniIcon.visible = false;
        bfIcon.visible = false;
    }
}

function update() {
    melonIcon.health = 1 - (healthBar.percent / 100);
    yaniIcon.health = 1 - (healthBar.percent / 100);
    bfIcon.health = healthBar.percent / 100;

    if (doIconBop) {
        melonIcon.scale.set(lerp(iconP1.scale.x, 1, 0.33), lerp(iconP1.scale.y, 1, 0.33));
        bfIcon.scale.set(lerp(iconP1.scale.x, 1, 0.33), lerp(iconP1.scale.y, 1, 0.33));
	    yaniIcon.scale.set(lerp(iconP2.scale.x, 0.8, 0.33), lerp(iconP2.scale.y, 0.8, 0.33));
        
        melonIcon.updateHitbox();
	    bfIcon.updateHitbox();
	    yaniIcon.updateHitbox();
    }
    if (FlxG.keys.justPressed.NINE) {
        if (newicon) {
            yaniIcon.setIcon("yani-old",150,150);
            newicon = false;
        }
        else if (!newicon) {
            yaniIcon.setIcon("yani",150,150);
            newicon = true;
        }
    }
}
function beatHit() {
    if (doIconBop) {
        bfIcon.scale.set(1.2, 1.2);
	    yaniIcon.scale.set(1.2, 1.2);
        melonIcon.scale.set(1.2, 1.2);

	    bfIcon.updateHitbox();
	    melonIcon.updateHitbox();
        yaniIcon.updateHitbox();
    }
}
function postUpdate() {
    timeBar.value = inst.time;
    
}
