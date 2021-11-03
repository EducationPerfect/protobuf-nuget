#!/bin/sh -l

#!/bin/sh
SRC=./src


for i in "$@"; do
  case $i in
    -p=*|--packages=*)
      PACKAGES="${i#*=}"
      shift
      ;;
    -s=*|--source=*)
      SOURCE="${i#*=}"
      shift
      ;;
    -k=*|--api-key=*)
      API_KEY="${i#*=}"
      shift
      ;;
    *)
      ;;
  esac
done

echo "Packages = $PACKAGES"
echo "Source   = $SOURCE"
echo "API KEY  = ****"

dotnet nuget push ./$PACKAGES \
          --source $SOURCE \
          --api-key $API_KEY \
          --skip-duplicate
