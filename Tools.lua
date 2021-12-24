-----------------------------------------------------------
-- Name: Tools											 --
-- Description: Contains all utilities & tools functions --
-----------------------------------------------------------

MTSL_Tools = {
	----------------------------------------------------------------------------------------------------------
	-- Creates a deep copy of an object
	--
	-- @orig		Object		The original object to copy
	--
	-- returns		Object		A copy of the original object
	----------------------------------------------------------------------------------------------------------
	CopyObject = function (self, orig)
		local orig_type = type(orig)
		local copy
		if orig_type == 'table' then
	        copy = {}
			for orig_key, orig_value in next, orig, nil do
	            copy[self:CopyObject(orig_key)] = self:CopyObject(orig_value)
			end
			setmetatable(copy, self:CopyObject(getmetatable(orig)))
		else -- number, string, boolean, etc
	        copy = orig
	    end
	    return copy
	end,

	----------------------------------------------------------------------------------------------------------
	-- Searches for an item by id in an unsorted list
	--
	-- @list		Array		The lsit in which to search
	-- @id			Number		The id to search for
	--
	-- returns		Object		The item with the corresponding id or nil if not found
	----------------------------------------------------------------------------------------------------------
	GetItemFromUnsortedListById = function(self, list, id)
		if list ~= nil then
			local i = 1
			-- lists are sorted on id (low to high)
			while list[i] ~= nil and list[i].id ~= id do
				i = i + 1
			end
		
			return list[i]
		end
		return nil
	end,

	----------------------------------------------------------------------------------------------------------
	-- Searches for an item by id in a sorted list
	--
	-- @list		Array		The lsit in which to search
	-- @id			Number		The id to search for
	--
	-- returns		Object		The item with the corresponding id or nil if not found
	----------------------------------------------------------------------------------------------------------
	GetItemFromSortedListById = function(self, list, id)
		if list ~= nil then
			local i = 1
			-- lists are sorted on id (low to high) so stop when id in array >= id we search
			while list[i] ~= nil and list[i].id < id do
				i = i + 1
			end
			-- item found in list so return it
			if list[i] ~= nil and list[i].id == id then
				return list[i]
			end
		end
		-- item not found in the list
		return nil
	end,

	----------------------------------------------------------------------------------------------------------
	-- Counts the number of elements in the list
	--
	-- @list		Array		The list to count items from
	--
	-- returns		Number		The amount of items
	----------------------------------------------------------------------------------------------------------
	CountItemsInArray = function(self, list)
		if list ~= nil then
			local i = 1
			while list[i] ~= nil do
				i = i + 1
			end
			return (i - 1)
		end
		return 0
	end,
	
	----------------------------------------------------------------------------------------------------------
	-- Counts the number of elements in the list
	--
	-- @t			Array			The list with keys
	-- @f			Sort Function	Custom sort function (optional)
	--
	-- returns		Iterable		The list with sorted key
	----------------------------------------------------------------------------------------------------------
	GiveKeysSorted = function (self, t, f)
		local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if a[i] == nil then
				return nil
			else 
				return a[i], t[a[i]]
			end
		end
		return iter
	end,
}