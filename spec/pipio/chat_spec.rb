describe Pipio::Chat do
  describe '#to_s' do
    it 'converts all lines to strings and joins them' do
      chat = Pipio::Chat.new(%w(a b c), '', '', Time.now, 'aim')
      expect(chat.to_s).to eq('abc')
    end
  end

  it 'is enumerable' do
    chat = Pipio::Chat.new(%w(a b c), '', '', Time.now, 'aim')
    expect(chat.map(&:upcase)).to eq(%w(A B C))
  end

  describe '#their_screen_name' do
    it 'is the screen name of the other person in the chat' do
      chat = Pipio::Chat.new([], 'me', 'them', Time.now, 'aim')

      expect(chat.their_screen_name).to eq('them')
    end
  end

  describe '#my_screen_name' do
    it 'is my screen name' do
      chat = Pipio::Chat.new([], 'me', 'them', Time.now, 'aim')

      expect(chat.my_screen_name).to eq('me')
    end
  end

  describe '#start_time_xmlschema' do
    it 'is the start time of the chat in xmlschema format' do
      time = Time.now
      chat = Pipio::Chat.new([], 'me', 'them', time, 'aim')

      expect(chat.start_time_xmlschema).to eq(time.xmlschema)
    end
  end

  describe '#service' do
    it 'is the chat service' do
      chat = Pipio::Chat.new([], 'me', 'them', Time.now, 'aim')

      expect(chat.service).to eq('aim')
    end
  end
end
