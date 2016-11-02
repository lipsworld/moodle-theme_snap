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
# Tests for course resource and activity editing features.
#
# Renderable for course section navigation.
# @package   theme_snap
# @author    Guy Thomas <gthomas@moodlerooms.com>
# @copyright Copyright (c) 2016 Blackboard Inc.
# @license   http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later

@theme @theme_snap
Feature: When the moodle theme is set to Snap, students do not see the course admin menu for 'topics', 'weeks',
  'folderview' and 'singleactivity' - for any other format they do.
  Note, folderview is not a core format and therefore is exculded from the tests.

  Background:
    Given the following config values are set as admin:
      | theme | snap |
      | defaulthomepage | 0 |
    And the following "courses" exist:
      | fullname | shortname | category | format |
      | Course 1 | C1        | 0        | topics |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | student1 | Student   | 1        | student1@example.com |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |

  @javascript
  Scenario Outline: When on main course page, user can / cannot access course admin menu. Students can access menu for
  any format except topics, weeks, singleactivity and folderview. Teachers can access menu for all course formats.
    Given the course format for "C1" is set to "<format>"
    And I log in as "<user>" (theme_snap)
    And I am on the course main page for "C1"
    Then "#admin-menu-trigger" "css_element" should <existornot>
  Examples:
    | user     | format         | existornot |
    | student1 | topics         | not exist  |
    | student1 | weeks          | not exist  |
    | student1 | singleactivity | not exist  |
    | student1 | social         | exist      |
    | teacher1 | topics         | exist      |
    | teacher1 | weeks          | exist      |
    | teacher1 | singleactivity | exist      |
    | teacher1 | social         | exist      |

  @javascript
  Scenario Outline: When not on main course page, user can / cannot access course admin menu. Students cannot
  access menu for any format. Teacher can access menu for all course formats.
    Given the course format for "C1" is set to "<format>"
    And I log in as "<user>" (theme_snap)
    And I am on the course "resources" page for "C1"
    Then "#admin-menu-trigger" "css_element" should <existornot>
  Examples:
    | user     | format         | existornot |
    | student1 | topics         | not exist  |
    | student1 | weeks          | not exist  |
    | student1 | singleactivity | not exist  |
    | student1 | social         | not exist  |
    | teacher1 | topics         | exist      |
    | teacher1 | weeks          | exist      |
    | teacher1 | singleactivity | exist      |
    | teacher1 | social         | exist      |
