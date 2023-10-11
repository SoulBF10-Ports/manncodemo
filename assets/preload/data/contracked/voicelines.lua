function onCreatePost()
	makeAnimatedLuaSprite('pauling', 'voicelines/pauline_dialouge', getProperty('dad.x') - 5, getProperty('dad.y') + 180);
	addAnimationByPrefix('pauling', 'voice1', 'pauline dialouge0', 24, false);
	addAnimationByIndices('pauling','idle','pauline dialouge0','0, 1, 2, 3, 4',24)
	objectPlayAnimation('pauling', 'idle');
	addLuaSprite('pauling', true)
	setProperty('pauling.flipX', true)

	makeAnimatedLuaSprite('pauling2', 'voicelines/pauline_dialogue_2', getProperty('dad.x') - 5, getProperty('dad.y') + 180);
	addAnimationByPrefix('pauling2', 'voice1', 'pauline dialouge 20', 24, false);
	addLuaSprite('pauling2', true)
	setProperty('pauling2.flipX', true)

	makeAnimatedLuaSprite('pauling3', 'voicelines/pauline_learning', getProperty('dad.x') - 5, getProperty('dad.y') + 180);
	addAnimationByPrefix('pauling3', 'voice1', 'pauline dialouge end0', 24, false);
	addLuaSprite('pauling3', true)
	setProperty('pauling3.flipX', true)
	
	setObjectOrder('pauling3', getObjectOrder('boyfriendGroup') - 1);
	setObjectOrder('pauling2', getObjectOrder('boyfriendGroup') - 1);
	setObjectOrder('pauling', getObjectOrder('boyfriendGroup') - 1);

	setProperty('pauling2.alpha', 0.0001);
	setProperty('pauling3.alpha', 0.0001);
	setProperty('dad.alpha', 0.0001);
end

function onSongStart()
	setProperty('pauling.alpha', 1);

	objectPlayAnimation('pauling', 'voice1', true);
end

function onStepHit()
	if curStep == 50 then
		setProperty('pauling2.alpha', 1);
		setProperty('pauling.alpha', 0);
	
		objectPlayAnimation('pauling2', 'voice1', true);
	end
	if curStep == 120 then
		setProperty('pauling2.alpha', 0);
		setProperty('dad.alpha', 1);
	end
	if curStep == 1904 then
		setProperty('pauling3.alpha', 1);
		setProperty('dad.alpha', 0);

		objectPlayAnimation('pauling3', 'voice1', true);
	end
end