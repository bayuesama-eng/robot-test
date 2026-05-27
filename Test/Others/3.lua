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
		return CGetBallX()-90
	end
end
local BallPosY = function()
	return function()
		return CGetBallY()+70
	end
end
local RY = function()
	return function()
		local res
		if CGetBallY()>=0 then
			res = 35
		else
			res =-35
		end
		return res
	end
end
local TY = function()
	return function()
		local res
		if CGetBallY()>=0 then
			res = 148
		else
			res =-148
		end
		return res
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
		if CBall2RoleDist("Kicker")<25 and CRole2TargetDist("Receiver")<5 then
			return "passball"
		end
	end,
	Kicker  = task.KickerTask("getBall2"),
	Receiver = task.ReceiverTask("wait2"),
},

["passball"] = {
	switch = function()
		if CBall2RoleDist("Kicker")>35 and CBall2RoleDist("Kicker")<600 then
			return "receive"
		end
	end,
	Kicker   = task.KickerTask("passball2"),
	Receiver = task.GotoPos("Receiver",RobotPosX("Receiver"),RobotPosY("Receiver"),Receiver2Balldir()),
},
["receive"] = {
	switch = function()
		if Cbuf_cnt(CBall2RoleDist("Receiver")<15,10)  then
			return "shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),Kicker2Balldir()),
	Receiver = task.ReceiverTask("receive"),
},
["shoot"] = {
	switch = function()
		--if Cbuf_cnt(CBall2RoleDist("Receiver")<12,20)  then
			return "shoot"
		--end
	end,
	Kicker   = task.GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),Kicker2Balldir()),
	Receiver = task.ReceiverTask("canShoot"),
},
name = "3"
}
