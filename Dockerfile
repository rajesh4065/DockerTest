FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /DockerTest
COPY *.sln .
COPY DockerTest/*.csproj ./DockerTest/
RUN dotnet restore
COPY DockerTest/. ./DockerTest/
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /DockerTest
COPY --from=build /DockerTest/out ./
ENTRYPOINT ["dotnet", "DockerTest.dll"]
