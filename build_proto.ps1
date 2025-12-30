Write-Host "Generating Protobuf code..."

$PROTO_PATH = ".\Proto\"
$OUT_DIR = ".\Runtime\"

# Docker image settings for proto compiler
$DOCKERFILE_PATH = ".\tools\protobuf-codegen\Dockerfile"
$PROTO_VERSION = "25.3"
$PROTO_IMAGE_NAME = "protoc-generator:$PROTO_VERSION"

# Create output directory if it doesn't exist
if (-not (Test-Path -Path $OUT_DIR -PathType Container)){
    New-Item -ItemType Directory -Path $OUT_DIR | Out-Null
}

Write-Host "Building Docker image '$PROTO_IMAGE_NAME' from '$DOCKERFILE_PATH'..."
docker build -f $DOCKERFILE_PATH -t $PROTO_IMAGE_NAME . --build-arg PROTOBUF_VERSION=$PROTO_VERSION

# Get .proto files
$protoFiles = Get-ChildItem -Path $PROTO_PATH -Filter "*.proto" | ForEach-Object { $_.Name }

Write-Host "Generating C# code..."
foreach ($file in $protoFiles) {
    Write-Host "  Generating C# for $file"

    $volumePathProto = (Convert-Path $PROTO_PATH).Replace('\', '/')
    $volumePathOut = (Convert-Path $OUT_DIR).Replace('\', '/')

    docker run --rm `
        -v `"$volumePathProto`":/app/proto `
        -v `"$volumePathOut`":/app/csharp_out `
        $PROTO_IMAGE_NAME `
        protoc -I/app/proto --csharp_out=/app/csharp_out /app/proto/$file
}

Write-Host "Done."
