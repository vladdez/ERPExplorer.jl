using ERPExplorer
using Documenter

DocMeta.setdocmeta!(ERPExplorer, :DocTestSetup, :(using ERPExplorer); recursive=true)

makedocs(;
    modules=[ERPExplorer],
    authors="Vladimir Mikheev",
    repo="https://github.com/vladdez/ERPExplorer.jl/blob/{commit}{path}#{line}",
    sitename="ERPExplorer.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://vladdez.github.io/ERPExplorer.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/vladdez/ERPExplorer.jl",
    devbranch="main",
)
