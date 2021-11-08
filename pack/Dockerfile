FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

RUN dotnet tool install -g dotnet-grpc
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY Directory.Build.props /opt/build-tools/Directory.Build.props.template
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT [ "/bin/entrypoint.sh"]
