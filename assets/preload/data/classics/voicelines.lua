local storedDefaultZoom = 0;
function onCreatePost()
	storedDefaultZoom = getProperty('defaultCamZoom');

	makeAnimatedLuaSprite('mercBG', 'fortress/bg/classics/mercvan', 1785, 450);
	addAnimationByPrefix('mercBG', 'idle', 'idle van0', 24, true);
	addAnimationByPrefix('mercBG', 'idle-alt', 'idle van angry0', 24, true);
	addAnimationByPrefix('mercBG', 'jump', 'idle van jump0', 24, false);
	addAnimationByPrefix('mercBG', 'no', 'voice 10', 24, false);
	addLuaSprite('mercBG', false)
	scaleObject('mercBG', 1.7, 1.7);

	makeAnimatedLuaSprite('merc', 'voicelines/mercenary_VA', getProperty('dad.x') + 225, getProperty('dad.y') - 200);
	addAnimationByPrefix('merc', 'jump', 'jump in0', 12, false);
	addAnimationByPrefix('merc', 'voice1', 'voice 10', 24, false);
	addAnimationByPrefix('merc', 'voice2', 'voice 20', 24, false);
	addAnimationByPrefix('merc', 'voice3', 'voice 30', 24, false);
	addAnimationByPrefix('merc', 'voice4', 'voice 40', 24, false);
	addAnimationByPrefix('merc', 'voice5', 'voice 50', 24, false);
	addAnimationByPrefix('merc', 'voice6', 'voice 60', 24, false);
	addAnimationByPrefix('merc', 'voice7', 'voice 70', 24, false);
	addLuaSprite('merc', true)

	makeAnimatedLuaSprite('civvie', 'voicelines/civi_VA', getProperty('dad.x'), getProperty('dad.y'));
	addAnimationByPrefix('civvie', 'voice1', 'voice 1 classic 10', 24, false);
	addAnimationByPrefix('civvie', 'voice2', 'voice 20', 24, false);
	addAnimationByPrefix('civvie', 'voice3', 'voice 30', 24, false);
	addAnimationByPrefix('civvie', 'voice4', 'voice 40', 24, false);
	addAnimationByPrefix('civvie', 'voice5', 'voice 50', 24, false);
	addAnimationByPrefix('civvie', 'voice6', 'voice classic 1 20', 24, false);
	addAnimationByPrefix('civvie', 'voice7', 'voice classic 2 10', 24, false);
	addAnimationByPrefix('civvie', 'voice8', 'voice og0', 24, false);
	addAnimationByPrefix('civvie', 'voice9', 'voice 1 3', 24, false);
	addLuaSprite('civvie', true);

	makeAnimatedLuaSprite('civvieIdleClone', 'characters/civvie', getProperty('dad.x'), getProperty('dad.y') - 10);
	addAnimationByPrefix('civvieIdleClone', 'idle', 'idle', 24, true);
	setProperty('civvieIdleClone.visible', false);
	addLuaSprite('civvieIdleClone', false);

	makeAnimatedLuaSprite('civvie2', 'voicelines/voice_1_4', getProperty('dad.x') - 80, getProperty('dad.y') - 50);
	addAnimationByPrefix('civvie2', 'voice1', 'voice 1 40', 24, false);
	addLuaSprite('civvie2', true)
	
	setObjectOrder('merc', getObjectOrder('dadGroup') - 1)
	setObjectOrder('civvie', getObjectOrder('boyfriendGroup') + 1);
	setObjectOrder('civvie2', getObjectOrder('merc') + 1);
	setObjectOrder('gfGroup', getObjectOrder('civvie2') + 1);
	setObjectOrder('dadGroup', getObjectOrder('gfGroup') + 1);
	setObjectOrder('civvieIdleClone', getObjectOrder('dadGroup') + 1);
	
	setProperty('civvie.alpha', 0.0001);
	setProperty('civvie2.alpha', 0.00001);
	objectPlayAnimation('mercBG', 'idle', true);
	setProperty('merc.alpha', 0.0001);
end


