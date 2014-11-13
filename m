From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2 00/10] UART driver support for BMIPS multiplatform kernels
Date: Thu, 13 Nov 2014 08:39:27 -0800
Message-ID: <CAJiQ=7CJzN=HD9_frDS1VxX8sByKsD_6Jo+C-ECgK7wbMj_M2A@mail.gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com> <87oasbtuum.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:64708 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932955AbaKMQjs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Nov 2014 11:39:48 -0500
In-Reply-To: <87oasbtuum.fsf@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Nov 12, 2014 at 11:36 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Kevin Cernekee <cernekee@gmail.com> writes:
>
>> V1->V2:
>>
>> Add a new UPIO_MEM32BE iotype instead of a separate big_endian flag.
>>
>> Change some of the of_*_is_* APIs to return bool, where appropriate.
>>
>> Fix a few minor comment issues.
>
> Hi Kevin,
>
> I'll review the pxa part tonight or tomorrow, just a simple preliminary question
> : did you test this serie with the triple activation of DEBUG_UART, early
> console, and kernel console, all of them on the same tty ?

I originally tested with MIPS EARLY_PRINTK + earlycon +
console=ttyS0,115200.  arch/arm/kernel/early_printk.c and
arch/mips/kernel/early_printk.c look very similar.  Using EARLY_PRINTK
+ earlycon at the same time produces duplicate messages until the
console switch occurs, so you'll probably want to disable ARM's
DEBUG_UART if you add "earlycon" to the pxa boot command line.

Once earlycon was stable, I started running with EARLY_PRINTK disabled
(and in fact, completely yanked the patch that was hardcoding the UART
base address into the kernel).

FWIW here is a log showing EARLY_PRINTK + earlycon + console=ttyS0,115200:

Linux version 3.18.0-rc4+ (cernekee@vm9) (gcc version 4.8.4 20140811
(prerelease) (Broadcom stbgcc-4.8-1.0) ) #428 SMP Thu Nov 13 08:25:53
PST 2014
bootconsole [early0] enabled
CPU0 revision is: 00025a11 (Broadcom BMIPS5000)
FPU revision is: 00130001
MIPS: machine is Broadcom BCM97346DBSMB
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
 memory: 30000000 @ 20000000 (usable)
Linux version 3.18.0-rc4+ (cernekee@vm9) (gcc version 4.8.4 20140811
(prerelease) (Broadcom stbgcc-4.8-1.0) ) #428 SMP Thu Nov 13 08:25:53
PST 2014
bootconsole [early0] enabled
CPU0 revision is: 00025a11 (Broadcom BMIPS5000)
FPU revision is: 00130001
MIPS: machine is Broadcom BCM97346DBSMB
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
 memory: 30000000 @ 20000000 (usable)
bootconsole [uart0] enabled
bootconsole [uart0] enabled
Initrd not found or emptyInitrd not found or empty - disabling initrd
 - disabling initrd
Zone ranges:
Zone ranges:
  Normal     Normal   [mem 0x00000000-0x1fffffff]
[mem 0x00000000-0x1fffffff]
  HighMem    HighMem  [mem 0x20000000-0x4fffffff]
[mem 0x20000000-0x4fffffff]
Movable zone start for each node
Movable zone start for each node
Early memory node ranges
Early memory node ranges
  node   0: [mem 0x00000000-0x0fffffff]
  node   0: [mem 0x00000000-0x0fffffff]
  node   0: [mem 0x20000000-0x4fffffff]
  node   0: [mem 0x20000000-0x4fffffff]
