From: Huang Shijie <shijie.huang@arm.com>
Subject: Re: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size
 in pl011_fifo_to_tty()"
Date: Mon, 26 Oct 2015 09:58:04 +0800
Message-ID: <20151026015802.GA7305@arm.com>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
 <562A297A.9030204@codeaurora.org>
 <20151023133403.GI4796@e103592.cambridge.arm.com>
 <562A544D.7080506@tabi.org>
 <20151023160246.GM4796@e103592.cambridge.arm.com>
 <562A6296.3070600@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <562A6296.3070600@codeaurora.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Timur Tabi <timur@codeaurora.org>
Cc: gregkh@linuxfoundation.org, Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The 10/23/2015 11:38, Timur Tabi wrote:
> On 10/23/2015 11:02 AM, Dave P Martin wrote:
> >I'm pretty sure CREAD should default to enabled[1], and that usually
> >software won't modify it.
> >
> >Assuming that this is indeed the problem, it's possible that another bug
> >in the pl011 driver is wrongly clearing this flag.  Sadly I don't have
> >time to look at the code again just now ...:(
>
> Perhaps, but !CREAD is definitely broken without this patch.  So if the
> driver really is clearing CREAD somewhere else, then that's where the real
> bug is.
>
> >
> >Could be interesting to stick some BUG_ON(!CREAD) in the driver to
> >try and track down where that's coming from.
>
> CREAD is disabled by default when opening the console.  You need to
> explicitly set it in the termios structure.  I can easily believe that
> Huang's rootfs is just forgetting to set that bit because for the last five
> years, it didn't matter.
>
> Huang,
>
> In the beginning of pl011_set_termios() and sbsa_uart_set_termios(), please
> add this code:
>
>       BUG_ON(!(termios->c_cflag & CREAD));
>
I added this code to pl011_set_termios() and sbsa_uart_set_termios().
But My console still hang at the login step.

I login in the board with ssh (the network is okay), the following is the kernel log:

 ======================================================================================
Booting Linux on physical CPU 0x0
Initializing cgroup subsys cpu
Linux version 4.3.0-rc6-next-20151022-00001-gc3cd913 (root@Huang.Shijie) (gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11) ) #48 SMP PREEMPT Mon Oct 26 09:41:33 CST 2015
Boot CPU: AArch64 Processor [411fd071]
earlycon: Early serial console at MMIO 0x7ff80000 (options '')
bootconsole [uart0] enabled
efi: Getting EFI parameters from FDT:
EFI v2.40 by ARM Juno EFI Mar 17 2015 15:42:19
efi:  ACPI=0xfebae000  ACPI 2.0=0xfebae014
cma: Reserved 16 MiB at 0x00000000fd800000
On node 0 totalpages: 2092816
  DMA zone: 8192 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 519952 pages, LIFO batch:31
  Normal zone: 24576 pages used for memmap
  Normal zone: 1572864 pages, LIFO batch:31
