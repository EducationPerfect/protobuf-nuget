FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

RUN dotnet tool install -g --version 2.43.0 dotnet-grpc
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
