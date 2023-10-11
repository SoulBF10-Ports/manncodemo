local cash = 0;

function onCreate()
	setProperty('part2', true);
	setProperty('curRouteSuffix', 'merc');
	addCharacterToList('mercenary', 'dad');

	makeLuaSprite('cashLogo', 'fortress/bg/classics/money', 490, 556);
	setObjectCamera('cashLogo', 'hud');
	addLuaSprite('cashLogo');

	makeLuaText('cashCounter', '$0/$1000', 300, 605, 585);
	setTextSize('cashCounter', 44);
	setTextFont('cashCounter', 'tf2build');
	setProperty('cashCounter.alignment', 'left');
	setProperty('cashCounter.color', 0x85bb65);
	addLuaText('cashCounter');

	if downscroll then
		setProperty('cashCounter.y', getProperty('cashCounter.y') - 500);
		setProperty('cashLogo.y', getProperty('cashLogo.y') - 500);
	end 
end

function onCreatePost()
	loadSongRoute('merc');
	loadSongRoute('civvie');
end

function lerp(a, b, t) 
	return a * (1 - t) + b * t 
end

function onUpdate(dt)
	local mult = lerp(1, getProperty('cashCounter.scale.x'), 1 - (dt * 6));
	setProperty('cashLogo.scale.x', mult);
	setProperty('cashLogo.scale.y', mult);
	setProperty('cashCounter.scale.x', mult);
	setProperty('cashCounter.scale.y', mult);
end

function onEndSong()
	runHaxeCode([[
		if (!FlxG.save.data.playedSongs.contains('classics' + game.curRouteSuffix)) {
			FlxG.save.data.playedSongs.push('classics' + game.curRouteSuffix);
			FlxG.save.flush();
		}
	]])
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Cash Note' then
		setProperty('cashCounter.scale.x', 1.2);
		setProperty('cashCounter.scale.y', 1.2);
		setProperty('cashLogo.scale.x', 1.2);
		setProperty('cashLogo.scale.y', 1.2);

		math.randomseed(getSongPosition());
		cash = cash + (math.random(50, 100) / 100);

		setProperty('cashCounter.text', string.format("$%d/$1000", cash * 100))
		if cash >= 10 and getProperty('curRouteSuffix') ~= 'civvie' then
			doTweenAlpha('logoAwayTween', 'cashLogo', 0, crochet / 1000);
			doTweenAlpha('counterAwayTween', 'cashCounter', 0, crochet / 1000);
			setProperty('curRouteSuffix', 'civvie');
			for i = 0, getProperty('unspawnNotes.length') do
				if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Cash Note' then
					removeFromGroup('unspawnNotes', i);
				end
			end

			for i = 0, getProperty('notes.length') do
				if getPropertyFromGroup('notes', i, 'noteType') == 'Cash Note' then
					removeFromGroup('notes', i);
				end
			end
		end
	end
end
