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
gPlayTable.CreatePlay{
firstState = "pass",

["pass"] = {
	switch = function()
		if Cbuf_cnt(true,300) then
			return "receive"
		end
	end,
	Kicker  = task.KickerTask("pass"),
	Receiver = task.GotoPos("Receiver",RobotPosX("Receiver"),RobotPosY("Receiver"),math.pi),
	--Receiver = task.ReceiveBall("Receiver"),
},
["receive"] = {
	switch = function()
		-- if Cbuf_cnt(CBall2RoleDist("Receiver")<35,30) and CRole2TargetDist("Kicker")<3 then
		-- 	return "passball"
		-- end
	end,
	Kicker  = task.GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),math.pi),
	Receiver = task.ReceiveBall("Receiver"),
},
-- ["passball"] = {
-- 	switch = function()
-- 		if CBall2RoleDist("Receiver")>36 then
-- 			return "receive"
-- 		end
-- 	end,
-- 	Receiver  = task.ReceiverTask("passball"),
-- 	Kicker = task.GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),Kicker2Balldir()),
-- },
-- ["receive"] = {
-- 	switch = function()
-- 		if Cbuf_cnt(CBall2RoleDist("Kicker")<20,10) then
-- 			return "shoot"
-- 		end
-- 	end,
-- 	Receiver   = task.ReceiverTask("canShoot1"),--GotoPos("Kicker",RobotPosX("Kicker"),RobotPosY("Kicker"),Receiver2Balldir()),
-- 	Kicker = task.KickerTask("receive2"),--接球后退
-- },
-- ["shoot"] = {
-- 	switch = function()
-- 		--if Cbuf_cnt(CBall2RoleDist("Receiver")<12,20)  then
-- 			return "shoot"
-- 		--end
-- 	end,
-- 	Receiver   = task.ReceiverTask("canShoot1"),
-- 	Kicker = task.GotoPos("Kicker",230,100,Kicker2Balldir()),
-- },
name = "Test"
}