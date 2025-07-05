# Scripts/AssetProcessing/BlenderImporter.py
def import_blender_model(filepath):
    model = load_gltf(filepath)
    if model.polycount > 1000000:
        return convert_to_nanite_mesh(model)
    return model