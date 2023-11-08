module Products
    using Kursovich.DB
    
    Base.@kwdef struct Product
        id::Union{String,Int} = "NULL"
        name::String
        image_link::String
        warehouse_id::UInt
        description::String
        price::Float64
    end

    getProduct(id)::Product = begin
        result = DB.executeQuery("SELECT name,image_link,warehouse_id,description,price FROM products WHERE id = $(id)")
        return Product(
            id,result[1, "name"],result[1, "image_link"],result[1, "warehouse_id"],result[1, "description"],result[1, "price"]
        )
    end
end