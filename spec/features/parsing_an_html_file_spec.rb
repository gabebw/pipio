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
    File.read(path_to_output_fixture).gsub("[DATE_AND_HOUR]", date_and_hour)
  end

  def date_and_hour
    utc = current_timezone.parse("2014-03-16 23:55:48").utc
    utc.strftime("%Y-%m-%dT%H")
  end


  def current_timezone
    ActiveSupport::TimeZone[current_timezone_identifier]
  end

  def current_timezone_identifier
    Time.now.zone
  end

  def path_to_input_fixture
    File.join(SPEC_ROOT, "fixtures", "input.html")
  end
end
