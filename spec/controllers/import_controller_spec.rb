require 'rails_helper'

RSpec.describe ImportController, type: :controller do
	before :each do
	  @file = fixture_file_upload('files/test_file.csv', 'text/csv')
	end

	it "can upload company operations" do

	end

	it "should separate categories list from kind column" do

	end

	context "when missing category"
		it "should create new category" do
		end
	end
	
	context "when category exists" do		
		it "should properly format date" do
		end
		it "should create operations of associated companies" do
		end
		
	end		

end
