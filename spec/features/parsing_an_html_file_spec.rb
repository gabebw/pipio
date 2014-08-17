require "spec_helper"

describe "Parse a Pidgin HTML log file" do
  it "outputs the correct data" do
    chat = Pipio.parse(path_to_input_fixture, ["Gabe B-W"])

    expect(chat.to_s).to eq expected_output_with_current_timezone_offset.strip
  end

  def path_to_output_fixture
    File.join(SPEC_ROOT, "fixtures", "output.xml")
  end

  def expected_output_with_current_timezone_offset
    File.read(path_to_output_fixture).gsub("-0400", timezone_offset)
  end

  def timezone_offset
    Time.now.strftime("%z")
  end

  def path_to_input_fixture
    File.join(SPEC_ROOT, "fixtures", "input.html")
  end
end
