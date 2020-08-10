# java-native-image-cnb-builder
A builder for Cloud Native Buildpacks to build a native java image

## How to build an image using this builder

```
pack build <image name> --builder making/java-native-image-cnb-builder --path <path-to-java-project-or-jar-file> -e BP_BOOT_NATIVE_IMAGE=1
```


### Example

```
curl https://start.spring.io/starter.tgz \
  -s \
  -d javaVersion=11 \
  -d artifactId=hello \
  -d baseDir=hello \
  -d dependencies=webflux,actuator \
  -d packageName=com.example \
  -d applicationName=HelloApplication | tar -xzvf -
sed -i.bak 's/@SpringBootApplication/@SpringBootApplication(proxyBeanMethods = false)/' hello/src/main/java/com/example/HelloApplication.java
rm -f hello/src/main/java/com/example/HelloApplication.java.bak

cd hello
./mvnw clean package -Dmaven.test.skip=true

pack build foo \
  --builder making/java-native-image-cnb-builder \
  --path target/hello*.jar \
  -e BP_BOOT_NATIVE_IMAGE=1


docker run --rm \
  -p 8080:8080 \
  -m 128m \
  -e MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE=info,health,env \
  foo

curl localhost:8080/actuator/env
```

## How to build this builder

```
pack create-builder making/java-native-image-cnb-builder -c builder.toml
```