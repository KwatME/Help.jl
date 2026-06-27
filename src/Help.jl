module Help

for pa in readdir(pkgdir(Help, "src"))

    if pa != "Help.jl"

        include(pa)

    end

end

# ---- #

function (@main)(ARGS)

    st = popfirst!(ARGS)

    if st == "log"

        Tree.log()

    elseif st == "template"

        co = length(ARGS)

        if isone(co)

            Template.write(ARGS[])

        elseif iszero(co)

            Template.write()

        end

    end

    return

end

end