Initmem setup node 0 [mem 0x00000000-0x4fffffff]
Initmem setup node 0 [mem 0x00000000-0x4fffffff]
Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
MIPS secondary cache 256kB, 8-way, linesize 128 bytes.
MIPS secondary cache 256kB, 8-way, linesize 128 bytes.
PERCPU: Embedded 7 pages/cpu @81a0d000 s6912 r0 d21760 u32768
PERCPU: Embedded 7 pages/cpu @81a0d000 s6912 r0 d21760 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 261120
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 261120
Kernel command line: console=ttyS0,115200 earlycon
Kernel command line: console=ttyS0,115200 earlycon
PID hash table entries: 1024 (order: 0, 4096 bytes)
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 1027712K/1048576K available (5010K kernel code, 183K rwdata,
684K rodata, 4096K init, 256K bss, 20864K reserved, 786432K highmem)
Memory: 1027712K/1048576K available (5010K kernel code, 183K rwdata,
684K rodata, 4096K init, 256K bss, 20864K reserved, 786432K highmem)
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
Hierarchical RCU implementation.
    RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
    RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:128
NR_IRQS:128
irq_bcm7038_l1: registered BCM7038 L1 intc (mem: 0xb0411400, parent IRQ: 2)
irq_bcm7038_l1: registered BCM7038 L1 intc (mem: 0xb0411400, parent IRQ: 2)
irq_bcm7120_l2: registered BCM7120 L2 intc (mem: 0xb0406780, parent IRQ(s): 1)
irq_bcm7120_l2: registered BCM7120 L2 intc (mem: 0xb0406780, parent IRQ(s): 1)
Calibrating delay loop... Calibrating delay loop... 866.30 BogoMIPS
(lpj=1732608)
866.30 BogoMIPS (lpj=1732608)
pid_max: default: 32768 minimum: 301
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
SMP: Booting CPU1...
SMP: Booting CPU1...
CPU1 revision is: 00025a11 (Broadcom BMIPS5000)
CPU1 revision is: 00025a11 (Broadcom BMIPS5000)
FPU revision is: 00130001
FPU revision is: 00130001
Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
MIPS secondary cache 256kB, 8-way, linesize 128 bytes.
MIPS secondary cache 256kB, 8-way, linesize 128 bytes.
Synchronize counters for CPU 1: done.
Synchronize counters for CPU 1: done.
SMP: CPU1 is running
SMP: CPU1 is running
Brought up 2 CPUs
Brought up 2 CPUs
devtmpfs: initialized
devtmpfs: initialized
NET: Registered protocol family 16
NET: Registered protocol family 16
SCSI subsystem initialized
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
usbcore: registered new device driver usb
Switched to clocksource MIPS
Switched to clocksource MIPS
cfg80211: Calling CRDA to update world regulatory domain
cfg80211: Calling CRDA to update world regulatory domain
NET: Registered protocol family 2
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 512 (order: 4, 65536 bytes)
futex hash table entries: 512 (order: 4, 65536 bytes)
fuse init (API version 7.23)
fuse init (API version 7.23)
bounce: pool size: 64 pages
bounce: pool size: 64 pages
io scheduler noop registered (default)
io scheduler noop registered (default)
pxa2xx-uart 10406900.serial: ttyS0 at MMIO 0x10406900 (irq = 64,
base_baud = 5062500) is a UART1
pxa2xx-uart 10406900.serial: ttyS0 at MMIO 0x10406900 (irq = 64,
base_baud = 5062500) is a UART1
console [ttyS0] enabled
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [early0] disabled
bootconsole [early0] disabled
bootconsole [early0] disabled
bootconsole [uart0] disabled
bootconsole [uart0] disabled
Default device node (4:64) for ttyS is busy, using dynamic major number
libphy: Fixed MDIO Bus: probed
bcmgenet 10430000.ethernet: failed to get enet clock
bcmgenet 10430000.ethernet: GENET 2.9 EPHY: 0x00b0
bcmgenet 10430000.ethernet: failed to get enet-wol clock
libphy: bcmgenet MII bus: probed
bcmgenet 10430000.ethernet: configuring instance for internal PHY
attached PHY at address 1 [Broadcom BCM7XXX 40nm]
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver cdc_ncm
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ehci-platform 10480300.usb: EHCI Host Controller
ehci-platform 10480300.usb: new USB bus registered, assigned bus number 1
ehci-platform 10480300.usb: irq 68, io mem 0x10480300
ehci-platform 10480300.usb: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-platform 10480500.usb: EHCI Host Controller
ehci-platform 10480500.usb: new USB bus registered, assigned bus number 2
ehci-platform 10480500.usb: irq 69, io mem 0x10480500
ehci-platform 10480500.usb: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ehci-platform 10490300.usb: EHCI Host Controller
ehci-platform 10490300.usb: new USB bus registered, assigned bus number 3
ehci-platform 10490300.usb: irq 73, io mem 0x10490300
ehci-platform 10490300.usb: USB 2.0 started, EHCI 1.00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
ehci-platform 10490500.usb: EHCI Host Controller
ehci-platform 10490500.usb: new USB bus registered, assigned bus number 4
ehci-platform 10490500.usb: irq 74, io mem 0x10490500
ehci-platform 10490500.usb: USB 2.0 started, EHCI 1.00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-platform: OHCI generic platform driver
ohci-platform 10480400.usb: Generic Platform OHCI controller
ohci-platform 10480400.usb: new USB bus registered, assigned bus number 5
ohci-platform 10480400.usb: irq 70, io mem 0x10480400
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
ohci-platform 10480600.usb: Generic Platform OHCI controller
ohci-platform 10480600.usb: new USB bus registered, assigned bus number 6
ohci-platform 10480600.usb: irq 71, io mem 0x10480600
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 1 port detected
ohci-platform 10490400.usb: Generic Platform OHCI controller
ohci-platform 10490400.usb: new USB bus registered, assigned bus number 7
ohci-platform 10490400.usb: irq 75, io mem 0x10490400
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 1 port detected
ohci-platform 10490600.usb: Generic Platform OHCI controller
ohci-platform 10490600.usb: new USB bus registered, assigned bus number 8
ohci-platform 10490600.usb: irq 76, io mem 0x10490600
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Freeing unused kernel memory: 4096K (805d0000 - 809d0000)
starting pid 830, tty '': '/etc/init.d/rcS'
Mounting virtual filesystems
Starting mdev
Configuring eth0 interface
bcmgenet 10430000.ethernet eth0: Link is Down
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Configuring lo interface
Configuring sit0 interface
Starting network services
starting pid 864, tty '': '/bin/cttyhack /bin/sh -l'
root@bmips#


