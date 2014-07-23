describe Pipio::Chat do
  describe '#to_s' do
    it 'converts all Messages to strings and joins them' do
      chat = Pipio::Chat.new([:a, 1, 3], metadata)

      expect(chat.to_s).to eq('a13')
    end
  end

  describe '#messages' do
    it 'returns all messages' do
      chat = Pipio::Chat.new(%w(a b c), metadata)

      expect(chat.messages).to eq %w(a b c)
    end
  end

  it 'is enumerable' do
    chat = Pipio::Chat.new(%w(a b c), metadata)

    expect(chat.map(&:upcase)).to eq(%w(A B C))
  end

  describe '#their_screen_name' do
    it 'is the screen name of the other person in the chat' do
      chat = Pipio::Chat.new([], metadata(their_screen_name: 'them'))

      expect(chat.their_screen_name).to eq('them')
    end
  end

  describe '#my_screen_name' do
    it 'is my screen name' do
      chat = Pipio::Chat.new([], metadata(my_screen_name: 'me'))

      expect(chat.my_screen_name).to eq('me')
    end
  end

  describe '#start_time_xmlschema' do
    it 'is the start time of the chat in xmlschema format' do
      time = Time.now
      chat = Pipio::Chat.new([], metadata(start_time: time))

      expect(chat.start_time_xmlschema).to eq(time.xmlschema)
    end
  end

  describe '#service' do
    it 'is the chat service' do
      chat = Pipio::Chat.new([], metadata(service: 'icq'))

      expect(chat.service).to eq('icq')
    end
  end

  def metadata(options = {})
    data = {
      my_screen_name: 'me',
      their_screen_name: 'them',
      start_time: Time.now,
      service: 'aim'
    }.merge(options)
    Pipio::Metadata.new(data)
  end
end
