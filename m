From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Fri, 12 Feb 2016 18:34:27 +0100
Message-ID: <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org> <56BC895E.2010108@sperl.org> <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de> <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


> On 12.02.2016, at 12:56, Martin Sperl <martin@sperl.org> wrote:
>=20
>=20
>> On 11.02.2016, at 18:55, Stefan Wahren <stefan.wahren@i2se.com> wrot=
e:
>> I think the reason for this behavior can be found in the uart-pl011 =
driver which
>> plays with the clocks.
>>=20
> I will look into the why and share what I find=E2=80=A6

Well - just disabling CONFIG_SERIAL_AMBA_PL011_CONSOLE
in config still results in the early-boot getting
dumped to ttyAMA0 and the same behaviour
when starting getty on that tty: crash=E2=80=A6

Similarly when compiled amba-pl011 as a module:
* strangely the boot messages still goes to ttyAMA
  - this may be something that uboot sets up?
  Maybe: earlycon-arm-semihost using SWI?
* loading the module works fine:
  [   65.458754] Serial: AMBA PL011 UART driver
  [   65.547204] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq =3D 81,=
 base_baud =3D 0) is a PL011 rev2
* using ttyAMA0 (via getty) crashes the system.
  [   73.560708] uart-pl011 20201000.uart: no DMA platform data
  [   73.667150] bcm2835-clk 20101000.cprman: plld: couldn't lock PLL
  [   73.673305] ------------[ cut here ]------------
  [   73.678039] WARNING: CPU: 0 PID: 2377 at drivers/clk/clk.c:680 clk=
_core_disable+0x34/0xf0()
  [   73.687320] ---[ end trace e38a11a59bfd67ea ]---
  [   73.692196] ------------[ cut here ]------------
  [   73.696973] WARNING: CPU: 0 PID: 2377 at drivers/clk/clk.c:575 clk=
_core_unprepare+0x34/0x110()
  [   73.706709] ---[ end trace e38a11a59bfd67eb ]---


Now having instrumented clock and amba-pl011 with debug prints I get:

Boot sequence (logged to ttyAMA0 without a driver / earlycon0):

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.5.0-rc3+ (root@raspcm.intern.sperl.org) =
(gcc version 4.7.2 (Debian 4.7.2-5+rpi1) ) #91 Fri Feb 12 13:12:31 UTC =
2016
[    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (A=
RMv7), cr=3D00c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasin=
g instruction cache
[    0.000000] Machine model: Raspberry Pi Model B+
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 113792
[    0.000000] Kernel command line: earlyprintk consoleblank=3D0 consol=
e=3DttyS0,115200n1 root=3D/dev/mmcblk0p2 rootwait
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 445500K/458752K available (5768K kernel code, 41=
8K rwdata, 1840K rodata, 420K init, 697K bss, 13252K reserved, 0K cma-r=
eserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xdc800000 - 0xff800000   ( 560 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xdc000000   ( 448 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0776394   (7609 kB)
[    0.000000]       .init : 0xc0777000 - 0xc07e0000   ( 420 kB)
[    0.000000]       .data : 0xc07e0000 - 0xc0848960   ( 419 kB)
[    0.000000]        .bss : 0xc0848960 - 0xc08f6f68   ( 698 kB)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000030] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wrap=
s every 2147483647500ns
[    0.008591] clocksource: timer: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 1911260446275 ns
[    0.018176] bcm2835: system timer (irq =3D 27)
[    0.023023] Console: colour dummy device 80x30
[    0.027636] Calibrating delay loop... 697.95 BogoMIPS (lpj=3D3489792=
)
[    0.094228] pid_max: default: 32768 minimum: 301
[    0.099359] Mount-cache hash table entries: 1024 (order: 0, 4096 byt=
es)
[    0.106197] Mountpoint-cache hash table entries: 1024 (order: 0, 409=
6 bytes)
[    0.114578] CPU: Testing write buffer coherency: ok
[    0.119730] ftrace: allocating 19776 entries in 58 pages
[    0.247172] Setting up static identity map for 0x8220 - 0x8258
[    0.257687] devtmpfs: initialized
[    0.267447] VFP support v0.3: implementor 41 architecture 1 part 20 =
variant b rev 5
[    0.275647] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfff=
fffff, max_idle_ns: 19112604462750000 ns
[    0.286277] pinctrl core: initialized pinctrl subsystem
[    0.293168] NET: Registered protocol family 16
[    0.298438] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.313885] No ATAGs?
[    0.316051] hw-breakpoint: found 6 breakpoint and 1 watchpoint regis=
ters.
[    0.323345] hw-breakpoint: maximum watchpoint size is 4 bytes.
=E2=80=A6
[    0.366218] clocksource: Switched to clocksource timer
[    0.424382] simple-framebuffer 5e887000.framebuffer: framebuffer at =
0x5e887000, 0x36c600 bytes, mapped to 0xdcc00000
[    0.435245] simple-framebuffer 5e887000.framebuffer: format=3Dr5g6b5=
, mode=3D1824x984x16, linelength=3D3648
[    0.482137] Console: switching to colour frame buffer device 228x61
[    0.524351] simple-framebuffer 5e887000.framebuffer: fb0: simplefb r=
egistered
!
=E2=80=A6
[    0.702577] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.711152] bcm2835-aux-uart 20215040.serial: could not get clk: -51=
7
=E2=80=A6
[    1.962031] usbhid: USB HID core driver
[    1.966329] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - plla
[    1.972879] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllb
[    1.979474] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllc
[    1.986019] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - plld
[    1.992608] bcm2835-clk 20101000.cprman: bcm2835_pll_get_rate - pllh
[    1.999375] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
timer
[    2.006434] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ti=
mer
[    2.013468] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
otp
[    2.020318] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ot=
p
[    2.027000] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
tsens
[    2.033959] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ts=
ens
[    2.040831] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
vpu
[    2.047679] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - vp=
u
[    2.054431] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
v3d
[    2.061271] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - v3=
d
[    2.067966] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
isp
[    2.074749] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - is=
p
[    2.081445] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
h264
[    2.088358] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - h2=
64
[    2.095120] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
sdram
[    2.102122] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - sd=
ram
[    2.109230] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
uart
[    2.116108] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ua=
rt
[    2.122907] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
vec
[    2.129734] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - ve=
c
[    2.136449] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
hsm
[    2.143234] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - hs=
m
[    2.149939] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
emmc
[    2.156853] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - em=
mc
[    2.163615] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.170448] bcm2835-clk 20101000.cprman: bcm2835_clock_get_rate - pw=
m
[    2.177114] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.184451] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.191391] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
[    2.198247] bcm2835-clk 20101000.cprman: bcm2835_clock_get_parent - =
pwm
=E2=80=A6
[    2.259033] bcm2835-clk 20101000.cprman: bcm2835_pll_on - pllc
[    2.265485] console [ttyS0] disabled
[    2.269377] 20215040.serial: ttyS0 at MMIO 0x0 (irq =3D 53, base_bau=
d =3D 3122499
9) is a 16550
[    2.277931] console [ttyS0] enabled
[    2.285083] bootconsole [earlycon0] disabled

