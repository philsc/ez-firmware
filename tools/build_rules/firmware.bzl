def _cc_firwmare_extras_impl(ctx):
    src = ctx.attr.src.files.to_list()[0]

    ctx.action(
        command = "{nm} {elf} > {map}".format(
            nm = ctx.fragments.cpp.nm_executable,
            elf = src.path,
            map = ctx.outputs.map.path,
        ),
        outputs = [
            ctx.outputs.map,
        ],
        inputs = ctx.files._cc_toolchain + [
            src,
        ],
    )

    ctx.action(
        command = "{objcopy} -O binary {elf} {bin}".format(
            objcopy = ctx.fragments.cpp.objcopy_executable,
            elf = src.path,
            bin = ctx.outputs.bin.path,
        ),
        outputs = [
            ctx.outputs.bin,
        ],
        inputs = ctx.files._cc_toolchain + [
            src,
        ],
    )

    ctx.action(
        command = "{objcopy} -O ihex {elf} {hex}".format(
            objcopy = ctx.fragments.cpp.objcopy_executable,
            elf = src.path,
            hex = ctx.outputs.hex.path,
        ),
        outputs = [ctx.outputs.hex],
        inputs = ctx.files._cc_toolchain + [
            src,
        ],
    )

_cc_firmware_extras = rule(
    implementation = _cc_firwmare_extras_impl,
    fragments = ["cpp"],
    attrs = {
        "src": attr.label(mandatory = True, single_file = True),
        "_cc_toolchain": attr.label(default = Label("//tools/cpp:toolchain")),
    },
    outputs = {
        "bin": "%{name}.bin",
        "hex": "%{name}.hex",
        "map": "%{name}.map",
    }
)

def cc_firmware(name, visibility=None, restricted_to=None, **kwargs):
    native.cc_binary(
        name = name + "__binary",
        restricted_to = restricted_to,
        visibility = ["//visibility:private"],
        **kwargs
    )

    _cc_firmware_extras(
        name = name,
        src = ":%s__binary" % name,
        restricted_to = restricted_to,
        visibility = visibility,
    )
