local storedDefaultZoom = 0;
local warnTextFinished = "Bonk Notes will temporarily disable your health regen, \nand then slow the chart!";

function onCreatePost()
	storedDefaultZoom = getProperty('defaultCamZoom');

	setPropertyFromClass('substates.game.GameOverSubstate', 'characterName', 'gameover/bf-death-scout');
	addCharacterToList('gameover/bf-death-scout', 'boyfriend');

	makeAnimatedLuaSprite('scoutV', 'voicelines/scout_voiceline', getProperty('dad.x') - 200, getProperty('dad.y') - 10);
	addAnimationByPrefix('scoutV', 'mapAintBig', 'voice 1', 24, false);
	addAnimationByPrefix('scoutV', 'terrible', 'voice 2', 24, false);
	addAnimationByPrefix('scoutV', 'not believable', 'voice 3', 24, false);
	addAnimationByPrefix('scoutV', 'winded', 'voice 4', 24, false);

	makeLuaSprite('warning', 'popups/offense/Bonk_warning', 0, 250);
	setObjectCamera('warning', 'other');
	scaleObject('warning', 1, 0.7)
	addLuaSprite('warning');
	setProperty('warning.x', -400);

	makeLuaText('warnText', '', 750, 330, 550);
	setObjectCamera('warnText', 'other');
	setTextFont('warnText', 'TF2secondary.ttf');
	setTextSize('warnText', 30);
	setTextAlignment('warnText','left')
	setTextBorder('warnText', 0)
	
	addLuaSprite('scoutV', true);
	setProperty('scoutV.alpha', 0.001);
	setObjectOrder('scoutV', getObjectOrder('gfGroup') + 1);

	makeLuaSpriteTextureAtlas('fan', 'fortress/bg/bridge/force_a_nature',-230, -230);
	setProperty('fan.alpha', 0.0001);
	addAnimationBySymbol('fan', 'fan', 'the', 24, false);
	setObjectCamera('fan', 'hud');
	addLuaSprite('fan', true);
end

local tweenCallBacks = {
    ['cardTween'] = function() 
		local beatlen= 1 / bpm * 60;
        runTimer('hi piq', beatlen*5);
    end,
    ['cardRemove'] = function() 
        removeLuaSprite('warning');
    end,
	['noteWarnTwn10'] = function() 
		triggerEvent('enableCopyYCheck');
		for i = 0, getProperty('notes.length') do 
			if getPropertyFromGroup('notes', i, 'strumTime') == 100000 then
				setPropertyFromGroup('notes', i, 'copyY', true);
				setPropertyFromGroup('notes', i, 'copyX', true);
				setPropertyFromGroup('notes', i, 'copyAngle', true);
				setPropertyFromGroup('notes', i, 'strumTime', getSongPosition() + 243);
			end
		end
    end
}

function onTweenCompleted(tag)
    tweenCallBacks[tag]();
end

function onGameOver()
	playSound('onDeath/scout');
end

local typedString = '';
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'hi piq' then
		local beatlen= 1 / bpm * 60;
        doTweenY('cardRemove', 'warning', -450, beatlen*3, 'elasticinout')
		doTweenScaleX('cardRemove2', 'warning', 0.6, beatlen*2, 'elasticinout')
		doTweenAlpha('blackTwn', 'blackOverlay', 0, beatlen*2, 'quadinout');
		runTimer('Type Text Backwards', 0.01, string.len(getProperty('warnText.text')));
    end

	if tag == 'Type Text' then
		local str = string.sub(warnTextFinished, 1, string.len(getProperty('warnText.text')) + 1);
		if string.len(str) < string.len(warnTextFinished) + 1 then
			setTextString('warnText', str)
		end

		if loopsLeft == 0 then
			setTextString('warnText', warnTextFinished);
		end
	end

	if tag == 'Type Text Backwards' then
		local str = string.sub(warnTextFinished, 1, string.len(getProperty('warnText.text')) - 1);
		if string.len(str) > -1 then
			setTextString('warnText', str)
		end

		if loopsLeft == 0 then
			removeLuaText('warnText');
		end
	end
end

