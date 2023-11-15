using Genie.Router, Genie.Requests
using Genie.Renderer, Genie.Renderer.Html
using Kursovich.Products


route("/") do
  products_result = Products.get_products(25)
  page = open(io->read(io, String),"./public/index.jl.html")
  Html.html(page,products = products_result)
end

route("/products/:id") do 
  product_id = payload(:id)
  product_result = Products.get_product(product_id)
  page = open(io->read(io, String),"./public/index.jl.html")
  Html.html(page,product = product_result)
end

route("signup") do 
  @info params()
  page = open(io->read(io, String),"./public/signup-form.jl.html")
  Html.html(page)
end