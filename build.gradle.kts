group = "com.ibm.pl.mlewandowski.certificates"
version = "1.0.0-SNAPSHOT"

plugins {
    base
    id("io.quarkus") apply false
}

subprojects {
    apply {
        plugin("java")
        plugin("io.quarkus")
    }

    val quarkusPlatformGroupId: String by project
    val quarkusPlatformArtifactId: String by project
    val quarkusPlatformVersion: String by project

    dependencies {
        "implementation"(enforcedPlatform("${quarkusPlatformGroupId}:${quarkusPlatformArtifactId}:${quarkusPlatformVersion}"))
        "implementation"("io.quarkus:quarkus-rest")
        "implementation"("io.quarkus:quarkus-arc")
        "testImplementation"("io.quarkus:quarkus-junit5")
        "testImplementation"("io.quarkus:quarkus-junit5-mockito")
        "testImplementation"("io.rest-assured:rest-assured")
    }

    repositories {
        mavenCentral()
    }

    configure<JavaPluginExtension> {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    tasks.withType<Test> {
        systemProperty("java.util.logging.manager", "org.jboss.logmanager.LogManager")
    }

    tasks.withType<JavaCompile> {
        options.encoding = "UTF-8"
        options.compilerArgs.add("-parameters")
    }

}
