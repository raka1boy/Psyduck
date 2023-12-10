module Users
    using Kursovich.DB
    
    Base.@kwdef struct User
        id::Union{Integer,String} = "NULL"
        name::String
        image_link:: String = "default.png"
        login::String
        password::String
    end

    get_user(id)::Product = begin
        result = DB.execute_query("SELECT name,image_link,login,password FROM products WHERE id = $(id)")
        return Product(
            id,result[1, "name"],result[1, "image_link"],result[1, "login"],result[1, "password"]
        )
    end

    login_user(login,password) = begin
        user = DB.execute_query("SELECT * FROM users WHERE login = '$(login)' AND password = '$(password)'")
        return User(user.id[1],user.name[1],user.image_link[1],user.login[1],user.password[1])
    end
    create_user(user::User)::Symbol = begin
        @info "INSERT INTO users(id,name,login,password,image_link) values(NULL,'$(user.name)', '$(user.login)', '$(user.password)', 'img/$(user.image_link)')"
        if (DB.execute_query("SELECT * FROM users WHERE login = '$(user.login)'") |> size)[2] == 0 
            return :erorr;
        end
        DB.execute_query("INSERT INTO users(id,name,login,password,image_link) values(NULL,'$(user.name)', '$(user.login)', '$(user.password)', 'img/$(user.image_link)')")
        return :ok;
    end
end