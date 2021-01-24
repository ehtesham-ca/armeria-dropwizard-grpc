package example.armeria.dropwizard;

import com.linecorp.armeria.common.HttpResponse;
import com.linecorp.armeria.common.MediaType;
import com.linecorp.armeria.common.grpc.GrpcSerializationFormats;
import com.linecorp.armeria.dropwizard.ArmeriaBundle;
import com.linecorp.armeria.server.HttpServiceWithRoutes;
import com.linecorp.armeria.server.ServerBuilder;

import com.linecorp.armeria.server.docs.DocService;
import com.linecorp.armeria.server.docs.DocServiceFilter;
import com.linecorp.armeria.server.grpc.GrpcService;
import example.armeria.dropwizard.armeria.services.http.HelloService;
import example.armeria.dropwizard.health.PingCheck;
import example.armeria.dropwizard.resources.JerseyResource;
import example.armeria.grpc.Hello;
import example.armeria.grpc.HelloServiceGrpc;
import example.armeria.grpc.HelloServiceImpl;
import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import io.grpc.protobuf.services.ProtoReflectionService;
import io.grpc.reflection.v1alpha.ServerReflectionGrpc;

public class DropwizardArmeriaApplication extends Application<DropwizardArmeriaConfiguration> {

    public static void main(String[] args) throws Exception {
        new DropwizardArmeriaApplication().run(args);
    }

    @Override
    public String getName() {
        return "dropwizard-armeria";
    }

    @Override
    public void initialize(Bootstrap<DropwizardArmeriaConfiguration> bootstrap) {
        final Hello.HelloRequest exampleRequest = Hello.HelloRequest.newBuilder().setName("Armeria").build();
        final HttpServiceWithRoutes grpcService =
                GrpcService.builder()
                        .addService(new HelloServiceImpl())
                        // See https://github.com/grpc/grpc-java/blob/master/documentation/server-reflection-tutorial.md
                        .addService(ProtoReflectionService.newInstance())
                        .supportedSerializationFormats(GrpcSerializationFormats.values())
                        .enableUnframedRequests(true)
                        // You can set useBlockingTaskExecutor(true) in order to execute all gRPC
                        // methods in the blockingTaskExecutor thread pool.
                        // .useBlockingTaskExecutor(true)
                        .build();
        final ArmeriaBundle<DropwizardArmeriaConfiguration> bundle =
                new ArmeriaBundle<DropwizardArmeriaConfiguration>() {
            @Override
            public void configure(ServerBuilder builder) {
                builder.service("/", (ctx, res) -> HttpResponse.of(MediaType.HTML_UTF_8, "<h2>It works!</h2>"));
                builder.service("/armeria", (ctx, res) -> HttpResponse.of("Hello, Armeria!"));

                builder.annotatedService(new HelloService());

                // You can also bind asynchronous RPC services such as Thrift and gRPC:
                // builder.service(THttpService.of(...));
                builder.service(grpcService);
                // You can access the documentation service at http://127.0.0.1:8080/docs.
                // See https://armeria.dev/docs/server-docservice for more information.
                builder.serviceUnder("/docs",
                        DocService.builder()
                                .exampleRequests(HelloServiceGrpc.SERVICE_NAME,
                                        "Hello", exampleRequest)
                                .exampleRequests(HelloServiceGrpc.SERVICE_NAME,
                                        "LazyHello", exampleRequest)
                                .exampleRequests(HelloServiceGrpc.SERVICE_NAME,
                                        "BlockingHello", exampleRequest)
                                .exclude(DocServiceFilter.ofServiceName(
                                        ServerReflectionGrpc.SERVICE_NAME))
                                .build());
            }
        };
        bootstrap.addBundle(bundle);
    }

    @Override
    public void run(DropwizardArmeriaConfiguration configuration,
                    Environment environment) {
        environment.jersey().register(JerseyResource.class);

        environment.healthChecks().register("ping", new PingCheck());
    }
}
