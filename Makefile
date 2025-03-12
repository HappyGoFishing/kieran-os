build_dir := out
boot_outfile := bootloader.bin
boot_srcfile := bootloader.asm
boot_outname := $(boot_outfile)

default:
	make build
	make run_vm_no_graphics
	
build: setup
	nasm -f bin src/boot/$(boot_srcfile) -o $(build_dir)/$(boot_outname)

setup:
	mkdir -p $(build_dir)

run_vm:
	GDK_SCALE=2 qemu-system-x86_64 $(build_dir)/$(boot_outname) -vga virtio -display gtk

run_vm_no_graphics:
	qemu-system-x86_64 -nographic $(build_dir)/$(boot_outname)

od:
	objdump -D -b binary -m i8086 -M intel $(build_dir)/$(boot_outname)
