require "tzinfo"

describe Pipio::TimeParser, "#parse" do
  it 'returns nil when timestamp is nil' do
    time_parser = Pipio::TimeParser.new(2011, 2, 3)

    expect(time_parser.parse(nil)).to be_nil
  end

  context 'when the given timestamp does have a date' do
    let(:time_parser) { Pipio::TimeParser.new(2011, 4, 28) }

    it 'parses "%m/%d/%Y %I:%M:%S %P"' do
      timestamp = '01/22/2008 03:01:45 PM'
      result = time_parser.parse(timestamp)
      expect(result.year).to eq(2008)
      expect(result.mon).to eq(1)
      expect(result.mday).to eq(22)
      expect(result.hour).to eq(adjusted_hour(15))
      expect(result.min).to eq(1)
      expect(result.sec).to eq(45)
    end

    [
      '%Y-%m-%d %H:%M:%S',
      '%Y/%m/%d %H:%M:%S',
      '%Y-%m-%d %H:%M:%S',
      '%a %b %d %H:%M:%S %Y'
    ].each do |format|
      it "parses '#{format}'" do
        time = Time.now
        timestamp = time.strftime(format)
        expect(time_parser.parse(timestamp)).to eq(Time.parse(timestamp).utc)
      end
    end

    it 'parses "%a %d %b %Y %H:%M:%S %p %Z", respecting TZ' do
      timestamp = "Sat 18 Apr 2009 10:43:35 AM PDT"
      time = Time.parse(timestamp).utc
      expect(time.hour).to eq(17)
      expect(time_parser.parse(timestamp)).to eq(time)
    end
  end

  it "uses UTC timezone" do
    timestamp = "3/16/2014 11:55:43 PM"
    time = Pipio::TimeParser.new(nil, nil, nil).parse(timestamp)
    expect(time.zone).to eq "UTC"
  end

  context 'when the given timestamp does not have a date' do
    let(:time_parser) { Pipio::TimeParser.new(2008, 4, 27) }

    it 'parses "%I:%M:%S %P"' do
      result = time_parser.parse("07:01:45 AM")
      expect(result.year).to eq(2008)
      expect(result.mon).to eq(4)
      expect(result.mday).to eq(27)
      expect(result.hour).to eq(adjusted_hour(7))
      expect(result.min).to eq(1)
      expect(result.sec).to eq(45)
    end

    it 'parses "%H:%M:%S"' do
      result = time_parser.parse("06:01:45")
      expect(result.year).to eq(2008)
      expect(result.mon).to eq(4)
      expect(result.mday).to eq(27)
      expect(result.hour).to eq(adjusted_hour(6))
      expect(result.min).to eq(1)
      expect(result.sec).to eq(45)
    end
  end

  def adjusted_hour(hour)
    (hour - offset_in_hours_from_utc) % 24
  end
end
