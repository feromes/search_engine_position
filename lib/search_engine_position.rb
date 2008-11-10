# = SearchEnginePosition
# SearchEnginePosition is a simple Ruby class made for help SEO administrator controling your websites position in many diferents search engines
#
# Author::    Fernando Gomes  (mailto:feromes@gmail.com)
# Copyright:: Copyright (c) 2008 Fernando Gomes
# License::   Distributes under the same terms as Ruby

class SearchEnginePosition

  require 'hpricot'
  require 'open-uri'
  
  SEARCH_ENGINES = {"www.google.com" => {:default_lang => "en", :main => :google, :country => "United States"}, 
                    "www.google.com.br" => {:default_lang => "pt-BR", :main => :google, :country => "Brazil"},
                    "br.search.yahoo.com" => {:default_lang => "lang_pt", :main => :yahoo, :country => "Brazil"},
                    "search.msn.com.br" => {:default_lang =>"pt-BR", :main => :msn, :country => "Brazil"},
                    "search.msn.com" => {:default_lang => "en", :main => :msn, :country => "United States"}}
  LANGUAGES = {:google => {"pt-BR" => "Portuguese (Brazilian)", "en" => "English"},
               :yahoo => {"lang_pt" => "Portuguese (Brazilian)"},
               :msn => {"pt-BR" => "Portuguese (Brazilian)", "en" => "English"}}
  
  # Return a SearchEenginePosition Object of a given site, on the given search engine, for the given keyword, on the given languages
  def initialize(site, keyword, search_engine = nil, language = nil)
    @site = site 
    @keyword = URI.escape(keyword) 
    @search_engine = search_engine || "www.google.com"
    @language = language || SEARCH_ENGINES[@search_engine][:default_lang]
    @page_result = Hpricot(open(search_url))
  end

  # Return the rank positions 
  def position
    @results = []  
    @page_result.search('li').each do |p|
      result = p.search("a[@href*=#{@site}]")
      unless result.empty?
        @results << p.position + 1
      end
    end
    return @results
  end
  
  # Show the aproprietaded URL in order to search 
  def search_url
    case SEARCH_ENGINES[@search_engine][:main]
    when :google
      "http://#{@search_engine}/search?num=100&hl=#{@language}&query=#{@keyword}"
    when :yahoo
      "http://#{@search_engine}/search?n=100&p=#{@keyword}&vl=#{@language}"
    when :msn
      "http://#{@search_engine}/results.aspx?q=#{@keyword}&num=50&mkt=#{@language}&setlang=#{@language}"
    end
  end

end
