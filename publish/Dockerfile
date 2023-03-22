FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

RUN dotnet tool install -g dotnet-grpc
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
