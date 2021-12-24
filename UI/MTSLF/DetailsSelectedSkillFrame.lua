------------------------------------------------------------------
-- Name: DetailsSelectedSkillFrame							    --
-- Description: Frame showing the details of the selected skill --
-- Parent Frame: MissingTradeSkillsListFrame					--
------------------------------------------------------------------

MTSLUI_MTSLF_DetailsSelectedSkillFrame = {	
	frame, 
	-- array holding all labels shown on this panel, for easy acces later
	labels = {
		name = {},
		min_skill = {},
		requires_xp = {},
		requires_rep = {},
		special_action = {},
		price = {},
		type = {},
		sources = {},
		alt_type ={},
		alt_sources = {},
	},
	sources = {
		main = {
			npcs = {},
			objects = {},
			items = {},
		},
		alt = {
			npcs = {},
			objects = {},
			items = {},
		},
	},
	-- keep id of the skill from which the information is shown
	skill_id,
	-- width of the frame
	FRAME_WIDTH = MTSLUI_Core.FRAME_WIDTH_RIGHTFRAME,
	-- height of the frame
	FRAME_HEIGHT = 363,
	-- height of the sources frame
	FRAME_SOURCES_HEIGHT = 250,
	FRAME_SOURCES_HEIGHT_SPLIT = 125,
	-- Define how many sources can be shown at once
	-- Only 1 source type is shown
	MAX_SOURCES_SHOWN_NOSPLIT = 15,
	-- When 2 source types are shown
	MAX_SOURCES_SHOWN_SPLIT = 7,
	-- Current amount of sources shown at this time
	current_max_sources_shown,
	-- Split active if we show 2 source types at once, disabled on load
	split_active = 0,
	-- Indicates if vertical scroll bar is active (disabled on load)
	slider_active = 0,
	alt_slider_active = 0,
	-- Offset in de list (based on slider)
	slider_offset = 1,
	alt_slider_offset = 1,

	----------------------------------------------------------------------------------------------------------
	-- Intialises the DetailsSelectedSkillFrame
	--
	-- @parent_frame		Frame		The parent frame
	----------------------------------------------------------------------------------------------------------
	Initialise = function (self, parent_frame)
		-- default no split so set correct max sources shown in scrollist
		self.current_max_sources_shown = self.MAX_SOURCES_SHOWN_NOSPLIT
		-- create the frame
		self.frame = MTSLUI_Core:CreateBaseFrame("Frame", "", parent_frame, nil, self.FRAME_WIDTH, self.FRAME_HEIGHT, true)
		-- position under MissingSkillsListFrame and above ProgressBar
		self.frame:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", MTSLUI_Core.FRAME_WIDTH_LEFTFRAME + 3, -40)
		--  Black background
		self.frame:SetBackdropColor(0,0,0,1)
		-- Add the Texts/Strings to the frame
		local text_label_left = 10
		local text_label_right = 115
		local text_label_top = -8
		local text_gap = 16
		-- Labels to show "name: <name>"
		self.labels.name.title = MTSLUI_Core:CreateLabel(self.frame, "Name:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.name.value = MTSLUI_Core:CreateLabel(self.frame, "", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Required skill: <min skill>"
		self.labels.min_skill.title = MTSLUI_Core:CreateLabel(self.frame, "Needs skill level:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.min_skill.value = MTSLUI_Core:CreateLabel(self.frame, "", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Required XP level: <xp level>"
		self.labels.requires_xp.title = MTSLUI_Core:CreateLabel(self.frame, "Needs XP level:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.requires_xp.value = MTSLUI_Core:CreateLabel(self.frame, "", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Required reputation: <reputation>"
		self.labels.requires_rep.title = MTSLUI_Core:CreateLabel(self.frame, "Needs reputation:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.requires_rep.value = MTSLUI_Core:CreateLabel(self.frame, "", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Special action <special action>"
		self.labels.special_action.title = MTSLUI_Core:CreateLabel(self.frame, "Special action:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.special_action.value = MTSLUI_Core:CreateLabel(self.frame, "", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Price: <price>"
		self.labels.price.title = MTSLUI_Core:CreateLabel(self.frame, "Price:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.price.value = MTSLUI_Core:CreateLabel(self.frame, "", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Learned from: <type>"
		self.labels.type.title = MTSLUI_Core:CreateLabel(self.frame, "Learned from:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.type.value = MTSLUI_Core:CreateLabel(self.frame, "", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Trained by: <trainers> or Sold by: <vendors> or Dropped by: <mobs> or Obtained from: <quest>"
		self.labels.sources.title = MTSLUI_Core:CreateLabel(self.frame, "Learned from:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		-- Create a scrollable frame to show the sources
		self.labels.sources.frame = MTSLUI_Core:CreateScrollFrame(self, self.frame, self.FRAME_WIDTH - 102, self.FRAME_SOURCES_HEIGHT, false, self.MAX_SOURCES_SHOWN_NOSPLIT, 14)
		-- position under MissingSkillsListFrame and above ProgressBar
		self.labels.sources.frame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", text_label_right - 9, text_label_top + 7)
		-- we have MAX_SOURCES_SHOWN we can show at same time
		self.labels.sources.values = {}
		text_label_top = -8
		text_label_right = 10
		-- Create the labels for sources
		for i=1,self.MAX_SOURCES_SHOWN_NOSPLIT do
			local string_sources_content = MTSLUI_Core:CreateLabel(self.labels.sources.frame, i, text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
			text_label_top = text_label_top - text_gap
			table.insert(self.labels.sources.values, string_sources_content)
		end
		text_label_right = 115
		text_label_top = text_label_top + text_gap
		self.labels.alt_type.title = MTSLUI_Core:CreateLabel(self.frame, "Also learned from:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		self.labels.alt_type.value = MTSLUI_Core:CreateLabel(self.frame, "Secundary source", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		text_label_top = text_label_top - text_gap
		-- Labels to show "Trained by: <trainers> or Sold by: <vendors> or Dropped by: <mobs> or Obtained from: <quest>"
		self.labels.alt_sources.title = MTSLUI_Core:CreateLabel(self.frame, "Learned from:", text_label_left, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
		-- Create a scrollable frame to show the alternative sources
		self.labels.alt_sources.frame = MTSLUI_Core:CreateScrollFrame(self, self.frame, self.FRAME_WIDTH - 102, self.FRAME_SOURCES_HEIGHT_SPLIT, false, self.MAX_SOURCES_SHOWN_SPLIT, 13)
		-- custom scroll event
		self.labels.alt_sources.frame.slider.frame:SetScript("OnValueChanged", function()
			self:HandleAltScrollEvent(this:GetValue())
		end)			
		-- position under MissingSkillsListFrame and above ProgressBar
		self.labels.alt_sources.frame:SetPoint("TOPLEFT", self.labels.sources.frame, "BOTTOMLEFT", 0, 3 + text_gap)
		-- we have MAX_SOURCES_SHOWN_SPLIT we can show at same time
		self.labels.alt_sources.values = {}
		text_label_top = -8
		text_label_right = 10
		-- Create the labels for sources
		for i=1,self.MAX_SOURCES_SHOWN_NOSPLIT do
			local string_sources_content = MTSLUI_Core:CreateLabel(self.labels.alt_sources.frame, i .. " alt", text_label_right, text_label_top, MTSLUI_Fonts.size.small, "TOPLEFT")
			text_label_top = text_label_top - text_gap
			table.insert(self.labels.alt_sources.values, string_sources_content)
		end

		-- Dont show on creation
		self.frame:Hide()
	end,
		
	---------------------------------------------------------------------------
	-- Show the details of a skill (based on its type)
	--
	-- @skill		MTSLDATA	The skill of which the information must be shown
	---------------------------------------------------------------------------
	ShowDetailsOfSkill = function(self, skill)
		if skill ~= nil then
			-- Set the id to all detail panels
			self.skill_id = skill.id
			-- Generic labelsetting for every type
			self.labels.name.value:SetText(MTSLUI_Fonts.colors.text.normal .. skill.name)
			-- Color the label red or green depending on our skill
			if MTSL.CURRENT_TRADESKILL.SKILL_LEVEL >= skill.min_skill then
				self.labels.min_skill.value:SetText(MTSLUI_Fonts.colors.text.success .. skill.min_skill)
			else
				self.labels.min_skill.value:SetText(MTSLUI_Fonts.colors.text.error .. skill.min_skill)
			end
			-- Set minimum xp level
			self:SetRequiredXPLevel(skill.min_level)
			self:SetRequiredReputationWithFaction(skill.reputation)
			-- if special action is required
			if skill.special_action ~= nil then
				self.labels.special_action.value:SetText(MTSLUI_Fonts.colors.text.normal .. skill.special_action)
			else
				self.labels.special_action.value:SetText(MTSLUI_Fonts.colors.text.normal .. "-")
			end
			-- clear the price
			self.labels.price.value:SetText(MTSLUI_Fonts.colors.text.normal .. "-")
			-- clear the previously saved scroll data
			self.sources.main = {}
			self.sources.alt = {}
			
			-- Default show only primary source
			self.labels.sources.frame:SetHeight(self.FRAME_SOURCES_HEIGHT)
			self.split_active = 0
			self.current_max_sources_shown = self.MAX_SOURCES_SHOWN_NOSPLIT
			-- default hide the secundary source window
			self.labels.alt_sources.title:Hide()
			self.labels.alt_sources.frame:Hide()
			self.labels.alt_type.title:Hide()
			self.labels.alt_type.value:Hide()

			if skill.item ~= nil then
				self:ShowDetailsOfSkillTypeItem(skill.item)
			elseif skill.trainers ~= nil then
				self:ShowDetailsOfSkillTypeTrainer(skill.trainers)
			elseif skill.quests ~= nil then
				self:ShowDetailsOfSkillTypeQuest(skill.quests, 0)
			end
		end
	end,
	
	----------------------------------------------------------------------------
	-- Show the details of a minimum XP level required
	--
	-- @min_xp_level	number	The minimum XP level required to learn the skill
	----------------------------------------------------------------------------
	SetRequiredXPLevel = function (self, min_xp_level)
		-- Check if we need certain XP level to learn
		if min_xp_level ~= nil then
			-- green if we meet the level, red if we dont meet it
			if MTSL:GetPlayerXpLevel() >= min_xp_level then
				self.labels.requires_xp.value:SetText(MTSLUI_Fonts.colors.text.success .. min_xp_level)
			else
				self.labels.requires_xp.value:SetText(MTSLUI_Fonts.colors.text.error .. min_xp_level)
			end
		else
			self.labels.requires_xp.value:SetText(MTSLUI_Fonts.colors.text.normal .. "-")
		end
	end,
	
	----------------------------------------------------------------------------
	-- Show the details of a minimum reputation level required with a faction
	--
	-- @reputation	object	Contains reputation.faction & reputation.level
	----------------------------------------------------------------------------
	SetRequiredReputationWithFaction = function(self, reputation)
		-- Check if require reputation to acquire
		if reputation ~= nil then
			-- Get the levels of reputation for player and needed for recipe
			local player_standing_faction = MTSL:GetReputationLevelWithFaction(reputation.faction)
			local req_standing_faction = MTSL:GetReputationLevelByLevelName(reputation.level)
			local msg = MTSLUI_Fonts.colors.text.normal .. reputation.faction
			-- use correct color if we have the required rep or not
			if player_standing_faction >= req_standing_faction then
				msg = msg .. MTSLUI_Fonts.colors.text.success .. " [" .. reputation.level .. "]"
			else
				msg = msg .. MTSLUI_Fonts.colors.text.error .. " [" .. reputation.level .. "]"
			end
			self.labels.requires_rep.value:SetText(msg)
		else
			self.labels.requires_rep.value:SetText(MTSLUI_Fonts.colors.text.normal .. "-")
		end
	end,

	---------------------------------------------------------------------------------------------------
	-- Show the details of a skill learned from trainer
	--
	-- @trainers_info		MTSLDATA	Contains the price from trainer and list of souces with npc ids
	----------------------------------------------------------------------------------------------------
	ShowDetailsOfSkillTypeTrainer = function(self, trainers_info)
		self.labels.price.value:SetText(MTSLUI_Core:GetNumberAsMoneyString(trainers_info.price))
		self.labels.type.value:SetText(MTSLUI_Fonts.colors.text.normal .. "Trainer")
		-- Labels to show "Trained by: <trainer>"
		self.labels.sources.title:SetText(MTSLUI_Fonts.colors.text.title .. "Trained by:")
		-- Get all "available" trainers for the player
		local trainers = MTSL:GetNpcsByIds(trainers_info.sources)
		-- Show all the npcs
		self:ShowDetailsOfNpcs(trainers, self.labels.sources)
		-- save the trainers for quicker refresh on scroll event
		self.sources.main.npcs = trainers
	end,

	---------------------------------------------------------------------------------------------------------
	-- Show the details of a skill learned from quest
	--
	-- @quest_id				number	The id of the quest to show
	-- @is_alternative_source	number	Indicates if quest is primary (=0) or secundary (=1) source for skill
	----------------------------------------------------------------------------------------------------------
	ShowDetailsOfSkillTypeQuest = function(self, quest_ids, is_alternative_source)
		if is_alternative_source == 1 then
			self.split_active = 1
			self.current_max_sources_shown = self.MAX_SOURCES_SHOWN_SPLIT
			self.labels.alt_sources.title:Show()
			self.labels.alt_type.title:Show()
			self.labels.alt_type.value:Show()
		end
		
		local quest = MTSL:GetQuestByIds(quest_ids)
		-- check if quest is availbe to us
		if quest ~= nil then 
			if is_alternative_source == 1 then
				self.labels.alt_sources.title:SetText(MTSLUI_Fonts.colors.text.title .. "Started by:")
				self.labels.alt_type.value:SetText(MTSLUI_Fonts.colors.text.normal .. "Quest: " .. quest.name)
			else
				self.labels.sources.title:SetText(MTSLUI_Fonts.colors.text.title .. "Started by:")
				self.labels.type.value:SetText(MTSLUI_Fonts.colors.text.normal .. "Quest: " .. quest.name)
			end
			-- show xp level requirements if any
			self:SetRequiredXPLevel(quest.min_xp_level)
			-- show the npcs as sources that start it if any

			local amount_npcs = MTSL_Tools:CountItemsInArray(quest.npcs)
			local amount_items = MTSL_Tools:CountItemsInArray(quest.items)
		
			-- Can only be 1 source
			if amount_npcs > 0 then
				-- Get the npcs the playe can interact with
				local questgivers = MTSL:GetNpcsByIds(quest.npcs)

				-- Quest is primary source
				if is_alternative_source == 0 then
					-- Show all the questgivers
					self:ShowDetailsOfNpcs(questgivers, self.labels.sources)
					-- save the trainers for quicker refresh on scroll event
					self.sources.main.npcs = quest.npcs
				else
					self:ShowDetailsOfNpcs(questgivers, self.labels.alt_sources)
					self.sources.alt.npcs = quest.npcs
				end
			end
			-- show the items as sources
			if amount_items > 0 then
				local items = MTSL:GetItemsCurrentTradeSkillByIds(quest.items)
				-- Primary source since no npcs
				-- Quest is primary source
				if is_alternative_source == 0 then
					self:ShowDetailsOfItems(items, self.labels.sources)
					-- save the items for quicker refresh on scroll event
					self.sources.main.items = items
				else
					self:ShowDetailsOfItems(items, self.labels.alt_sources)
					self.sources.alt.items = items
				end
			end
			-- show the objects
			if quest.objects ~= nil then
				local objects = MTSL:GetObjectsByIds(quest.objects)
				-- Primary source for quest
				if is_alternative_source == 0 then
					self:ShowDetailsOfObjects(objects, self.labels.sources)
					self.sources.main.objects = objects
				else
					self:ShowDetailsOfItems(items, self.labels.alt_sources)
					self.sources.alt.objects = objects
				end
			end
		else
			if is_alternative_source == 1 then
				self.labels.alt_type.value:SetText(MTSLUI_Fonts.colors.text.normal .. "Quest")
				self:ShowDetailsOfNpcs({}, self.labels.alt_sources)
			else
				self.labels.type.value:SetText(MTSLUI_Fonts.colors.text.normal .. "Quest")
				self:ShowDetailsOfNpcs({}, self.labels.sources)
			end
		end
	end,
	
	---------------------------------------------------------------------------------------------------
	-- Show the details of a skill learned from a recipe
	--
	-- @item_id		number	The id of the item to show
	----------------------------------------------------------------------------------------------------
	ShowDetailsOfSkillTypeItem = function(self, item_id)
		-- Always only source, so make sure the frame is set correct height
		self.labels.sources.frame:SetHeight(self.FRAME_SOURCES_HEIGHT_SPLIT)
		self.current_max_sources_shown = self.MAX_SOURCES_SHOWN_NOSPLIT

		local item = MTSL:GetItemCurrentTradeSkillById(item_id)
		self:SetRequiredXPLevel(item.min_xp_level)
		self:SetRequiredReputationWithFaction(item.reputation)	
		self.labels.type.value:SetText(MTSLUI_Fonts:GetTextColorOnQuality(item.quality) .. item.name)
		-- Check the amount for each source possible
		local has_vendors = 0
		if item.vendors ~= nil then
			has_vendors = 1
		end
		local has_quests = 0
		if item.quests ~= nil then
			has_quests = 1
		end
		local has_drops = 0
		if item.drops ~= nil then
			has_drops = 1
		end
		local amount_sources = has_drops + has_vendors + has_quests
		-- check if we have more then 1 source to activate the split
		if amount_sources > 1 then
			self.split_active = 1 
			self.current_max_sources_shown = self.MAX_SOURCES_SHOWN_SPLIT
			-- adjust the height of the source frames to split situation
			self.labels.sources.frame:SetHeight(self.FRAME_SOURCES_HEIGHT_SPLIT)
			self.labels.alt_sources.frame:SetHeight(self.FRAME_SOURCES_HEIGHT_SPLIT)
			self.labels.alt_sources.title:Show()
			self.labels.alt_type.title:Show()
			self.labels.alt_type.value:Show()
		end

		-- obtained from vendors
		if has_vendors > 0 then
			self.labels.sources.title:SetText(MTSLUI_Fonts.colors.text.title .."Sold by:")
			self.labels.price.value:SetText(MTSLUI_Core:GetNumberAsMoneyString(item.vendors.price))
			-- Get all "available" vendors for the player
			local vendors = MTSL:GetNpcsByIds(item.vendors.sources)
			self:ShowDetailsOfNpcs(vendors, self.labels.sources)
			-- save the trainers for quicker refresh on scroll event
			self.sources.main.npcs = vendors
		end
		-- Obtained from a quest
		if has_quests > 0 then
			-- primary source since no vendors
			if has_vendors <= 0 then
				self:ShowDetailsOfSkillTypeQuest(item.quests, 0)
			-- secundary source
			else
				self:ShowDetailsOfSkillTypeQuest(item.quests, 1)
			-- save the quests for quicker refresh on scroll event
			end
		end
		-- Obtained as drop of a mob or range of mobs
		if has_drops > 0 then
			-- primary source since no vendors or quests
			if has_vendors <= 0 and has_quests <= 0 then
				self.labels.sources.title:SetText(MTSLUI_Fonts.colors.text.title .."Dropped by:")
				-- check if drop of mob or world drops
				if item.drops.mobs_range ~= nil then
					self:ShowWorldDropSources(item.drops.mobs_range.min_xp_level, item.drops.mobs_range.max_xp_level, self.labels.sources)
				else
					local mobs = MTSL:GetMobsByIds(item.drops.mobs)
					self:ShowDetailsOfNpcs(mobs, self.labels.sources)
					-- save the mobs for quicker refresh on scroll event
					self.sources.main.npcs = mobs
				end
			-- alternative/secundary source
			else
				self.labels.alt_type.value:SetText(MTSLUI_Fonts.colors.text.title .."Mobs")
				self.labels.alt_sources.title:SetText(MTSLUI_Fonts.colors.text.title .."Dropped by:")
				-- check if drop of mob or world drops
				if item.drops.mobs_range ~= nil then
					self:ShowWorldDropSources(item.drops.mobs_range.min_xp_level, item.drops.mobs_range.max_xp_level, self.labels.alt_sources)
				else
					local mobs = MTSL:GetMobsByIds(item.drops.mobs)
					self:ShowDetailsOfNpcs(mobss, self.labels.alt_sources)
					-- save the mobs for quicker refresh on scroll event
					self.sources.alt.npcs = mobs
				end
			end
		end
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

	---------------------------------------------------------------------------
	-- Show the details of a list of npcs as sources
	--
	-- @npcs			Array		The list of npcs
	-- @source_labels	Array		The list of labels to update
	---------------------------------------------------------------------------
	ShowDetailsOfNpcs = function(self, npcs, labels_sources)
		local array_index = self.slider_offset
		-- Count amount of trainers
		local npcs_amount = MTSL_Tools:CountItemsInArray(npcs)
		
		-- No need for slider
		if npcs_amount <= self.current_max_sources_shown then
			self.slider_active = 0
			labels_sources.frame.slider:Hide()
		else
			self.slider_active = 1
			local max_steps = npcs_amount - self.current_max_sources_shown + 1
			labels_sources.frame.slider:Refresh(max_steps, self.current_max_sources_shown)
			labels_sources.frame.slider:Show()
		end
		
		-- Not obtainable for this faction
		if npcs_amount <= 0 then
			labels_sources.values[1]:SetText("Not available for your faction!")
			labels_sources.values[1]:Show()
			-- Hide the other labels
			for i=2,self.MAX_SOURCES_SHOWN_NOSPLIT do
				labels_sources.values[i]:Hide()		
			end
		else
			self:UpdateNpcsSources(npcs, labels_sources)
		end
	end,

	---------------------------------------------------------------------------
	-- Show the details of a list of items as sources
	--
	-- @items			Array		The list of items
	-- @source_labels	Array		The list of labels to update
	---------------------------------------------------------------------------
	ShowDetailsOfItems = function(self, items, label_sources)
		local array_index = self.slider_offset
		-- Count amount of trainers
		local items_amount = MTSL_Tools:CountItemsInArray(items)

		-- No need for slider
		if items_amount <= self.current_max_sources_shown then
			self.slider_active = 0
			label_sources.frame.slider:Hide()
		else
			self.slider_active = 1
			local max_steps = items_amount - self.current_max_sources_shown + 1
			label_sources.frame.slider:Refresh(max_steps, self.current_max_sources_shown)
			label_sources.frame.slider:Show()
		end
		
		self:UpdateItemsSources(objects, label_sources)
	end,

	---------------------------------------------------------------------------
	-- Show the details of a list of objects as sources
	--
	-- @objects			Array		The list of objects
	-- @source_labels	Array		The list of labels to update
	---------------------------------------------------------------------------
	ShowDetailsOfObjects = function(self, objects, label_sources)
		local array_index = self.slider_offset
		-- Count amount of objects
		local objects_amount = MTSL_Tools:CountItemsInArray(objects)

		-- No need for slider
		if objects_amount <= self.current_max_sources_shown then
			self.slider_active = 0
			label_sources.frame.slider:Hide()
		else
			self.slider_active = 1
			local max_steps = npcs_amount - self.current_max_sources_shown + 1
			label_sources.frame.slider:Refresh(max_steps, self.current_max_sources_shown)
			label_sources.frame.slider:Show()
		end
		
		self:UpdateObjectsSources(objects, label_sources)
	end,
			
	---------------------------------------------------------------------------
	-- Show the labels of the world drop in the main list
	--
	-- @npcs	Array		The list of npcs
	-- @source_labels	Array		The list of labels to update
	---------------------------------------------------------------------------
	ShowWorldDropSources = function(self, min_level, max_level, label_sources)
		-- Only 1 source here , No need for slider
		self.slider_active = 0
		label_sources.frame.slider:Hide()
		local text = "World drop of mobs from level " .. min_level .. " to " .. max_level
		label_sources.values[1]:SetText(text)
		label_sources.values[1]:Show()
		for i=2,self.MAX_SOURCES_SHOWN_NOSPLIT do
			label_sources.values[i]:Hide()
		end
	end,
	
	---------------------------------------------------------------------------
	-- Show the details of a list of items as sources
	--
	-- @items			Array		The list of items
	-- @source_labels	Array		The list of labels to update
	---------------------------------------------------------------------------
	UpdateItemsSources = function(self, items, source_labels)
		local array_index = self.slider_offset
		for i=1,self.MAX_SOURCES_SHOWN_NOSPLIT do
			if items[array_index] ~= nil and i <= self.current_max_sources_shown then
				local text = "[item] " .. items[array_index].name .. " - " .. items[array_index].zone
				-- add coords if known
				if items[array_index].location ~= nil and items[array_index].location.x ~= "-" and
						items[array_index].location.x ~= "" then
					text = text .. " (" .. items[array_index].location.x ..", " .. items[array_index].location.y ..")"
				end
				source_labels.values[i]:SetText(text)
				source_labels.values[i]:Show()
			else				
				source_labels.values[i]:Hide()
			end			
			array_index = array_index + 1
		end
	end,

	---------------------------------------------------------------------------
	-- Show the labels of the visible objects in the main list
	--
	-- @objects			Array		The list of objects
	-- @source_labels	Array		The list of labels to update
	---------------------------------------------------------------------------
	UpdateObjectsSources = function(self, objects, source_labels)
		local array_index = self.slider_offset
		for i=1,self.MAX_SOURCES_SHOWN_NOSPLIT do
			if objects[array_index] ~= nil and i <= self.current_max_sources_shown then
				local text =  "[object] " .. objects[array_index].name .. " - " .. objects[array_index].zone
				-- add coords if known
				if objects[array_index].location ~= nil and objects[array_index].location.x ~= "-" and
						objects[array_index].location.x ~= "" then
					text = text .. " (" .. objects[array_index].location.x ..", " .. objects[array_index].location.y ..")"
				end
				source_labels.values[i]:SetText(text)
				source_labels.values[i]:Show()
			else				
				source_labels.values[i]:Hide()
			end			
			array_index = array_index + 1
		end
	end,
	
	---------------------------------------------------------------------------
	-- Show the labels of the visible NPCs in the main list
	--
	-- @npcs			Array		The list of npcs
	-- @source_labels	Array		The list of labels to update
	---------------------------------------------------------------------------
	UpdateNpcsSources = function(self, npcs, source_labels)
		local array_index = self.slider_offset
		-- Show the "visible" NPCs starting from the scroll offset
		for i=1,self.MAX_SOURCES_SHOWN_NOSPLIT do
			if npcs[array_index] ~= nil and i <= self.current_max_sources_shown then
				local text = npcs[array_index].name .. " - " .. npcs[array_index].zone
				-- add coords if known
				if npcs[array_index].location ~= nil and npcs[array_index].location.x ~= "-" and
						npcs[array_index].location.x ~= "" then
					text = text .. " (" .. npcs[array_index].location.x ..", " .. npcs[array_index].location.y ..")"
				end
				-- Check if require reputation to interact with npc
				if npcs[array_index].reputation ~= nil then
					text = text .. " [Requires ".. npcs[array_index].reputation.faction .. " - " .. npcs[array_index].reputation.level .. "]"
				end
				-- Check if special action is required to interact with npc
				if npcs[array_index].special_action ~= nil then
					text = text .. " [ ".. npcs[array_index].special_action .. "]"
				end
				-- show level of mob/npc if known
				if npcs[array_index].level ~= nil and npcs[array_index].level ~= "" and npcs[array_index].level ~= 0 then
					text = "[" .. npcs[array_index].level .. "] " .. text
				end
				source_labels.values[i]:SetText(text)
				source_labels.values[i]:Show()
			else				
				source_labels.values[i]:Hide()
			end			
			array_index = array_index + 1
		end
	end,

	---------------------------------------------------------
	-- Handle scroll event in primary source list
	---------------------------------------------------------
	HandleScrollEvent = function (self, offset)
		-- Only handle the event if slider is visible
		if self.slider_active == 1 then
			self.slider_offset = offset
			if self.sources.main.npcs ~= {} then
				self:UpdateNpcsSources(self.sources.main.npcs, self.labels.sources)
			elseif self.sources.main.objects ~= {} then
				self:UpdateObjectsSources(self.sources.main.objects, self.labels.sources)
			else
				self:UpdateItemsSources(self.sources.main.items, self.labels.sources)
			end
		end
	end,
	
	---------------------------------------------------------
	-- Handle scroll event in secundary source list
	---------------------------------------------------------
	HandleAltScrollEvent = function (self, offset)
		-- Only handle the event if slider is visible
		if self.alt_slider_active == 1 then
			self.alt_slider_offset = offset
			if self.sources.alt.npcs ~= {} then
				self:UpdateNpcsSources(self.sources.alt.npcs, self.labels.alt_sources)
			elseif self.sources.main.objects ~= {} then
				self:UpdateObjectsSources(self.sources.alt.objects, self.labels.alt_sources)
			else
				self:UpdateItemsSources(self.sources.alt.items, self.labels.alt_sources)
			end
		end
	end,
}