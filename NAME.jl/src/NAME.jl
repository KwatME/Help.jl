module NAME

for pa in readdir(pkgdir(NAME, "src"))

    if pa != "NAME.jl"

        include(pa)

    end

end

# ---- #

end
