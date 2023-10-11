local dead = false;
local musictimeover = false;

function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length') - 1 do
		setPropertyFromGroup('notes', i, 'copyAlpha', false); -- KEEP THIS, ELSE THIS WON'T WORK!!!
	end

	setPropertyFromClass('substates.game.GameOverSubstate', 'characterName', 'gameover/bf-death-spy');
	addCharacterToList('gameover/bf-death-spy', 'boyfriend');

	makeAnimatedLuaSprite('spy', 'characters/gameover/spykill', getProperty('dad.x') - 10, getProperty('dad.y') - 20);
	addAnimationByPrefix('spy', 'death', 'Spy killer0', 24, false);
	addLuaSprite('spy', true)

	setObjectOrder('spy', getObjectOrder('boyfriendGroup') - 1);
	setProperty('spy.alpha', 0);
	setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 1);
end

function onUpdatePost(elapsed)
	if curStep > 1464 and curStep < 1744 then
    	for i = 0, getProperty('notes.length') - 1 do
        	strumTime = getPropertyFromGroup('notes', i, 'strumTime');

			if (not getPropertyFromGroup('notes', i, 'ignoreNote')) then
        		if (strumTime - getSongPosition()) < 100 then
            		setPropertyFromGroup('notes', i, 'alpha', 0);
        		elseif (strumTime - getSongPosition()) < 500 then
            		setPropertyFromGroup('notes', i, 'alpha', (strumTime - getSongPosition() - 100) / 200);
        		end
			end
    	end
	end
end

function onGameOver()
	if not dead then
		setProperty('dad.visible', false);
		deathpos = getPropertyFromClass('Conductor', 'songPosition')
		setProperty('canPause', false);
		setProperty('boyfriend.stunned', true);
		setProperty('boyfriend.animation.curAnim.looped', true);
		for i = 0, getProperty('strumLineNotes.length')-1 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0);
		end
		setProperty('camHUD.alpha', 0)
		setProperty('spy.alpha', 1);
		objectPlayAnimation('spy', 'death', true);
		runTimer('die', 1.45)
		runTimer('move', 0.6)
		setPropertyFromClass('Conductor', 'songPosition', deathpos) 
		setPropertyFromClass('flixel.FlxG', 'sound.music.time', deathpos)
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0);
		setProperty('vocals.time', deathpos)
		dead = true;
	end
	return Function_Stop;
end

function onTimerCompleted(tag)
	if tag == 'move' then
		setProperty('spy.x', getProperty('dad.x') + 260)
	end
	if tag == 'die' then
		setProperty('boyfriend.visible', false);
		setObjectCamera('blackOverlay', 'game');
		setScrollFactor('blackOverlay', 0, 0);
		setBlendMode('blackOverlay', 'alpha');

		setProperty('blackOverlay.alpha', 1);
		setProperty('blackOverlay.scale.x', 5);
		setProperty('blackOverlay.scale.y', 5);
		doDeath(false, true);
	end
end