require "synonym_searcher_jp/version"
require "mechanize"
require "shellwords"

module SynonymSearcherJp
    @agent = Mechanize.new
    module_function
    def fetch word
        result = []
        begin
            result = @agent.get("http://renso-ruigo.com/word/#{Shellwords.shellescape(word)}")
                .search('.word_t_field a')
                .map{ |e| e.inner_text }
        rescue Mechanize::ResponseCodeError => e
            if e.response_code == "404"
                puts "No results found for \"#{word}\". "
            else
                puts "Something went wrong : #{e}"
            end
        rescue SocketError => e
            puts "Network Error : #{e}"
        rescue => e
            puts "Something went wrong : #{e}"
        end
    end

    def fetch_wno_ruby word
        fetch(word).map { |e| e.sub(/\（.*?\）/,"") }
    end
end
