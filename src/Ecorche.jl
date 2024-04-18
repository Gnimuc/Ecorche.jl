module Ecorche

using MultivariateStats, Statistics
using ProgressMeter

if haskey(ENV, "CAROTID_INSTALL_PREFIX") &&
   !isempty(get(ENV, "CAROTID_INSTALL_PREFIX", ""))
    # DevMode
    const __DLEXT = Base.BinaryPlatforms.platform_dlext()
    const __ARTIFACT_BINDIR = Sys.iswindows() ? "bin" : "lib"

    const libcarotid = normpath(joinpath(ENV["CAROTID_INSTALL_PREFIX"],
                                         __ARTIFACT_BINDIR, "libcarotid.$__DLEXT"))
else
    using Carotid_jll
    export Carotid_jll
end

include(joinpath(@__DIR__, "..", "lib", "LibCarotid.jl"))
using .LibCarotid

include("io.jl")
export parse_to!, load_samples

include("identity.jl")
export calculate_identity_coefficients

end
