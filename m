From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: alloc_tty_driver fails with ENOMEM
Date: Tue, 6 Oct 2015 09:44:24 +0300
Message-ID: <20151006064424.GD2472@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi linux-usb list,

Since upgrading to kernel version from 4.1.x to 4.2.1 on Debian testing I am 
getting on my PC the following usbserial module init failure when connecting 
my PC to the i.MX6 SabreSD FTDI USB/serial connector:

[39987.092021] usb 1-5.1: new full-speed USB device number 4 using ehci-pci
[39987.190805] usb 1-5.1: New USB device found, idVendor=0403, idProduct=6001
[39987.190810] usb 1-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[39987.190813] usb 1-5.1: Product: FT232R USB UART
[39987.190817] usb 1-5.1: Manufacturer: FTDI
[39987.190820] usb 1-5.1: SerialNumber: A903PDKT
[39989.127918] systemd-udevd: page allocation failure: order:4, mode:0x2040d0
[39989.127923] CPU: 0 PID: 5856 Comm: systemd-udevd Not tainted 4.2.0-1-amd64 #1 Debian 4.2.1-2
[39989.127925] Hardware name: Gigabyte Technology Co., Ltd. EP45-DS3/EP45-DS3, BIOS F5 06/18/2008
[39989.127928]  0000000000000000 0000000000000004 ffffffff81548756 00000000002040d0
[39989.127931]  ffffffff8115266f ffff88007feddb00 0000000000000000 0000000000000001
[39989.127934]  0000000000000004 0000000000000040 ffff8800793ce7c0 00000000002040d0
[39989.127937] Call Trace:
[39989.127945]  [<ffffffff81548756>] ? dump_stack+0x40/0x50
[39989.127951]  [<ffffffff8115266f>] ? warn_alloc_failed+0xcf/0x130
[39989.127954]  [<ffffffff81155d74>] ? __alloc_pages_nodemask+0x2b4/0x9e0
[39989.127959]  [<ffffffff8119d561>] ? kmem_getpages+0x61/0x110
[39989.127961]  [<ffffffff8119f27f>] ? fallback_alloc+0x1af/0x1f0
[39989.127966]  [<ffffffff813803f0>] ? __tty_alloc_driver+0x90/0x150
[39989.127968]  [<ffffffff8119f616>] ? __kmalloc+0x2c6/0x490
[39989.127970]  [<ffffffff813803f0>] ? __tty_alloc_driver+0x90/0x150
[39989.127973]  [<ffffffff813803f0>] ? __tty_alloc_driver+0x90/0x150
[39989.127975]  [<ffffffffa080d000>] ? 0xffffffffa080d000
[39989.127980]  [<ffffffffa080d014>] ? usb_serial_init+0x14/0x1000 [usbserial]
[39989.127984]  [<ffffffff8100213e>] ? do_one_initcall+0xce/0x200
[39989.127986]  [<ffffffff81547c30>] ? do_init_module+0x5a/0x1e0
[39989.127989]  [<ffffffff810e8074>] ? load_module+0x21a4/0x2500
[39989.127992]  [<ffffffff810e4490>] ? __symbol_put+0x40/0x40
[39989.127995]  [<ffffffff810e4875>] ? copy_module_from_fd.isra.50+0xa5/0x130
[39989.127997]  [<ffffffff810e8586>] ? SyS_finit_module+0x76/0xa0
[39989.128001]  [<ffffffff8154de72>] ? system_call_fast_compare_end+0xc/0x6b
[39989.128002] Mem-Info:
[39989.128008] active_anon:63431 inactive_anon:55185 isolated_anon:0
                active_file:167005 inactive_file:125394 isolated_file:0
                unevictable:12 dirty:4 writeback:0 unstable:0
                slab_reclaimable:69242 slab_unreclaimable:8869
                mapped:26162 shmem:2238 pagetables:5339 bounce:0
                free:9465 free_pcp:27 free_cma:0
[39989.128024] Node 0 DMA free:8072kB min:40kB low:48kB high:60kB active_anon:1056kB inactive_anon:1364kB active_file:2120kB inactive_file:1928kB unevictable:0kB isolated(anon):0kB isolated(file):8kB present:15988kB managed:15904kB mlocked:0kB dirty:0kB writeback:0kB mapped:1832kB shmem:132kB slab_reclaimable:456kB slab_unreclaimable:356kB kernel_stack:96kB pagetables:160kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:20 all_unreclaimable? no
[39989.128030] lowmem_reserve[]: 0 1984 1984 1984
[39989.128034] Node 0 DMA32 free:29804kB min:5584kB low:6980kB high:8376kB active_anon:252668kB inactive_anon:219376kB active_file:665884kB inactive_file:499640kB unevictable:48kB isolated(anon):0kB isolated(file):0kB present:2079616kB managed:2035904kB mlocked:48kB dirty:16kB writeback:0kB mapped:102816kB shmem:8820kB slab_reclaimable:276512kB slab_unreclaimable:35120kB kernel_stack:6640kB pagetables:21196kB unstable:0kB bounce:0kB free_pcp:88kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
[39989.128040] lowmem_reserve[]: 0 0 0 0
[39989.128043] Node 0 DMA: 34*4kB (UEM) 11*8kB (UEM) 13*16kB (UM) 1*32kB (M) 1*64kB (M) 1*128kB (M) 1*256kB (M) 2*512kB (UE) 2*1024kB (EM) 2*2048kB (EM) 0*4096kB = 8080kB
[39989.128057] Node 0 DMA32: 2056*4kB (UEM) 1073*8kB (UEM) 642*16kB (UEM) 81*32kB (UEM) 1*64kB (E) 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 29864kB
[39989.128069] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[39989.128071] 294941 total pagecache pages
[39989.128073] 300 pages in swap cache
[39989.128075] Swap cache stats: add 5938, delete 5638, find 589/756
[39989.128076] Free swap  = 4966840kB
[39989.128077] Total swap = 4988176kB
[39989.128079] 523901 pages RAM
[39989.128080] 0 pages HighMem/MovableOnly
[39989.128081] 10949 pages reserved
[39989.128082] 0 pages hwpoisoned

After trying two more times it finally worked:

[41066.465307] usb 1-5.1: USB disconnect, device number 6
[41070.248026] usb 1-5.1: new full-speed USB device number 7 using ehci-pci
[41070.346629] usb 1-5.1: New USB device found, idVendor=0403, idProduct=6001
[41070.346633] usb 1-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[41070.346637] usb 1-5.1: Product: FT232R USB UART
[41070.346640] usb 1-5.1: Manufacturer: FTDI
[41070.346643] usb 1-5.1: SerialNumber: A903PDKT
[41071.369988] usbcore: registered new interface driver usbserial
[41071.370015] usbcore: registered new interface driver usbserial_generic
[41071.370038] usbserial: USB Serial support registered for generic
[41071.387541] usbcore: registered new interface driver ftdi_sio
[41071.387568] usbserial: USB Serial support registered for FTDI USB Serial Device
[41071.387693] ftdi_sio 1-5.1:1.0: FTDI USB Serial Device converter detected
[41071.387756] usb 1-5.1: Detected FT232RL
[41071.388791] usb 1-5.1: FTDI USB Serial Device converter now attached to ttyUSB0

Any suggestion?

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
