const CAROTID_VERTEX_COUNT_LVL1 = 12466
const CAROTID_VERTEX_COUNT_LVL2 = 49751
const CAROTID_VERTEX_COUNT_LVL3 = 198781

function calculate_identity_coefficients(observations::Vector{Vector{Float64}}, vertex_count=CAROTID_VERTEX_COUNT_LVL2)
    obs = reduce(hcat, observations)
    @assert size(obs, 1) == vertex_count * 3

    model = fit(PCA, obs)

    return mean(model), eigvecs(model), eigvals(model)
end
