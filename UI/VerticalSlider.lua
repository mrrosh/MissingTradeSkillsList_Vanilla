----------------------------------------------------------------------
-- Name: VerticalSlider												--
-- Description: Contains all functionality for the vertical slider	--
-- Parent Frame: -													--
----------------------------------------------------------------------

MTSLUI_VerticalSlider = {
	frame,
	-- Scroll 1 item at a time
	SLIDER_STEP = 1,
	-- width of the slider
	FRAME_WIDTH = 30,
	STEP_HEIGHT = 18,
	----------------------------------------------------------------------------------------------------------
	-- Intialises the VerticalSlider
	--
	-- @parent_class		Class		The lua class that owns the sliderframe
	-- @parent_frame		Frame		The parent frame
	-- @slider_steps		Number		The mount of steps the vertical slider has
	-- @height_step			Number		The height of 1 step in the slider
	----------------------------------------------------------------------------------------------------------PrintMessage
	Initialise = function (self, parent_class, parent_frame, slider_steps, height_step)
		self.STEP_HEIGHT = height_step
		-- Calculate the height (-4 for borders parentframe)
		local height = slider_steps * self.STEP_HEIGHT - 2
		self.frame = MTSLUI_Core:CreateBaseFrame("Slider", "", parent_frame, "UIPanelScrollBarTemplate", self.FRAME_WIDTH, height, false)
		self.frame:SetPoint("RIGHT", parent_frame, "RIGHT", 2, 0)
		self.frame:SetValueStep(self.SLIDER_STEP)
		-- parent frame handles the scrolling event
		self.frame:SetScript("OnValueChanged", function()
			parent_class:HandleScrollEvent(this:GetValue())
		end)			
		-- Enable scrolling with mousewheel
		self.frame:EnableMouseWheel(true)
		self.frame:SetScript("OnMouseWheel", function()
			-- scroll up on positive delta
			if arg1 > 0 then
				self:ScrollUp()
			else
				self:ScrollDown()
			end
		end)
		return self
	end,
		
	---------------------------------------------------------------------------------------
	-- Refresh the slider
	-- When opening other tradeskill frame, amount of staps might have to be altered
	--
	-- @max_steps				number		Total amount of steps the slider has
	-- @amount_visibile_steps	number		The amount of visible steps/items in the slider
	----------------------------------------------------------------------------------------
	Refresh = function(self, max_steps, amount_visibile_steps)
		-- Calculate the height (-4 for borders)
		local height = amount_visibile_steps * self.STEP_HEIGHT - 2
		self.frame:SetHeight(height)
		self.frame:SetMinMaxValues(1, max_steps)
		-- Select top step
		self.frame:SetValue(0)
	end,

	---------------------------------------------------------------------------------------
	-- Hides the slider
	----------------------------------------------------------------------------------------
	Hide = function (self) 
		if self.frame ~= nil then
			self.frame:Hide()
		end
	end,
	
	---------------------------------------------------------------------------------------
	-- Shows the slider
	----------------------------------------------------------------------------------------
	Show = function (self)
		-- Create frame first
		if self.frame == nil then
			self:Initialise()
		end
		self.frame:Show()
	end,
			
	---------------------------------------------------------------------------------------
	-- Sets the height of  the slider
	----------------------------------------------------------------------------------------
	SetHeight = function (self, height)
		-- Only set if frame is made
		if self.frame ~= nil then
			self.frame:SetHeight(height)
		end
	end,

	---------------------------------------------------------------------------------------
	-- Scrolls the slider up by SLIDER_STEP
	----------------------------------------------------------------------------------------
	ScrollUp = function (self)
		local new_value = self.frame:GetValue() - self.SLIDER_STEP
		-- Set the new value of the slider, this executes "OnValueChanged"
		-- Does not set new value if not in MinMaxValues range
		self.frame:SetValue(new_value)
	end,
	
	---------------------------------------------------------------------------------------
	-- Scrolls the slider down by SLIDER_STEP
	----------------------------------------------------------------------------------------
	ScrollDown = function (self)
		local new_value = self.frame:GetValue() + self.SLIDER_STEP
		-- Set the new value of the slider, this executes "OnValueChanged"
		-- Does not set new value if not in MinMaxValues range
		self.frame:SetValue(new_value)
	end,
}