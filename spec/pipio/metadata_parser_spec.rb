describe Pipio::MetadataParser do
  context '#parse' do
    it "finds my screen name" do
      screen_name = "JIM the guy"
      file = create_chat_file('log.html') do |b|
        b.first_line from: screen_name
      end

      metadata = Pipio::MetadataParser.new(first_line_of(file)).parse
      expect(metadata[:my_screen_name]).to eq(screen_name)
    end

    it "finds their screen name" do
      file = create_chat_file('log.html') do |b|
        b.first_line to: 'lady anne'
      end

      metadata = Pipio::MetadataParser.new(first_line_of(file)).parse
      expect(metadata[:their_screen_name]).to eq('lady anne')
    end

    it 'finds the start time' do
      time_string = '2008-04-01 22:36:06'
      file = create_chat_file('log.html') do |b|
        b.first_line time: time_string
      end

      metadata = Pipio::MetadataParser.new(first_line_of(file)).parse
      expect(metadata[:start_time]).to eq(Time.parse(time_string))
    end

    {
      "Tue 06 Dec 2011 11:03:40 AM PST" => Time.parse("2011-12-06 11:03:40 AM PST"),
      "Tue 20 Dec 2011 04:17:17 PM PST" => Time.parse("2011-12-20 04:17:17 PM PST"),
      "1/15/2008 7:14:45 AM" => Time.parse('2008-01-15 07:14:45'),
    }.each do |(timestamp, expected_time)|
      it "can parse a slightly peculiar time of #{timestamp}" do
        file = create_chat_file('log.html') do |b|
          b.first_line time: timestamp
        end

        metadata = Pipio::MetadataParser.new(first_line_of(file)).parse
        parsed_time = metadata[:start_time]

        expect(parsed_time).to eq expected_time
      end
    end

    it 'finds the correct service' do
      path = create_chat_file('log.html') do |b|
        b.first_line service: 'aim'
      end

      metadata = Pipio::MetadataParser.new(first_line_of(path)).parse

      expect(metadata[:service]).to eq 'aim'
    end

    it 'sets all attributes to nil when initialized with an empty string' do
      metadata = Pipio::MetadataParser.new('').parse
      assert_all_attributes_nil(metadata)
    end

    it 'sets all attributes to nil when initialized with nil' do
      metadata = Pipio::MetadataParser.new(nil).parse
      assert_all_attributes_nil(metadata)
    end

    it 'resets all attributes to nil when given a non-standard file to parse' do
      file = FileBuilder.create_file('nonstandard.html')
      file.write '<HTML><BODY BGCOLOR="#ffffff"><B><FONT COLOR="#ff0000" LANG="0">jiggerific bug<!-- (3:22:29 PM)--></B></FONT><FONT COLOR="#ff0000" BACK="#ffffff">:</FONT><FONT COLOR="#000000"> try direct IM now</FONT><BR>'
      file.close

      metadata = Pipio::MetadataParser.new(first_line_of(file)).parse
      assert_all_attributes_nil(metadata)
    end
  end

  def first_line_of(file)
    File.readlines(file).first
  end

  def assert_all_attributes_nil(metadata)
    expect(metadata[:start_time]).to be_nil
    expect(metadata[:their_screen_name]).to be_nil
    expect(metadata[:my_screen_name]).to be_nil
  end
end