psci: probing for conduit method from DT.
psci: PSCIv1.0 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: Trusted OS migration not required
PERCPU: Embedded 15 pages/cpu @ffffffc97fedb000 s24000 r8192 d29248 u61440
pcpu-alloc: s24000 r8192 d29248 u61440 alloc=15*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
Detected PIPT I-cache on CPU0
CPU features: enabling workaround for ARM erratum 832075
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2060048
Kernel command line: console=ttyAMA0,115200 earlycon=pl011,0x7ff80000 root=/dev/sda1 rootwait verbose debug sky2.mac_address=0x00,0x02,0xF7,0x00,0x63,0x3C  debug_pagealloc=on
log_buf_len individual max cpu contribution: 4096 bytes
log_buf_len total cpu_extra contributions: 20480 bytes
log_buf_len min size: 16384 bytes
log_buf_len: 65536 bytes
early log buf free: 14288(87%)
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
software IO TLB [mem 0xf9800000-0xfd800000] (64MB) mapped at [ffffffc079800000-ffffffc07d7fffff]
Memory: 8134528K/8371264K available (5638K kernel code, 537K rwdata, 2440K rodata, 544K init, 213K bss, 220352K reserved, 16384K cma-reserved)
Virtual kernel memory layout:
    vmalloc : 0xffffff8000000000 - 0xffffffbdbfff0000   (   246 GB)
    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
              0xffffffbdc2000000 - 0xffffffbde8000000   (   608 MB actual)
    fixed   : 0xffffffbffa7fd000 - 0xffffffbffac00000   (  4108 KB)
    PCI I/O : 0xffffffbffae00000 - 0xffffffbffbe00000   (    16 MB)
    modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
    memory  : 0xffffffc000000000 - 0xffffffc980000000   ( 38912 MB)
      .init : 0xffffffc000866000 - 0xffffffc0008ee000   (   544 KB)
      .text : 0xffffffc000080000 - 0xffffffc0008659e4   (  8087 KB)
      .data : 0xffffffc0008ff000 - 0xffffffc000985600   (   538 KB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
Preemptible hierarchical RCU implementation.
        Build-time adjustment of leaf fanout to 64.
        RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=6.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=6
NR_IRQS:64 nr_irqs:64 0
GIC: Using split EOI/Deactivate mode
GICv2m: Node v2m: range[0x2c1c0000:0x2c1c0fff], SPI[224:256]
Architected cp15 and mmio timer(s) running at 50.00MHz (phys/phys).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
Console: colour dummy device 80x25
allocated 16777216 bytes of page_ext
Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=500000)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
Initializing cgroup subsys memory
Initializing cgroup subsys hugetlb
Remapping and enabling EFI services.
  EFI remap 0x0000000008000000 => 0000000040000000
  EFI remap 0x000000001c170000 => 0000000044000000
  EFI remap 0x00000009faf6f000 => 000000004401f000
  EFI remap 0x00000009fff6e000 => 000000004406e000
  EFI remap 0x00000009fffaf000 => 00000000440af000
