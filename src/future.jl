
import Base.getindex

struct Future_C
   cass_future::Ptr{Void}
end

# TODO check if it is necessary to free the rerult
free(f::Future_C) = ccall((:cass_future_free, libcass), Void, (Ptr{Void},), f.cass_future)

getindex(f::Future_C) = nothing
getindex(f::Future_C, args...) = nothing

function isready(f::Future_C)
   ready = ccall((:cass_future_ready. libcass), Cint, (Ptr{Void},), f.cass_future)
   ready == 1 ? true : false
end

function wait(f::Future_C)
   ccall((:cass_future_wait, libcass), Void, (Ptr{Void},), f.cass_future)
   f
end

function wait(f::Future_C, μ)
   ready = ccall((:cass_future_wait_timed, libcass), Cint, (Ptr{Void}, Cint), f.cass_future, μ)
   ready == 1 ? true : false
end

function fetch(f::Future_C)
   wait(f)
   r = ccall((:cass_future_get_result, libcass), Ptr{Void}, (Ptr{Void},), f.cass_future)
   Result(r)
end

error_code(f::Future_C) = ccall((:cass_future_error_code, libcass), Int, (Ptr{Void},), f.cass_future)
