Write-Host "Generating Protobuf code..."

$PROTO_PATH = "./Proto"
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
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "$PROTO_PATH/landmark.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "$PROTO_PATH/kinect_pose_landmarks.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "$PROTO_PATH/pose_landmarks.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "$PROTO_PATH/hand_landmarks.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "$PROTO_PATH/face_results.proto"
protoc -I"$PROTO_PATH" --python_out="$PYTHON_OUT_DIR" "$PROTO_PATH/holistic_landmarks.proto"

# Create an empty __init__.py file
New-Item -Path "$PYTHON_OUT_DIR\__init__.py" -ItemType File -Force | Out-Null

Write-Host "Generating C# code..."
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "$PROTO_PATH/landmark.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "$PROTO_PATH/kinect_pose_landmarks.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "$PROTO_PATH/pose_landmarks.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "$PROTO_PATH/hand_landmarks.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "$PROTO_PATH/face_results.proto"
protoc -I"$PROTO_PATH" --csharp_out="$CSHARP_OUT_DIR" "$PROTO_PATH/holistic_landmarks.proto"

Write-Host "Done."
