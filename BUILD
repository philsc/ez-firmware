load("//:tools/build_rules/firmware.bzl", "cc_firmware")

cc_binary(
    name = "test",
    srcs = [
        "test.cc",
    ],
)

cc_firmware(
    name = "avr_test",
    srcs = [
        "avr_test.cc",
    ],
    restricted_to = ["//tools:avr"],
)
