# This file is part of Moodle - http://moodle.org/
#
# Moodle is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Moodle is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Moodle.  If not, see <http://www.gnu.org/licenses/>.
#
# Tests course edting mode.
#
# @package    theme_snap
# @copyright Copyright (c) 2015 Moodlerooms Inc. (http://www.moodlerooms.com)
# @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later


@theme @theme_snap
Feature: When the moodle theme is set to Snap, teachers only see block edit controls when in edit mode.

  Background:
    Given the following config values are set as admin:
      | theme | snap |
    And the following "courses" exist:
      | fullname | shortname | category | format |
      | Course 1 | C1        | 0        | topics |
    And the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | student1 | Student   | 1        | student1@example.com |
    And the following "course enrolments" exist:
      | user     | course | role |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student |
    And the following "activities" exist:
      | activity | course | idnumber | name             | intro                         | section |
      | assign   | C1     | assign1  | Test assignment1 | Test assignment description 1 | 1       |

  @javascript
  Scenario: In read mode, teacher clicks edit blocks and can edit blocks.
    Given I log in with snap as "teacher1"
    And I follow "Menu"
    And I follow "Course 1"
    And I wait until the page is ready
    And I follow "Topic 1"
   Then "#section-1" "css_element" should exist
    And ".block_news_items a.toggle-display" "css_element" should not exist
    And I should see "Test assignment1" in the "#section-1" "css_element"
    And I follow "Course Tools"
    And I follow "Edit course blocks"
    And I wait until the page is ready
    And I should not see "Test assignment1" in the "#section-1" "css_element"
    And ".block_news_items a.toggle-display" "css_element" should exist

