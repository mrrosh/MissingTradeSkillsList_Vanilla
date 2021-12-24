------------------------------------------------------------------
-- Name: TitleFrame											    --
-- Description: The tile frame									--
-- Parent Frame: MissingTradeSkillsListFrame					--
------------------------------------------------------------------

MTSLUI_MTSLF_TitleFrame = {	
	FRAME_WIDTH = MTSLUI_Core.FRAME_WIDTH_SUBFRAME,
	FRAME_HEIGHT = 35, 

	---------------------------------------------------------------------------------------
	-- Initialises the titleframe
	----------------------------------------------------------------------------------------
	Initialise = function (self, parent_frame)
		local frame = MTSLUI_Core:CreateBaseFrame("Frame", "", parent_frame, nil, self.FRAME_WIDTH, self.FRAME_HEIGHT)
		frame:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", 5, -5)
		-- Title text
		local title_text = MTSLUI_Fonts.colors.text.title ..MTSLADDON.NAME .. MTSLUI_Fonts.colors.text.normal.. " (by " .. MTSLADDON.AUTHOR .. ") " .. MTSLUI_Fonts.colors.text.title  .. "v" .. MTSLADDON.VERSION
		frame.text = MTSLUI_Core:CreateLabel(frame, title_text, 0, 0, MTSLUI_Fonts.size.large, "CENTER")
	end
}