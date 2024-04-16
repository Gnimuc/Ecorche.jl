module LibCarotid

const carotid_context = Ptr{Cvoid}

@enum carotid_err::UInt32 begin
    carotid_success = 0
    carotid_error = 1
end

function carotid_sanity_check()
    ccall((:carotid_sanity_check, libcarotid), Cint, ())
end

function carotid_context_create(n_params, err)
    ccall((:carotid_context_create, libcarotid), carotid_context, (UInt32, Ptr{carotid_err}), n_params, err)
end

function carotid_context_dispose(ctx)
    ccall((:carotid_context_dispose, libcarotid), Cvoid, (carotid_context,), ctx)
end

function carotid_load_model(ctx, model_dir, err)
    ccall((:carotid_load_model, libcarotid), Cvoid, (carotid_context, Ptr{Cchar}, Ptr{carotid_err}), ctx, model_dir, err)
end

function carotid_get_vertex_count(ctx)
    ccall((:carotid_get_vertex_count, libcarotid), UInt32, (carotid_context,), ctx)
end

function carotid_get_param_count(ctx)
    ccall((:carotid_get_param_count, libcarotid), UInt32, (carotid_context,), ctx)
end

function carotid_update_model(ctx, params, len)
    ccall((:carotid_update_model, libcarotid), Cvoid, (carotid_context, Ptr{Cfloat}, UInt32), ctx, params, len)
end

function carotid_get_model(ctx, model, len)
    ccall((:carotid_get_model, libcarotid), Cvoid, (carotid_context, Ptr{Cfloat}, UInt32), ctx, model, len)
end

function carotid_get_basemodel(ctx, model, len)
    ccall((:carotid_get_basemodel, libcarotid), Cvoid, (carotid_context, Ptr{Cfloat}, UInt32), ctx, model, len)
end

# exports
const PREFIXES = ["carotid_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
