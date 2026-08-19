FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Pin dotnet-grpc to the last version that supports the net7.0 SDK.
# Version 2.76.0 and later target net8.0 and fail to install on this image.
RUN dotnet tool install -g dotnet-grpc --version 2.71.0
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
