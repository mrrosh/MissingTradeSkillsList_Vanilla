----------------------------------------------------------------------
-- Name: SkillButton												--
-- Description: Button that shows a missing skill if visible frame	--
-- Parent Frame: MissingSkillsListFrame								--
----------------------------------------------------------------------

MTSLUI_MTSLF_MSLF_SkillButton = {
	-- The "slider"
	frame,
	-- Keep if it is selected or not
	is_selected,
	-- width of the button when slider is visible (FRAME_WIDTH_SUBFRAME - 2*15 border)
	FRAME_WIDTH_SLIDER = MTSLUI_MTSLF_MissingSkillsListFrame.FRAME_WIDTH - 30,
	-- width of the button when slider is not visible (FRAME_WIDTH_SLIDER + 16)
	FRAME_WIDTH_NO_SLIDER = MTSLUI_MTSLF_MissingSkillsListFrame.FRAME_WIDTH  - 14,
	-- height of the button
	FRAME_HEIGHT = 18,
	-- Different textures to use for the button
	TEXTURES = {
		SELECTED = "Interface/Buttons/UI-Listbox-Highlight",
		HIGHLIGHTED = "Interface/Tooltips/UI-Tooltip-Background",
		NOT_SELECTED = nil
	},

	----------------------------------------------------------------------------------------------------------
	-- Intialises the SkillButton
	--
	-- @parent_frame		Frame		The parent frame
	-- @position_left		Number		Start position of the button (left)
	-- @position_top		Number		Start position of the button (top)
	----------------------------------------------------------------------------------------------------------
	Initialise = function (self, parent_frame, id, position_left, position_top)
		self.frame = MTSLUI_Core:CreateBaseFrame("Button", "", parent_frame, "UIPanelButtonTemplate", self.FRAME_WIDTH_SLIDER, self.FRAME_HEIGHT)
		self.frame:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", position_left, position_top)
		
		-- strip textures
		self.frame:SetNormalTexture(self.TEXTURES.NOT_SELECTED)
		self.frame:SetPushedTexture(self.TEXTURES.NOT_SELECTED)
		self.frame:SetDisabledTexture(self.TEXTURES.NOT_SELECTED)
		-- set own textures
		self.frame:SetHighlightTexture(self.TEXTURES.HIGHLIGHTED)
		-- set the id (= index) of the button so we later know which one is pushed	
		self.frame:SetID(id)

		self.frame.text = self.frame:CreateFontString(nil,"ARTWORK")
		self.frame.text:SetFont(MTSLUI_Fonts.name, MTSLUI_Fonts.size.normal)
		self.frame.text:SetPoint("LEFT",5,0)

		self.frame:SetScript("OnClick", function()
			local button_index = this:GetID()
			MTSLUI_MTSLF_MissingSkillsListFrame:HandleSkillButtonSelect(button_index)
		end)

		self.is_selected = 0
	end,
		
	---------------------------------------------------------------------------------------
	-- Refresh the button
	--
	-- @text				String		Text to show on the button
	----------------------------------------------------------------------------------------
	Refresh = function(self, text)
		self.frame.text:SetText(text)
		-- Make button smaller if slider is visible so they dont overlap
		if MTSLUI_MTSLF_MissingSkillsListFrame.slider_active == 1 then
			self.frame:SetWidth(self.FRAME_WIDTH_SLIDER)
		else
			self.frame:SetWidth(self.FRAME_WIDTH_NO_SLIDER)
		end
	end,

	---------------------------------------------------------------------------------------
	-- Hides the button
	----------------------------------------------------------------------------------------
	Hide = function (self) 
		if self.frame ~= nil then
			self.frame:Hide()
		end
	end,
	
	---------------------------------------------------------------------------------------
	-- Shows the button
	----------------------------------------------------------------------------------------
	Show = function (self)
		-- Create frame first
		if self.frame == nil then
			self:Initialise()
		end
		self.frame:Show()
	end,
	
	---------------------------------------------------------------------------------------
	-- Checks if button is selected
	--
	-- returns		Number		Flag that indicates if button is selected (1 = selected)
	----------------------------------------------------------------------------------------
	IsSelected = function (self)
		return self.is_selected
	end,

	---------------------------------------------------------------------------------------
	-- Deselects the button
	----------------------------------------------------------------------------------------
	Deselect = function (self)
		self.is_selected = 0
		self.frame:SetNormalTexture(self.TEXTURES.NOT_SELECTED)
	end,

	---------------------------------------------------------------------------------------
	-- Selects the button
	----------------------------------------------------------------------------------------
	Select = function (self)
		self.is_selected = 1
		self.frame:SetNormalTexture(self.TEXTURES.SELECTED)
	end,
}

