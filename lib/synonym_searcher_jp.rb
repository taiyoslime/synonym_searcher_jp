require "synonym_searcher_jp/version"
require "mechanize"

module SynonymSearcherJp
  module_function
  def fetch word
      agent = Mechanize.new
      agent.get("http://renso-ruigo.com/word/#{word}").search('.word_t_field a').reduce([]){|e,el| e << el.inner_text}
  end
end
