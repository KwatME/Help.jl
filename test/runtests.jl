using Help

for pa in readdir()

    if pa == "runtests.jl"

        continue

    end

    @info "🛫 $pa"

    run(`julia --project $pa`)

end

# ---- #
