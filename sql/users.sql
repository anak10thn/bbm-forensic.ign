select users.*,con.PersonalMessage from users left join Contacts as con on con.UserId = users.UserId;

select TextMessages.*,owner.DisplayName as owner,participant.DisplayName as participant,recive.DisplayName as recivient, Conversations.OwnerId,Participants.UserId as username from TextMessages
left join Participants on Participants.ParticipantId = TextMessages.ParticipantId
left join Conversations on Conversations.ConversationId = TextMessages.ConversationId
left join Participants as own on own.ConversationId = Conversations.ConversationId and own.participantId = Conversations.OwnerId
left join Users as owner on owner.UserId = own.UserId
left join Users as participant on participant.UserId = Participants.UserId
left join Participants as rec on
(case when owner.UserId == Participants.UserId
then rec.ConversationId = Conversations.ConversationId and rec.participantId != Conversations.OwnerId
else rec.ConversationId = Conversations.ConversationId and rec.participantId = Conversations.OwnerId
end)
left join Users as recive on recive.UserId = rec.UserId;
