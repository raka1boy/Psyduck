(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using Kursovich
const UserApp = Kursovich
Kursovich.main()
