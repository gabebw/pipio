describe Pipio::ParserFactory do
  let(:aliases) { '' }

  %w(html htm HTML).each do |html_extension|
    context "when passed a .#{html_extension} file" do
      it 'returns an HtmlLogParser' do
        logfile_path = "whatever.#{html_extension}"
        factory = Pipio::ParserFactory.new(logfile_path, aliases)
        expect(factory.parser).to be_a Pipio::HtmlLogParser
      end
    end
  end

  %w(txt TXT).each do |text_extension|
    context "when passed a .#{text_extension} file" do
      it 'returns a TextLogParser' do
        logfile_path = "whatever.#{text_extension}"
        factory = Pipio::ParserFactory.new(logfile_path, aliases)
        expect(factory.parser).to be_a Pipio::TextLogParser
      end
    end
  end

  context 'when passed a non-HTML, non-text file' do
    it 'returns something that responds to parse' do
      other_path = 'foo.bar'
      factory = Pipio::ParserFactory.new(other_path, aliases)
      expect(factory.parser).to respond_to(:parse)
    end
  end
end
