module Users
    using Kursovich.DB
    
    Base.@kwdef struct User
        id::Union{Integer,String} = "NULL"
        name::String
        image_link::String = "default.png"
        login::String
        password::String
    end

    get_user(id)::Product = begin
        result = DB.execute_query("SELECT name,image_link,login,password FROM products WHERE id = $(id)")
        return Product(
            id,result[1, "name"],result[1, "image_link"],result[1, "login"],result[1, "password"]
        )
    end

    create_user(user::User)::nothing = begin
        DB.execute_query("INSERT INTO users(id,name,image_link,login,password) values(NULL,'$(user.name)', 'img/$(user.image_link)', '$(user.login)', '$(user.password)')")
    end
end