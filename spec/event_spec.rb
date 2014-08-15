require 'spec_helper'

describe Event do
  I18n.enforce_available_locales = false

  it { should validate_presence_of :description }
  it { should validate_uniqueness_of :description }

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

  describe ".all_by_date" do
    it "returns all of the events that take place today" do
      event_yesterday = Event.create({:description => "sleep",
                                      :start_date => Date.today - 1,
                                      :end_date => Date.today - 1})

      event_today = Event.create({:description => "sleep off hangover from tech thingy",
                                  :start_date => Date.today, :end_date => Date.today})

      expect(Event.all_by_date).to eq [event_today]

    end

    it "returns all of the events taking place this week" do
      event_tomorrow = Event.create({:description => "Save World",
                                      :start_date => Date.today + 1,
                                      :end_date => Date.today + 1})

      event_after_tomorrow = Event.create({:description => "Destroy World",
                                      :start_date => Date.today + 2,
                                      :end_date => Date.today + 2})

      event_yesterday = Event.create({:description => "have early mid-life crisis",
                                      :start_date => Date.today - 1,
                                      :end_date => Date.today - 1})

      expect(Event.all_by_date(Date.today, Date.today + 7)).to eq [event_tomorrow, event_after_tomorrow]
    end
  end

  describe ".to_dos" do
    it 'will list all to-dos' do
      to_do = Event.create({:description => "Active Record Assessment"})
      to_do_two = Event.create({:description => "Update Linkedin"})
      expect(Event.to_dos).to eq [to_do, to_do_two]
    end
  end
end