Boot sequence after earlycon0 to ttyS0:
[    2.277931] console [ttyS0] enabled
[    2.285083] bootconsole [earlycon0] disabled
[    2.294646] bcm2835-clk 20101000.cprman: bcm2835_clock_on - emmc
[    2.306321] usb 1-1: new high-speed USB device number 2 using dwc2
[    2.346289] mmc0: SDHCI controller on 20300000.sdhci [20300000.sdhci=
] using PIO
[    2.361549] Waiting for root device /dev/mmcblk0p2...
[    2.409495] mmc0: MAN_BKOPS_EN bit is not set
[    2.415026] mmc0: new MMC card at address 0001
[    2.420585] mmcblk0: mmc0:0001 4FEACB 3.64 GiB
[    2.425646] mmcblk0boot0: mmc0:0001 4FEACB partition 1 4.00 MiB
[    2.432466] mmcblk0boot1: mmc0:0001 4FEACB partition 2 4.00 MiB
[    2.439214] mmcblk0rpmb: mmc0:0001 4FEACB partition 3 512 KiB
[    2.447959]  mmcblk0: p1 p2
[    2.477939] EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to featu=
re incompatibilities
=E2=80=A6
getty - Serial open on ttyS0, network up

Loading module:
root@raspcm:~# modprobe amba-pl011
[   59.238155] Serial: AMBA PL011 UART driver
[   59.245951] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq =3D 81, b=
ase_baud =3D2
root@raspcm:~#

And when starting getty ttyAMA0:
root@raspcm:~# /sbin/getty -a root -L ttyAMA0 115200 vt100
[   67.998916] pl011_startup - start
[   68.002326] pl011_hwinit - prepare-enable
[   68.006434] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[   68.012524] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[   68.018733] pl011_hwinit - prepare-enable - 0
[   68.024790] uart-pl011 20201000.uart: no DMA platform data
[   68.030693] pl011_startup - exit
[   68.038628] pl011_shutdown - start
[   68.042152] pl011_shutdown - disable_unprepare
[   68.046715] bcm2835-clk 20101000.cprman: bcm2835_clock_off - uart
[   68.053040] bcm2835-clk 20101000.cprman: bcm2835_clock_wait_busy - u=
art
[   68.059818] bcm2835-clk 20101000.cprman: bcm2835_pll_off - plld
[   68.065856] pl011_shutdown - exit

Note that I have now a hdmi display connected and the display
stops showing the framebuffer but the display goes off.

