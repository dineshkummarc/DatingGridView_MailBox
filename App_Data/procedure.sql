
CREATE PROCEDURE [dbo].[usp_GetMessages] 
   @ProfileId INT, 
   @Username NVARCHAR(20), 
   @ListMessageIds VARCHAR(MAX) 
AS 
SET NOCOUNT ON 
declare @now datetime 
set @now = GETUTCDATE() 
IF(LEN(@ListMessageIds) > 0) 
   BEGIN 
      UPDATE [Mailbox] 
      SET [MsgDeleted] = 1 ,
      [Box] = '' ,
      [FromProfileId] = '' ,
      [FromUsername] = '' ,
      [Subject] = '' ,
      [Body] = '' ,
      [Tag] = '' 
      WHERE ( ([ProfileId] = @ProfileId) AND ([MessageId] _
		IN(SELECT * FROM dbo.ufn_CsvToInt(@ListMessageIds))) ) 
   END 
   BEGIN 
      SELECT [MessageId]
            ,[ProfileId]
            ,[Box]
            ,[FromProfileId]
            ,[FromUsername] 
            ,[Subject] 
            ,[Body] 
            ,[Tag] 
            ,convert(varchar, [MsgDate], 107) AS zdate 
            ,[MsgDate] 
            ,[MsgRead] 
            ,[MsgReplied] 
            ,[MsgDeleted] 
      FROM [Mailbox] WHERE (([ProfileId] = @ProfileId) AND ([MsgDeleted] <> 1)) 
   END