Write-Host "Generating Protobuf code..."

$PROTO_PATH = "./Proto/"
$PYTHON_OUT_DIR = ".\Runtime\Python"
$CSHARP_OUT_DIR = ".\Runtime\Csharp"

# Create proto_generated directory for Python, similar to 'mkdir || echo' but more PowerShell idiomatic.
if (-not (Test-Path -Path $PYTHON_OUT_DIR -PathType Container)){
    New-Item -ItemType Directory -Path $PYTHON_OUT_DIR | Out-Null
}

# Create C# output directory if it doesn't exist
if (-not (Test-Path -Path $CSHARP_OUT_DIR -PathType Container)){
    New-Item -ItemType Directory -Path $CSHARP_OUT_DIR | Out-Null
}

Write-Host "Generating Python code..."
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "landmark.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "kinect_pose_landmarks.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "pose_landmarks.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "hand_landmarks.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "face_results.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "holistic_landmarks.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "landmark_log.proto"

# Create an empty __init__.py file
New-Item -Path "$PYTHON_OUT_DIR\__init__.py" -ItemType File -Force | Out-Null

Write-Host "Generating C# code..."
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "landmark.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "kinect_pose_landmarks.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "pose_landmarks.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "hand_landmarks.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "face_results.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "holistic_landmarks.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "landmark_log.proto"

Write-Host "Done."
