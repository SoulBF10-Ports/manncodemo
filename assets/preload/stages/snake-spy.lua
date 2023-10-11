function onCreate()
	-- background shit
	makeLuaSprite('sky', 'fortress/bg/snake3/snakewater3_sky', -600, -375);
	setScrollFactor('sky', 0.1, 0.1);
	scaleObject('sky', 1.5, 1.5);
	
	makeLuaSprite('bg', 'fortress/bg/snake3/snakewater3_bg', -400, -175);
	setScrollFactor('bg', 0.5, 0.5);
	scaleObject('bg', 1.5, 1.5);
	
	makeLuaSprite('fg', 'fortress/bg/snake3/snakewater3_fg', -400, -175);
	setScrollFactor('fg', 1, 1);
	scaleObject('fg', 1.5, 1.5);

    addLuaSprite('sky', false);
	addLuaSprite('bg', false);
	addLuaSprite('fg', false);
end