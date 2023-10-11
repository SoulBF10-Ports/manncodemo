function onCreate()
	-- background shit
	makeLuaSprite('soldierHalf', 'fortress/bg/grease/greasemigga', 0, 0);
	setScrollFactor('soldierHalf', 1, 1);
	scaleObject('soldierHalf', 1, 1);
	addLuaSprite('soldierHalf', false);

	makeAnimatedLuaSprite('greaseHalf', 'fortress/bg/grease/bolt', 0, -50);
	setScrollFactor('greaseHalf', 1, 1);
	scaleObject('greaseHalf', 1, 1);
	addAnimationByPrefix('greaseHalf', 'idle', 'bolt', 24, true);
	objectPlayAnimation('greaseHalf', 'idle');
	addLuaSprite('greaseHalf', false);
	setObjectOrder('greaseHalf', getObjectOrder('dadGroup') + 1);
	setObjectOrder('boyfriendGroup', getObjectOrder('dadGroup') + 2);
end

function onCreatePost()
	setProperty('gf.visible', false);
	setProperty('camCanMove', true);
end