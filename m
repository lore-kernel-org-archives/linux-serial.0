From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: No output on console despite ignore_loglevel earlyprintk
Date: Fri, 3 Mar 2017 16:55:48 +0000
Message-ID: <20170303165548.GO21222@n2100.armlinux.org.uk>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 03, 2017 at 05:42:02PM +0100, Marc Gonzalez wrote:
> Hello,
> 
> I'm confused about early consoles and earlyprintk, and all that good stuff.
> When my kernel panics, I don't get the expected output.
> 
> Using "mem=256M ignore_loglevel earlyprintk"
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.9.7-1-rc2 (gcc version 5.3.1 20160113 (Linaro GCC 5.3-2016.02) ) #153 SMP PREEMPT Fri Mar 3 17:31:37 CET 2017
> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt:Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] On node 0 totalpages: 65536
> [    0.000000] free_area_init_node: node 0, pgdat c10234c0, node_mem_map cfdf9000
> [    0.000000]   Normal zone: 512 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 65536 pages, LIFO batch:15
> [    0.000000] percpu: Embedded 14 pages/cpu @cfdd7000 s24960 r8192 d24192 u57344
> [    0.000000] pcpu-alloc: s24960 r8192 d24192 u57344 alloc=14*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> [    0.000000] Kernel command line: mem=256M ignore_loglevel earlyprintk
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Memory: 243980K/262144K available (4096K kernel code, 146K rwdata, 876K rodata, 10240K init, 233K bss, 18164K reserved, 0K cma-reserved, 0K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
> [    0.000000]       .init : 0xc0600000 - 0xc1000000   (10240 kB)
> [    0.000000]       .data : 0xc1000000 - 0xc1024860   ( 147 kB)
> [    0.000000]        .bss : 0xc1024860 - 0xc105ed40   ( 234 kB)
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000]  Build-time adjustment of leaf fanout to 32.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 ID prefetch enabled, offset 4 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x72860401
> [    0.000000] clocksource: tango-xtal: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 70787423951 ns
> [    0.000004] sched_clock: 32 bits at 27MHz, resolution 37ns, wraps every 79536431085ns
> [    0.007960] Switching to timer-based delay loop, resolution 37ns
> [    0.014325] Console: colour dummy device 80x30
> [    0.018885] console [tty0] enabled
> [    0.022396] bootconsole [earlycon0] disabled
> 
> And it hangs there.

tty0 is the kernel virtual terminal console, which is what appears on
VGA or framebuffers.  This is the default console if nothing else is
specified.

What happened here is that the virtual terminal console registered, was
detected to be the system console, so early console was shut down, and
the boot messages logged to the virtual terminal console instead.

> If I use an explicit console= configuration, I do see the panic.
> Using "mem=256M ignore_loglevel console=ttyS0,115200 earlyprintk"

The extra console= tells the kernel to use the serial port as the system
console, rather than the virtual terminal console.  The serial port
driver was not registered by the time your panic happened, so the
system console was never installed, and so the early console remained
in place.

Early console outputs the console messages until the system console has
been registered.

Note: "registered" does not necessarily mean "capable of producing
visible output".  Framebuffer initialisation happens after the VT
console has been registered.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
