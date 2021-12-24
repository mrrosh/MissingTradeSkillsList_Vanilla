----------------------------------------------------------------------------------
-- Name: MissingSkillsListFrame													--
-- Description: Shows the missing skills (order from low to high on min_skill)  --
-- Parent Frame: MissingTradeSkillsListFrame									--
-- Container for:																--
--					SkillButton													--
--					VerticalSlider												--
----------------------------------------------------------------------------------

MTSLUI_MTSLF_MissingSkillsListFrame = {
	-- Keeps the current created frame
	frame,
	-- Maximum amount of items shown at once
	MAX_ITEMS_SHOWN = 18,
	-- array holding the buttons of this frame
	SKILLS_BUTTONS,
	-- Offset in de list (based on slider)
	slider_offset = 1,
	-- index of the selected skill
	selected_skill_index,
	-- index of the selected button
	selected_button_index,
	-- Flag to check if slider is active or not
	slider_active,
	-- width of the frame
	FRAME_WIDTH = MTSLUI_Core.FRAME_WIDTH_LEFTFRAME,
	-- height of the frame
	FRAME_HEIGHT = 363,
	
	----------------------------------------------------------------------------------------------------------
	-- Intialises the MissingSkillsListFrame
	--
	-- @parent_frame		Frame		The parent frame
	----------------------------------------------------------------------------------------------------------
	Initialise = function(self, parent_frame)
		self.frame = MTSLUI_Core:CreateScrollFrame(self, parent_frame, self.FRAME_WIDTH, self.FRAME_HEIGHT, true, self.MAX_ITEMS_SHOWN, 18)
		-- position under TitleFrame and above MissingSkillsListFrame
		self.frame:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", 5, -40)
		-- Create the buttons
		self.SKILLS_BUTTONS = {}
		local left = 7
		local top = -6
		for i=1,self.MAX_ITEMS_SHOWN do
			-- Create a new button by making a copy of MTSLUI_MTSLF_MSLF_SkillButton
			local skill_button = MTSL_Tools:CopyObject(MTSLUI_MTSLF_MSLF_SkillButton)
			skill_button:Initialise(self.frame, i, left, top)
			-- adjust top position for next button
			top = top - 19
			-- add button to list
			table.insert(self.SKILLS_BUTTONS, skill_button)
		end
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Updates the list of MissingSkillsListFrame
	----------------------------------------------------------------------------------------------------------
	UpdateList = function (self)
		-- No need for slider
		if MTSL.MISSING_SKILLS_AMOUNT <= self.MAX_ITEMS_SHOWN then
			self.slider_active = 0
			self.frame.slider:Hide()
		else
			self.slider_active = 1
			local max_steps = MTSL.MISSING_SKILLS_AMOUNT - self.MAX_ITEMS_SHOWN + 1
			self.frame.slider:Refresh(max_steps, self.MAX_ITEMS_SHOWN)
			self.frame.slider:Show()
		end
		self:UpdateButtons()
		self:SelectInformationFrame()
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Updates the skillbuttons of MissingSkillsListFrame
	----------------------------------------------------------------------------------------------------------
	UpdateButtons = function (self)
		for i=1,self.MAX_ITEMS_SHOWN do
			-- 1 cause offset starts at 1 too, 
			local skill_for_button = MTSL.MISSING_SKILLS[i + self.slider_offset - 1]
			-- Check if button has text to display, otherwise hide it
			if skill_for_button ~= nil then
				-- create the text to be shown
				local text_for_button = MTSLUI_Fonts.colors.available.yes
				if skill_for_button.min_skill > MTSL.CURRENT_TRADESKILL.SKILL_LEVEL then
					text_for_button = MTSLUI_Fonts.colors.available.no
				end
				text_for_button = text_for_button .. "[" .. skill_for_button.min_skill .. "] " .. MTSLUI_Fonts.colors.text.normal .. skill_for_button.name
				-- update & show the button
				self.SKILLS_BUTTONS[i]:Refresh(text_for_button)
				self.SKILLS_BUTTONS[i]:Show()
			-- button is unavaible so hide it
			else
				self.SKILLS_BUTTONS[i]:Hide()
			end
		end
	end,
		
	----------------------------------------------------------------------------------------------------------
	-- Handles the event when skill button is pushed
	--
	-- @id		Number		The id (= index) of button that is pushed
	----------------------------------------------------------------------------------------------------------
	HandleSkillButtonSelect = function(self, id)
		-- Clicked on same button so deselect it
		if self.SKILLS_BUTTONS[id]:IsSelected() == 1 then
			self.selected_skill_index = nil
			self.selected_button_index = nil
			self.SKILLS_BUTTONS[id]:Deselect()
		-- Selecting a fresh skill
		else
			-- Deselect the current button if visible
			self:DeselectCurrentSkillButton()
			-- update the index of selected button
			self.selected_button_index = id
			self:SelectCurrentSkillButton()
			-- Subtract 1 because index starts at 1 instead of 0
			self.selected_skill_index = self.slider_offset + id - 1
			-- Show the information of the selected skill
			local selected_skill = MTSL:GetMissingSkillCurrentTradeSkillByIndex(self.selected_skill_index)
			MTSLUI_MTSLF_DetailsSelectedSkillFrame:ShowDetailsOfSkill(selected_skill)
		end		
		
		self:SelectInformationFrame()
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Shows the correct information/detail frame based on the situation
	----------------------------------------------------------------------------------------------------------
	SelectInformationFrame = function (self)		
		-- Only Act if frames exist 
		if MTSLUI_MTSLF_NoSkillSelectedFrame ~= nil and MTSLUI_MTSLF_DetailsSelectedSkillFrame ~= nil then
			-- if no skill is selected
			if self.selected_skill_index == nil then
				MTSLUI_MTSLF_NoSkillSelectedFrame:Show()
				MTSLUI_MTSLF_DetailsSelectedSkillFrame:Hide()
			else
				MTSLUI_MTSLF_NoSkillSelectedFrame:Hide()
				MTSLUI_MTSLF_DetailsSelectedSkillFrame:Show()
			end
		end
	end, 
	----------------------------------------------------------------------------------------------------------
	-- Handles the event when we scroll
	--
	-- @offset	Number
	----------------------------------------------------------------------------------------------------------
	HandleScrollEvent = function (self, offset)
		-- Only handle the event if slider is visible
		if self.slider_active == 1 then
			-- Update the index of the selected skill if any
			if self.selected_skill_index ~= nil then
				-- Deselect the current button if visible
				self:DeselectCurrentSkillButton()
				-- adjust index of the selected skill in the list
				local scroll_gap = offset - self.slider_offset
				self.selected_skill_index = self.selected_skill_index - scroll_gap
				self.selected_button_index = self.selected_button_index - scroll_gap
				-- Select the current button if visible
				self:SelectCurrentSkillButton()
			end
			-- Update the offset for the slider
			self.slider_offset = offset
			-- update the text on the buttons based on the new "visible" skills
			self:UpdateButtons()
		end
	end,

	----------------------------------------------------------------------------------------------------------
	-- reset the position of the scroll bar & deselect current skill
	----------------------------------------------------------------------------------------------------------
	Reset = function(self)
		-- dselect current skill & button
		self:DeselectCurrentSkillButton()
		self.selected_skill_index = nil
		self.selected_button_index = nil
		-- Scroll all way to top
		self:HandleScrollEvent(1)
		self:SelectInformationFrame()
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Selects the current selected skillbuton
	----------------------------------------------------------------------------------------------------------
	SelectCurrentSkillButton = function (self)
		if self.selected_button_index ~= nil and
			self.selected_button_index >= 1 and 
			self.selected_button_index <= self.MAX_ITEMS_SHOWN then
			self.SKILLS_BUTTONS[self.selected_button_index]:Select()
		end
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Deselects the current selected skillbuton
	----------------------------------------------------------------------------------------------------------
	DeselectCurrentSkillButton = function (self)
		if self.selected_button_index ~= nil and
			self.selected_button_index >= 1 and 
			self.selected_button_index <= self.MAX_ITEMS_SHOWN then
			self.SKILLS_BUTTONS[self.selected_button_index]:Deselect()
		end
	end,
}