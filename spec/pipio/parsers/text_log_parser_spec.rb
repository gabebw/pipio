describe Pipio::TextLogParser do
  describe "#parse" do
    it "returns a Chat with the correct number of lines" do
      chat = build_chat do |b|
        b.message
      end

      expect(chat.messages.size).to eq(1)
    end

    it "returns a Chat with the correct message type" do
      chat = build_chat do |b|
        b.message
      end

      expect(chat.messages.first).to be_instance_of(Pipio::XMLMessage)
    end

    it "returns a Chat with the correct data" do
      message = build_chat do |b|
        b.first_line time: '2006-12-21 22:36:06', from: 'awesome SN'
        b.message from_alias: 'Gabe B-W', time: '22:36:11',
          text: "what are you doing tomorrow?"
      end.messages.first

      expect(message.sender_screen_name).to eq("awesomesn")
      expect(message.body).to eq("what are you doing tomorrow?")
      expect(message.sender_alias).to eq("Gabe B-W")
      expect(message.time).to eq(Time.parse('2006-12-21 22:36:11').utc)
    end
  end

  def build_chat(aliases = ['Gabe B-W'], &block)
    path = create_chat_file('file.txt', &block).path
    Pipio::TextLogParser.new(path, Array(aliases)).parse
  end
end
