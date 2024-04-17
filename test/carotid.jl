using Test
using Ecorche
using Ecorche.LibCarotid

@testset "Carotid" begin
    observations = Vector{Float64}[]
    for i = 1:200
        push!(observations, randn(Ecorche.CAROTID_VERTEX_COUNT_LVL2 * 3))
    end

    avg, vecs, vals = calculate_identity_coefficients(observations)

    write(joinpath(@__DIR__, "avg.bin"), Float32.(avg))
    write(joinpath(@__DIR__, "vecs.bin"), Float32.(vecs))
    write(joinpath(@__DIR__, "vals.bin"), Float32.(vals))

    errRef = Ref(carotid_success)

    dim = size(vecs, 2)

    ctx = carotid_context_create(dim, errRef)
    @test errRef[] == carotid_success

    carotid_load_model(ctx, @__DIR__, errRef)
    @test errRef[] == carotid_success

    @test carotid_get_vertex_count(ctx) == Ecorche.CAROTID_VERTEX_COUNT_LVL2
    @test carotid_get_param_count(ctx) == dim

    basemodel = zeros(Float32, carotid_get_vertex_count(ctx) * 3)
    carotid_get_basemodel(ctx, basemodel, length(basemodel))
    @test basemodel ≈ avg + vecs * vals

    params = zeros(Float32, dim)
    carotid_update_model(ctx, params, length(params))

    model = zeros(Float32, carotid_get_vertex_count(ctx) * 3)
    carotid_get_model(ctx, model, length(model))
    @test model ≈ avg + vecs * params

    carotid_context_dispose(ctx)
end
