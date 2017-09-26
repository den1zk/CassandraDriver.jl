struct Cluster
    cass_cluster::Ptr{Void}
end

cluster_new() = Cluster( ccall((:cass_cluster_new, libcass), Ptr{Void},  (), ) )

function cluster_new(contact_points::String)
    cluster = cluster_new()
    set_contact_points(cluster, contact_points)
    cluster
end

set_contact_points(c::Cluster, contact_points::String) = ccall( 
        (:cass_cluster_set_contact_points, libcass), Void, (Ptr{Void}, Cstring),
                c.cass_cluster, contact_points)

free(c::Cluster) = ccall((:cass_cluster_free, libcass), Void, (Ptr{Void},), c.cass_cluster)
