// its pretty messy but i just want this out so im not cleaning this up fuck you :3c - Dataleak
import funkin.game.HealthIcon;
import flixel.ui.FlxBar.FlxBarFillDirection;
import flixel.ui.FlxBar;

var timeBar:FlxBar;
var melonIcon:HealthIcon;
var bfIcon:HealthIcon;
var yaniIcon:HealthIcon;
var newicon = true;
var botplayTxt:FunkinText;
var botplay:Bool = false;
function create() {
    missesTxt.visible = false;
    accuracyTxt.visible = false;
    scoreTxt.x = scoreTxt.x - 220;

    bfIcon = new HealthIcon("bf",false);
    bfIcon.setPosition(FlxG.width - 310, 130);
    yaniIcon = new HealthIcon("yani",false);
    yaniIcon.setPosition(FlxG.width - 1130, 130);
    melonIcon = new HealthIcon("melon",false);
    melonIcon.screenCenter(0x01);
    melonIcon.y = 130;
    for (icons in [bfIcon, yaniIcon, melonIcon]) {
        icons.cameras = [camHUD];
        icons.scale.set(0.8,0.8);
        icons.scrollFactor(1,1);
        insert(strumLines, icons);
        if (FlxG.save.data.hideicons) {
            icons.visible = false;
        }
    }
    
    //get these strumlines away from me
    if (FlxG.save.data.hideopps) {
        strumLines.members[0].visible = false;
        strumLines.members[1].visible = false;
    }

    timeBar = new FlxBar(0, 0, FlxBarFillDirection.RIGHT_TO_LEFT, FlxG.width, 15, strumLines, "length", 0, 58000, false);
	timeBar.cameras = [camHUD];
	timeBar.numDivisions = 58000;
	timeBar.flipX = true;
	timeBar.createColoredEmptyBar(0x60000000, false);
	timeBar.createColoredFilledBar(0xFFffffff, false);
	add(timeBar);

    introLength = 0;
    health = 0.1;
    iconP1.visible = false;
    iconP2.visible = false;

    //botplay shit
    botplayTxt = new FunkinText(0, 80, 0, "BOTPLAY", 36, true);
    botplayTxt.cameras = [camHUD];
    botplayTxt.screenCenter(0x01);
    botplayTxt.visible = botplay;
    add(botplayTxt);
    botplay = FlxG.save.data.botplay;
    strumLines.members[2].cpu = botplay;
    botplayTxt.visible = botplay;
}

function update() {
    // Icon stuff
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
    // easter egg!!!!
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
    // botplay for all the STINKIES
    if (FlxG.keys.justPressed.EIGHT) {
        validScore = false;
        if (botplay) {
            strumLines.members[2].cpu = false;
            botplay = false;
        }
        else if (!botplay) {
            strumLines.members[2].cpu = true;
            botplay = true;
        }
        botplayTxt.visible = botplay;
        FlxG.save.data.botplay = botplay;
    }
}
function beatHit() {
    // bwa
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
    // timeBar stuff my beloved
    timeBar.value = inst.time;
}
