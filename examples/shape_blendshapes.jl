using Ecorche

DATA_PREFIX = joinpath(@__DIR__, "..", "assets", "samples") |> abspath
@assert isdir(DATA_PREFIX)

observations = load_samples(DATA_PREFIX)

avg, vecs, vals = calculate_identity_coefficients(observations)

MODEL_PREFIX = joinpath(@__DIR__, "..", "assets", "models") |> abspath

write(joinpath(MODEL_PREFIX, "avg.bin"), Float32.(avg))
write(joinpath(MODEL_PREFIX, "vecs.bin"), Float32.(vecs))
write(joinpath(MODEL_PREFIX, "vals.bin"), Float32.(vals))
