local curpage=1
local startsong=false
local conv=1280/1920
local talkin=true
local talklen=0.03
local talksound='dialogue'
local cock=0

function port(img,pref,x,y)
	makeAnimatedLuaSprite('diaport','ui/ports/'..img,x,y)
	addAnimationByPrefix('diaport','talk',pref,24,false)
	setObjectCamera('diaport','other')
	scaleObject('diaport',conv,conv)
	addLuaSprite('diaport',true)
	objectPlayAnimation('diaport','talk',true)
end

function box(col,dir)
	objectPlayAnimation('box',col,true) setProperty('box.flipX',dir)
end

--formatting: {text,event}
local dialogue={
		{
			'Alright who the hell let the freakin comicon nerds play dress up in the middle of a warzone?',
			function() port('scout','talk',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'Bop!',
			function() port('bf_new','bf_normal',845,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Yeah it was pretty easy actually. You can literally just walk right in.',
			function() port('gf','talk',845,100) box('red',true) talksound='text/gfText' end,
		},
		{
			'...',
			function() 
				port('scout','talk',45,100) box('red',false) 
				talklen=0.3
				talksound='text/scoutText'
			end,
		},
		{
			'I suppose you two chuckleheads have a point, this place ain`t exactly a fortress.',
			function() 
				port('scout','talk',45,100) box('red',false) 
				talklen=0.03 
				talksound='text/scoutText'
			end,
		},
		{
			'But, do you got a freakin death wish!? You two dough for brains are just askin to get hurt!',
			function() port('scout','alt',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'Rap battles.',
			function() port('bf_new','bf_silly',845,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'What?',
			function() port('scout','talk',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'You heard me.',
			function() port('bf_new','bf_normal',845,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'That`s what he said.',
			function() port('gf','talk',845,100) box('red',true) talksound='text/gfText' end,
		},
		{
			'Listen kid, as much as I`d love to humor the two of yous and join in on your little karaoke session-',
			function() port('scout','talk',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'Cut the crap. Don`t tell me you`re really afraid of rapping another scout?',
			function() 
				port('bf_new','bf_normal',845,100) box('blu',true)
				talksound='text/boyfriendText'
				--[[
				setProperty('speech.scale.x',1.05)
				setProperty('speech.scale.y',0.95)
				doTweenX('speechX','speech.scale',1,1,'circOut')
				doTweenY('speechY','speech.scale',1,1,'circOut')
				setProperty('speechShad.scale.x',1.05)
				setProperty('speechShad.scale.y',0.95)
				doTweenX('speechShadX','speechShad.scale',1,1,'circOut')
				doTweenY('speechShadY','speechShad.scale',1,1,'circOut')
				]]--
			end,
		},
		{
			'Yeah, what`s the matter? Afraid you`ll be replaced by my bf whose dick is twice as tall as you?',
			function() port('gf','talk',845,100) box('red',true) talksound='text/gfText' end,
		},
		{
			'Oh, I see...',
			function() 
				port('scout','talk',45,100) box('red',false) 
				talklen=0.05
				talksound='text/scoutText'
			end,
		},
		{
			'Fine kid. You`re on! But don`t go crying to your girl when I give you a good old Boston Beatdown!',
			function() 
				port('scout','alt',45,100) box('red',false) 
				talklen=0.03
				talksound='text/scoutText'
			end,
		},
	}

function onInit()
	
end

function onCreatePost()
	if isStoryMode then
		makeLuaSprite('blur','ui/2fortblur',0,0)
		setObjectCamera('blur','other')
		scaleObject('blur',conv,conv)
		addLuaSprite('blur',true)
		
		makeLuaSprite('dark','ui/dark',0,0)
		setObjectCamera('dark','other')
		scaleObject('dark',conv,conv)
		addLuaSprite('dark',true)
		
		makeLuaSprite('bars','ui/bars',0,0)
		setObjectCamera('bars','other')
		scaleObject('bars',conv,conv)
		addLuaSprite('bars',true)
		
		makeAnimatedLuaSprite('box','ui/diabox',0,540*conv)
		setObjectCamera('box','other')
		scaleObject('box',conv,conv)
		addAnimationByPrefix('box','red','red',24,false)
		addAnimationByPrefix('box','blu','blu',24,false)
		addLuaSprite('box',true)
		
		makeLuaText('speech',dialogue[curpage][1],970,0,495)
		setObjectCamera('speech','other')
		setTextSize('speech',48)
		screenCenter('speech','x')
		setTextColor('speech','FFFFF0')
		addLuaText('speech')
		
		makeLuaText('speechShad',dialogue[curpage][1],970,0,495)
		setObjectCamera('speechShad','other')
		setTextSize('speechShad',48)
		screenCenter('speechShad','x')
		setProperty('speechShad.offset.x',-2)
		setProperty('speechShad.offset.y',-2)
		setProperty('speechShad.alpha',0.5)
		setTextColor('speechShad', '000000')
		addLuaText('speechShad')
		
		setTextFont('speech','TF2secondary.ttf')
		setTextFont('speechShad','TF2secondary.ttf')
		setTextAlignment('speech','left')
		setTextAlignment('speechShad','left')
		setTextBorder('speech', 0, '000000')
		setTextBorder('speechShad', 0, '000000')
		
		makeLuaText('hint','Press ESC to skip',300,16,24)
		setObjectCamera('hint','other')
		setTextSize('hint',32)
		setTextColor('hint','FFFFF0')
		setTextAlignment('hint','left')
		setTextFont('hint','TF2secondary.ttf')
		setTextBorder('hint', 0, '000000')
		setProperty('hint.alpha',0.25)
		addLuaText('hint')
		
		setObjectOrder('blur',1)
		setObjectOrder('dark',2)
		setObjectOrder('bars',3)
		setObjectOrder('box', 4)
		setObjectOrder('speechShad', 5)
		setObjectOrder('speech', 6)
		setProperty('speech.antialiasing',true)
		setProperty('speechShad.antialiasing',true)
		setProperty('hint.antialiasing',true)
		
		if dialogue[curpage][1] then setTextString('speech',dialogue[curpage][1]) setTextString('speechShad',dialogue[curpage][1]) end
		if dialogue[curpage][2] then dialogue[curpage][2]() end
		playMusic('exceptional_encounter', 1, true)
		onInit()
	end
end

function onStartCountdown()
	if not startsong and isStoryMode then
		setProperty('inCutscene', true)
		return Function_Stop;
	end
	return Function_Continue;
end

function onUpdatePost()
	if talkin==true and isStoryMode then
		if (keyJustPressed('accept') or keyJustPressed('space')) and curpage<table.maxn(dialogue) then
			curpage=curpage+1
			playSound('dialogueClose',0.3)
			cancelTimer('textlerp')
			cock=0
			if dialogue[curpage][2] then dialogue[curpage][2]() end
			if dialogue[curpage][1] then runTimer('textlerp',talklen) end
		elseif ((keyJustPressed('accept') or keyJustPressed('space')) and curpage==table.maxn(dialogue)) or keyJustPressed('back') then
			talkin=false
			makeLuaSprite('fuckoff','',0,0) makeGraphic('fuckoff',1280,720,'000000')
			setObjectCamera('fuckoff','other') addLuaSprite('fuckoff',true) setProperty('fuckoff.alpha',0)
			doTweenAlpha('fuckoff','fuckoff',1,0.5,'linear')
			soundFadeOut('',1,0)
			cancelTimer('textlerp')
		end
	end
end

function onTimerCompleted(tag)
	if tag=='textlerp' then
		cock=cock+1
		local out=string.sub(dialogue[curpage][1],1,cock)
		setTextString('speech',out)
		setTextString('speechShad',out)
		playSound(talksound,0.3)
		objectPlayAnimation('diaport','talk',false)
		if string.len(out)<string.len(dialogue[curpage][1]) then
			runTimer('textlerp',talklen)
		end
	end
end

function onTweenCompleted(tag)
	if tag=='fuckoff' then
		removeLuaSprite('blur',true)
		removeLuaSprite('dark',true)
		removeLuaSprite('bars',true)
		removeLuaSprite('box',true)
		removeLuaText('speechShad',true)
		removeLuaText('speech',true)
		removeLuaText('hint',true)
		removeLuaSprite('diaport',true)
		
		startsong=true
		talkin=false
		setProperty('inCutscene', false)
		doTweenAlpha('fuckoff2','fuckoff',0,0.5,'linear')
		startCountdown()
	end
end