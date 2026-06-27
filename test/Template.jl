using Help

cd(pkgdir(Help, "ou"))

Help.Template.write("PackageName.jl")

cd("../..")

Help.Template.write()
