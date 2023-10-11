local prop={
	x=-500,
	y=-375,
	s=100/75,
	
	dad={0,250},
	gf={450,-150},
	bf={1050,150},
}

function make(tag,img,over)
	makeLuaSprite(tag,img,prop.x,prop.y)
	scaleObject(tag,prop.s,prop.s)
	addLuaSprite(tag,over)
end

function onCreatePost()
	make('sky','fortress/bg/barn1/sky') setScrollFactor('sky',0.7,0.7)

	makeAnimatedLuaSprite('bgExplosion', 'fortress/bg/barn1/Explosion', 250, -350);
	addAnimationByPrefix('bgExplosion', 'explode', 'Explosion instancia 1', 24, false);
	addLuaSprite('bgExplosion', false);
	setProperty('bgExplosion.alpha', 0.001);
	scaleObject('bgExplosion', 2, 2);

	make('bg','fortress/bg/barn1/ground')
	make('add0','fortress/bg/barn1/capLight',true) setBlendMode('add0','add')
	make('add1','fortress/bg/barn1/skyLight',true) setBlendMode('add1','add')
	make('mult','fortress/bg/barn1/shadows',true) setBlendMode('mult','multiply')

	setProperty('boyfriend.camOffsetX', -100);
end