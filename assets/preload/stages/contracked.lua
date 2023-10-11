function onCreatePost()
	-- background shit
	makeLuaSprite('bg1', 'fortress/bg/contracked/layer7', 0, 0);
	addLuaSprite('bg1', false);
	makeLuaSprite('bg2', 'fortress/bg/contracked/layer6', 0, 0);
	addLuaSprite('bg2', false);
	makeLuaSprite('bg3', 'fortress/bg/contracked/layer5', 0, 0);
	addLuaSprite('bg3', false);

	makeLuaSprite('crate', 'fortress/bg/contracked/crates', getProperty('dad.x') - 50, getProperty('dad.y') + getProperty('dad.frameHeight') + 115);
	setProperty('crate.flipX', false);
	addLuaSprite('crate', false);

	--makeLuaSprite('bg4', 'fortress/bg/contracked/layer4', 0, 0);
	--addLuaSprite('bg4', true);
	makeLuaSprite('bg5', 'fortress/bg/contracked/layer3', 0, 0);
	addLuaSprite('bg5', true);

	makeLuaSprite('mult1', 'fortress/bg/contracked/layer2', 0, 0);
	addLuaSprite('mult1', true);
	makeLuaSprite('add1', 'fortress/bg/contracked/layer1', 0, 0);
	addLuaSprite('add1', true);

	makeLuaSprite('mult2', 'fortress/bg/contracked/layer2_phase2', 0, 0);
	addLuaSprite('mult2', true);
	makeLuaSprite('add2', 'fortress/bg/contracked/layer1_phase2', 0, 0);
	addLuaSprite('add2', true);

	setProperty('add2.alpha', 0.0001);
	setProperty('mult2.alpha', 0.0001);

	for i = 1, 5 do scaleObject('bg'..i, 1.25, 1.25); end

	for i = 1, 2 do 
		setBlendMode('add'..i, 'add');  
		setBlendMode('mult'..i, 'multiply'); 
		scaleObject('add'..i, 1.25, 1.25); 
		scaleObject('mult'..i, 1.25, 1.25); 
	end


	makeLuaSprite('overlay', 'fortress/bg/contracked/layer0', 0, 0);
	setObjectCamera('overlay', 'hud');
	scaleObject('overlay', 0.67, 0.67);
	addLuaSprite('overlay', true);

	setObjectOrder('gfGroup', getObjectOrder('bg2'));
end