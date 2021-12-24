------------------------------------------------------------------
-- Name: ToggleButton											--
-- Description: Contains all functionality for the togglebutton --
------------------------------------------------------------------
MTSLUI_ToggleButton = {
	-- the frame of this toggle button
	frame = nil,
	type = nil,

	---------------------------------------------------------------------------------------
	-- Initialises the togglebutton
	----------------------------------------------------------------------------------------
	Initialise = function (self, parent_frame, type)
		-- if not already made
		if self.frame == nil then
			self.frame = MTSLUI_Core:CreateBaseFrame("Button", "", parent_frame, "UIPanelButtonTemplate", 50, 20)
			self.frame:SetText("MTSL")
			self.frame:SetPoint("TOPLEFT", parent_frame, "TOPRIGHT", -107, -14)
			self.frame:SetScript("OnClick", function () 
				MTSLUI_Core:ToggleMissingTradeSkillsListFrame(self.type) 
			end)	
			self.frame:Show()
		end

		self.type = type
	end,
		
	---------------------------------------------------------------------------------------
	-- Hides the togglebutton
	----------------------------------------------------------------------------------------
	Hide = function (self) 
		if self.frame ~= nil then
			self.frame:Hide()
		end
	end,
	
	---------------------------------------------------------------------------------------
	-- Shows the togglebutton
	----------------------------------------------------------------------------------------
	Show = function (self)
		-- Create button first if not made yet
		if self.frame == nil then
			self:Initialise()
		end
		self.frame:Show()
	end,
}