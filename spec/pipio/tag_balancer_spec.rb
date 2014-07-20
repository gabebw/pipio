describe Pipio::TagBalancer do
  describe 'text without tags' do
    it 'is left untouched' do
      text = 'foo!'
      expect(Pipio::TagBalancer.new(text).balance).to eq(text)
    end
  end

  describe 'text with tags' do
    it 'is balanced correctly' do
      unbalanced = '<p><b>this is unbalanced!'
      balanced = '<p><b>this is unbalanced!</b></p>'
      expect(Pipio::TagBalancer.new(unbalanced).balance).to eq(balanced)
    end
  end
end
