#include "VertexVolumeAttribute.h"
#include "Mesh.h"

#include <string>

void VertexVolumeAttribute::compute_from_mesh(Mesh& mesh) {
    size_t num_vertices = mesh.get_num_vertices();
    size_t num_voxels = mesh.get_num_voxels();
    size_t num_vertex_per_voxel = mesh.get_vertex_per_voxel();

    VectorI& voxels = mesh.get_voxels();
    VectorF& volumes = get_voxel_volumes(mesh);
    VectorF& vertex_volumes = m_values;

    vertex_volumes = VectorF::Zero(num_vertices);

    for (size_t i=0; i<num_voxels; i++) {
        for (size_t j=0; j<num_vertex_per_voxel; j++) {
            size_t index = i*num_vertex_per_voxel + j;
            vertex_volumes[voxels[index]] += volumes[i];
        }
    }
}

VectorF& VertexVolumeAttribute::get_voxel_volumes(Mesh& mesh) {
    std::string voxel_volume_attribute("voxel_volume");
    if (!mesh.has_attribute(voxel_volume_attribute)) {
        mesh.add_attribute(voxel_volume_attribute);
    }
    return mesh.get_attribute(voxel_volume_attribute);
}
