local dead = false;
local canRetry = false;
local deathOver = false;

function onCreate()
	preCacheVideo('greasydeath');

	makeAnimatedLuaSprite('greaseretry', 'fortress/bg/grease/gmretry', 450, -300);
	scaleObject('greaseretry', 0.4, 0.4)
	addAnimationByPrefix('greaseretry', 'intro', 'Ready? Intro0001', 0, false);
	addAnimationByPrefix('greaseretry', 'retry', 'Ready? Intro', 24, false);

	setObjectCamera('greaseretry', 'other');
	addLuaSprite('greaseretry', true);
	setProperty('greaseretry.alpha', 0);
end

function onUpdatePost(dt)
	if dead then
		if canRetry and not deathOver then
			if keyJustPressed('accept') then
				runHaxeCode([[
					FlxG.sound.play(Paths.sound('retry/grease'));
					FlxG.sound.music.stop();
				]]);

				objectPlayAnimation('greaseretry', 'retry');
				runTimer('restart', 1);
				deathOver = true;
				canRetry = false;
			end

			if keyJustPressed('back') then
				exitSong(false);
				deathOver = true;
				canRetry = false;
			end
		end
	end
end

function onCreatePost()
end

function onStepHit()

end

function onSongStart()
end

function switchCamerasVisible(visible)

end

function onFinishVideo(name)
	if name == 'greasydeath' then
		objectPlayAnimation('greaseretry', 'intro');
		doTweenAlpha('retryTwn', 'greaseretry', 1, 1.25);
		doTweenY('retryTwnY', 'greaseretry', 220, 1.25, 'quadinout');
		doTweenScaleX('retryTwnSX', 'greaseretry', 0.9, 1.75, 'quadinout');
		doTweenScaleY('retryTwnSY', 'greaseretry', 0.9, 1.75, 'quadinout');

		playMusic('greaseGameOverMusic', 'Game Over/grease', 0);
		runHaxeCode([[
			FlxG.sound.playMusic(Paths.music('Game Over/grease'));
			FlxG.sound.music.fadeIn(1.25, 0, 1);
		]]);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'restart' then
		doTweenAlpha('retryFade', 'greaseretry', 0, 2);
	end
end

function onTweenCompleted(tag)
	if tag == 'retryTwn' then
		canRetry = true;
	elseif tag == 'retryFade' then
		restartSong(false);
	end
end

function onGameOver()
	if not dead then
		setProperty('canPause', false);
		runHaxeCode(
			[[
				game.speed = 0;
			]]
		);
		startVideo('greasydeath', true);
		setProperty('blackOverlay.alpha', 1);
		setPropertyFromGroup('noteCam', 0, 'visible', false);
		setPropertyFromGroup('sustainCam', 0, 'visible', false);

		dead = true;
	end
	return Function_Stop;
end