And here's a log with "earlycon console=ttyS0,115200" and EARLY_PRINTK disabled:

Linux version 3.18.0-rc4+ (cernekee@vm9) (gcc version 4.8.4 20140811
(prerelease) (Broadcom stbgcc-4.8-1.0) ) #429 SMP Thu Nov 13 08:33:30
PST 2014
CPU0 revision is: 00025a11 (Broadcom BMIPS5000)
FPU revision is: 00130001
MIPS: machine is Broadcom BCM97346DBSMB
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
 memory: 30000000 @ 20000000 (usable)
bootconsole [uart0] enabled
Initrd not found or empty - disabling initrd
Zone ranges:
  Normal   [mem 0x00000000-0x1fffffff]
  HighMem  [mem 0x20000000-0x4fffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x0fffffff]
  node   0: [mem 0x20000000-0x4fffffff]
Initmem setup node 0 [mem 0x00000000-0x4fffffff]
Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
MIPS secondary cache 256kB, 8-way, linesize 128 bytes.
PERCPU: Embedded 7 pages/cpu @81a0d000 s6912 r0 d21760 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 261120
Kernel command line: console=ttyS0,115200 earlycon
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 1027712K/1048576K available (5010K kernel code, 183K rwdata,
684K rodata, 4096K init, 256K bss, 20864K reserved, 786432K highmem)
SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Hierarchical RCU implementation.
    RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS:128
