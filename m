From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
Date: Mon, 16 Sep 2019 14:38:39 -0700 (PDT)
Message-ID: <mhng-5091669f-461c-4e62-a71c-e16957801fad@palmer-si-x1c4>
References: <87ftkwdo85.fsf@igel.home>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ftkwdo85.fsf@igel.home>
Sender: linux-kernel-owner@vger.kernel.org
To: schwab@suse.de
Cc: Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, 16 Sep 2019 12:40:10 PDT (-0700), schwab@suse.de wrote:
> On Sep 16 2019, Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> On Sun, 15 Sep 2019 23:42:53 PDT (-0700), Christoph Hellwig wrote:
>>> On Fri, Sep 13, 2019 at 01:40:27PM -0700, Palmer Dabbelt wrote:
>>>> OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.
>>>> I can't find anything about just "earlycon".  I've sent a patch adding sbi
>>>> to the list of earlycon arguments.
>>>
>>> earlycon without arguments is documented, although just for ARM64.
>>> I can send a patch to update it to properly cover all DT platforms
>>> in addition.
>>
>> Thanks.  I've kind of lost track of the thread, but assuming that does the
>> "automatically pick an earlycon" stuff then that's probably what we should
>> be using in the distros.
>
> Except that it doesn't work.

Sorry, once again I've lost track of the thread.

The code looks generic.  The device tree in arch/riscv for the HiFive Unleashed 
doesn't have a stdout-path set, which if I understand correctly is used by the 
automatic earlycon stuff to pick a console.  I gave this a quick test on QEMU, 
which finds a 16550 earlycon for me.  I use openembedded's qemuriscv64 target, 
the following diff to make sure I'm getting an earlycon

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 5cd8c36c8fcc..61290714bbcb 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -106,6 +106,7 @@ static void early_serial8250_write(struct console *console,
        struct earlycon_device *device = console->data;
        struct uart_port *port = &device->port;

+       uart_console_write(port, "_e_", 3, serial_putc);
        uart_console_write(port, s, count, serial_putc);
 }

and run this command line

    /home/palmer/work/linux/openembedded-riscv64/build/tmp-glibc/work/x86_64-linux/qemu-helper-native/1.0-r1/recipe-sysroot-native/usr/bin/qemu-system-riscv64 -device virtio-net-device,netdev=net0,mac=52:54:00:12:35:02 -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::2323-:23,tftp=/home/palmer/work/linux/openembedded-riscv64/build/tmp-glibc/deploy/images/qemuriscv64 -drive id=disk0,file=/home/palmer/work/linux/openembedded-riscv64/build/tmp-glibc/deploy/images/qemuriscv64/core-image-full-cmdline-qemuriscv64-20190711162644.rootfs.ext4,if=none,format=raw -device virtio-blk-device,drive=disk0 -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-device,rng=rng0 -show-cursor -monitor null -device loader,file=/home/palmer/work/linux/linux/arch/riscv/boot/Image,addr=0x802000
 00  -nographic -machine virt  -m 512 -serial mon:stdio -serial null -kernel /home/palmer/work/linux/openembedded-riscv64/build/tmp-glibc/deploy/images/qemuriscv64/fw_jump.elf -append 'root=/dev/vda rw highres=off  console=ttyS0 mem=512M ip=dhcp earlycon '

which gives me some early stuff and then some non-early stuff

_e_[    0.407579] printk: console [ttyS0] disabled
_e_[    0.409205] 10000000.uart: ttyS0 at MMIO 0x10000000 (irq = 10, base_baud = 230400) is a 16550A
[    0.410720] printk: console [ttyS0] enabled
_e_[    0.410720] printk: console [ttyS0] enabled
[    0.411391] printk: bootconsole [ns16550a0] disabled
_e_[    0.411391] printk: bootconsole [ns16550a0] disabled
[    0.420664] [drm] radeon kernel modesetting enabled.
[    0.428086] random: fast init done
[    0.429331] random: crng init done
[    0.440678] loop: module loaded
[    0.447607] virtio_blk virtio1: [vda] 262830 512-byte logical blocks (135 MB/128 MiB)
[    0.469483] libphy: Fixed MDIO Bus: probed

If you don't have something like "/chosen/stdout-path = &uart0;" in your device 
tree, then that's probably the issue.  Here's where it's set in Christoph's 
k210:

    http://git.infradead.org/users/hch/riscv.git/blob/f10e64873eafc68516b8884c06b9290b9887633b:/arch/riscv/boot/dts/kendryte/kd210.dts#l20

but we don't set it for the HiFive Unleashed.  I'd call that a bug, something 
like this

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 93d68cbd64fe..6d0ec76d93fe 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -13,6 +13,7 @@
        compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
 
        chosen {
+               stdout-path = &uart0;
        };
 
        cpus {

should fix it.  LMK if I've misunderstood something.
