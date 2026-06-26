module Template

using Base: write as Basewrite

using UUIDs: uuid4

const S1 = "NAME"

const S2 = "$S1.jl"

const PA = pkgdir(Template, S2)

function write(pa)

    cd(cp(PA, pa))

    mv(joinpath("src", S2), joinpath("src", pa))

    run(
        pipeline(
            `find . -type f -print0`,
            `xargs -0 sed -i '' -e s/$S1/$(splitext(pa)[1])/g -e s/11111111-1111-1111-1111-111111111111/$(uuid4())/g`,
        ),
    )

    return

end

function write()

    p1 = basename(pwd())

    nd = length(PA) + 2

    for (p4, p1_, p2_) in walkdir(PA)

        p5 = p4[nd:end]

        for p3_ in (p1_, p2_), p6 in p3_

            if p6 == "Manifest.toml"

                continue

            elseif p6 == S2

                p6 = p1

            end

            p7 = joinpath(p5, p6)

            @assert ispath(p7) p7

        end

    end

    s1 = "# ---- #"

    p2 = ".gitignore"

    p3 = joinpath("test", "runtests.jl")

    pa = S1 => splitext(p1)[1]

    for (s2, p4) in (
            (read(joinpath(PA, p2), String), p2),
            (
                replace(read(joinpath(PA, "src", S2), String), pa),
                joinpath("src", p1),
            ),
            (replace(read(joinpath(PA, p3), String), pa), p3),
        )

        s3 = read(p4, String)

        s4 = "$(split(s2, s1; limit = 2)[1])$s1$(split(s3, s1; limit = 2)[2])"

        if s3 == s4

            continue

        end

        Basewrite(p4, s4)

        @info "🍡 $p4"

    end

    return

end

end