local storedNoteX = 0;
local storedNoteY = 0;
local storedNoteScaleX = 0;
local storedNoteScaleY = 0;
function onSongStart()
	triggerEvent('disableCopyYCheck');
	activeNoteTweenX('noteWarnTwn1', 243, 600, crochet / 500, 'quadinout')
	activeNoteTweenY('noteWarnTwn2', 243, 300, crochet / 500, 'quadinout')
	activeNoteTweenScaleX('noteWarnTwn3', 243, 0.9, crochet / 500, 'quadinout')
	activeNoteTweenScaleY('noteWarnTwn4', 243, 0.9, crochet / 500, 'quadinout')
	activeNoteTweenAngle('noteWarnTwn5', 243, 720, crochet / 500, 'quadinout')
	for i = 0, getProperty('notes.length') do 
		setPropertyFromGroup('notes', i, 'copyY', false);
		setPropertyFromGroup('notes', i, 'copyX', false);
		setPropertyFromGroup('notes', i, 'copyAngle', false);
		setPropertyFromGroup('notes', i, 'strumTime', 100000);
		if getPropertyFromGroup('notes', i, 'strumTime') == 100000 then
			storedNoteX = getPropertyFromGroup('notes', i, 'x');
			storedNoteY = getPropertyFromGroup('notes', i, 'y');
			storedNoteScaleX = getPropertyFromGroup('notes', i, 'scale.x');
			storedNoteScaleY = getPropertyFromGroup('notes', i, 'scale.y');
		end
	end
	doTweenX('cardTween', 'warning', (getPropertyFromClass('flixel.FlxG', 'width') / 2) - (getProperty('warning.width') / 2) - 200, crochet / 500, 'elasticinout')
	doTweenScaleX('cardTween2', 'warning', 0.7, crochet / 350, 'bounceinout')
	doTweenAlpha('blackTwn', 'blackOverlay', 0.5, crochet / 500, 'quadinout');
	addLuaText('warnText');
	runTimer('Type Text', 0.01, string.len(warnTextFinished) + 1);
end

function onStepHit()
	if curStep == 32 then
		activeNoteTweenScaleX('noteWarnTwn6', 100000, storedNoteScaleX, crochet / 500, 'quadinout')
		activeNoteTweenScaleY('noteWarnTwn7', 100000, storedNoteScaleY, crochet / 500, 'quadinout')
		activeNoteTweenX('noteWarnTwn8', 100000, storedNoteX, crochet / 500, 'quadInOut')
		activeNoteTweenY('noteWarnTwn9', 100000, storedNoteY, crochet / 500, 'quadInOut')
		activeNoteTweenAngle('noteWarnTwn10', 100000, -720, crochet / 500, 'quadInOut')
	end
	if curStep == 120 or curStep == 928 or curStep == 1884 or curStep == 1184 then
		doTweenZoom('bruh', 'camGame', storedDefaultZoom, crochet / 500, 'quadInOut');
		setProperty('defaultCamZoom', storedDefaultZoom);

		setProperty('scoutV.alpha', 0);
		setProperty('dad.alpha', 1);
	end

	if curStep == 96 then
		doTweenZoom('bruh', 'camGame', storedDefaultZoom + 0.1, crochet / 500, 'quadInOut');
		setProperty('defaultCamZoom', storedDefaultZoom + 0.1);

		setProperty('scoutV.alpha', 1);
		setProperty('dad.alpha', 0);

		objectPlayAnimation('scoutV', 'mapAintBig');
	end
	if curStep == 615 then
		setProperty('fan.alpha', 1);
		objectPlayAnimation('fan', 'fan');
	end
	if curStep == 640 then
		cameraShake('camGame', 0.02, 0.2);
	end
	if curStep == 896 then
		doTweenZoom('bruh', 'camGame', storedDefaultZoom + 0.1, crochet / 2000, 'circOut');
		setProperty('defaultCamZoom', storedDefaultZoom + 0.1);

		setProperty('scoutV.alpha', 1);
		setProperty('dad.alpha', 0);

		objectPlayAnimation('scoutV', 'terrible');
	end
	if curStep == 904 then 		
		doTweenZoom('bruh', 'camGame', storedDefaultZoom + 0.2, crochet / 2000, 'circOut');
		setProperty('defaultCamZoom', storedDefaultZoom + 0.2);
	end
	if curStep == 912 then 		
		doTweenZoom('bruh', 'camGame', storedDefaultZoom + 0.3, crochet / 2000, 'circOut');
		setProperty('defaultCamZoom', storedDefaultZoom + 0.3);
	end
	if curStep == 920 then
		doTweenZoom('bruh', 'camGame', storedDefaultZoom, crochet / 1000, 'circOut');
		setProperty('defaultCamZoom', storedDefaultZoom);
	end
	if curStep == 1164 then
		setProperty('scoutV.alpha', 1);
		setProperty('dad.alpha', 0);

		setProperty('scoutV.x', getProperty('dad.x') - 185);
		setProperty('scoutV.y', getProperty('dad.y') + 15);

		objectPlayAnimation('scoutV', 'winded');
	end
	if curStep == 1564 then
		triggerEvent('Play Animation', 'hey', 'bf');
		triggerEvent('Play Animation', 'yea', 'dad');
	end
	if curStep == 1792 then
		doTweenZoom('bruh', 'camGame', storedDefaultZoom + 0.1, crochet / 500, 'quadInOut');
		setProperty('defaultCamZoom', storedDefaultZoom + 0.1);

		setProperty('scoutV.alpha', 1);
		setProperty('dad.alpha', 0);
		setProperty('scoutV.x', getProperty('dad.x'));

		objectPlayAnimation('scoutV', 'not believable');
	end
	if curStep == 1824 then
		doTweenZoom('bruh', 'camGame', storedDefaultZoom, crochet / 500, 'quadInOut');
		setProperty('defaultCamZoom', storedDefaultZoom);
	end
end
