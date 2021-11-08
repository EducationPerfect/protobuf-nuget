#!/bin/sh -l

set -e

SRC=./src

for i in "$@"; do
  case $i in
    -n=*|--package-name=*)
      PACKAGE_NAME="${i#*=}"
      shift
      ;;
    -v=*|--package-version=*)
      PACKAGE_VERSION="${i#*=}"
      shift
      ;;
    -p=*|--protobuf-dir-path=*)
      PROTOBUF_FOLDER="${i#*=}"
      shift
      ;;
    -o=*|--output-path=*)
      OUTPUT_PATH="${i#*=}"
      shift
      ;;
    -c=*|--company=*)
      COMPANY="${i#*=}"
      shift
      ;;
    -a=*|--authors=*)
      AUTHORS="${i#*=}"
      shift
      ;;
    *)
      ;;
  esac
done

echo "[Inputs]:"
echo "  - Package name    = $PACKAGE_NAME"
echo "  - Package version = $PACKAGE_VERSION"
echo "  - ProtoBuf folder = $PROTOBUF_FOLDER"
echo "  - Output path     = $OUTPUT_PATH"
echo "  - Company         = $COMPANY"
echo "  - Authors         = $AUTHORS"

export PATH="$PATH:/root/.dotnet/tools"

echo "Clean up..."
rm -rf ./src

echo "Installing GRPC tools"
export PATH="$PATH:/root/.dotnet/tools"
dotnet tool install --global dotnet-grpc-cli --version 0.5.0

echo "Creating file 'Directory.Build.props'..."
cp /opt/build-tools/Directory.Build.props.template ./Directory.Build.props
sed -i -e "s/{{ Company }}/$COMPANY/g" -e "s/{{ Authors }}/$AUTHORS/g"  Directory.Build.props

echo "Creating $PACKAGE_NAME project..."
dotnet new classlib --name $PACKAGE_NAME --output $SRC/$PACKAGE_NAME --framework netstandard2.0
rm -f ./$SRC/$PACKAGE_NAME/Class1.cs

echo "Adding Protobuf files..."
found=$(find $PROTOBUF_FOLDER -name "*.proto" | grep -q '.' && echo 'found')

if [ "$found" = "found" ]; then
  for file in $(find $PROTOBUF_FOLDER -name "*.proto")
  do
      path="../.$file"
      dotnet-grpc add-file  --services None --project ./$SRC/$PACKAGE_NAME/$PACKAGE_NAME.csproj  $path
  done

  echo "Packing $PACKAGE_NAME version $PACKAGE_VERSION at $OUTPUT_PATH"...
  dotnet pack ./$SRC/$PACKAGE_NAME/$PACKAGE_NAME.csproj -c Release -p:PackageVersion=$PACKAGE_VERSION -o $OUTPUT_PATH
else
  echo "Error: No Protobuf file found at '$PROTOBUF_FOLDER'"
  exit -1
fi