irq_bcm7038_l1: registered BCM7038 L1 intc (mem: 0xb0411400, parent IRQ: 2)
irq_bcm7120_l2: registered BCM7120 L2 intc (mem: 0xb0406780, parent IRQ(s): 1)
Calibrating delay loop... 866.30 BogoMIPS (lpj=1732608)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
SMP: Booting CPU1...
CPU1 revision is: 00025a11 (Broadcom BMIPS5000)
FPU revision is: 00130001
Primary instruction cache 32kB, VIPT, 4-way, linesize 64 bytes.
Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
MIPS secondary cache 256kB, 8-way, linesize 128 bytes.
Synchronize counters for CPU 1: done.
SMP: CPU1 is running
Brought up 2 CPUs
devtmpfs: initialized
NET: Registered protocol family 16
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
cfg80211: Calling CRDA to update world regulatory domain
Switched to clocksource MIPS
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 1, 8192 bytes)
TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
futex hash table entries: 512 (order: 4, 65536 bytes)
fuse init (API version 7.23)
bounce: pool size: 64 pages
io scheduler noop registered (default)
pxa2xx-uart 10406900.serial: ttyS0 at MMIO 0x10406900 (irq = 64,
base_baud = 5062500) is a UART1
console [ttyS0] enabled
console [ttyS0] enabled
bootconsole [uart0] disabled
bootconsole [uart0] disabled
Default device node (4:64) for ttyS is busy, using dynamic major number
libphy: Fixed MDIO Bus: probed
bcmgenet 10430000.ethernet: failed to get enet clock
bcmgenet 10430000.ethernet: GENET 2.9 EPHY: 0x00b0
bcmgenet 10430000.ethernet: failed to get enet-wol clock
libphy: bcmgenet MII bus: probed
bcmgenet 10430000.ethernet: configuring instance for internal PHY
attached PHY at address 1 [Broadcom BCM7XXX 40nm]
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
usbcore: registered new interface driver cdc_ncm
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ehci-platform 10480300.usb: EHCI Host Controller
ehci-platform 10480300.usb: new USB bus registered, assigned bus number 1
ehci-platform 10480300.usb: irq 68, io mem 0x10480300
ehci-platform 10480300.usb: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ehci-platform 10480500.usb: EHCI Host Controller
ehci-platform 10480500.usb: new USB bus registered, assigned bus number 2
ehci-platform 10480500.usb: irq 69, io mem 0x10480500
ehci-platform 10480500.usb: USB 2.0 started, EHCI 1.00
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
ehci-platform 10490300.usb: EHCI Host Controller
ehci-platform 10490300.usb: new USB bus registered, assigned bus number 3
ehci-platform 10490300.usb: irq 73, io mem 0x10490300
ehci-platform 10490300.usb: USB 2.0 started, EHCI 1.00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 1 port detected
ehci-platform 10490500.usb: EHCI Host Controller
ehci-platform 10490500.usb: new USB bus registered, assigned bus number 4
ehci-platform 10490500.usb: irq 74, io mem 0x10490500
ehci-platform 10490500.usb: USB 2.0 started, EHCI 1.00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 1 port detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-platform: OHCI generic platform driver
ohci-platform 10480400.usb: Generic Platform OHCI controller
ohci-platform 10480400.usb: new USB bus registered, assigned bus number 5
ohci-platform 10480400.usb: irq 70, io mem 0x10480400
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 1 port detected
ohci-platform 10480600.usb: Generic Platform OHCI controller
ohci-platform 10480600.usb: new USB bus registered, assigned bus number 6
ohci-platform 10480600.usb: irq 71, io mem 0x10480600
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 1 port detected
ohci-platform 10490400.usb: Generic Platform OHCI controller
ohci-platform 10490400.usb: new USB bus registered, assigned bus number 7
ohci-platform 10490400.usb: irq 75, io mem 0x10490400
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 1 port detected
ohci-platform 10490600.usb: Generic Platform OHCI controller
ohci-platform 10490600.usb: new USB bus registered, assigned bus number 8
ohci-platform 10490600.usb: irq 76, io mem 0x10490600
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 1 port detected
usbcore: registered new interface driver usb-storage
TCP: cubic registered
NET: Registered protocol family 10
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Freeing unused kernel memory: 4096K (805d0000 - 809d0000)
starting pid 830, tty '': '/etc/init.d/rcS'
Mounting virtual filesystems
Starting mdev
Configuring eth0 interface
bcmgenet 10430000.ethernet eth0: Link is Down
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
Configuring lo interface
Configuring sit0 interface
Starting network services
starting pid 864, tty '': '/bin/cttyhack /bin/sh -l'
root@bmips#
