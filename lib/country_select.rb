# CountrySelect
module ActionView
  module Helpers
    module FormOptionsHelper
      COUNTRY_SELECT_MODEL_NAME  = "Country" unless const_defined?("COUNTRY_SELECT_MODEL_NAME")
      COUNTRY_SELECT_MODEL_FIELD = "name"    unless const_defined?("COUNTRY_SELECT_MODEL_FIELD")
      
      # Return select and option tags for the given object and method, using country_options_for_select to generate the list of option tags.
      def country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(priority_countries, options, html_options)
      end
      # Returns a string of option tags for pretty much any country in the world. Supply a country name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of countries as +priority_countries+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def country_options_for_select(selected = nil, priority_countries = nil)
        country_options = ""

        if priority_countries
          priority_countries.each do |priority_country|
            country = COUNTRY_SELECT_MODEL_NAME.constantize.find_by_name priority_country
            country_options += options_for_select({ country.name => country.id}, selected)
          end
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end

        return country_options + options_for_select(COUNTRIES.collect{ |country| [ country.name, country.id ] }, selected)
      end
      # All the countries included in the country_options output.
      COUNTRIES = COUNTRY_SELECT_MODEL_NAME.constantize.all
    end
    
    class InstanceTag
      def to_country_select_tag(priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            country_options_for_select(value, priority_countries),
            options, value
          ), html_options
        )
      end
    end
    
    class FormBuilder
      def country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end