local prop={
		x=-350,
		y=-200,
		s=10/7,
	}
function make(tag,img,over)
	makeLuaSprite(tag,img,prop.x,prop.y)
	scaleObject(tag,prop.s,prop.s)
	addLuaSprite(tag,over)
end

function onCreate()
	make('sky0','fortress/bg/bridge/sky0',false) setScrollFactor('sky0',0.6,0.8)
	make('sky1','fortress/bg/bridge/sky1',false) setScrollFactor('sky1',0.7,0.85)
	make('sky2','fortress/bg/bridge/sky2',false) setScrollFactor('sky2',0.8,0.9)
	make('sky3','fortress/bg/bridge/sky3',false) setScrollFactor('sky3',0.9,0.95)
	
	make('floor1','fortress/bg/bridge/floor',false)
	make('floor2','fortress/bg/bridge/floor2',false)
	
	make('vig','fortress/bg/bridge/light1',true)
	make('mult','fortress/bg/bridge/light2',true) setBlendMode('mult','multiply')
	make('add','fortress/bg/bridge/light3',true) setBlendMode('add','add')
	
    makeLuaSprite('scout', 'cards/Force-a-nature', 0, 0)
    setObjectCamera('scout','camOther')
    scaleObject('scout', 0.67, 0.67)
end