local BallPosX = function()
	return function()
		return CGetBallX()-90
	end
end
local BallPosY= function()
	return function()
		if CGetBallY()>0 then
			return -50
		else
			return 50
		end
	end
end
local Receiver2Balldir = function()
	return function()
		return CRole2BallDir("Receiver")
	end
end
gPlayTable.CreatePlay{

firstState = "stop",

["stop"] = {
    switch = function()
		if CGameOn() then 
	        return "finish"
	    elseif CGetBallX()>200 and CGetBallX() < 230 and CGetBallY() > -20 and CGetBallY() <20 then
	    	return "stop1"
	    elseif CGetBallX()>30 and CGetBallX() < 200 then
	    	return "stop2"
	    elseif CGetBallX()>220 then
	    	return "stop2"
	    else
	    	return "stop"
	    end
	end,
	Kicker   = task.KickerTask("getBall"),--task.Stop("Kicker",1),
	Receiver = task.ReceiverTask("GoToP"),--task.Stop("Receiver",3) ,
	Goalie   = task.Stop("Goalie",6)
},
["stop1"] = {
	switch = function()
		if CGameOn() then 
	        return "finish"
	    elseif CGetBallX()>200 and CGetBallX() < 230 and CGetBallY() > -20 and CGetBallY() <20 then
	    	return "stop1"
	    elseif CGetBallX()>30 and CGetBallX() < 200 then
	    	return "stop2"
	    elseif CGetBallX()>220 then
	    	return "stop2"
	    else
	    	return "stop"
	    end
	end,
Kicker   = task.Stop("Kicker",1),
Receiver = task.Stop("Receiver",3) ,
Goalie   = task.Stop("Goalie",6)
},
["stop2"] = {
	switch = function()
		if CGameOn() then 
	        return "finish"
	    elseif CGetBallX()>210 and CGetBallX() < 230 and CGetBallY() > -10 and CGetBallY() <10 then
	    	return "stop1"
	    elseif CGetBallX()>30 and CGetBallX() < 200 then
	    	return "stop2"
	    elseif CGetBallX()>220 then
	    	return "stop2"
	    else
	    	return "stop"
	    end
	end,
	Kicker  = task.KickerTask("getBall2"),
	Receiver = task.GotoPos("Receiver",BallPosX(),BallPosY(),Receiver2Balldir()),
},
name = "Ref_Stop"
}