FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

RUN dotnet tool install -g dotnet-grpc
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY Directory.Build.props .
COPY entrypoint.sh .
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]
