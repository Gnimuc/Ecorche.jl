function parse_to!(vec::Vector{Float64}, obj_path::AbstractString)
    lines = readlines(obj_path)

    for line in lines
        isempty(line) && continue
        line = strip(chomp(line))

        tokens = split(line)

        tokens[1] == "vt" && break # stop when we reach the texture coordinates

        tokens[1] == "v" || continue # skip lines that don't start with "v"
        @assert length(tokens) == 4

        push!(vec, parse(Float64, tokens[2]))
        push!(vec, parse(Float64, tokens[3]))
        push!(vec, parse(Float64, tokens[4]))
    end

    return nothing
end

function load_samples(dir::AbstractString)
    obj_files = [x for x in readdir(dir, join=true) if isfile(x) && endswith(x, ".obj")]

    observations = Vector{Vector{Float64}}(undef, length(obj_files))

    @showprogress for (i, x) in enumerate(obj_files)
        observations[i] = Float64[]
        parse_to!(observations[i], x)
    end

    return observations
end
