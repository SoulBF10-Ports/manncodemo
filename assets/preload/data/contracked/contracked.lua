
local storedDefaultZoom = 0; 
local dadZoom = 0;
local gfZoom = 0;
local bfZoom = 0;

local trackedGfHp = 0;

local dead = false;

function onCreatePost()
	storedDefaultZoom = getProperty('defaultCamZoom');

	dadZoom = storedDefaultZoom + 0.2;
	gfZoom = storedDefaultZoom - 0.1;
	bfZoom = storedDefaultZoom + 0.05;

	setPropertyFromGroup('noteCam', 0, 'alpha', 0.78);
	setPropertyFromGroup('sustainCam', 0, 'alpha', 0.78);

	addCharacterToList('gameover/bf-death-contracked', 'bf');
	setPropertyFromClass('substates.game.GameOverSubstate', 'characterName', 'gameover/bf-death-contracked');
	setPropertyFromClass('substates.game.GameOverSubstate', 'loopSoundName', 'Game Over/contracked');
end

function onBeatHit()
	if curBeat % 4 == 0 then
		local currentZoom = zoomSectionCheck(bfZoom, dadZoom, gfZoom);
		setProperty('defaultCamZoom', currentZoom);
	end
end

function onUpdatePost()
	setProperty('camZooming', true);
end

function zoomSectionCheck(playerZoom, opponentZoom, gfZoom)
	local zoom = 0;
	if mustHitSection then
		zoom = playerZoom; 
	else
		zoom = opponentZoom;
	end

	if gfSection then
		zoom = gfZoom;
	end
		
	return zoom
end

function onCountdownStarted()
	for i = 0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums', i, 'x', _G['defaultPlayerStrumX'..i]);
		setPropertyFromGroup('playerStrums', i, 'x', _G['defaultOpponentStrumX'..i]);
	end
end

function onGameOver()
	if not dead then
		setProperty('canPause', false);
		setProperty('boyfriend.stunned', true);
		setProperty('boyfriend.animation.curAnim.looped', false);
		
		for i = 0, getProperty('strumLineNotes.length')-1 do
			noteTweenAlpha('noteTwn'..i, i, 0, 1, 'quadInOut');
		end
		doTweenAlpha('nuh uh', 'camHUD', 0, 2, 'quadInOut');
		doTweenPlaybackSpeed('dead', 0, 2, 'quadInOut');

		dead = true;
	end
	return Function_Stop;
end

function onTweenCompleted(tag)
	if tag == 'dead' then
		setProperty('boyfriend.visible', false);
		setObjectCamera('blackOverlay', 'game');
		setScrollFactor('blackOverlay', 0, 0);
		setBlendMode('blackOverlay', 'alpha');

		setProperty('blackOverlay.alpha', 0.6);
		setProperty('blackOverlay.scale.x', 5);
		setProperty('blackOverlay.scale.y', 5);

		doDeath(false, true);
	end
end

