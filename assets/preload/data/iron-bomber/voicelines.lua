function onCreatePost()
	setPropertyFromClass('substates.game.GameOverSubstate', 'characterName', 'gameover/bf-death-demo');
	addCharacterToList('gameover/bf-death-demo', 'boyfriend');

	setProperty('camHUD.alpha', 0);

	makeAnimatedLuaSprite('demov1', 'voicelines/Demoman_voices_1', getProperty('dad.x') - 90, getProperty('dad.y') - 2);
	addAnimationByPrefix('demov1', 'getem', 'Demoman GET THEM ALLL', 24, false);
	addAnimationByPrefix('demov1', 'ayyy', 'Demoman Intro instancia', 24, false);
	addAnimationByPrefix('demov1', 'kablooey', 'Demoman Kablooey instancia', 24, false);
	addLuaSprite('demov1', true);
	setProperty('demov1.alpha', 0.001);
	setObjectOrder('demov1', getObjectOrder('gfGroup') + 1);

	makeAnimatedLuaSprite('demov2', 'voicelines/Demoman_voices_2', getProperty('dad.x') - 65, getProperty('dad.y'));
	addAnimationByPrefix('demov2', 'Roa trying to finish these voicelines', 'Demoman COME OOOON', 24, false);
	addAnimationByPrefix('demov2', 'its on', 'Demoman It\'s on instancia', 24, false);
	addAnimationByPrefix('demov2', 'laugh', 'Demoman laugh instancia', 24, false);
	addLuaSprite('demov2', true);
	setProperty('demov2.alpha', 0.001);
	setObjectOrder('demov2', getObjectOrder('gfGroup') + 1);

	makeAnimatedLuaSprite('kablooey', 'fortress/bg/barn1/Explosion', getProperty('dad.x') - 125, getProperty('dad.y') - 375);
	addAnimationByPrefix('kablooey', 'explode', 'Explosion instancia 1', 24, false);
	addLuaSprite('kablooey', true);
	setProperty('kablooey.alpha', 0.001);
	scaleObject('kablooey', 1.4, 1.4);

	makeLuaSpriteTextureAtlas('micThrow', 'voicelines/bfMicThrow', getProperty('boyfriend.x') + 70, getProperty('boyfriend.y') + 13);
	setProperty('micThrow.alpha', 0.0001);
	addAnimationBySymbol('micThrow', 'bf mic throw', 'bf mic attack', 24, false);
	setScrollFactor('micThrow', getProperty('boyfriend.scrollFactor.x'), getProperty('boyfriend.scrollFactor.y'));
	addLuaSprite('micThrow', false);
	setObjectOrder('micThrow', getObjectOrder('demov1'));
end

function onCountdownStarted()
	for i = 0, getProperty('strumLineNotes.length') do 
		setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
	end
end

function onSongStart()
	setProperty('dad.alpha', 0);
	setProperty('demov1.alpha', 1);
	objectPlayAnimation('demov1', 'ayyy');
end

function onGameOver()
	playSound('onDeath/demoman');
end

function onStepHit()
	if curStep == 70 then
		setProperty('boyfriend.alpha', 0);
		setProperty('micThrow.alpha', 1);
		objectPlayAnimation('micThrow', 'bf mic throw');
	end

	if curStep == 73 then
		playSound('drop');

	end
	if curStep == 96 then
		setProperty('boyfriend.alpha', 1);
		setProperty('micThrow.alpha', 0);
	end
	
	if curStep == 128 then
		setProperty('demov1.alpha', 0);
		setProperty('dad.alpha', 1);
		doTweenAlpha('camtwn', 'camHUD', 1, 0.8, 'quadinout')

		for i = 0, getProperty('strumLineNotes.length') do 
			noteTweenAlpha('twen'..i, i, 1, 0.8, 'quadinout')
		end

		setProperty('bgExplosion.alpha', 1);
		objectPlayAnimation('bgExplosion', 'explode');
	end

	if curStep == 368 then
		setProperty('demov1.alpha', 1);
		setProperty('dad.alpha', 0);
		objectPlayAnimation('demov1', 'kablooey');
		setProperty('demov1.y', getProperty('dad.x') - 175)
		setProperty('demov1.y', getProperty('dad.y') - 250)
	end

	if curStep == 384 then
		setProperty('healthP2', getProperty('healthP2') - (random(52, 56) / 100));
		setProperty('kablooey.alpha', 1);
		objectPlayAnimation('kablooey', 'explode');
	end

	if curStep == 386 then
		setProperty('demov1.alpha', 0);
		setProperty('dad.alpha', 1);
		setProperty('demov1.x', getProperty('dad.x') - 50)
		setProperty('demov1.y', getProperty('dad.y') - 50)
	end

	if curStep == 392 then
		removeLuaSprite('kablooey');
	end

	if curStep == 624 then
		setProperty('demov1.alpha', 1);
		setProperty('dad.alpha', 0);
		objectPlayAnimation('demov1', 'getem');
	end

	if curStep == 640 then
		setProperty('demov1.alpha', 0);
		setProperty('dad.alpha', 1);

		objectPlayAnimation('bgExplosion', 'explode');
	end

	if curStep == 880 then
		setProperty('demov2.alpha', 1);
		setProperty('dad.alpha', 0);
		objectPlayAnimation('demov2', 'laugh');
	end

	if curStep == 896 then
		setProperty('demov2.alpha', 0);
		setProperty('dad.alpha', 1);
		setProperty('demov2.x', getProperty('dad.x') - 100)
		setProperty('demov2.y', getProperty('dad.y') - 45)

		objectPlayAnimation('bgExplosion', 'explode');
	end

	if curStep == 1152 then
		objectPlayAnimation('bgExplosion', 'explode');
	end

	if curStep == 1400 then
		setProperty('demov2.alpha', 1);
		setProperty('dad.alpha', 0);
		objectPlayAnimation('demov2', 'its on');
	end

	if curStep == 1408 then
		setProperty('demov2.alpha', 0);
		setProperty('dad.alpha', 1);
		setProperty('demov2.x', getProperty('dad.x'))
		setProperty('demov2.y', getProperty('dad.y') - 50)

		objectPlayAnimation('bgExplosion', 'explode');
	end

	if curStep == 1648 then
		setProperty('demov2.alpha', 1);
		setProperty('dad.alpha', 0);
		objectPlayAnimation('demov2', 'Roa trying to finish these voicelines');
	end

	if curStep == 1664 then
		setProperty('demov2.alpha', 0);
		setProperty('dad.alpha', 1);

		objectPlayAnimation('bgExplosion', 'explode');
	end

	if curStep == 1792 or curStep == 1920 then
		objectPlayAnimation('bgExplosion', 'explode');
	end
end

function onUpdatePost()
	setProperty('camZooming', true);
end

function random(min, max)
	math.randomseed(os.time());
	return math.random(min, max);
end