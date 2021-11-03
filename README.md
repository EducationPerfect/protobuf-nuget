# Protobuf NuGet Generator

This action generates Nuget Packages out of Protobuf files.

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
uses: EducationPerfect/protobuf-nuget-generator@master
with:
  package-name: 'AwesomePackage'
  package-version: 1.0.0
  protobuf-dir-path: ./protos
  output-path: ./packages
```
