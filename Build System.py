import os
import subprocess
import platform

def build_engine(config='Release'):
    build_dir = f"Build/{platform.system()}/{config}"
    os.makedirs(build_dir, exist_ok=True)
    
    # Generate project files
    subprocess.run(["cmake", "-S", ".", "-B", build_dir, 
                   f"-DCMAKE_BUILD_TYPE={config}"])
    
    # Compile
    subprocess.run(["cmake", "--build", build_dir, "--config", config])
    
    # Deploy to Binaries
    deploy_dir = f"Binaries/{config}"
    os.makedirs(deploy_dir, exist_ok=True)
    copy_artifacts(build_dir, deploy_dir)

if __name__ == "__main__":
    build_engine('Development')