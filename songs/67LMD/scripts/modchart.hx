// basic functions
function finaleBullshit(num:String){
    if (num == '1')
        FlxTween.tween(camHUD, {alpha: 0}, 1.2);
    else if (num == '2') {
        FlxTween.tween(camGame, {alpha: 0}, 0.4);
    }
}