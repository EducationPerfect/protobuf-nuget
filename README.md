# Protobuf NuGet GitHub Actions

This repository contains pack and publish action to generate Nuget Packages out of Protobuf files and publish them.

---
# Pack
The pack action has the following inputs:

## Inputs

### `package-name`

**Required** The name of the NuGet package.

### `package-version`

**Required** The version of the NuGet package.

### `protobuf-folder`

**Required** The path to the folder containing Protobuf files.

### `output-path`

**Required** The path to the put generated package at.

## Example usage

```yaml
uses: EducationPerfect/protobuf-nuget/pack@v0.3.0
with:
  package-name: 'AwesomePackage'
  package-version: 1.0.0
  protobuf-dir-path: ./protos
  output-path: ./packages
```

---
# Publish
TBC
