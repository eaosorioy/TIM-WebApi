FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
LABEL maintainer="eaosorioy@gmail.com"
LABEL maintainer="brayanm.avelez@gmail.com"
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["timapi.csproj", "./"]
RUN dotnet restore "./timapi.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "timapi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "timapi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "timapi.dll"]
