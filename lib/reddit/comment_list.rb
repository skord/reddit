module Reddit
  
  # The list of comments found for an article.
  class CommentList < ResourceList
    
    # Initializes a comments list.  Takes the ID of the article for which the comments belong to.
    def initialize(article_id)
      @article_id = article_id
      @url = COMMENTS_URL.gsub('[id]', @article_id)
    end
    
    # returns the top level comments for the thread.
    def top_level(options = {})
      get_resources(@url, :querystring => options[:querystring], :count => options[:count]) do |resource_json|
        comment = Comment.new(resource_json['data'])
      end
    end
    
    private
    
    # forward any method calls to the top level comments array.
    def method_missing(meth, *args, &block)
      top_level.send(meth, *args, &block)
    end 
  end
end