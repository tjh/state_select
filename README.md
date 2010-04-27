StateSelect
=============

Provides a simple helper to get an HTML select list of states.  The list of states comes from an ActiveRecord model.

Based on the original work of Michael Koziarski on country_select

Example
=======

The plugin defaults to using the "State" model with field "Name". Override STATE_SELECT_MODEL_NAME and STATE_SELECT_MODEL_FIELD for different behavior.

    state_select("user", "state_name")

Create a selector for a province (using the "model_name" to override the default "State" model. Also, pass an array of provinces that should show up at the top of the list.

    form_for @user do |form|
      form.state_select :province, Province.priority_provinces, { :model_name => "Province"}
    end

Changelog
=========

* 4/27/2010 - Priority states are now passed as an array of objects that respond to #id and #name. Used to accept a simple array of strings that were looked up in the db individually (slow)

Copyright (c) 2010 Tim Harvey, released under the MIT license
