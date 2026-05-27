--desc: 
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
firstState = "start1",

-- ["start"] = {
-- 	switch = function()
-- 		if Cbuf_cnt(CBall2RoleDist("Kicker")<35,10) then
-- 			return "start1"
-- 		end
-- 	end,
-- 	Kicker  = task.KickerTask("getBall"),
-- 	Receiver = task.GetBall("Receiver","Kicker"),
-- 	--Kicker = task.KickerTask("GoToP"),
-- },
["start1"] = {
	switch = function()
		if CBall2RoleDist("Kicker")<25 and CRole2TargetDist("Receiver")<3 then
			return "passball"
		end
	end,
	Kicker  = task.KickerTask("getBall2"),
	Receiver = task.ReceiverTask("GoToP"),
},

["passball"] = {
	switch = function()
		if CBall2RoleDist("Kicker")>30 then
			return "receive"
		end
	end,
	Kicker  = task.KickerTask("passball"),
	Receiver = task.GotoPos("Receiver",RobotPosX("Receiver"),RobotPosY("Receiver"),Receiver2Balldir()),
},
["receive"] = {
	switch = function()
		if Cbuf_cnt(CBall2RoleDist("Receiver")<20,30) then
			return "shoot"
		end
	end,
	Kicker   = task.KickerTask("canShoot"),--GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),Receiver2Balldir()),
	Receiver = task.ReceiverTask("receive2"),--接球后退
},
["shoot"] = {
	switch = function()
		if Cbuf_cnt(CBall2RoleDist("Receiver")<12,20)  then
			return "shoot"
		end
	end,
	Kicker   = task.KickerTask("canShoot"),
	Receiver = task.GotoPos("Receiver",230,100,Receiver2Balldir()),
},
name = "1"
}