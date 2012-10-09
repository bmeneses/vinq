
  shared_examples_for "a general_attribute" do

    it { should respond_to(:name) }
    it { should respond_to(:url) }

    describe "when name is not present" do
      before { subject.name = " " }
      it { should_not be_valid }
    end

    describe "when url is not present" do
      before { subject.url = " " }
      it { should_not be_valid }
    end

    describe "when URLs are the right format" do
      before do
        valid_url = "http://www.appellation.com/V6/Calera-Central-Coast-Chardonnay-2010/wine/113077/detail.aspx?hid=hp_col1_9020new"
        subject.url = valid_url
      end
      it { should be_valid }
    end

    describe "url is not the right format" do
      before { subject.url = "http:/blah" }
      it { should_not be_valid }
    end


    # describe "when record is not unique" do
    #   before do
    #     @other_attribute = subject.dup
    #   end
    #   specify { @other_attribute.should_not be_valid }
    # end

  end
