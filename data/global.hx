import funkin.menus.BetaWarningState;
import funkin.backend.utils.WindowUtils;
var indev:Bool = false;
function update(elapsed:Float) {
	if (FlxG.keys.justPressed.F5) FlxG.resetState();
}
var redirectStates:Map<FlxState, String> = [
    BetaWarningState => '67LMD/WelcomeScreen',
    MainMenuState => '67LMD/MenuScreen',
    FreeplayState => '67LMD/SongSelect',
    TitleState => '67LMD/MenuScreen',
];

function preStateSwitch() {
    FlxG.camera.bgColor = 0xFF000000;
    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(getTargetState(redirectState));
}

function getTargetState(state) {
	return redirectStates.get(state);
}

function new() {
    // FlxG.save.data is your mod's save data
    if (FlxG.save.data.nomodcharts == null)
        FlxG.save.data.nomodcharts = false;
    if (FlxG.save.data.hideicons == null)
        FlxG.save.data.hideicons = false;
    // -- Dataleak
    if (indev)
        WindowUtils.winTitle = "67LMD: A Friday Night Funkin' oneshot [DEVELOPMENT BUILD]";
    else 
        WindowUtils.winTitle = "67LMD: A Friday Night Funkin' oneshot";
}