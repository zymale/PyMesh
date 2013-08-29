#pragma once

#include "MeshAttribute.h"

class FaceNormalAttribute : public MeshAttribute {
    public:
        FaceNormalAttribute(const std::string& name) : MeshAttribute(name) {}
        virtual ~FaceNormalAttribute() {}

    public:
        virtual void compute_from_mesh(Mesh& mesh);

    private:
        Vector3F compute_triangle_normal(Mesh& mesh, size_t i);
};
