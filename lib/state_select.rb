# StateSelect
module ActionView
  module Helpers
    module FormOptionsHelper
      STATE_SELECT_MODEL_NAME  = "State" unless const_defined?("STATE_SELECT_MODEL_NAME")
      STATE_SELECT_MODEL_FIELD = "name"  unless const_defined?("STATE_SELECT_MODEL_FIELD")
      
      # Return select and option tags for the given object and method, using state_options_for_select to generate the list of option tags.
      def state_select(object, method, priority_states = nil, options = {}, html_options = {})
        # If no model name given, use the constant
        options.reverse_merge!({ :model_name => STATE_SELECT_MODEL_NAME })
        
        InstanceTag.new(object, method, self, options.delete(:object)).to_state_select_tag(priority_states, options, html_options)
      end
      # Returns a string of option tags for all states in the database. Supply a state name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of states as +priority_states+,
      # so that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def state_options_for_select(selected = nil, priority_states = nil, model_name = STATE_SELECT_MODEL_NAME)
        state_options = ""
        
        if priority_states
          state_options += options_for_select(priority_states.collect{ |state| [state.name, state.id] }, selected)
          state_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end

        return state_options + options_for_select(model_name.constantize.all.collect{ |state| [ state.name, state.id ] }, selected)
      end
    end
    
    class InstanceTag
      def to_state_select_tag(priority_states, options, html_options)
        html_options = html_options.stringify_keys
        model_name   = options[:model_name]
        add_default_name_and_id(html_options)
        value = value(object).to_i                                                # Convert to integer in case the ID is stored as a string in the ORM
        content_tag("select",
          add_options(
            state_options_for_select(value, priority_states, model_name),
            options, value
          ), html_options
        )
      end
    end
    
    class FormBuilder
      def state_select(method, priority_states = nil, options = {}, html_options = {})
        @template.state_select(@object_name, method, priority_states, options.merge(:object => @object), html_options)
      end
    end
  end
end