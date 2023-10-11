function onCreate()
	setProperty('skipCountdown', true);
	preCacheVideo('greasemonkeycutscene');
end

function onCreatePost()
	switchCamerasVisible(false);
end

function onStepHit()
	if curStep == 192 then
		switchCamerasVisible(true);
	end
end

function onSongStart()
	startVideo('greasemonkeycutscene', true)
end

function switchCamerasVisible(visible)
	local alpha = 0.001;
	if visible then alpha = 1 end

	setProperty('camGame.alpha', alpha);
	setProperty('camHUD.alpha', alpha);
	setProperty('camOther.alpha', alpha);
	setPropertyFromGroup('noteCam', 0, 'alpha', alpha);
	setPropertyFromGroup('sustainCam', 0, 'alpha', alpha);
end