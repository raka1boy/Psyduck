module Kursovich

using Genie
include("Db.jl")
include("Products.jl")
include("Users.jl")
const up = Genie.up
export up

function main()
  Genie.genie(; context = @__MODULE__)
end

end