ASID allocator initialised with 65536 entries
Detected PIPT I-cache on CPU1
CPU1: Booted secondary processor [411fd071]
Detected VIPT I-cache on CPU2
CPU features: enabling workaround for ARM erratum 845719
CPU2: Booted secondary processor [410fd033]
Detected VIPT I-cache on CPU3
CPU3: Booted secondary processor [410fd033]
Detected VIPT I-cache on CPU4
CPU4: Booted secondary processor [410fd033]
Detected VIPT I-cache on CPU5
CPU5: Booted secondary processor [410fd033]
Brought up 6 CPUs
SMP: Total of 6 processors activated.
CPU: All CPU(s) started at EL2
alternatives: patching kernel code
devtmpfs: initialized
DMI not present or invalid.
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
cpuidle: using governor ladder
cpuidle: using governor menu
vdso: 2 pages (1 code @ ffffffc000905000, 1 data @ ffffffc000904000)
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
DMA: preallocated 256 KiB pool for atomic allocations
Serial: AMBA PL011 UART driver
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
dmi: Firmware registration failed.
clocksource: Switched to clocksource arch_sys_counter
NET: Registered protocol family 2
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
UDP hash table entries: 4096 (order: 5, 131072 bytes)
UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
PCI: CLS 0 bytes, default 64
kvm [1]: interrupt-controller@2c04f000 IRQ14
kvm [1]: timer IRQ4
kvm [1]: Hyp mode initialized successfully
futex hash table entries: 2048 (order: 5, 131072 bytes)
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(0.570:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
fuse init (API version 7.23)
9p: Installing v9fs 9p2000 file system support
io scheduler noop registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
msm_serial: driver initialized
loop: module loaded
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
sky2: driver version 1.30
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-platform: EHCI generic platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-platform: OHCI generic platform driver
usbcore: registered new interface driver usb-storage
mousedev: PS/2 mouse device common for all mice
rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
Synopsys Designware Multimedia Card Interface Driver
sdhci-pltfm: SDHCI platform and OF driver helper
ledtrig-cpu: registered to indicate activity on CPUs
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
NET: Registered protocol family 17
9pnet: Installing 9P2000 support
Key type dns_resolver registered
bootconsole [uart0] disabled
registered taskstats version 1
7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 23, base_baud = 0) is a PL011 rev3
console [ttyAMA0] enabled
hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7 counters available
hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
pl061_gpio 1c1d0000.gpio: PL061 GPIO chip @0x000000001c1d0000 registered
libphy: smsc911x-mdio: probed
smsc911x 18000000.ethernet eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=18000000.etherne:01, irq=-1)
smsc911x 18000000.ethernet eth0: MAC Address: 00:02:f7:00:63:3b
ehci-platform 7ffc0000.ehci: EHCI Host Controller
ehci-platform 7ffc0000.ehci: new USB bus registered, assigned bus number 1
ehci-platform 7ffc0000.ehci: irq 26, io mem 0x7ffc0000
ehci-platform 7ffc0000.ehci: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ohci-platform 7ffb0000.ohci: Generic Platform OHCI controller
ohci-platform 7ffb0000.ohci: new USB bus registered, assigned bus number 2
ohci-platform 7ffb0000.ohci: irq 25, io mem 0x7ffb0000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
mmci-pl18x 1c050000.mmci: No vqmmc regulator found
mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 31,0 (pio)
mmci-pl18x 1c050000.mmci: DMA channels RX none, TX none
leds-syscon 1c010000.apbregs:led@08.0: registered LED vexpress:0
leds-syscon 1c010000.apbregs:led@08.1: registered LED vexpress:1
leds-syscon 1c010000.apbregs:led@08.2: registered LED vexpress:2
leds-syscon 1c010000.apbregs:led@08.3: registered LED vexpress:3
leds-syscon 1c010000.apbregs:led@08.4: registered LED vexpress:4
leds-syscon 1c010000.apbregs:led@08.5: registered LED vexpress:5
leds-syscon 1c010000.apbregs:led@08.6: registered LED vexpress:6
leds-syscon 1c010000.apbregs:led@08.7: registered LED vexpress:7
input: smb:motherboard:gpio_keys as /devices/platform/smb/smb:motherboard/smb:motherboard:gpio_keys/input/input1
rtc-efi rtc-efi: setting system clock to 2015-07-06 05:13:05 UTC (1436159585)
uart-pl011 7ff80000.uart: no DMA platform data
usb 1-1: new high-speed USB device number 2 using ehci-platform
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
atkbd serio0: keyboard reset failed on 1c060000.kmi
Waiting for root device /dev/sda1...
usb 1-1.1: new high-speed USB device number 3 using ehci-platform
usb-storage 1-1.1:1.0: USB Mass Storage device detected
scsi host0: usb-storage 1-1.1:1.0
atkbd serio1: keyboard reset failed on 1c070000.kmi
scsi 0:0:0:0: Direct-Access     SanDisk  Ultra            1.00 PQ: 0 ANSI: 6
sd 0:0:0:0: [sda] 242614272 512-byte logical blocks: (124 GB/115 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 43 00 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk
EXT2-fs (sda1): error: couldn't mount because of unsupported optional features (244)
EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities
EXT4-fs (sda1): INFO: recovery required on readonly filesystem
EXT4-fs (sda1): write access will be enabled during recovery
EXT4-fs (sda1): recovery complete
EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
devtmpfs: mounted
Freeing unused kernel memory: 544K (ffffffc000866000 - ffffffc0008ee000)
Freeing alternatives memory: 48K (ffffffc0008ee000 - ffffffc0008fa000)
udevd[839]: starting version 182
EXT4-fs (sda1): re-mounted. Opts: data=ordered
random: dd urandom read with 46 bits of entropy available
smsc911x 18000000.ethernet eth0: SMSC911x/921x identified at 0xffffff8000120000, IRQ: 29
random: nonblocking pool is initialized

 ======================================================================================

 thanks
 Huang Shijie


________________________________

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
