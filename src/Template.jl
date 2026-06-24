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

# TODO: Use fu
function write(s1, pa)

    s2 = "# ---- #"

    s3 = read(pa, String)

    s4 = "$(split(s1, s2; limit = 2)[1])$s2$(split(s3, s2; limit = 2)[2])"

    if s3 == s4

        return

    end

    Basewrite(pa, s4)

    @info "🍡 $pa"

    return

end

function write()

    p1 = basename(pwd())

    nd = length(PA) + 2

    for (p2, p1_, p2_) in walkdir(PA)

        p3 = p2[nd:end]

        for p3_ in (p1_, p2_), p4 in p3_

            if p4 == "Manifest.toml"

                continue

            elseif p4 == S2

                p4 = p1

            end

            p5 = joinpath(p3, p4)

            @assert ispath(p5) p5

        end

    end

    write(read(joinpath(PA, ".gitignore"), String), ".gitignore")

    pa = S1 => splitext(p1)[1]

    write(
        replace(read(joinpath(PA, "src", S2), String), pa),
        joinpath("src", p1),
    )

    write(
        replace(read(joinpath(PA, "test", "runtests.jl"), String), pa),
        joinpath("test", "runtests.jl"),
    )

    return

end

end
