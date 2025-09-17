package com.ibm.pl.mlewandowski.certificates;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

import io.quarkus.test.InjectMock;
import io.quarkus.test.junit.QuarkusTest;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

@QuarkusTest
class GreetingResourceTest {

    @InjectMock
    @RestClient
    RemoteGreetingService mock;

    @BeforeEach
    public void setUp() {
        Mockito.when(mock.getGreeting()).thenReturn("Hello from Quarkus REST");
    }

    @Test
    void testHelloEndpoint() {
        given().when().get("/hello").then().statusCode(200).body(is("Remote greeting: Hello from Quarkus REST"));
    }
}
