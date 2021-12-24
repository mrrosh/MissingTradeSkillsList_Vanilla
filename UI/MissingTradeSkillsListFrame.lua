--------------------------------------------------
-- Name: MissingTradeSkillsListFrame			--
-- Description: The base frame of the addon		--
-- Container for:								--
--					TitleBar					--
--					MissingSkillsListFrame		--
--					DetailsSelectedSkillFrame	--
--					ProgressBar					--
--------------------------------------------------

MTSLUI_MissingTradeSkillsListFrame = {
	frame, 
	type, 

	----------------------------------------------------------------------------------------------------------
	-- Intialises the MissingTradeSkillsListFrame
	--
	-- @parent_frame		Frame		The parent frame
	-- @type				String		The type of the frame ("tradeskill" or "craftskill")
	----------------------------------------------------------------------------------------------------------
	Initialise = function (self, parent_frame, type)
		self.frame = MTSLUI_Core:CreateBaseFrame("Frame", "", parent_frame, nil, MTSLUI_Core.FRAME_WIDTH_MTSL, MTSLUI_Core.FRAME_HEIGHT_MTSL, true)
		-- Position next to tradeskillframe
		self.frame:SetPoint("TOPLEFT", parent_frame, "TOPRIGHT", -37, -11)
		self.frame:SetScript("OnMouseWheel", function()
			-- Dummy operation to do nothing, discarding the zooming in/out
			local x = 1
		end)
		-- Create the childframes
		MTSLUI_MTSLF_TitleFrame:Initialise(self.frame)
		MTSLUI_MTSLF_MissingSkillsListFrame:Initialise(self.frame)
		MTSLUI_MTSLF_DetailsSelectedSkillFrame:Initialise(self.frame)
		MTSLUI_MTSLF_NoSkillSelectedFrame:Initialise(self.frame)
		MTSLUI_MTSLF_EverySkillLearnedFrame:Initialise(self.frame)
		MTSLUI_MTSLF_ProgressBar:Initialise(self.frame)
		self:Hide()
		self.type = type
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Show the frame
	----------------------------------------------------------------------------------------------------------
	Show = function(self)			
		self.frame:Show()
	end,
	
	----------------------------------------------------------------------------------------------------------
	--  Hide the frame
	----------------------------------------------------------------------------------------------------------
	Hide = function (self)
		-- Only try to hide if frame is made
		if self.frame ~= nil then
			-- reset the scrollbar & deselect the skill
			MTSLUI_MTSLF_MissingSkillsListFrame:Reset()
			self.frame:Hide()
		end
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Toggle the visibility of the frame
	----------------------------------------------------------------------------------------------------------
	Toggle = function(self)
		-- Create the frame if not made yet
		if self.frame == nil then
			self:Initialise(TradeSkillFrame)
		end
		-- If window is shown, hide it
		if self.frame:IsVisible() then
			self:Hide()
		-- If it is hidden, update frame then show
		else
			-- refresh the data and ui of the addon
			self:Refresh()
			-- show the addon
			self:Show()
		end
	end,

	---------------------------------------------------------------------------------------
	-- Get visibility of the frame
	----------------------------------------------------------------------------------------
	IsVisible = function(self)
		if self.frame == nil then
			return 0
		elseif self.frame:IsVisible() then
			return 1
		else
			return 0
		end
	end,	
		
	----------------------------------------------------------------------------------------------------------
	-- Refresh the data and ui of the addon
	----------------------------------------------------------------------------------------------------------
	Refresh = function (self)
		if self.type == "TradeSkill" then
			-- Get info on opened TradeSkillFrame
			MTSL:UpdateCurrentTradeSkillInfo()
			-- Search for missing skills for this tradeskill
			MTSL:SearchMissingTradeSkills()
		else
			-- Get info on opened CraftFrame
			MTSL:UpdateCurrentCraftInfo()
			-- Search for missing skills for this craftskill
			MTSL:SearchMissingCraftSkills()
		end
		-- Refresh the UI frame showing the list of skill
		MTSLUI_MTSLF_MissingSkillsListFrame:UpdateList()
		-- update the progress bar
		local skills_max_amount = MTSL:GetTotalNumberOfSkillsCurrentTradeskill()
		MTSLUI_MTSLF_ProgressBar:UpdateStatusbar(MTSL.MISSING_SKILLS_AMOUNT, skills_max_amount)
		-- Show frame if we learned all
		if MTSL.MISSING_SKILLS_AMOUNT <= 0 then
			MTSLUI_MTSLF_EverySkillLearnedFrame:Show()
			MTSLUI_MTSLF_NoSkillSelectedFrame:Hide()
		else
			MTSLUI_MTSLF_EverySkillLearnedFrame:Hide()
			MTSLUI_MTSLF_NoSkillSelectedFrame:Show()
		end
		MTSLUI_MTSLF_DetailsSelectedSkillFrame:Hide()
	end,
}	