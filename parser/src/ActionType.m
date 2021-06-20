classdef ActionType
    
    properties(Access = private, Constant)
        ACTIONS =	{	uint32(0), 'PAUSE';...
            uint32(1), 'ACTIVITY1';...
            uint32(2), 'ACTIVITY2';...
            uint32(3), 'ACTIVITY3';...
            uint32(4), 'ACTIVITY4';...
            uint32(5), 'ACTIVITY5';...
            uint32(6), 'ACTIVITY6';...
            uint32(7), 'ACTIVITY7';...
            uint32(8), 'ACTIVITY8';...
            uint32(9), 'ACTIVITY9';...
            uint32(10), 'ACTIVITY10';...           
            };
    end
    
    % COMPUTED PROPERTIES (for octave compatibility)
    methods(Access = private, Static)
        function result = actionNameMap(v) % id -> name
            persistent value;
            if isempty(value)
                value = containers.Map({ActionType.ACTIONS{:,1}}, {ActionType.ACTIONS{:,2}});
            end
            result = value(uint32(v)); % uint32 OCTAVE BUG
        end
        function result = actionIdMap(v) % name -> id
            persistent value;
            if isempty(value)
                value = containers.Map({ActionType.ACTIONS{:,2}}, {ActionType.ACTIONS{:,1}});
            end
            result = value(v);
        end
        
        function result = actionColorMap(v)
            persistent value;
            if isempty(value)
                colorPalette = hsv(single(length(ActionType.ACTIONS)));
                colorPalette = arrayfun(@(i) colorPalette(i,:), 1:size(colorPalette, 1), 'UniformOutput', false);
                value = containers.Map({ActionType.ACTIONS{:,1}}, colorPalette);
            end
            result = value(uint32(v)); % uint32 OCTAVE BUG
        end
    end
    
    methods(Access = public, Static)
        function actionId = actionNames2Id(actionNames)
            if iscell(actionNames)
                actionId = cellfun(@(a) ActionType.actionIdMap(a), actionNames);
            elseif ischar(actionNames)
                actionId = ActionType.actionIdMap(actionNames);
            else
                error('actionName has to either be a char, or a cell-array of chars');
            end
        end
        function actionColors = actions2Color(actions)
            actionColors = arrayfun(@(a) ActionType.actionColorMap(a), actions, 'UniformOutput', false);
            actionColors = reshape([actionColors{:}], 3, length(actions))';
        end
        function actionNames = action2Names(actions)
            actionNames = arrayfun(@(a) ActionType.actionNameMap(a), actions, 'UniformOutput', false);
        end
        function actionName = action2Name(action)
            assert(isnumeric(action), 'Single action has to be an integer.');
            actionName = ActionType.actionNameMap(action);
        end
    end
    
end

