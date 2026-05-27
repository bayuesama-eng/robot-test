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
local ff = function(role)
	return function()
		local res
		if COurRole_y(role) >0 then
			res = 150
		else
			res =-150
		end
		return res
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
		if CGetBallX() < 140 and math.abs(CGetBallY()) >90 then
			return CGetBallX()
		else
			return CGetBallX()-90
		end
	end
end
local BallPosY = function()
	return function()
		return CGetBallY()+70
	end
end

gPlayTable.CreatePlay{
firstState = "start",

["start"] = {
	switch = function()
		if CBall2RoleDist("Kicker")<25 and CRole2TargetDist("Receiver")<5 then
			return "passball"
		end
	end,
	Kicker  = task.KickerTask("getBall2"),
	Receiver = task.ReceiverTask("wait"),
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
		if Cbuf_cnt(CBall2RoleDist("Receiver")<13,10)  then
			return "shoot"
		end
	end,
	Kicker   = task.GotoPos("Kicker",250,ff("Kicker"),Kicker2Balldir()),
	Receiver = task.ReceiverTask("receive"),
},
["shoot"] = {
	switch = function()
		--if Cbuf_cnt(CBall2RoleDist("Receiver")<12,20)  then
			return "shoot"
		--end
	end,
	Kicker   = task.GotoPos("Kicker",250,ff("Kicker"),Kicker2Balldir()),
	Receiver = task.ReceiverTask("canShoot"),
},
name = "Kick_front_A4"
}