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

    nd = length(PA) + 2

    p1 = basename(pwd())

    for (p2, p1_, p2_) in walkdir(PA), p3_ in (p1_, p2_), p3 in p3_

        if p3 == "Manifest.toml"

            continue

        elseif p3 == S2

            p3 = p1

        end

        p4 = joinpath(p2[nd:end], p3)

        @assert ispath(p4) p4

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
