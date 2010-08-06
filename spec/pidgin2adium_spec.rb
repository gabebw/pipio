require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Pidgin2Adium" do
  describe "constants" do
    it "should set ADIUM_LOG_DIR correctly" do
      Pidgin2Adium::ADIUM_LOG_DIR.should == File.expand_path('~/Library/Application Support/Adium 2.0/Users/Default/Logs/') + '/'
    end

    it "should set BAD_DIRS correctly" do
      Pidgin2Adium::BAD_DIRS.should == %w{. .. .DS_Store Thumbs.db .system}
    end
  end # constants

  describe "utility methods" do
    before(:each) do
      Pidgin2Adium.stub!(:log_msg).and_return(nil)
    end

    describe "oops" do
      it "should add a message to @@oops_messages" do
        #Kernel.should_receive(:warn)
        message = "Oops! I messed up!"
        Pidgin2Adium.oops(message)
        Pidgin2Adium.send(:class_variable_get, :@@oops_messages).should == [message]
      end
    end

    describe "error" do
      it "should add a message to @@error_messages" do
        #Kernel.should_receive(:warn)
        err_message = "Error! I *really* messed up!"
        Pidgin2Adium.error(err_message)
        Pidgin2Adium.send(:class_variable_get, :@@error_messages).should == [err_message]
      end
    end

    describe "delete_search_indexes" do
      before(:each) do
        @dirty_file = File.expand_path("~/Library/Caches/Adium/Default/DirtyLogs.plist")
        @log_index_file = File.expand_path("~/Library/Caches/Adium/Default/Logs.index")
      end

      describe "when search indices exist" do
        before(:each) do
          `touch #{@dirty_file}`
          `touch #{@log_index_file}`
        end
        it "should delete the search indices when they are writeable" do
          [@dirty_file, @log_index_file].each do |f|
            `chmod +w #{f}` # make writeable
          end
          Pidgin2Adium.delete_search_indexes()
          File.exist?(@dirty_file).should be_false
          File.exist?(@log_index_file).should be_false
        end

        it "should give an error message when they are not writable" do
          [@dirty_file, @log_index_file].each do |f|
            `chmod -w #{f}` # make unwriteable
          end
          Pidgin2Adium.should_receive(:error).with("File exists but is not writable. Please delete it yourself: #{@dirty_file}")
          Pidgin2Adium.should_receive(:error).with("File exists but is not writable. Please delete it yourself: #{@log_index_file}")
          Pidgin2Adium.should_receive(:log_msg).with("...done.")
          Pidgin2Adium.should_receive(:log_msg).with("When you next start the Adium Chat Transcript Viewer, " +
                                                     "it will re-index the logs, which may take a while.")
          Pidgin2Adium.delete_search_indexes()
          File.exist?(@dirty_file).should be_true
          File.exist?(@log_index_file).should be_true
        end
      end # when search indices exist
    end # delete_search_indexes
  end
end
