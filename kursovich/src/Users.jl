module Users
    using Kursovich.DB
    
    Base.@kwdef struct User
        id::Union{Integer,String} = "NULL"
        name::String
        image_link::String
        login::String
        password::String
    end

    
end