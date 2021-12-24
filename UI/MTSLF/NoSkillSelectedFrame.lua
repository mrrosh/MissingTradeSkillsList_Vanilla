------------------------------------------------------------------------------
-- Name: NoSkillSelectedFrame												--
-- Description: Frame showing message when no skill is selected for details	--
-- Parent Frame: MissingTradeSkillsListFrame								--
------------------------------------------------------------------------------

MTSLUI_MTSLF_NoSkillSelectedFrame = {
	frame, 
	-- width of the frame
	FRAME_WIDTH = MTSLUI_Core.FRAME_WIDTH_RIGHTFRAME,
	-- height of the frame
	FRAME_HEIGHT = 363,

	----------------------------------------------------------------------------------------------------------
	-- Intialises the NoSkillSelectedFrame
	--
	-- @parent_frame		Frame		The parent frame
	----------------------------------------------------------------------------------------------------------
	Initialise = function (self, parent_frame)
		self.frame = MTSLUI_Core:CreateBaseFrame("Frame", "", parent_frame, nil, self.FRAME_WIDTH, self.FRAME_HEIGHT, true)
		-- position under MissingSkillsListFrame and above ProgressBar
		self.frame:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", MTSLUI_Core.FRAME_WIDTH_LEFTFRAME + 3, -40)
		--  Black background
		self.frame:SetBackdropColor(0,0,0,1)
		-- Add the Texts/Strings to the frame
		local text = MTSLUI_Fonts.colors.text.error .. "Select a missing skill first!"
		MTSLUI_Core:CreateLabel(self.frame, text, 10, -10, MTSLUI_Fonts.size.large, "TOPLEFT")
	end,

	---------------------------------------------------------------------------------------
	-- Hides the frame
	----------------------------------------------------------------------------------------
	Hide = function (self) 
		if self.frame ~= nil then
			self.frame:Hide()
		end
	end,
	
	---------------------------------------------------------------------------------------
	-- Shows the frame
	----------------------------------------------------------------------------------------
	Show = function (self)
		-- Create frame first
		if self.frame == nil then
			self:Initialise()
		end
		self.frame:Show()
	end,
}