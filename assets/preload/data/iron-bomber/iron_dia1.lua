local curpage=1
local startsong=false
local conv=1280/1920
local talkin=true
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
BF: Alright so twofort was a bust.
GF: Yeah, that briefcase was just full of pictures of Scout's mom.
Demo: Ayeee Laddies!
BF & GF: Oh God...
Demo: Yes you ya Blu Devil. You and yer pretty lass
BF: Ugh. Lemme guess
BF: You want to fight?
Demo: Noh ya imbecile, I wanted to see if ya wanted to get drunk and sing kereeoke with meh.
BF: Oh wait for real?
BF: Freakin finally!
BF: Someone who doesn't want to kill us
Demo: Aye! you want a sip of mah scrumpeh? 
BF: Sure!
BF takes the bottle underestimating the weight of it and it drops onto the ground shattering
Demo: Mah Scrumpeh!! You've done it now ya Blu haired freak!
Demo: When I'm done with you they're gonna have to glue you back together!
BF: Oh its on Drunk Tank! Come get some!
]]--

--formatting: {text,event}
local dialogue={
		{
			'Alright, so two-fort was a bust..',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Yeah, that briefcase was just full of pictures of Scout`s mom.',
			function() port('gf','alt',835,100) box('red',true) talksound='text/gfText' end,
		},
		{
			'Aye, laddies!',
			function() port('demo','talk',45,100) box('red',false) talksound='text/demoText' end,
		},
		{
			'Oh God...',
			function() port('gf','alt',835,100) box('red',true) talksound='text/gfText' end,
		},
		{
			'Yes you ya Blu Devil. \nYou and yer pretty lass!',
			function() port('demo','talk',45,100) box('red',false) talksound='text/demoText' end,
		},
		{
			'Ugh. Lemme guess',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'You want to fight?',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Noh ya imbecile, I wanted to see if ya wanted to get drunk and sing karoake with meh.',
			function() port('demo','talk',45,100) box('red',false) talksound='text/demoText' end,
		},
		{
			'Oh wait for real?',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Freakin finally!',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Someone who doesn`t want to kill us!',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Aye! you want a sip of mah scrumpeh? ',
			function() port('demo','talk',45,100) box('red',false) talksound='text/demoText' end,
		},
		{
			'Sure!',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Oh shit-',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
		{
			'Mah Scrumpeh!! \nYou`ve done it now ya blue haired freak!',
			function() port('demo','talk',45,100) box('red',false) talksound='text/demoText' end,
		},
		{
			'When I`m done with ye, this lass`ll have to glue you back together!',
			function() port('demo','talk',45,100) box('red',false) talksound='text/demoText' end,
		},
		{
			'Oh its on, drunk tank! Come get some!',
			function() port('bf_new','bf_normal',835,100) box('blu',true) talksound='text/boyfriendText' end,
		},
	}

function onInit()
	
end

function onCreatePost()
	if isStoryMode then
		makeLuaSprite('blur','ui/barnblur1',0,0)
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