function onStepHit()
	local part2Initialized = getProperty('part2Initialized');
	local routeSuffix = getProperty('curRouteSuffix');
	if routeSuffix == 'civvie' and part2Initialized then
		if curStep == 3 then
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);

			objectPlayAnimation('civvie', 'voice1', true);
			setProperty('civvie.offset.x', -5)
			setProperty('civvie.offset.y', -2)

			objectPlayAnimation('mercBG', 'idle-alt', true);
			setProperty('mercBG.offset.x', -80)
			setProperty('mercBG.offset.y', -95)
		elseif curStep == 16 then 
			setProperty('civvie.alpha', 0);
			setProperty('dad.alpha', 1);

			doTweenAlpha('txtfadein', 'timeTxt', 1, 1, 'quadInOut');
			doTweenAlpha('piefadein', 'timePie', 1, 1, 'quadInOut');
			doTweenAlpha('piebgfadein', 'timePieBG', 1, 1, 'quadinout');
		elseif curStep == 128 then
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);

			objectPlayAnimation('civvie', 'voice6');
			setProperty('civvie.offset.x', 39);
			setProperty('civvie.offset.y', 35);
		elseif curStep == 144 then
			setProperty('civvie.alpha', 0);
			setProperty('dad.alpha', 1);
		elseif curStep == 264 then
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);

			objectPlayAnimation('civvie', 'voice9');
			setProperty('civvie.offset.x', -30);
			setProperty('civvie.offset.y', -7);
		elseif curStep == 272 then 
			setProperty('dad.alpha', 1);
			setProperty('civvie.alpha', 0);
		elseif curStep == 416 then 
			setProperty('dad.alpha', 0);
			setProperty('civvie2.alpha', 1);
			objectPlayAnimation('civvie2', 'voice1', true);
			setProperty('civvie.offset.x', 39);
			setProperty('civvie.offset.y', 70);
		end
	elseif routeSuffix == 'merc' and part2Initialized then
		if curStep == 1 then
			setProperty('dad.alpha', 1);
			setProperty('civvie.alpha', 0);
		elseif curStep == 16 then
			setProperty('merc.alpha', 0);
			doTweenAlpha('txtfadein', 'timeTxt', 1, 1, 'quadInOut');
			doTweenAlpha('piefadein', 'timePie', 1, 1, 'quadInOut');
			doTweenAlpha('piebgfadein', 'timePieBG', 1, 1, 'quadinout');

			if getProperty('curRouteSuffix') == 'merc' then
				cameraFlash('game', 0xFFffffff, 1);
			end
			setProperty('civvieIdleClone.visible', true);
			objectPlayAnimation('civvieIdleClone', 'idle');
			
			setProperty('civvieIdleClone.x', getProperty('civvieIdleClone.x'))
			setProperty('dad.x', 745);
			setProperty('dad.y', 410);
		elseif curStep == 134 then
			setProperty('dad.alpha', 0);
			setProperty('merc.alpha', 1);
			objectPlayAnimation('merc', 'voice2');

			setProperty('merc.offset.x', 110);
			setProperty('merc.offset.y', -60);
		elseif curStep == 144 or curStep == 272 or curStep == 400 or curStep == 528 or curStep == 656 then
			setProperty('dad.alpha', 1);
			setProperty('merc.alpha', 0);
		elseif curStep == 262 then
			setProperty('dad.alpha', 0);
			setProperty('merc.alpha', 1);
			objectPlayAnimation('merc', 'voice3');

			setProperty('merc.offset.x', -20);
			setProperty('merc.offset.y', -50);
		elseif curStep == 392 then
			setProperty('dad.alpha', 0);
			setProperty('merc.alpha', 1);
			objectPlayAnimation('merc', 'voice4');

			setProperty('merc.offset.x', 28);
			setProperty('merc.offset.y', 157);
		elseif curStep == 520 then 
			setProperty('dad.alpha', 0);
			setProperty('merc.alpha', 1);
			objectPlayAnimation('merc', 'voice5');

			setProperty('merc.offset.x', -3);
			setProperty('merc.offset.y', -50);
		elseif curStep == 650 then
			setProperty('dad.alpha', 0);
			setProperty('merc.alpha', 1);
			objectPlayAnimation('merc', 'voice6');

			setProperty('merc.offset.x', 245)
			setProperty('merc.offset.y', 0)
		elseif curStep == 795 then
			setProperty('civvieIdleClone.alpha', 0);
			setProperty('civvie.alpha', 1);
			objectPlayAnimation('civvie', 'voice7', true);

			setProperty('civvie.offset.x', 55)
			setProperty('civvie.offset.y', 50)
		end
	elseif not part2Initialized then
		if curStep == 112 then
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);
	
			objectPlayAnimation('civvie', 'voice8', true);
			setProperty('civvie.offset.x', 8)
			setProperty('civvie.offset.y', 8)
		elseif curStep == 128 then
			setProperty('civvie.alpha', 0);
			setProperty('dad.alpha', 1);
			doTweenZoom('l', 'camGame', 0.55, crochet / 500, 'quadInOut');
			setProperty('defaultCamZoom', 0.5)
		elseif curStep == 384 then 
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);
	
			objectPlayAnimation('civvie', 'voice2', true);
			setProperty('civvie.offset.x', 0)
			setProperty('civvie.offset.y', 0)

			doTweenZoom('hurry', 'camGame',storedDefaultZoom - 0.1, crochet / 350, 'quadInOut');
			setProperty('defaultCamZoom', storedDefaultZoom - 0.1);
		elseif curStep == 400 then 
			setProperty('civvie.alpha', 0);
			setProperty('dad.alpha', 1);
			doTweenZoom('hurry', 'camGame', 0.5, crochet / 350, 'quadInOut');
			setProperty('defaultCamZoom', 0.5);

		elseif curStep == 512 then
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);
	
			objectPlayAnimation('civvie', 'voice3', true);
			setProperty('civvie.offset.x', 0)
			setProperty('civvie.offset.y', 24)

			doTweenZoom('fun', 'camGame',storedDefaultZoom - 0.2, crochet / 750, 'quadInOut');
			setProperty('defaultCamZoom', storedDefaultZoom - 0.2);
		elseif curStep == 519 then
			doTweenZoom('funp', 'camGame',storedDefaultZoom - 0.1, crochet / 750, 'quadInOut');
			setProperty('defaultCamZoom', storedDefaultZoom - 0.1);
		elseif curStep == 528 then
			setProperty('civvie.alpha', 0);
			setProperty('dad.alpha', 1);

			doTweenZoom('hurry', 'camGame', 0.5, crochet / 500, 'quadInOut');
			setProperty('defaultCamZoom', 0.5);
		elseif curStep == 650 then
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);
	
			objectPlayAnimation('civvie', 'voice4', true);
			setProperty('civvie.offset.x', 2);
			setProperty('civvie.offset.y', 8);
		elseif curStep == 656 then 
			setProperty('civvie.alpha', 0);
			setProperty('dad.alpha', 1);
		elseif curStep == 912 then
			setProperty('dad.alpha', 0);
			setProperty('civvie.alpha', 1);
	
			objectPlayAnimation('civvie', 'voice5', true);
			setProperty('civvie.offset.x', 48);
			setProperty('civvie.offset.y', 35);

			doTweenAlpha('txtfadeout', 'timeTxt', 0, 1, 'quadInOut');
			doTweenAlpha('piefadeout', 'timePie', 0, 1, 'quadInOut');
			doTweenAlpha('piebgfadeout', 'timePieBG', 0, 1, 'quadinout');

			if routeSuffix == 'merc' then
				setProperty('cashCounter.color', 0xBB0000)
			end
		elseif curStep == 914 then
			if routeSuffix == 'merc' then
				objectPlayAnimation('mercBG', 'jump', true);
				setProperty('mercBG.offset.x', 70);
				setProperty('mercBG.offset.y', 1864);
			end
			doTweenAlpha('logoDisappearTween', 'cashLogo', 0, crochet / 1000);
			doTweenAlpha('counterDisappearTween', 'cashCounter', 0, crochet / 1000);
		elseif curStep == 925 then
			if routeSuffix == 'merc' then
				setProperty('merc.alpha', 1);
				setProperty('mercBG.alpha', 0);
				objectPlayAnimation('merc', 'jump', true);

				setProperty('merc.offset.y', 340);
			end
		elseif curStep == 927 then
			setProperty('civvie.alpha', 1);
			objectPlayAnimation('merc', 'voice1', true);
			setProperty('merc.offset.x', 122)
			setProperty('merc.offset.y', -30)

			if routeSuffix == 'civvie' then
				objectPlayAnimation('mercBG', 'no', true);
				setProperty('mercBG.offset.x', 25)
				setProperty('mercBG.offset.y', -95)
			end
		end
  	end
end