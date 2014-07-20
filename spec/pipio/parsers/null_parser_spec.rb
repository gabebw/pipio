describe Pipio::NullParser do
  context '#parse' do
    it 'does nothing' do
      expect do
        Pipio::NullParser.new('path/to/file', 'alias').parse
      end.not_to raise_error
    end

    it 'returns falsy' do
      expect(Pipio::NullParser.new('path/to/file', 'alias').parse).not_to be
    end
  end
end
