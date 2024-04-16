using Clang
using Clang.Generators
using Carotid_jll

cd(@__DIR__)

target = "x86_64-linux-gnu"

artifact_dir = Clang.JLLEnvs.get_pkg_artifact_dir(Carotid_jll, target)

include_dir = normpath(artifact_dir, "include")

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args(target)

push!(args, "-I$include_dir")

headers = detect_headers(include_dir, args)

ctx = create_context(headers, args, options)

build!(ctx)
