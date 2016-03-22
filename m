From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Mon, 21 Mar 2016 19:44:25 -0700
Message-ID: <56F0B189.2080206@hurleysoftware.com>
References: <56F07DA1.8080404@universe-factory.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <56F07DA1.8080404@universe-factory.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Matthias Schiffer <mschiffer@universe-factory.net>, Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Matthias,

On 03/21/2016 04:02 PM, Matthias Schiffer wrote:
> Hi,
> we're experiencing weird nondeterministic hangs during bootconsole/console
> handover on some ath79 systems on OpenWrt. I've seen this issue myself on
> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to other
> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs like
> QCA953x likewise.
> 
> See the log below for the exact place it hangs; the log was taken in during
> a good boot; a bad boot will just hang forever at the marked location. The
> issue is extremely hard to debug, as changing the timing in any way (like
> adding additional printk) will usually make it work without problems. (Even
> recompiling the kernel with the same config, but different uname timestamp
> will make the occurence more or less likely)
> 
> My theory is the following:
> 
> As soon as ttyS0 is detected and installed as the console, there are two
> console drivers active on the serial port at the same time: early0 and
> ttyS0. I suspect that the hang occurs when the primitive early0
> implementation prom_putchar_ar71xx waits indefinitely on THRE, but the real
> driver has just reset the serial controller in a way that makes THRE never
> come.

Doubtful.

console writes are performed with ints disabled, as is the 8250 driver's
autoconfig probing. Since this is a UP platform, as long as you're not
using the DEBUG_AUTOCONF switch in the 8250 driver, I don't think there's
a way for the boot console to be outputting while the 8250 driver is
configuring.

> When the boot is successful, I also sometimes see just garbage
> instead of the message "serial8250.0: ttyS0 at MMIO 0x18020000...", which
> supports my idea that the kernel is trying to use the serial console while
> it is not correctly setup.
> 
> Is is possible that the first "console [ttyS0] disabled" message caused by
> the call chain
> 
>   serial8250_register_8250_port
>   uart_remove_one_port
>   unregister_console
> 
> should rather unregister early0 (as ttyS0 is not even registered at this
> point), so having both drivers active at the same time is avoided?

No.

Having both consoles active briefly at the handover is not really a problem;
all consoles are serialized with each other. Only one console can be outputting
at any one time.

The unregister_console() producing the bogus "ttyS0 disabled" message
is wrong but harmless.

That part happens because the 8250 driver creates phantom ports which are
unregistered as new ports are probed, but the ttyS0 console hadn't actually
been registered yet.


> Does this make any sense? Or do you have any other idea what might cause this?

I wonder if autoconfig probing (that's what discovers the uart port type)
is broken.

You could test this hypothesis by setting the port type directly and
set UPF_FIXED_TYPE; ie., in arch/mips/ath79/dev-common.c

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 516225d..3814a42 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -36,7 +36,8 @@ static struct plat_serial8250_port ath79_uart_data[] = {
 	{
 		.mapbase	= AR71XX_UART_BASE,
 		.irq		= ATH79_MISC_IRQ(3),
-		.flags		= AR71XX_UART_FLAGS,
+		.flags		= AR71XX_UART_FLAGS | UPF_FIXED_TYPE,
+		.type		= PORT_16550A,
 		.iotype		= UPIO_MEM32,
 		.regshift	= 2,
 	}, {


Regards,
Peter Hurley

> Thanks in advance,
> Matthias
> 
> 
> [1] https://dev.openwrt.org/ticket/21773
> [2] https://dev.openwrt.org/ticket/21857
> 
> 
>> [    0.000000] Linux version 3.18.27 (neoraider@avalon) (gcc version 4.8.3 (OpenWrt/Linaro GCC 4.8-2014.04 r47335) ) #6 Sun Mar 20 22:40:15 CET 2016
>> [    0.000000] bootconsole [early0] enabled
>> [    0.000000] CPU0 revision is: 00019374 (MIPS 24Kc)
>> [    0.000000] SoC: Atheros AR7241 rev 1
>> [    0.000000] Determined physical RAM map:
>> [    0.000000]  memory: 02000000 @ 00000000 (usable)
>> [    0.000000] Initrd not found or empty - disabling initrd
>> [    0.000000] Zone ranges:
>> [    0.000000]   Normal   [mem 0x00000000-0x01ffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x00000000-0x01ffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x01ffffff]
>> [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
>> [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
>> [    0.000000] Kernel command line:  board=TL-WR841N-v7 console=ttyS0,115200 rootfstype=squashfs,jffs2 noinitrd
>> [    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
>> [    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
>> [    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> [    0.000000] Writing ErrCtl register=00000000
>> [    0.000000] Readback ErrCtl register=00000000
>> [    0.000000] Memory: 28324K/32768K available (2573K kernel code, 133K rwdata, 540K rodata, 264K init, 193K bss, 4444K reserved)
>> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> [    0.000000] NR_IRQS:51
>> [    0.000000] Clocks: CPU:400.000MHz, DDR:400.000MHz, AHB:200.000MHz, Ref:5.000MHz
>> [    0.000000] Calibrating delay loop... 265.42 BogoMIPS (lpj=1327104)
>> [    0.080000] pid_max: default: 32768 minimum: 301
>> [    0.080000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.090000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.100000] NET: Registered protocol family 16
>> [    0.100000] MIPS: machine is TP-LINK TL-WR841N/ND v7
>> [    0.550000] registering PCI controller with io_map_base unset
>> [    0.560000] PCI host bridge to bus 0000:00
>> [    0.570000] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13ffffff]
>> [    0.570000] pci_bus 0000:00: root bus resource [io  0x0000]
>> [    0.580000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>> [    0.580000] pci 0000:00:00.0: fixup device configuration
>> [    0.590000] pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1000ffff 64bit]
>> [    0.590000] pci 0000:00:00.0: using irq 40 for pin 1
>> [    0.600000] Switched to clocksource MIPS
>> [    0.600000] NET: Registered protocol family 2
>> [    0.610000] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.610000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>> [    0.620000] TCP: Hash tables configured (established 1024 bind 1024)
>> [    0.630000] TCP: reno registered
>> [    0.630000] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.640000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> [    0.640000] NET: Registered protocol family 1
>> [    0.650000] futex hash table entries: 256 (order: -1, 3072 bytes)
>> [    0.660000] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>> [    0.670000] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
>> [    0.680000] msgmni has been set to 55
>> [    0.680000] io scheduler noop registered
>> [    0.690000] io scheduler deadline registered (default)
>> [    0.690000] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
>> [    0.700000] console [ttyS0] disabled
>>>> Boot will hang here <<<
>> [    0.730000] serial8250.0: ttyS0 at MMIO 0x18020000 (irq = 11, base_baud = 12500000) is a 16550A
>> [    0.740000] console [ttyS0] enabled
>> [    0.740000] console [ttyS0] enabled
>> [    0.740000] bootconsole [early0] disabled
>> [    0.740000] bootconsole [early0] disabled
> 
