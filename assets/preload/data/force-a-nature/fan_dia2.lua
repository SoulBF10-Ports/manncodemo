local curpage=1
local seenEnd=false
local conv=1280/1920
local talkin=false
local talklen=0.03
local talksound='dialogue'
local cock=0
local enable=true

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

--[[
Scout: Un
Scout: Freakin
Scout: Believable
Scout: There's no way I just got bested my some chucklehead dressed as me and his smokin hot broad
BF: What can I say? You're washed up
Scout: Oh yeah? Let's see how washed up I am when I bash your freakin brains in!
BF: Boop
GF: Bye Now
]]--

--formatting: {text,event}
local dialogue={
		{
			'FRICKIN.',
			function() port('scout','talk',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'UNBELIEVABLE.',
			function() port('scout','talk',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'There`s no way I just got beat my some chucklehead dressed as me and his smokin hot broad.',
			function() port('scout','talk',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'What can I say? You`re washed up.',
			function() port('bf_new','bf_normal',845,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Oh yeah? \nLet`s see how washed up I am when I bash your freakin` brains in!',
			function() port('scout','talk',45,100) box('red',false) talksound='text/scoutText' end,
		},
		{
			'boop',
			function() port('bf_new','bf_silly',845,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Ok Bye Now',
			function() port('gf','alt',845,100) box('red',true) talksound='text/gfText' end,
		},
	}

function onInit()
	
end

function onEndSong()
	if isStoryMode and not seenEnd then
		setProperty('inCutscene', true)
		talkin=true
		makeLuaSprite('sup_fuckers','',0,0) makeGraphic('sup_fuckers',1280,720,'000000')
		setObjectCamera('sup_fuckers','other') addLuaSprite('sup_fuckers',true) setProperty('sup_fuckers.alpha',0)
		doTweenAlpha('initEndDialogue','sup_fuckers',1,0.5,'linear')
		return Function_Stop;
	end
	return Function_Continue;
end

function onUpdatePost()
	if talkin and isStoryMode then
		if (keyJustPressed('accept') or keyJustPressed('space')) and curpage<table.maxn(dialogue) then
			curpage=curpage+1
			playSound('dialogueClose',0.3)
			cancelTimer('textlerp_post')
			cock=0
			if dialogue[curpage][2] then dialogue[curpage][2]() end
			if dialogue[curpage][1] then runTimer('textlerp_post',talklen) end
		elseif ((keyJustPressed('accept') or keyJustPressed('space')) and curpage==table.maxn(dialogue)) or keyJustPressed('back') then
			talkin=false
			seenEnd=true
			makeLuaSprite('fuckoff','',0,0) makeGraphic('fuckoff',1280,720,'000000')
			setObjectCamera('fuckoff','other') addLuaSprite('fuckoff',true) setProperty('fuckoff.alpha',0)
			doTweenAlpha('fuckoff_end','fuckoff',1,0.5,'linear')
			soundFadeOut('',1,0)
			cancelTimer('textlerp_post')
		end
	end
end

function onTimerCompleted(tag)
	if tag=='textlerp_post' then
		cock=cock+1
		local out=string.sub(dialogue[curpage][1],1,cock)
		setTextString('speech',out)
		setTextString('speechShad',out)
		playSound(talksound,0.3)
		objectPlayAnimation('diaport','talk',false)
		if string.len(out)<string.len(dialogue[curpage][1]) then
			runTimer('textlerp_post',talklen)
		end
	end
end

function onTweenCompleted(tag)
	if tag=='fuckoff_end' then
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
		endSong()
	end
	
	if tag=='initEndDialogue' then
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
		
		--setObjectOrder('sup_fuckers',1)
		setObjectOrder('blur',2)
		setObjectOrder('dark',3)
		setObjectOrder('bars',4)
		setObjectOrder('box', 5)
		setObjectOrder('speechShad', 6)
		setObjectOrder('speech', 7)
		
		setProperty('speech.antialiasing',true)
		setProperty('speechShad.antialiasing',true)
		setProperty('hint.antialiasing',true)
		
		if dialogue[curpage][1] then setTextString('speech',dialogue[curpage][1]) setTextString('speechShad',dialogue[curpage][1]) end
		if dialogue[curpage][2] then dialogue[curpage][2]() end
		playMusic('exceptional_encounter', 1, true)
		onInit()
		setObjectOrder('sup_fuckers',getObjectOrder('diaport')+1)
		doTweenAlpha('sup_fuckers_fade','sup_fuckers',0,0.5,'linear')
	end
end