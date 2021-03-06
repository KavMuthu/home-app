USE [SurveyAndSite]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionText] [nvarchar](max) NULL,
	[Options] [nvarchar](max) NULL,
	[QuestionType] [int] NOT NULL,
	[ParentQuestionId] [int] NULL,
	[ParentRequiredAnswer] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[Required] [bit] NOT NULL,
	[TextBoxDataType] [nvarchar](20) NULL,
 CONSTRAINT [PK_dbo.Questions] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ParentQuestionId] ON [dbo].[Questions] 
(
	[ParentQuestionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Templates]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Templates](
	[TemplateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[IsInternal] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Templates] PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TemplateQuestions]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TemplateQuestions](
	[TemplateQuestionId] [int] IDENTITY(1,1) NOT NULL,
	[TemplateId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.TemplateQuestions] PRIMARY KEY CLUSTERED 
(
	[TemplateQuestionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyTemplates]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyTemplates](
	[SurveyTemplateId] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[TemplateId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.SurveyTemplates] PRIMARY KEY CLUSTERED 
(
	[SurveyTemplateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Surveys]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Surveys](
	[SurveyId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](300) NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedDate] [datetime] NULL,
	[ExpireOn] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[FilterQuestion] [nvarchar](max) NULL,
	[IsPIT] [bit] NOT NULL,
	[IsEncampment] [bit] NOT NULL,
	[NeedsROIAndImages] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Surveys] PRIMARY KEY CLUSTERED 
(
	[SurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncampmentSites]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncampmentSites](
	[EncampmentSiteId] [int] IDENTITY(1,1) NOT NULL,
	[CouncilDistrict] [int] NULL,
	[EncampLocation] [nvarchar](2000) NULL,
	[EncampDispatchId] [nvarchar](2000) NULL,
	[SiteCode] [nvarchar](2000) NULL,
	[EncampmentType] [nvarchar](2000) NULL,
	[SizeOfEncampment] [nvarchar](2000) NULL,
	[EnvironmentalImpact] [nvarchar](2000) NULL,
	[VisibilityToThePublic] [nvarchar](2000) NULL,
	[Inactive] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.EncampmentSites] PRIMARY KEY CLUSTERED 
(
	[EncampmentSiteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupSurveys]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupSurveys](
	[GroupSurveyId] [int] IDENTITY(1,1) NOT NULL,
	[GroupId] [int] NOT NULL,
	[SurveyId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.GroupSurveys] PRIMARY KEY CLUSTERED 
(
	[GroupSurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[GroupId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.Groups] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[Last4SSN] [nvarchar](4) NULL,
	[ServicePointClientID] [int] NULL,
 CONSTRAINT [PK_dbo.Clients] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[AccountType] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[Organization] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[IdentityRole_Id] [nvarchar](128) NULL,
	[ApplicationUser_Id] [int] NULL,
	[IdentityUser_Id] [nvarchar](128) NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[UserId] [int] NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ApplicationUser_Id] [int] NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ApplicationUser_Id] ON [dbo].[AspNetUserLogins] 
(
	[ApplicationUser_Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[ApplicationUser_Id] [int] NULL,
	[UserId] [int] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ApplicationUser_Id] ON [dbo].[AspNetUserClaims] 
(
	[ApplicationUser_Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncampmentVisits]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncampmentVisits](
	[EncampmentVisitId] [int] IDENTITY(1,1) NOT NULL,
	[VisitDate] [datetime] NOT NULL,
	[EncampmentSiteId] [int] NOT NULL,
	[Agency] [nvarchar](20) NULL,
	[Worker] [nvarchar](100) NULL,
	[Reason4Visit] [nvarchar](max) NULL,
	[Referrals] [nvarchar](100) NULL,
	[Comments] [nvarchar](max) NULL,
	[UserId] [nvarchar](120) NULL,
 CONSTRAINT [PK_dbo.EncampmentVisits] PRIMARY KEY CLUSTERED 
(
	[EncampmentVisitId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EncampmentSiteId] ON [dbo].[EncampmentVisits] 
(
	[EncampmentSiteId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSurveys]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSurveys](
	[ClientSurveyId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[SurveyId] [int] NOT NULL,
	[SurveyDate] [datetime] NOT NULL,
	[EnteredBy] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[SubmissionDate] [datetime] NULL,
 CONSTRAINT [PK_dbo.ClientSurveys] PRIMARY KEY CLUSTERED 
(
	[ClientSurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClientId] ON [dbo].[ClientSurveys] 
(
	[ClientId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EnteredBy] ON [dbo].[ClientSurveys] 
(
	[EnteredBy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SurveyId] ON [dbo].[ClientSurveys] 
(
	[SurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurveyQuestions]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyQuestions](
	[SurveyQuestionId] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[OrderId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.SurveyQuestions] PRIMARY KEY CLUSTERED 
(
	[SurveyQuestionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_QuestionId] ON [dbo].[SurveyQuestions] 
(
	[QuestionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_SurveyId] ON [dbo].[SurveyQuestions] 
(
	[SurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGroups]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroups](
	[UserId] [nvarchar](128) NOT NULL,
	[GroupId] [int] NOT NULL,
	[User_Id] [int] NULL,
 CONSTRAINT [PK_dbo.UserGroups] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[GroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_User_Id] ON [dbo].[UserGroups] 
(
	[User_Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_UserIdAndGroupId] ON [dbo].[UserGroups] 
(
	[UserId] ASC,
	[GroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PITs]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PITs](
	[PITId] [int] IDENTITY(1,1) NOT NULL,
	[Latitude] [float] NOT NULL,
	[Longitude] [float] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[GenderAnswer] [nvarchar](max) NULL,
	[AgeAnswer] [nvarchar](max) NULL,
	[FamilyAnswer] [nvarchar](max) NULL,
	[DwellingAnswer] [nvarchar](max) NULL,
	[LocationAnswer] [nvarchar](max) NULL,
	[HouseholdId] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[SubmissionDate] [datetime] NULL,
 CONSTRAINT [PK_dbo.PITs] PRIMARY KEY CLUSTERED 
(
	[PITId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[PITs] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[path] [nvarchar](max) NULL,
	[ClientSurveyId] [int] NULL,
 CONSTRAINT [PK_dbo.Images] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClientId] ON [dbo].[Images] 
(
	[ClientId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClientSurveyId] ON [dbo].[Images] 
(
	[ClientSurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROIs]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROIs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EnteredBy] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Date] [datetime] NOT NULL,
	[ClientSurveyId] [int] NOT NULL,
 CONSTRAINT [PK_dbo.ROIs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClientSurveyId] ON [dbo].[ROIs] 
(
	[ClientSurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_EnteredBy] ON [dbo].[ROIs] 
(
	[EnteredBy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientSurveyResponses]    Script Date: 04/13/2015 18:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientSurveyResponses](
	[ClientSurveyResponseId] [int] IDENTITY(1,1) NOT NULL,
	[ClientSurveyId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.ClientSurveyResponses] PRIMARY KEY CLUSTERED 
(
	[ClientSurveyResponseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClientSurveyId] ON [dbo].[ClientSurveyResponses] 
(
	[ClientSurveyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_QuestionId] ON [dbo].[ClientSurveyResponses] 
(
	[QuestionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Default [DF__Surveys__NeedsRO__4222D4EF]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[Surveys] ADD  DEFAULT ((0)) FOR [NeedsROIAndImages]
GO
/****** Object:  Default [DF__AspNetUse__Email__1273C1CD]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF__AspNetUse__Email__1273C1CD]  DEFAULT ((0)) FOR [EmailConfirmed]
GO
/****** Object:  Default [DF__AspNetUse__Phone__1367E606]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF__AspNetUse__Phone__1367E606]  DEFAULT ((0)) FOR [PhoneNumberConfirmed]
GO
/****** Object:  Default [DF__AspNetUse__TwoFa__145C0A3F]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF__AspNetUse__TwoFa__145C0A3F]  DEFAULT ((0)) FOR [TwoFactorEnabled]
GO
/****** Object:  Default [DF__AspNetUse__Locko__15502E78]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF__AspNetUse__Locko__15502E78]  DEFAULT ((0)) FOR [LockoutEnabled]
GO
/****** Object:  Default [DF__AspNetUse__Acces__164452B1]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF__AspNetUse__Acces__164452B1]  DEFAULT ((0)) FOR [AccessFailedCount]
GO
/****** Object:  Default [DF__ClientSur__Enter__1273C1CD]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ClientSurveys] ADD  DEFAULT ((0)) FOR [EnteredBy]
GO
/****** Object:  Default [DF__PITs__HouseholdI__4316F928]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[PITs] ADD  DEFAULT ((0)) FOR [HouseholdId]
GO
/****** Object:  Default [DF__ROIs__ClientSurv__2E1BDC42]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ROIs] ADD  DEFAULT ((0)) FOR [ClientSurveyId]
GO
/****** Object:  ForeignKey [FK_dbo.Questions_dbo.Questions_ParentQuestionId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Questions_dbo.Questions_ParentQuestionId] FOREIGN KEY([ParentQuestionId])
REFERENCES [dbo].[Questions] ([QuestionId])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_dbo.Questions_dbo.Questions_ParentQuestionId]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_ApplicationUser_Id]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_ApplicationUser_Id] FOREIGN KEY([ApplicationUser_Id])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_ApplicationUser_Id]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_ApplicationUser_Id]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_ApplicationUser_Id] FOREIGN KEY([ApplicationUser_Id])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_ApplicationUser_Id]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_ApplicationUser_Id]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_ApplicationUser_Id] FOREIGN KEY([ApplicationUser_Id])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_ApplicationUser_Id]
GO
/****** Object:  ForeignKey [FK_dbo.EncampmentVisits_dbo.EncampmentSites_EncampmentSiteId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[EncampmentVisits]  WITH CHECK ADD  CONSTRAINT [FK_dbo.EncampmentVisits_dbo.EncampmentSites_EncampmentSiteId] FOREIGN KEY([EncampmentSiteId])
REFERENCES [dbo].[EncampmentSites] ([EncampmentSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EncampmentVisits] CHECK CONSTRAINT [FK_dbo.EncampmentVisits_dbo.EncampmentSites_EncampmentSiteId]
GO
/****** Object:  ForeignKey [FK_dbo.ClientSurveys_dbo.AspNetUsers_EnteredBy]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ClientSurveys]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientSurveys_dbo.AspNetUsers_EnteredBy] FOREIGN KEY([EnteredBy])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[ClientSurveys] CHECK CONSTRAINT [FK_dbo.ClientSurveys_dbo.AspNetUsers_EnteredBy]
GO
/****** Object:  ForeignKey [FK_dbo.ClientSurveys_dbo.Clients_ClientId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ClientSurveys]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientSurveys_dbo.Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([ClientId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientSurveys] CHECK CONSTRAINT [FK_dbo.ClientSurveys_dbo.Clients_ClientId]
GO
/****** Object:  ForeignKey [FK_dbo.ClientSurveys_dbo.Surveys_SurveyId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ClientSurveys]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientSurveys_dbo.Surveys_SurveyId] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Surveys] ([SurveyId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClientSurveys] CHECK CONSTRAINT [FK_dbo.ClientSurveys_dbo.Surveys_SurveyId]
GO
/****** Object:  ForeignKey [FK_dbo.SurveyQuestions_dbo.Questions_QuestionId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[SurveyQuestions]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SurveyQuestions_dbo.Questions_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([QuestionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SurveyQuestions] CHECK CONSTRAINT [FK_dbo.SurveyQuestions_dbo.Questions_QuestionId]
GO
/****** Object:  ForeignKey [FK_dbo.SurveyQuestions_dbo.Surveys_SurveyId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[SurveyQuestions]  WITH CHECK ADD  CONSTRAINT [FK_dbo.SurveyQuestions_dbo.Surveys_SurveyId] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Surveys] ([SurveyId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SurveyQuestions] CHECK CONSTRAINT [FK_dbo.SurveyQuestions_dbo.Surveys_SurveyId]
GO
/****** Object:  ForeignKey [FK_dbo.UserGroups_dbo.AspNetUsers_User_Id]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[UserGroups]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserGroups_dbo.AspNetUsers_User_Id] FOREIGN KEY([User_Id])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[UserGroups] CHECK CONSTRAINT [FK_dbo.UserGroups_dbo.AspNetUsers_User_Id]
GO
/****** Object:  ForeignKey [FK_dbo.UserGroups_dbo.Groups_GroupId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[UserGroups]  WITH CHECK ADD  CONSTRAINT [FK_dbo.UserGroups_dbo.Groups_GroupId] FOREIGN KEY([GroupId])
REFERENCES [dbo].[Groups] ([GroupId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserGroups] CHECK CONSTRAINT [FK_dbo.UserGroups_dbo.Groups_GroupId]
GO
/****** Object:  ForeignKey [FK_dbo.PITs_dbo.AspNetUsers_UserId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[PITs]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PITs_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PITs] CHECK CONSTRAINT [FK_dbo.PITs_dbo.AspNetUsers_UserId]
GO
/****** Object:  ForeignKey [FK_dbo.Images_dbo.Clients_ClientId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[Images]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Images_dbo.Clients_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([ClientId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_dbo.Images_dbo.Clients_ClientId]
GO
/****** Object:  ForeignKey [FK_dbo.Images_dbo.ClientSurveys_ClientSurveyId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[Images]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Images_dbo.ClientSurveys_ClientSurveyId] FOREIGN KEY([ClientSurveyId])
REFERENCES [dbo].[ClientSurveys] ([ClientSurveyId])
GO
ALTER TABLE [dbo].[Images] CHECK CONSTRAINT [FK_dbo.Images_dbo.ClientSurveys_ClientSurveyId]
GO
/****** Object:  ForeignKey [FK_dbo.ROIs_dbo.AspNetUsers_EnteredBy]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ROIs]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ROIs_dbo.AspNetUsers_EnteredBy] FOREIGN KEY([EnteredBy])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[ROIs] CHECK CONSTRAINT [FK_dbo.ROIs_dbo.AspNetUsers_EnteredBy]
GO
/****** Object:  ForeignKey [FK_dbo.ROIs_dbo.ClientSurveys_ClientSurveyId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ROIs]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ROIs_dbo.ClientSurveys_ClientSurveyId] FOREIGN KEY([ClientSurveyId])
REFERENCES [dbo].[ClientSurveys] ([ClientSurveyId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ROIs] CHECK CONSTRAINT [FK_dbo.ROIs_dbo.ClientSurveys_ClientSurveyId]
GO
/****** Object:  ForeignKey [FK_dbo.ClientSurveyResponses_dbo.ClientSurveys_ClientSurveyId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ClientSurveyResponses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientSurveyResponses_dbo.ClientSurveys_ClientSurveyId] FOREIGN KEY([ClientSurveyId])
REFERENCES [dbo].[ClientSurveys] ([ClientSurveyId])
GO
ALTER TABLE [dbo].[ClientSurveyResponses] CHECK CONSTRAINT [FK_dbo.ClientSurveyResponses_dbo.ClientSurveys_ClientSurveyId]
GO
/****** Object:  ForeignKey [FK_dbo.ClientSurveyResponses_dbo.Questions_QuestionId]    Script Date: 04/13/2015 18:13:36 ******/
ALTER TABLE [dbo].[ClientSurveyResponses]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ClientSurveyResponses_dbo.Questions_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([QuestionId])
GO
ALTER TABLE [dbo].[ClientSurveyResponses] CHECK CONSTRAINT [FK_dbo.ClientSurveyResponses_dbo.Questions_QuestionId]
GO
