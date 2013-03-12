# Rails Code QA

## Installation

Add the following to your gemfile

	gem 'rails_code_qa'

Add the following to your test/test_helper.rb file

	require 'simplecov'
	SimpleCov.start 'rails'

## Usage:

	#Everything:
	rake rcqa

	#Just tests and coverage:
	rake rcqa:test

	#Just Flog:
	rake rcqa:flog

	#Just Flay:
	rake rcqa:flay

## Features
### Ruby 1.8.x
No longer supported

### Ruby 1.9.x

* Runs tests with simplecov
* Runs Flog
* Runs Flay



Copyright (c) 2009-2011 Nathan Humbert, released under the MIT license
