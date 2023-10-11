local gainHealth = true;
local stun = false;
local hit = false;


local lockedHealth = 0;
local toScroll = 0.5; 
local strunScroll = 0;
local inactiveAlpha = 0.4;
local preScollDuration = 8;
local scrollDownDuration = 5;
local speedMulti = -0.45;

local beatToNextSlow = nil;

local checkForCopyY = true;

function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bonk Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'fortress/noteassets/notetypes/NOTE_bonk');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end
	stunScroll = scrollSpeed;
	if downscroll then speedMulti = speedMulti * -1 end
end

function onUpdatePost(dt)
	if stun then
		if stunScroll > toScroll + 0.05 then
			stunScroll = lerp(stunScroll, toScroll, dt * 5);
		end
	else 
		if stunScroll < scrollSpeed - 0.05 then
			stunScroll = lerp(stunScroll, scrollSpeed, dt * 5);
		end
	end

	if checkForCopyY then
		for i = 0, getProperty('notes.length')-1 do 
			if not getPropertyFromGroup('notes', i, 'copyY') then
				slowedNotePos(i);
			end
		end
	end
end

function slowedNotePos(id)
	local defaultDistance = speedMulti * (getSongPosition() - getPropertyFromGroup('notes', id, 'strumTime'));
	local noteData = getPropertyFromGroup('notes', id, 'noteData');

	setPropertyFromGroup('notes', id, 'y', getPropertyFromGroup('playerStrums', noteData, 'y') + (defaultDistance * stunScroll));

	if stunScroll >= scrollSpeed - 0.05 then
		setPropertyFromGroup('notes', id, 'copyY', true);
	elseif getPropertyFromGroup('notes', id, 'wasGoodHit') and getPropertyFromGroup('notes', id, 'isSustainNote') then
		removeFromGroup('notes', id); -- Fucking sustain clip fix for now lmao - heat
	end
end

function lerp(a, b, ratio) 
	return a + ratio * (b - a) 
end

function preScrollDown(duration)
	gainHealth = false;
	lockedHealth = getProperty('healthP1');
	playSound('drink');
	switchBonkNotes(false);

	local preScrollSeconds = duration * 1000;
	beatToNextSlow = curBeat + math.floor(preScrollSeconds / crochet);
	beatToNextSlow = beatToNextSlow + (4 - (beatToNextSlow % 4));
	--while not beatToNextSlow % 4 == 0 do 
	--beatToNextSlow = beatToNextSlow - 1; 
	--end
end

function switchBonkNotes(active)
	local alpha = inactiveAlpha;
	for i = 0, getProperty('notes.length') do 
		if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == 'Bonk Note' then
			setPropertyFromGroup('notes', i, 'alpha', alpha);
			setPropertyFromGroup('notes', i, 'stunlocked', not active);
			setPropertyFromGroup('notes', i, 'copyAlpha', active);
		end
	end

	for i = 0, getProperty('unspawnNotes.length') do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bonk Note' then
			setPropertyFromGroup('unspawnNotes', i, 'alpha', alpha);
			setPropertyFromGroup('unspawnNotes', i, 'stunlocked', not active);
			setPropertyFromGroup('unspawnNotes', i, 'copyAlpha', active);
		end
	end
end

function doScrollDown()
	stun = true;
	for i = 0, getProperty('notes.length') do 
		if getPropertyFromGroup('notes', i, 'mustPress') then
			setPropertyFromGroup('notes', i, 'copyY', false);
		end
	end

	for i = 0, getProperty('unspawnNotes.length') do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then 
			setPropertyFromGroup('unspawnNotes', i, 'copyY', false);
		end
	end
	playSound('stunScunt');
	runTimer('seduce', scrollDownDuration);
end

function onBeatHit()
	if curBeat >= beatToNextSlow then
		doScrollDown();
		beatToNextSlow = nil;
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Bonk Note' and not hit then
		hit = true;
		preScrollDown(preScollDuration);
	end

	if not gainHealth then
		if lockedHealth < 0.09 then
			lockedHealth = 0.09;
		end
		setProperty('healthP1', lockedHealth);
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if not gainHealth then
		lockedHealth = lockedHealth - getPropertyFromGroup('notes', id, 'missHealth');
	end
end

function opponentNoteHit()
	if not gainHealth then
		lockedHealth = lockedHealth - getProperty('opponentNoteDamage');
	end
end

function onEvent(tag, val1, val2, val3) 
	if tag == 'disableCopyYCheck' then -- beacause I apparently CAN'T just do checkForCopyY = val1??? - heat
		checkForCopyY = false; 
	end
	if tag == 'enableCopyYCheck' then
		checkForCopyY = true; 
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'seduce' then
		stun = false;
		hit = false;
		gainHealth = true;
		switchBonkNotes(true);
	end
end