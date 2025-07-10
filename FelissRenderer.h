#pragma once

#include <string>
#include <iostream>

namespace FelissRenderer {

enum class AntiAliasingMode {
    NONE,
    FXAA,
    SMAA,
    TAA
};

class RendererSettings {
public:
    static AntiAliasingMode GetAAModeFromString(const std::string& modeStr) {
        if (modeStr == "FXAA") return AntiAliasingMode::FXAA;
        if (modeStr == "SMAA") return AntiAliasingMode::SMAA;
        if (modeStr == "TAA") return AntiAliasingMode::TAA;
        return AntiAliasingMode::NONE;
    }

    static std::string ToString(AntiAliasingMode mode) {
        switch (mode) {
            case AntiAliasingMode::FXAA: return "FXAA";
            case AntiAliasingMode::SMAA: return "SMAA";
            case AntiAliasingMode::TAA: return "TAA";
            default: return "NONE";
        }
    }
};

class Renderer {
private:
    AntiAliasingMode currentAA = AntiAliasingMode::NONE;

public:
    void SetAntiAliasingMode(AntiAliasingMode mode) {
        currentAA = mode;
        std::cout << "[Renderer] AntiAliasing set to " << RendererSettings::ToString(mode) << "\n";
        // Apply shaders or pipeline changes here
    }

    AntiAliasingMode GetAntiAliasingMode() const {
        return currentAA;
    }
};

} 