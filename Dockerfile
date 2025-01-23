# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy the project file and restore dependencies
COPY MyRazorApp.csproj .
RUN dotnet restore

# Copy the rest of the application files and build
COPY . .
RUN dotnet publish -c Release -o /app

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy the build artifacts from the first stage
COPY --from=build /app .

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["dotnet", "MyRazorApp.dll"]
