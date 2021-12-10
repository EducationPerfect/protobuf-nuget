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
PROJ=./$SRC/$PACKAGE_NAME/$PACKAGE_NAME.csproj

echo "Clean up..."
rm -rf ./src

echo "Creating file 'Directory.Build.props'..."
cp /opt/build-tools/Directory.Build.props.template ./Directory.Build.props
sed -i -e "s/{{ Company }}/$COMPANY/g" -e "s/{{ Authors }}/$AUTHORS/g"  Directory.Build.props

echo "Creating $PACKAGE_NAME project..."
dotnet new classlib --name $PACKAGE_NAME --output $SRC/$PACKAGE_NAME --framework netstandard2.0
rm -f ./$SRC/$PACKAGE_NAME/Class1.cs

echo "Adding Protobuf files..."

count=$(find $PROTOBUF_FOLDER -name "*.proto" | wc -l)
if [ "$count" -eq "0" ]; then
  echo "Error: No Protobuf file found at '$PROTOBUF_FOLDER'"
  exit -1
fi  

for file in $(find $PROTOBUF_FOLDER -name "*.proto" -exec readlink -f {} \;)
do
  echo "Protobuf file found at '$file'. Trying to add it to the project..."
  dotnet-grpc add-file  --services None --project $PROJ  $file
done

added_files=$(dotnet-grpc list --project $PROJ | grep -c "$PROTOBUF_FOLDER" )
if [ $added_files -ne $count ]; then
  echo "Error: The number of the Protobuf files found at the given path and the number of added files to the project doesn't march (found=$count,added=$added_files)!"
  exit -1
else
    echo "$count Protobuf file(s) added to the project successfully"
    echo " "
fi

echo "Restoring packages"...
dotnet restore $PROJ

echo "Packing $PACKAGE_NAME version $PACKAGE_VERSION at $OUTPUT_PATH"...
dotnet pack $PROJ -c Release --no-build --no-restore  -p:PackageVersion=$PACKAGE_VERSION -o $OUTPUT_PATH 
