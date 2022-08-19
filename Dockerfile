#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
# BUILD STAGE
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src
COPY . .
RUN dotnet restore "Test-AppSettings/Test-AppSettings.csproj"
RUN dotnet publish "Test-AppSettings/Test-AppSettings.csproj" -c Release -o /app --no-restore

# SERVE STAGE
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine
WORKDIR /app
COPY --from=build /app ./

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "Test-AppSettings.dll"]

#Docker run command
#docker run -d -p 80:5000 -p 443:5001 -e ASPNETCORE_URLS="https://+:5001;http://+:5000" -e ASPNET_ENVIRONMENT="Stage" -e ASPNETCORE_Kestrel__Certificates__Default__Password="1234" -e ASPNETCORE_Kestrel__Certificates__Default__Path=/https/aspnetapp.pfx -v ${HOME}/.aspnet/https:/https/ --name testlogging akasharya3/testlogging:latest
#docker run -d -p 5000:80 -p 5001:443 -e TestRoot__Test.Value="Docker" -e ASPNETCORE_URLS="https://+:443;http://+:80" -e ASPNET_ENVIRONMENT="Stage" -e ASPNETCORE_Kestrel__Certificates__Default__Password="1234" -e ASPNETCORE_Kestrel__Certificates__Default__Path=/https/aspnetapp.pfx -v ${HOME}/.aspnet/https:/https/ --name testappsettings takasharya3/est-appsettings:latest