So it seems as if pl011_shutdown gets called for some reason,
which turns off the uart clock and as a consequence also the
plld gets shut down (probably ref-counting.

I wonder why we have the VPU as a secondary clock in the dt -=20
amba-pll11 does not reference it anywhere.

When adding a return to bcm2835_pll_off it looks like this:
root@raspcm:~# /sbin/getty -a root -L ttyAMA0 115200 vt100
[   73.862152] pl011_startup - start
[   73.865558] pl011_hwinit - prepare-enable
[   73.869886] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[   73.875854] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[   73.882044] pl011_hwinit - prepare-enable - ret =3D 0
[   73.888126] uart-pl011 20201000.uart: no DMA platform data
[   73.893757] pl011_startup - exit
[   73.901495] pl011_shutdown - start
[   73.905034] pl011_shutdown - disable_unprepare
[   73.909742] bcm2835-clk 20101000.cprman: bcm2835_clock_off - uart
[   73.915967] bcm2835-clk 20101000.cprman: bcm2835_clock_wait_busy - u=
art
[   73.922775] bcm2835-clk 20101000.cprman: bcm2835_pll_off - plld
[   73.928844] pl011_shutdown - exit
[   73.934152] pl011_startup - start
[   73.937617] pl011_hwinit - prepare-enable
[   73.941726] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
[   73.947738] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[   73.953865] pl011_hwinit - prepare-enable - ret =3D 0
[   73.959776] pl011_startup - exit

The ttyAMA0 console does not work, hdmi display blinks,
but the network works...

When removing the pll_on/off from the pll_ops I have a similar effect
but in this case PLL is not touched at all:
root@raspcm:~# /sbin/getty -a root -L ttyAMA0 115200 vt100
[   83.345055] pl011_startup - start
[   83.348580] pl011_hwinit - prepare-enable
[   83.352725] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[   83.358910] pl011_hwinit - prepare-enable - 0
[   83.365083] uart-pl011 20201000.uart: no DMA platform data
[   83.370790] pl011_startup - exit
[   83.378653] pl011_shutdown - start
[   83.382176] pl011_shutdown - disable_unprepare
[   83.386873] bcm2835-clk 20101000.cprman: bcm2835_clock_off - uart
[   83.393097] bcm2835-clk 20101000.cprman: bcm2835_clock_wait_busy - u=
art
[   83.399888] pl011_shutdown - exit
[   83.405164] pl011_startup - start
[   83.408652] pl011_hwinit - prepare-enable
[   83.412771] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
[   83.418952] pl011_hwinit - prepare-enable - 0
[   83.423665] pl011_startup - exit

The system continues, but the UART still is not working and the
HDMI-Display is flashing only (but with a certain pattern on the
display: totally blue, then some wait, then a black horizontal bar
finally a full dark screen flash - that happens in a 3-4 second
cycle.

As if there is something else that requires the UART clock running
- maybe in the firmware?

Even making the uart clock a VPU clock does not help:
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm283=
5.c
index 015e687..4856657 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -758,6 +761,7 @@ static const struct bcm2835_clock_data bcm2835_cloc=
k_uart_da
        .div_reg =3D CM_UARTDIV,
        .int_bits =3D 10,
        .frac_bits =3D 12,
+       .is_vpu_clock =3D true,
 };

 /* HDMI state machine */

This produces the following debug messages:
[   56.409818] pl011_startup - start
[   56.413225] pl011_hwinit - prepare-enable
[   56.417443] pl011_hwinit - prepare-enable - ret =3D 0
[   56.423297] uart-pl011 20201000.uart: no DMA platform data
[   56.428989] pl011_startup - exit
[   56.435485] pl011_shutdown - start
[   56.440337] pl011_shutdown - disable_unprepare
[   56.444913] pl011_shutdown - exit
[   56.449762] pl011_startup - start
[   56.453165] pl011_hwinit - prepare-enable
[   56.457371] pl011_hwinit - prepare-enable - ret =3D 0
[   56.462175] pl011_startup - exit

The screen is still blinking and UART does not work.
Maybe the driver is not able to handle the =E2=80=9Cremapping=E2=80=9D
of registers to a different range and is touching ram
used by the FW?

The only solution that I found is using fixed clocks
in the device-tree (which is not what we intended:
/ {
                clk_uart0: clock@3 {
                        compatible =3D "fixed-clock";
                        reg =3D <3>;
                        #clock-cells =3D <0>;
                        clock-output-names =3D "uart0_pclk";
                        clock-frequency =3D <3000000>;
                };

                clk_apb_p: clock@4 {
                        compatible =3D "fixed-clock";
                        reg =3D <4>;
                        #clock-cells =3D <0>;
                        clock-output-names =3D "apb_pclk";
                        clock-frequency =3D <126000000>;
                };
};
&uart0 {
        clocks =3D <&clk_uart0 &clk_apb_p>;
};

(so I have ruled out that the amba-pl011 writes to
the wrong addresses).

So as far as I can tell it is only clock related
and when the new clock-framework is used it fails...

Martin

