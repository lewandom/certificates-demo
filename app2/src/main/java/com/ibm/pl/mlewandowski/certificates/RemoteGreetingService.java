package com.ibm.pl.mlewandowski.certificates;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@Path("/")
@RegisterRestClient(configKey = "remote-greeting")
public interface RemoteGreetingService {
    @GET
    @Path("/hello")
    @Produces(MediaType.TEXT_PLAIN)
    String getGreeting();
}
