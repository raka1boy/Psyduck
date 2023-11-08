module Kursovich

using Genie
include("Db.jl")
include("Products.jl")
const up = Genie.up
export up

function main()
  Genie.genie(; context = @__MODULE__)
end

end
