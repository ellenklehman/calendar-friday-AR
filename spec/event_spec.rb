require 'spec_helper'

describe Event do
  describe ".all_ordered" do
    it 'will list out events in the order in which they occur' do
      another_event = Event.create({:description => 'Feed the cat', :location => 'home', :start_date => Date.today + 2, :end_date => Date.today + 2})
      new_event = Event.create({:description => 'Walk the dog', :location => 'park', :start_date => Date.today + 1, :end_date => Date.today + 1})
      expect(Event.all_ordered).to eq [new_event, another_event]
    end

    it "will only return future events" do
      event_yesterday = Event.create({:description => "sleep",
                                      :start_date => Date.today - 1,
                                      :end_date => Date.today - 1})

      event_nextweek = Event.create({:description => "get a haircut",
                                      :start_date => Date.today + 7,
                                      :end_date => Date.today + 7})

      event_tomorrow = Event.create({:description => "party",
                                      :start_date => Date.today + 1,
                                      :end_date => Date.today + 1})

      event_nextmonth = Event.create({:description => "eat cake alone",
                                      :start_date => Date.today >> 1,
                                      :end_date => Date.today >> 1})

      expect(Event.all_ordered).to eq [ event_tomorrow,
                                        event_nextweek,
                                        event_nextmonth]

    end

  end
end
