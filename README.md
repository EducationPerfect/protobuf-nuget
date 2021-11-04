# Protobuf NuGet GitHub Actions

This repository contains pack and publish action to generate Nuget Packages out of Protobuf files and publish them.

---
# Pack
The `pack` action generate a Nuget package out of the given Protobuf files and has the following inputs:

## Inputs

### `package-name`

**Required** The name of the NuGet package.

### `package-version`

**Required** The version of the NuGet package.

### `protobuf-folder`

**Required** The path to the folder containing Protobuf files.

### `output-path`

**Required** The path to the put generated package at.

### `company-name`

The name of the company publishing the package. The default value is `Education Perfect`.

### `authors`

The authors of the package. The default value is `Education Perfect`.

## Example usage

```yaml
uses: EducationPerfect/protobuf-nuget/pack@v0.3.8
with:
  package-name: 'AwesomePackage'
  package-version: 1.0.0
  protobuf-dir-path: ./protos
  output-path: ./packages
  authors: 'Team Void'
```

---
# Publish
The `public` action publish the given Nuget packages to s given source and has the following inputs:

## Inputs

### `packages`

**Required** The path of the NuGet package. (e.g. ./packages/*.nupkg)

### `source`

**Required** The source for hosting NuGet packages.

### `api-key`

**Required** The API Key of the source.

## Example usage

```yaml
uses: EducationPerfect/protobuf-nuget/publish@v0.3.8
with:
  packages: ./packages/*.nupkg
  source: https://nuget.pkg.github.com/${{ github.repository_owner }}/index.json
  api-key: ${{ github.token }}
```
