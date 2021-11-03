#!/bin/sh -l

#!/bin/sh
SRC=./src

echo $@

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
    *)
      ;;
  esac
done

echo "Package name    = $PACKAGE_NAME"
echo "Package version = $PACKAGE_VERSION"
echo "ProtoBuf folder = $PROTOBUF_FOLDER"
echo "Output path     = $OUTPUT_PATH"

echo "Creating .Net solution..."
rm -rf ./src
dotnet new sln --name $PACKAGE_NAME --output $SRC
dotnet new classlib --name $PACKAGE_NAME --output $SRC/$PACKAGE_NAME --framework netstandard2.0 
rm -f ./$SRC/$PACKAGE_NAME/Class1.cs


echo "Adding Protobuffer files..."
for file in $(find $PROTOBUF_FOLDER -name "*.proto")
do
    path="../.$file"
    echo "Protobuffer file found at $path"
    dotnet-grpc add-file  --services None --project ./$SRC/$PACKAGE_NAME/$PACKAGE_NAME.csproj  $path
done

dotnet pack ./$SRC/$PACKAGE_NAME/$PACKAGE_NAME.csproj -c Release -p:PackageVersion=$PACKAGE_VERSION -o $OUTPUT_PATH 
