RSpec.describe Pomodoro do
  context "#state" do
    it "begins unstarted" do
      pomodoro = Pomodoro.new
      expect(pomodoro.state).to be(:unstarted)
    end

    it "becomes active when started" do
      pomodoro = Pomodoro.new
      pomodoro.start
      expect(pomodoro.state).to be(:active)
    end

    it "becomes completed when finished" do
      pomodoro = Pomodoro.new
      pomodoro.finish
      expect(pomodoro.state).to be(:completed)
    end
  end

  context "#duration" do
    it "displays minutes" do
      pomodoro = Pomodoro.done(in: 20.minutes)
      expect(pomodoro.duration).to eq("20m")
    end

    it "rounds to the nearest minute" do
      pomodoro = Pomodoro.done(in: (20.minutes + 35.seconds))
      expect(pomodoro.duration).to eq("21m")
    end

    it "is nil if @duration is nil" do
      pomodoro = Pomodoro.done()
      expect(pomodoro.duration).to be_nil
    end
  end
end
