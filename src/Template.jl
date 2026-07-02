module Template

using Base: read as Baseread, write as Basewrite

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

    i1 = length(PA) + 2

    for (p4, p1_, p2_) in walkdir(PA)

        p5 = p4[i1:end]

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

    function string(s3, i2)

        return split(s3, s1; limit = 2)[i2]

    end

    function read(p4)

        return Baseread(joinpath(PA, p4), String)

    end

    s2 = splitext(p1)[1]

    function string(s3)

        return replace(s3, S1 => s2)

    end

    p2 = ".gitignore"

    p3 = joinpath("test", "runtests.jl")

    for (s3, p4) in (
            (read(p2), p2),
            (string(read(joinpath("src", S2))), joinpath("src", p1)),
            (string(read(p3)), p3),
        )

        s4 = Baseread(p4, String)

        s5 = "$(string(s3, 1))$s1$(string(s4, 2))"

        if s4 == s5

            continue

        end

        Basewrite(p4, s5)

        @info "🍡 $p4"

    end

    return

end

end
