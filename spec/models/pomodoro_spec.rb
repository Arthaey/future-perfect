RSpec.describe Pomodoro do
  context "#state" do
    it "begins unstarted" do
      pomodoro = Pomodoro.new
      expect(pomodoro.state).to eq(:unstarted)
      expect(pomodoro.unstarted?).to eq(true)
    end

    it "becomes started" do
      pomodoro = Pomodoro.new
      pomodoro.start
      expect(pomodoro.state).to eq(:started)
      expect(pomodoro.started?).to eq(true)
    end

    it "becomes stopped" do
      pomodoro = Pomodoro.new
      pomodoro.stop
      expect(pomodoro.state).to eq(:stopped)
      expect(pomodoro.stopped?).to eq(true)
    end
  end

  context "#duration" do
    it "displays minutes" do
      pomodoro = Pomodoro.stop(in: 20.minutes)
      expect(pomodoro.duration).to eq("20m")
    end

    it "rounds to the nearest minute" do
      pomodoro = Pomodoro.stop(in: (20.minutes + 35.seconds))
      expect(pomodoro.duration).to eq("21m")
    end

    it "is nil if @duration is nil" do
      pomodoro = Pomodoro.stop()
      expect(pomodoro.duration).to be_nil
    end
  end
end
