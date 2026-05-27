
gPlayTable.CreatePlay{
firstState = "start",

["start"] = {
	switch = function()
		-- if Cbuf_cnt(CBall2RoleDist("Kicker")<350 , 600)  then
		-- 	return "passball"
		-- end
	end,
	Kicker  = task.KickerTask("skill"),
	-- Receiver = task.ReceiverTask("gotopos_r"),
},

-- ["passball"] = {
-- 	switch = function()
-- 		if CBall2RoleDist("Kicker")>40 then
-- 			return "receive"
-- 		end
-- 	end,
-- 	Kicker   = task.KickerTask("passball_k"),
-- 	Receiver = task.ReceiverTask("gotopos_r"),
-- },

-- ["receive"] = {
-- 	switch = function()
-- 		if Cbuf_cnt(true, 120)  then
-- 			return "receive"
-- 		end
-- 	end,
-- 	Kicker   = task.RobotHalt(),
-- 	Receiver = task.ReceiverTask("receive_r"),
-- },

name = "testSkill"
}