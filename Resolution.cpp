// Engine/Source/Runtime/Rendering/ResolutionScaler.cpp
void setResolutionQuality(ResolutionLevel level) {
    switch(level) {
        case RES_720P:
            renderScale = 0.67f;
            break;
        case RES_1080P:
            renderScale = 1.0f;
            break;
        case RES_1440P:
            renderScale = 1.5f;
            break;
        case RES_4K:
            renderScale = 2.0f;
            break;
    }
    applyTAA(); 
}