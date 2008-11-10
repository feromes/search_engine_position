require File.join(File.dirname(__FILE__), '/../lib/search_engine_position')

describe SearchEnginePosition do
  
  describe "with no site and no keyword" do
    
    it "should complain" do 
      lambda { SearchEnginePosition.new }.should raise_error(ArgumentError)
    end
  end
  
  describe "with no search_engine and no language" do
    it "should uses google.com and english as language" do end
  end
  
  describe "with a given search engine and no language" do
    it "should assumes a default language as language" do end
  end
  
  describe "with a incorrect search_engine or language" do
    it "should complain" do end
  end
  
  describe "with correct parameters" do
    it "should return a search URL" do
  
    end
  
    it "should return a Array of positions" do
    
    end
  end

  
end
