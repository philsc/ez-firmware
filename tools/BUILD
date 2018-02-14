package(default_visibility = ["//visibility:public"])

environment(name = "k8")

environment(name = "avr")

environment_group(
    name = "cpus",
    defaults = [
        ":k8",
        ":avr",
    ],
    environments = [
        ":k8",
        ":avr",
    ],
)
