module DB
    using CSV
    using MySQL
    using JSON
    using DataFrames
    using JSONTables
    execute_query(query::String) = begin
        conn = MySQL.DBInterface.connect(MySQL.Connection, "localhost", "root", "", db = "Psyduck_dev")
        ret =MySQL.DBInterface.execute(conn, query) |>  DataFrame
        MySQL.DBInterface.close!(conn)
        return ret
    end
end