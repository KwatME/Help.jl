module Tree

function log()

    nd = length(pwd()) + 2

    for (p1, p1_, p2_) in walkdir()

        if any(occursin(p1), (".git", ".key", ".numbers", ".pages"))

            continue

        end

        p2 = p1[nd:end]

        for p3_ in (p1_, p2_), p3 in p3_

            p4 = joinpath(p2, p3)

            if startswith(p3, '.')

                @info "⚫️ $p4"

            elseif !isone(count(isuppercase, p3))

                @info "🟡 $p4"

            end

            p5 = replace(
                p3,
                r"^\s+" => "",
                r"\s+$" => "",
                r"\s{2,}" => ' ',
                r"(?<=\d)th"i => "th",
                r"1st"i => "1st",
                r"2nd"i => "2nd",
                r"3rd"i => "3rd",
                r"'d"i => "'d",
                r"'m"i => "'m",
                r"'re"i => "'re",
                r"'s"i => "'s",
                r"'ve"i => "'ve",
                r"(?<= )a(?= )"i => 'a',
                r"(?<= )an(?= )"i => "an",
                r"(?<= )and(?= )"i => "and",
                r"(?<= )as(?= )"i => "as",
                r"(?<= )at(?= )"i => "at",
                r"(?<= )but(?= )"i => "but",
                r"(?<= )by(?= )"i => "by",
                r"(?<= )for(?= )"i => "for",
                r"(?<= )from(?= )"i => "from",
                r"(?<= )in(?= )"i => "in",
                r"(?<= )into(?= )"i => "into",
                r"(?<= )nor(?= )"i => "nor",
                r"(?<= )of(?= )"i => "of",
                r"(?<= )off(?= )"i => "off",
                r"(?<= )on(?= )"i => "on",
                r"(?<= )onto(?= )"i => "onto",
                r"(?<= )or(?= )"i => "or",
                r"(?<= )out(?= )"i => "out",
                r"(?<= )over(?= )"i => "over",
                r"(?<= )the(?= )"i => "the",
                r"(?<= )to(?= )"i => "to",
                r"(?<= )up(?= )"i => "up",
                r"(?<= )vs(?= )"i => "vs",
                r"(?<= )with(?= )"i => "with",
            )

            if p3 != p5

                @info "🔴 $p2\n$p3\n$p5"

            end

        end

    end

    return

end

end
