FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

RUN dotnet tool install -g dotnet-grpc --version 2.44.0
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY Directory.Build.props /opt/build-tools/Directory.Build.props.template
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT [ "/bin/entrypoint.sh"]
