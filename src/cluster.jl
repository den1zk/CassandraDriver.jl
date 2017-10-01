struct Cluster
    ptr::Ptr{Void}
    function Cluster()
        new( ccall((:cass_cluster_new, libcass), Ptr{Void},  (), ) )
    end

    function Cluster(contact_points::String)
        cluster = Cluster()
        set_contact_points(cluster, contact_points)
        cluster
    end
end

export Cluster, free

set_contact_points(c::Cluster, contact_points::String) = ccall(
        (:cass_cluster_set_contact_points, libcass), Void, (Ptr{Void}, Cstring),
                c.ptr, contact_points)

free(c::Cluster) = ccall((:cass_cluster_free, libcass), Void, (Ptr{Void},), c.ptr)
