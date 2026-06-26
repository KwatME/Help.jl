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

        if isempty(ARGS)

            Template.write()

        elseif isone(length(ARGS))

            Template.write(ARGS[])

        end

    end

    return

end

end
