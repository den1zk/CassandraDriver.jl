
struct Future_C
   ptr::Ptr{Void}
end

# TODO check if it is necessary to free the rerult
free(f::Future_C) = ccall((:cass_future_free, libcass), Void, (Ptr{Void},), f.ptr)

Base.getindex(f::Future_C) = nothing
Base.getindex(f::Future_C, args...) = nothing

function Base.isready(f::Future_C)
   ready = ccall((:cass_future_ready. libcass), Cint, (Ptr{Void},), f.ptr)
   ready == 1 ? true : false
end

function Base.wait(f::Future_C)
   ccall((:cass_future_wait, libcass), Void, (Ptr{Void},), f.ptr)
   f
end

function Base.wait(f::Future_C, μ)
   ready = ccall((:cass_future_wait_timed, libcass), Cint, (Ptr{Void}, Cint), f.ptr, μ)
   ready == 1 ? true : false
end

function Base.fetch(f::Future_C)
   wait(f)
   r = ccall((:cass_future_get_result, libcass), Ptr{Void}, (Ptr{Void},), f.ptr)
   Result(r)
end

error_code(f::Future_C) = ccall((:cass_future_error_code, libcass), Int, (Ptr{Void},), f.ptr)
