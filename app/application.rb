class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      @@cart.each do |item| 
        resp.write "You have added #{item} in your cart"
      end
    elsif req.path.match(/add/)
      add_item = req.params["item"]
      resp.write handle_cart(add_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_cart(add_item)
    if @@items.include?(add_item)
      @@cart << add_item
    else
      return "You do not have #{add_item} in your items."
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
