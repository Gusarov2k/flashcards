require 'spec_helper'

RSpec.describe Whenever do
  before do
    load 'Rakefile'
  end

  it 'makes sure `runner` statements exist' do
    schedule = Whenever::Test::Schedule.new(file: 'config/schedule.rb')

    assert_equal 1, schedule.jobs[:runner].count

    schedule.jobs[:runner].each { |job| instance_eval job[:task] }
  end

  it 'makes sure runner start every day to 11:30 Am' do
    schedule = Whenever::Test::Schedule.new(file: 'config/schedule.rb')

    # Makes sure the rake task is defined:
    assert_equal [1.day, { at: '11:30 am' }], schedule.jobs[:runner].first[:every]
  end
end
