module LibCarotid

using ..Ecorche: libcarotid


const carotid_context = Ptr{Cvoid}

@enum carotid_err::UInt32 begin
    carotid_success = 0
    carotid_error = 1
end

function carotid_sanity_check()
    @ccall libcarotid.carotid_sanity_check()::Bool
end

function carotid_context_create(n_params, err)
    @ccall libcarotid.carotid_context_create(n_params::UInt32, err::Ptr{carotid_err})::carotid_context
end

function carotid_context_dispose(ctx)
    @ccall libcarotid.carotid_context_dispose(ctx::carotid_context)::Cvoid
end

function carotid_load_model(ctx, model_dir, err)
    @ccall libcarotid.carotid_load_model(ctx::carotid_context, model_dir::Ptr{Cchar}, err::Ptr{carotid_err})::Cvoid
end

function carotid_get_vertex_count(ctx)
    @ccall libcarotid.carotid_get_vertex_count(ctx::carotid_context)::UInt32
end

function carotid_get_param_count(ctx)
    @ccall libcarotid.carotid_get_param_count(ctx::carotid_context)::UInt32
end

function carotid_update_model(ctx, params, len)
    @ccall libcarotid.carotid_update_model(ctx::carotid_context, params::Ptr{Cfloat}, len::UInt32)::Cvoid
end

function carotid_get_model(ctx, model, len)
    @ccall libcarotid.carotid_get_model(ctx::carotid_context, model::Ptr{Cfloat}, len::UInt32)::Cvoid
end

function carotid_get_basemodel(ctx, model, len)
    @ccall libcarotid.carotid_get_basemodel(ctx::carotid_context, model::Ptr{Cfloat}, len::UInt32)::Cvoid
end

# exports
const PREFIXES = ["carotid_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
