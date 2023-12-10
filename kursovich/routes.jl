using Genie.Router, Genie.Requests
using Genie.Renderer, Genie.Renderer.Html
using Kursovich.Products
using Kursovich.Users
using HTTP.Cookies
using HTTP
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

route("login") do
  page = open(io->read(io, String),"./public/login-form.jl.html") 
  Html.html(page)
end
route("reg") do
  values = payload(:GET)
  Users.create_user(Users.User("NULL",values[:name],"default.png",values[:email],values[:password]))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_name",  value = values[:name]))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_image_link", value ="default.png"))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_login", value = values[:email]))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_password", value = values[:password]))
end

route("log") do
  values = payload(:GET)
  @info values
  values = Users.login_user(values[:email],values[:password])
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_name", value = values.name, maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_image_link", value = values.image_link, maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_login", value = values.login, maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_password", value = values.password, maxage = 0))
  
end

route("/add_cart/:id::Int") do
  values = payload(:GET)
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_name", value = values[:name], maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_image_link", value = values[:image_link], maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_login", value = values[:login], maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_password", value = values[:password], maxage = 0))
end

route("/myprofile") do 
  values = payload(:GET)
  page = open(io->read(io, String),"./public/personal-cabinet.jl.html")
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_name", value = values[:name], maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_image_link", value = values[:image_link], maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_login", value = values[:login], maxage = 0))
  addcookie!(params(:REQUEST),Cookies.Cookie(name = "user_password", value = values[:password], maxage = 0))
  Html.html(page, user = Users.get_user(payload(:id)) , )
end

