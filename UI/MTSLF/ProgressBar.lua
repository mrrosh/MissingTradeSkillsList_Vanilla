------------------------------------------------------------------
-- Name: ProgressBar											--
-- Description: Contains all functionality for the progressbar	--
-- Parent Frame: MissingTradeSkillsListFrame					--
------------------------------------------------------------------

MTSLUI_MTSLF_ProgressBar = {	
	-- The "colored" / filled bar
	progressbar,
	-- The text shown on the bar
	progressbar_text,
	-- width of the "filled" progressbar
	progressbar_width = MTSLUI_Core.FRAME_WIDTH_SUBFRAME - 90,
	FRAME_HEIGHT = 24,

	----------------------------------------------------------------------------------------------------------
	-- Intialises  the progressbar
	--
	-- @parent_frame		Frame		The parent frame
	----------------------------------------------------------------------------------------------------------
	Initialise = function (self, parent_frame)
		local progressbar_frame = MTSLUI_Core:CreateBaseFrame("Frame", "", parent_frame, nil, MTSLUI_Core.FRAME_WIDTH_SUBFRAME, self.FRAME_HEIGHT)		
		-- Position at bottom of MissingTradeSkillsListFrame
		progressbar_frame:SetPoint("TOPLEFT", parent_frame, "BOTTOMLEFT", 4, self.FRAME_HEIGHT + 4)
		local text = MTSLUI_Fonts.colors.text.title .. "Missing Skills:"
		progressbar_frame.text = MTSLUI_Core:CreateLabel(progressbar_frame, text, 5, 0, MTSLUI_Fonts.size.normal, "LEFT")

		-- Create the childframes
		self:CreateProgressBar(progressbar_frame)
		self:CreateProgressBarText(progressbar_frame)
	end,

	----------------------------------------------------------------------------------------------------------
	-- Creates the progressbar
	--
	-- @parent_frame		Frame		The parent frame
	----------------------------------------------------------------------------------------------------------
	CreateProgressBar = function (self, parent_frame)
		-- Only create it if ProgressFrame exists
		self.progressbar = MTSLUI_Core:CreateBaseFrame("Statusbar", "", parent_frame, nil, self.progressbar_width, self.FRAME_HEIGHT - 8, false)
		self.progressbar:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", 94, -4)
		self.progressbar:SetStatusBarTexture("Interface/PaperDollInfoFrame/UI-Character-Skills-Bar")
	end,

	----------------------------------------------------------------------------------------------------------
	-- Creates the text shown on the progressbar
	--
	-- @parent_frame		Frame		The parent frame
	----------------------------------------------------------------------------------------------------------
	CreateProgressBarText = function (self, parent_frame)
		-- Only create it if ProgressFrame exists
		self.progressbar_text = MTSLUI_Core:CreateBaseFrame("Frame", "", parent_frame, nil, self.progressbar_width, self.FRAME_HEIGHT, true)
		self.progressbar_text:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", 90, 0)
		-- Status text
		self.progressbar_text.text = MTSLUI_Core:CreateLabel(self.progressbar_text, "", 0, 0, MTSLUI_Fonts.size.normal, "CENTER")
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Updates the values shown on the progressbar
	--
	-- @skills_learned		number		The amount of skills learned for the current tradeskill
	-- @max_skills			number		The maximum amount of skills to be learned for the current tradeskill
	----------------------------------------------------------------------------------------------------------
	UpdateStatusbar = function (self, skills_learned, max_skills)
		self.progressbar:SetMinMaxValues(1, max_skills)
		self.progressbar:SetValue(skills_learned)
		self.progressbar:SetStatusBarColor(0.0, 1.0, 0.0, 0.95)
		self.progressbar_text.text:SetText(MTSLUI_Fonts.colors.text.normal .. skills_learned .. "/" .. max_skills)
	end
}