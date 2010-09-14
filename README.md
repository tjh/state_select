StateSelect
=============

Provides a simple helper to get an HTML select list of states.  The list of states comes from an ActiveRecord model.

Based on the original work of Michael Koziarski on country_select

Example
=======

The plugin defaults to using the "State" model with field "Name".

`state_select("user", "state_name")`

Override the following for different behavior(s):

* `STATE_SELECT_MODEL_NAME`
* `STATE_SELECT_SCOPE_NAME`
* `STATE_SELECT_MODEL_FIELD`

To create a selector for a province use the `:model_name` to override the default "State" model. For priority options, simply pass an array of provinces that should show up at the top of the list. Optionally, override the "default_scope" of the model by passing in a specific `:scope_name`

    form_for @user do |form|
      form.state_select :province, Province.priority_provinces, { :model_name => "Province", :scope_name => "all_with_initial_option"}
    end

Changelog
=========

* 04/27/2010 - Priority states are now passed as an array of objects that respond to #id and #name. Used to accept a simple array of strings that were looked up in the db individually (slow)
* 09/14/2010 - Added ability to pass a named_scope as an option. Used to override the default_scope of the model.

Copyright (c) 2010 Tim Harvey, released under the MIT license
