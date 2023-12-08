using Genie.Router, Genie.Requests
using Genie.Renderer, Genie.Renderer.Html
using Kursovich.Products
using HTTP.Cookies

function prs(data)
  data = split(replace(data, r" " => ""), ';')
  dicts = []
  for i in eachindex(data)
      pair = split(data[i], "=")
      push!(dicts,Pair(pair[1],pair[2]))
  end
  dicts
end

route("/") do
  user_data = params(:REQUEST)["Cookie"] |> prs 
  products_result = Products.get_products(25)
  page = open(io->read(io, String),"./public/index.jl.html")
  Html.html(page,products = products_result, user = user_data)
end

route("/products/:id::Int") do 
  product_result = Products.get_product(payload(:id))
  @info product_result
  page = open(io->read(io, String),"./public/product.jl.html")
  Html.html(page)
end

route("signup") do 
  page = open(io->read(io, String),"./public/signup-form.jl.html")
  Html.html(page)
end

route("reg") do 
  
end

route("test") do 
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user", value =321))
  Html.html(params(:REQUEST)["Cookie"] |> prs)
end
route("/add_cart/:id::Int") do

end

route("/myprofile/:id::Int") do 
  page = open(io->read(io, String),"./public/personal-cabinet.jl.html")
  Html.html(page, user = Users.get_user(payload(:id)))
end

