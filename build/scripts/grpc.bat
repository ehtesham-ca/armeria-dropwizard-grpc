@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  grpc startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and GRPC_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\grpc.jar;%APP_HOME%\lib\armeria-grpc-1.3.0.jar;%APP_HOME%\lib\armeria-dropwizard2-1.3.0.jar;%APP_HOME%\lib\armeria-grpc-protocol-1.3.0.jar;%APP_HOME%\lib\armeria-jetty9-1.3.0.jar;%APP_HOME%\lib\armeria-1.3.0.jar;%APP_HOME%\lib\grpc-services-1.33.1.jar;%APP_HOME%\lib\grpc-protobuf-1.33.1.jar;%APP_HOME%\lib\grpc-stub-1.33.1.jar;%APP_HOME%\lib\dropwizard-core-2.0.16.jar;%APP_HOME%\lib\dropwizard-metrics-2.0.16.jar;%APP_HOME%\lib\dropwizard-lifecycle-2.0.16.jar;%APP_HOME%\lib\dropwizard-jetty-2.0.16.jar;%APP_HOME%\lib\dropwizard-jersey-2.0.16.jar;%APP_HOME%\lib\dropwizard-configuration-2.0.16.jar;%APP_HOME%\lib\dropwizard-request-logging-2.0.16.jar;%APP_HOME%\lib\dropwizard-logging-2.0.16.jar;%APP_HOME%\lib\dropwizard-jackson-2.0.16.jar;%APP_HOME%\lib\dropwizard-validation-2.0.16.jar;%APP_HOME%\lib\dropwizard-servlets-2.0.16.jar;%APP_HOME%\lib\dropwizard-util-2.0.16.jar;%APP_HOME%\lib\grpc-protobuf-lite-1.33.1.jar;%APP_HOME%\lib\grpc-core-1.33.1.jar;%APP_HOME%\lib\grpc-api-1.33.1.jar;%APP_HOME%\lib\perfmark-api-0.19.0.jar;%APP_HOME%\lib\protobuf-jackson-1.1.0.jar;%APP_HOME%\lib\protobuf-java-util-3.12.0.jar;%APP_HOME%\lib\metrics-servlets-4.1.16.jar;%APP_HOME%\lib\jackson-datatype-joda-2.12.0.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.12.0.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.12.0.jar;%APP_HOME%\lib\jackson-module-afterburner-2.12.0.jar;%APP_HOME%\lib\jackson-module-parameter-names-2.12.0.jar;%APP_HOME%\lib\jackson-dataformat-yaml-2.12.0.jar;%APP_HOME%\lib\metrics-json-4.1.16.jar;%APP_HOME%\lib\jackson-jaxrs-json-provider-2.12.0.jar;%APP_HOME%\lib\jackson-jaxrs-base-2.12.0.jar;%APP_HOME%\lib\jackson-module-jaxb-annotations-2.12.0.jar;%APP_HOME%\lib\jackson-databind-2.12.0.jar;%APP_HOME%\lib\jackson-core-2.12.0.jar;%APP_HOME%\lib\jackson-annotations-2.12.0.jar;%APP_HOME%\lib\jackson-datatype-guava-2.12.0.jar;%APP_HOME%\lib\guava-30.0-jre.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\reactor-core-3.3.8.RELEASE.jar;%APP_HOME%\lib\metrics-jetty9-4.1.16.jar;%APP_HOME%\lib\metrics-jvm-4.1.16.jar;%APP_HOME%\lib\metrics-jmx-4.1.16.jar;%APP_HOME%\lib\metrics-jersey2-4.1.16.jar;%APP_HOME%\lib\metrics-logback-4.1.16.jar;%APP_HOME%\lib\metrics-core-4.1.16.jar;%APP_HOME%\lib\metrics-healthchecks-4.1.16.jar;%APP_HOME%\lib\jul-to-slf4j-1.7.30.jar;%APP_HOME%\lib\log4j-over-slf4j-1.7.30.jar;%APP_HOME%\lib\jcl-over-slf4j-1.7.30.jar;%APP_HOME%\lib\metrics-annotation-4.1.16.jar;%APP_HOME%\lib\slf4j-api-1.7.30.jar;%APP_HOME%\lib\micrometer-core-1.5.3.jar;%APP_HOME%\lib\netty-codec-http2-4.1.51.Final.jar;%APP_HOME%\lib\netty-codec-haproxy-4.1.51.Final.jar;%APP_HOME%\lib\netty-resolver-dns-4.1.51.Final.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.51.Final-linux-x86_64.jar;%APP_HOME%\lib\netty-incubator-transport-native-io_uring-0.0.1.Final-linux-x86_64.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.51.Final-linux-x86_64.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.51.Final.jar;%APP_HOME%\lib\netty-handler-proxy-4.1.51.Final.jar;%APP_HOME%\lib\netty-codec-http-4.1.51.Final.jar;%APP_HOME%\lib\netty-handler-4.1.51.Final.jar;%APP_HOME%\lib\netty-codec-dns-4.1.51.Final.jar;%APP_HOME%\lib\netty-codec-socks-4.1.51.Final.jar;%APP_HOME%\lib\netty-codec-4.1.51.Final.jar;%APP_HOME%\lib\netty-transport-4.1.51.Final.jar;%APP_HOME%\lib\reactive-streams-1.0.3.jar;%APP_HOME%\lib\netty-tcnative-boringssl-static-2.0.34.Final.jar;%APP_HOME%\lib\protobuf-java-3.12.0.jar;%APP_HOME%\lib\javax.annotation-api-1.3.2.jar;%APP_HOME%\lib\HdrHistogram-2.1.12.jar;%APP_HOME%\lib\LatencyUtils-2.0.3.jar;%APP_HOME%\lib\netty-buffer-4.1.51.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.51.Final.jar;%APP_HOME%\lib\netty-common-4.1.51.Final.jar;%APP_HOME%\lib\gson-2.8.6.jar;%APP_HOME%\lib\annotations-4.1.1.4.jar;%APP_HOME%\lib\proto-google-common-protos-1.17.0.jar;%APP_HOME%\lib\caffeine-2.8.6.jar;%APP_HOME%\lib\error_prone_annotations-2.4.0.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.18.jar;%APP_HOME%\lib\jersey-bean-validation-2.32.jar;%APP_HOME%\lib\jersey-container-servlet-2.32.jar;%APP_HOME%\lib\jersey-container-servlet-core-2.32.jar;%APP_HOME%\lib\jersey-server-2.32.jar;%APP_HOME%\lib\jersey-metainf-services-2.32.jar;%APP_HOME%\lib\jersey-hk2-2.32.jar;%APP_HOME%\lib\jersey-client-2.32.jar;%APP_HOME%\lib\jersey-media-jaxb-2.32.jar;%APP_HOME%\lib\jersey-common-2.32.jar;%APP_HOME%\lib\hk2-locator-2.6.1.jar;%APP_HOME%\lib\hk2-api-2.6.1.jar;%APP_HOME%\lib\hk2-utils-2.6.1.jar;%APP_HOME%\lib\jakarta.annotation-api-1.3.5.jar;%APP_HOME%\lib\byte-buddy-1.10.9.jar;%APP_HOME%\lib\logback-classic-1.2.3.jar;%APP_HOME%\lib\jakarta.servlet-api-4.0.4.jar;%APP_HOME%\lib\hibernate-validator-6.1.6.Final.jar;%APP_HOME%\lib\jakarta.validation-api-2.0.2.jar;%APP_HOME%\lib\jakarta.ws.rs-api-2.1.6.jar;%APP_HOME%\lib\argparse4j-0.8.1.jar;%APP_HOME%\lib\jetty-servlet-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-security-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-server-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-servlets-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-http-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-io-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-util-ajax-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-util-9.4.35.v20201120.jar;%APP_HOME%\lib\jetty-setuid-java-1.0.4.jar;%APP_HOME%\lib\jakarta.inject-2.6.1.jar;%APP_HOME%\lib\classmate-1.5.1.jar;%APP_HOME%\lib\jakarta.el-3.0.3.jar;%APP_HOME%\lib\javassist-3.27.0-GA.jar;%APP_HOME%\lib\joda-time-2.10.8.jar;%APP_HOME%\lib\commons-text-1.9.jar;%APP_HOME%\lib\commons-lang3-3.11.jar;%APP_HOME%\lib\grpc-context-1.33.1.jar;%APP_HOME%\lib\logback-access-1.2.3.jar;%APP_HOME%\lib\logback-core-1.2.3.jar;%APP_HOME%\lib\logback-throttling-appender-1.1.0.jar;%APP_HOME%\lib\profiler-1.1.1.jar;%APP_HOME%\lib\osgi-resource-locator-1.0.3.jar;%APP_HOME%\lib\jboss-logging-3.3.2.Final.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\checker-qual-3.7.0.jar;%APP_HOME%\lib\j2objc-annotations-1.3.jar;%APP_HOME%\lib\jetty-continuation-9.4.35.v20201120.jar;%APP_HOME%\lib\aopalliance-repackaged-2.6.1.jar;%APP_HOME%\lib\snakeyaml-1.27.jar;%APP_HOME%\lib\jakarta.xml.bind-api-2.3.2.jar;%APP_HOME%\lib\jakarta.activation-api-1.2.1.jar


@rem Execute grpc
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %GRPC_OPTS%  -classpath "%CLASSPATH%" example.armeria.dropwizard.DropwizardArmeriaApplication %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable GRPC_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%GRPC_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
