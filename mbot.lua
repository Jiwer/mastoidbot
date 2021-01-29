local discordia = require('discordia')
local client = discordia.Client()
local privateMessages = {}
local numMessages = 0
local REAL_MASTOID_ID = "160878703226781696"
local REAL_MASTOID_DM_CHANNEL = "804782798576812073"

client:on('ready', function()
	
	print('Logged in as '.. client.user.username)

	client:setGame("use 'mtalk messagehere' to talk to me")

end)

client:on('messageCreate', function(message)

	if message.content:sub(1, 7) == 'mreply ' then

		if message.channel.id == REAL_MASTOID_DM_CHANNEL then

			local replyID = tonumber(message.content:sub(7, 8))

			if privateMessages[replyID] then

				privateMessages[replyID].mChannel:send("<@!" .. privateMessages[replyID].mUserID .. "> reply from mastoid: " .. message.content:sub(9, string.len(message.content)))

			else

				message.channel:send("invalid reply ID")

			end

		end

	end

	if message.content:sub(1, 6) == 'mtalk ' then

		if message.channel.id == REAL_MASTOID_DM_CHANNEL then return end

		local realMastoid = message.guild:getMember(REAL_MASTOID_ID)
			
		numMessages = numMessages + 1

		privateMessages[numMessages] = {mUserID = message.author.id, mChannel = message.channel, mMessage = message.content}

		realMastoid:send("[" .. numMessages .. "] " .. message.author.name .. " says: " .. message.content:sub(6, string.len(message.content)))

		message.channel:send("<@!" .. message.author.id .. "> " .. "yeah i heard that shit [" .. numMessages .. "]")

	end

end)

client:run('Bot botcodehere')