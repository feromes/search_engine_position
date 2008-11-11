require File.join(File.dirname(__FILE__), '/../lib/search_engine_position')

describe SearchEnginePosition do
  
  describe "with no site and no keyword" do
    it "should complain" do 
      lambda { SearchEnginePosition.new }.should raise_error(ArgumentError)
    end
  end
  
  describe "with no search_engine and no language" do
    before(:each) do
      @seo = SearchEnginePosition.new("www.orkut.com", "orkut")
    end
    it "should uses google.com and english as language" do 
      @seo.search_url.should == "http://www.google.com/search?num=100&hl=en&query=orkut"
    end
  end
  
  describe "with a given search engine and no language" do
    before(:each) do
      @seo = SearchEnginePosition.new("www.orkut.com", "orkut", "www.google.com.br")
    end
    it "should assumes a default language as language if there is a default language" do 
      @seo.search_url.should == "http://www.google.com.br/search?num=100&hl=pt-BR&query=orkut"
    end
  end
  
  describe "with a incorrect search_engine or language" do
    it "should complain" do 
      lambda { SearchEnginePosition.new("www.orkut.com", "orkut", "www.xxx.com", "en" ) }.should raise_error(ArgumentError)
    end
  end
  
  describe "with a search engine with nil as default language" do
    %w(www.google.com.bd).each do |search_engine|
      it "should be ok, like on #{search_engine}, that I don't know what is default language" do
        @seo = SearchEnginePosition.new("www.orkut.com", "orkut", search_engine)
        @seo.search_url.should == "http://#{search_engine}/search?num=100&hl=&query=orkut"
        @seo.position.class.should == Array
      end
    end
  end
  
  describe "with correct parameters" do
    before(:each) do
      @seo = SearchEnginePosition.new("www.orkut.com", "orkut", "www.google.com", "en")
    end
    
    it "should return a correct search URL" do
      @seo.search_url.should == "http://www.google.com/search?num=100&hl=en&query=orkut"
    end
  
    it "should return a Array of positions" do
      @seo.position.class.should == Array
    end
  end
    
end
