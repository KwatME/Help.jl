module Help

for pa in readdir(pkgdir(Help, "src"))

    if pa != "Help.jl"

        include(pa)

    end

end

# ---- #

function (@main)(ARGS)

    st = ARGS[1]

    if st == "log"

        Tree.log()

    elseif st == "write"

        Template.write(ARGS[2:end]...)

    end

    return

end

end
