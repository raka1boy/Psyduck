using Genie.Router, Genie.Requests
using Genie.Renderer, Genie.Renderer.Html
using Kursovich.Products


route("/") do
  products_result = Products.get_products(25)
  page = open(io->read(io, String),"./public/index.jl.html")
  Html.html(page,products = products_result)
end

route("/products/:id::Int") do 
  product_result = Products.get_product(payload(:id))
  @info product_result
  page = open(io->read(io, String),"./public/product.jl.html")
  Html.html(page)
end

route("signup") do 
  @info params()
  page = open(io->read(io, String),"./public/signup-form.jl.html")
  Html.html(page)
end