function onStepHit()
	if curStep == 896 then
		for i = 0, getProperty('strumLineNotes.length')-1 do
			noteTweenAlpha('noteTwn'..i, i, 0, 1, 'quadInOut');
		end

		doTweenAlpha('tweenAdd2', 'add2', 1, crochet / 2000)
		setProperty('mult1.alpha', 0);
		setProperty('mult2.alpha', 1);

		doTweenAlpha('hudtwn', 'camHUD', 0, 0.8);
		doTweenY('thingy', 'bg2', getProperty('bg2.y') - 1000, 4);
		doTweenAngle('thingy2', 'bg2', 7, 4);
	end

	if curStep == 1008 then
		for i = 0, getProperty('opponentStrums.length')-1 do
			setPropertyFromGroup('gfStrums', i, 'x', _G['defaultOpponentStrumX'..i]);
			setPropertyFromGroup('opponentStrums', i, 'x', _G['defaultPlayerStrumX'..i] + 600);
			setPropertyFromGroup('playerStrums', i, 'x', _G['defaultPlayerStrumX'..i]);
		end

		gfZoom = storedDefaultZoom + 0.25;

		for i = 0, getProperty('strumLineNotes.length')-1 do
			noteTweenAlpha('noteTwn'..i, i, 1, 1, 'quadInOut');
		end

		doTweenAlpha('hudtwn', 'camHUD', 1, 0.8);

		local maxGfHp = getProperty('gf.charHealth');
		reloadHealthBar('dad', 'demo', maxGfHp, maxGfHp, 'demo', -35, -100, false);
	end
	if curStep == 1660 then
		for i = 0, getProperty('playerStrums.length')-1 do
			noteTweenX('twn2'..i, i+4, _G['defaultOpponentStrumX'..i], crochet / 500, 'elasticinout')
			noteTweenX('twn3'..i, i+8, -500 + (105*i), crochet / 1000, 'quadinout')
		end
	end
	if curStep == 1724 then
		for i = 0, getProperty('opponentStrums.length')-1 do
			noteTweenX('twn'..i, i, _G['defaultPlayerStrumX'..i], crochet / 500, 'quadinout')
		end
		trackedGfHp = getProperty('healthP2');
		local maxDadHp = getProperty('dad.charHealth');
		reloadHealthBar('dad', 'pauling', maxDadHp, maxDadHp, 'pauling', 0, -80, true);
	end
	if curStep == 1728 then
		doTweenAlpha('tweenAdd2', 'add2', 0, crochet / 2000)
		setProperty('mult1.alpha', 1);
		setProperty('mult2.alpha', 0);
	end
	if curStep == 1840 then
		doTweenAlpha('tweenAdd2', 'add2', 1, crochet / 2000)
		setProperty('mult1.alpha', 0);
		setProperty('mult2.alpha', 1);
	end
	if curStep == 1852 then
		local maxGfHp = getProperty('gf.charHealth');
		reloadHealthBar('dad', 'demo', trackedGfHp, maxGfHp, 'demo', -35, -100, true);
	end
	if curStep == 1856 then
		for i = 0, getProperty('playerStrums.length')-1 do
			noteTweenX('twn'..i, i, getPropertyFromGroup('opponentStrums', i, 'x') + 100 - (10*i), crochet / 1000, 'quadinout')
			noteTweenX('twn2'..i, i+4, getPropertyFromGroup('playerStrums', i, 'x') + 330 - (10*i), crochet / 1000, 'quadinout') 
			noteTweenX('twn3'..i, i+8, getPropertyFromGroup('gfStrums', i, 'x') + 500, crochet / 500, 'quadinout') 
		end

		reloadStoredZoom(-0.18);
		local currentZoom = zoomSectionCheck(bfZoom, dadZoom, gfZoom);
		setProperty('defaultCamZoom', currentZoom);
		triggerEvent('Camera Follow Pos', 1300, 800);	
	end
	if curStep == 1920 then
		for i = 0, getProperty('playerStrums.length')-1 do
			noteTweenX('twn'..i, i, getPropertyFromGroup('opponentStrums', i, 'x') + 500, crochet / 200, 'quadinout')
			noteTweenX('twn3'..i, i+8, getPropertyFromGroup('gfStrums', i, 'x') - 500, crochet / 200, 'quadinout') 
		end
		for i = 0, getProperty('strumLineNotes.length')-1 do
			noteTweenAlpha('twn4'..i, i, 0, crochet / 125, 'quadinout')
		end
	end

	if curStep == 1904 then
		reloadStoredZoom(0.25);
		local currentZoom = zoomSectionCheck(bfZoom, dadZoom, gfZoom);
		setProperty('defaultCamZoom', currentZoom);
	end
end

function reloadStoredZoom(diff)
	storedDefaultZoom = storedDefaultZoom + diff; 
	dadZoom = storedDefaultZoom + 0.2;
	gfZoom = storedDefaultZoom - 0.1;
	bfZoom = storedDefaultZoom + 0.05;
end