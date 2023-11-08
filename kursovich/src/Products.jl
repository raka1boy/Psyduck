module Products
    using Kursovich.DB


    template() = begin
        """<template class="main__catalogue-list-item-template">
        <li class="main__catalogue-list-item">
          <a href="#0" class="main__catalogue-list-link">
            <article class="main__catalogue-list-card">
              <img src="" alt="" class="main__catalogue-product-image" />
              <div class="main__catalogue-list-card-container">
                <h3 class="main__catalogue-list-card-title"></h3>
                <p class="main__catalogue-list-card-description"></p>
              </div>
            </article>
          </a>
        </li>
      </template>"""
    end
    Base.@kwdef struct Product
        id::Union{String,Integer} = "NULL"
        name::String
        image_link::String
        warehouse_id::UInt
        description::String
        price::Float64
    end

    get_product(id)::Product = begin
        result = DB.execute_query("SELECT name,image_link,warehouse_id,description,price FROM products WHERE id = $(id)")
        return Product(
            id,result[1, "name"],result[1, "image_link"],result[1, "warehouse_id"],result[1, "description"],result[1, "price"]
        )
    end

    get_products(limit)::Vector{Product} = begin
        result = DB.execute_query("SELECT * FROM products LIMIT $(limit)")
        [Product(result[i, "id"],result[i, "name"],result[i, "image_link"],result[i, "warehouse_id"],result[i, "description"],result[i, "price"]) for i in 1:limit]
    end
end