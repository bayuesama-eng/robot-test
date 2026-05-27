-- local Kickerdir2Tierdir = function()
-- 	return COurRole2RoleDir("Kicker", "Tier")
-- end

local Receiver2Balldir = function()
	return function()
		return CRole2BallDir("Receiver")
	end
end
local Kicker2Balldir = function()
	return function()
		return CRole2BallDir("Kicker")
	end
end
local RobotPosX = function(role)
	return function()
		return COurRole_x(role)
	end
end
local RobotPosY = function(role)
	return function()
		return COurRole_y(role)
	end
end
local BallPosX = function()
	return function()
		return CGetBallX()+40
	end
end
local BallPosY = function()
	return function()
		return CGetBallY()+70
	end
end
-- local Receiver2Kickerdir = function()
-- 	return COurRole2RoleDir("Receiver", "Kicker")
-- end

-- local Kickerdir2Receiverdir = function()
-- 	return COurRole2RoleDir("Kicker", "Receiver")
-- end

-- local Tierdir2Receiverdir = function()
-- 	return COurRole2RoleDir("Tier", "Receiver")
-- end

gPlayTable.CreatePlay{
firstState = "start",

["start"] = {
	switch = function()
		if Cbuf_cnt(CBall2RoleDist("Receiver")<35,30) and CRole2TargetDist("Kicker")<3 then
			return "passball"
		end
	end,
	Receiver  = task.ReceiverTask("getBall"),
	Kicker = task.KickerTask("GoToP"),
},

["passball"] = {
	switch = function()
		if CBall2RoleDist("Receiver")>36 then
			return "receive"
		end
	end,
	Receiver  = task.ReceiverTask("passball"),
	Kicker = task.GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),Kicker2Balldir()),
},
["receive"] = {
	switch = function()
		if Cbuf_cnt(CBall2RoleDist("Kicker")<20,10) then
			return "shoot"
		end
	end,
	Receiver   = task.ReceiverTask("canShoot1"),--GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),Receiver2Balldir()),
	Kicker = task.KickerTask("receive2"),--接球后退
},
["shoot"] = {
	switch = function()
		--if Cbuf_cnt(CBall2RoleDist("Receiver")<12,20)  then
			return "shoot"
		--end
	end,
	Receiver   = task.ReceiverTask("canShoot1"),
	Kicker = task.GotoPos("Kicker",230,100,Kicker2Balldir()),
},
name = "Kick_off_A"
}