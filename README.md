# ez-firmware
An experiment to write firmware for the Ergodox EZ using the latest C++
features.

Check out [build_avr_gcc.sh](tools/cpp/avr_gcc/build_avr_gcc.sh) to see how I
built the AVR toolchain.

Install [bazel](https://docs.bazel.build/versions/master/install.html) and
build everything like so:
```bash
bazel build -c opt //...
```

To build for AVR you need to specify the `--cpu` argument:
```bash
bazel build -c opt --cpu=avr //...
```
