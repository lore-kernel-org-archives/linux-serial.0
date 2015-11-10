From: Andi Kleen <andi@firstfloor.org>
Subject: Re: 4.3 serial driver crashes with console shortly after boot
Date: Tue, 10 Nov 2015 23:43:40 +0100
Message-ID: <20151110224340.GA30452@two.firstfloor.org>
References: <20151110002939.GG3533@two.firstfloor.org>
 <56414DE9.20707@hurleysoftware.com>
 <20151110223957.GI3533@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151110223957.GI3533@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 10, 2015 at 11:39:57PM +0100, Andi Kleen wrote:
> > I've just tried to reproduce this without success on my current
> > tree which has some additional patches I just posted this am. They weren't
> > intended to fix crashes but they directly impact the area of concern. Could
> > you try these three?
> >
> > [PATCH v2 2/4] n_tty: Ignore all read data when closing
> > [PATCH v2 3/4] tty: Abstract and encapsulate tty->closing behavior
> > [PATCH v2 4/4] tty: Remove drivers' extra tty_ldisc_flush()
> >
> Applying the three patches fixes the crash. 
> I haven't tried to figure out which one did the trick.

Actually I was wrong sorry. It still crashes, but now it doesn't
hang the system anymore.

Here are full oopses:

[  109.350595] BUG: unable to handle kernel NULL pointer dereference at 00000000000001f4
[  109.358410] IP: [<ffffffff813bbe1a>] __uart_start.isra.1+0x1a/0x40
[  109.364151] PGD 0 
[  109.365216] Oops: 0000 [#1] SMP 
[  109.367705] Modules linked in: x86_pkg_temp_thermal crc32c_intel
[  109.373363] CPU: 2 PID: 2957 Comm: kworker/u129:8 Not tainted
4.3.0-dirty #679
[  109.380206] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
GRNDSDP1.86B.0046.R00.1502111331 02/11/2015
[  109.390542] Workqueue: events_unbound flush_to_ldisc
[  109.394915] task: ffff88085a2b5c00 ti: ffff880858ad8000 task.ti:
ffff880858ad8000
[  109.402049] RIP: 0010:[<ffffffff813bbe1a>]  [<ffffffff813bbe1a>]
__uart_start.isra.1+0x1a/0x40
[  109.410681] RSP: 0018:ffff880858adbce8  EFLAGS: 00010046
[  109.415390] RAX: 0000000000000000 RBX: ffffffff81edfd60 RCX:
ffffffff817ce300
[  109.422137] RDX: 0000000000000001 RSI: 0000000000000020 RDI:
ffffffff81edfd60
[  109.428886] RBP: ffff880858adbd08 R08: 0000000000000074 R09:
00000000ffffffff
[  109.435628] R10: ffff880856caa120 R11: 0000000000000074 R12:
ffff881059583c00
[  109.442365] R13: 0000000000000286 R14: ffffc90009c782b0 R15:
0000000000000000
[  109.449107] FS:  0000000000000000(0000) GS:ffff88085f840000(0000)
knlGS:0000000000000000
[  109.456922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  109.462116] CR2: 00000000000001f4 CR3: 0000000001af3000 CR4:
00000000001406e0
[  109.468862] Stack:
[  109.469873]  ffffffff813bbe77 ffff881059583c00 ffffc90009c76000
0000000000000074
[  109.477133]  ffff880858adbd18 ffffffff813bbe9e ffff880858adbdc0
ffffffff813a56b9
[  109.484393]  0000000000015200 ffff881059583cd8 ffff880800000001
ffff880800000074
[  109.491651] Call Trace:
[  109.493155]  [<ffffffff813bbe77>] ? uart_start+0x37/0x50
[  109.497866]  [<ffffffff813bbe9e>] uart_flush_chars+0xe/0x10
[  109.502868]  [<ffffffff813a56b9>]
n_tty_receive_buf_common+0x6e9/0xc90
[  109.508938]  [<ffffffff813a5c74>] n_tty_receive_buf2+0x14/0x20
[  109.514232]  [<ffffffff813a90aa>] flush_to_ldisc+0xda/0x170
[  109.519236]  [<ffffffff810b9684>] process_one_work+0x144/0x430
[  109.524525]  [<ffffffff810b99bb>] worker_thread+0x4b/0x4c0
[  109.529417]  [<ffffffff810b9970>] ? process_one_work+0x430/0x430
[  109.534892]  [<ffffffff810bf849>] kthread+0xc9/0xe0
[  109.539111]  [<ffffffff810bf780>] ? flush_kthread_worker+0x70/0x70
[  109.544798]  [<ffffffff8175315f>] ret_from_fork+0x3f/0x70
[  109.549602]  [<ffffffff810bf780>] ? flush_kthread_worker+0x70/0x70
[  109.555271] Code: ff ff 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 44 00 00 48 8b bf 90 01 00 00 48 8b 87 a0 00 00 00 48 8b 80 90 00
00 00 <f6> 80 f4 01 00 00 01 74 01 c3 8b 87 f0 00 00 00 85 c0 75 f5 55 
[  109.579051] RIP  [<ffffffff813bbe1a>] __uart_start.isra.1+0x1a/0x40
[  109.584875]  RSP <ffff880858adbce8>
[  109.587537] CR2: 00000000000001f4
[  109.590008] ---[ end trace 0e4d53c4437868b0 ]---
[  163.478518] ------------[ cut here ]------------
[  163.478524] WARNING: CPU: 2 PID: 2957 at
/home/ak/lsrc/git/linux-2.6/kernel/watchdog.c:331
watchdog_overflow_callback+0x79/0xa0()
[  163.478526] Watchdog detected hard LOCKUP on cpu 2
[  163.478528] Modules linked in: x86_pkg_temp_thermal crc32c_intel
[  163.478531] CPU: 2 PID: 2957 Comm: kworker/u129:8 Tainted: G      D
4.3.0-dirty #679
[  163.478532] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
GRNDSDP1.86B.0046.R00.1502111331 02/11/2015
[  163.478536] Workqueue: events_unbound flush_to_ldisc
[  163.478539]  ffffffff81a00b28 ffff88085f845b00 ffffffff81310ce4
ffff88085f845b48
[  163.478541]  ffff88085f845b38 ffffffff810a42b2 ffff88085b9f8000
0000000000000000
[  163.478543]  ffff88085f845c40 ffff88085f845ef8 0000000000000000
ffff88085f845b98
[  163.478544] Call Trace:
[  163.478552]  <NMI>  [<ffffffff81310ce4>] dump_stack+0x44/0x60
[  163.478557]  [<ffffffff810a42b2>] warn_slowpath_common+0x82/0xc0
[  163.478560]  [<ffffffff810a433c>] warn_slowpath_fmt+0x4c/0x50
[  163.478562]  [<ffffffff81117669>]
watchdog_overflow_callback+0x79/0xa0
[  163.478567]  [<ffffffff8114dcac>] __perf_event_overflow+0x8c/0x1d0
[  163.478570]  [<ffffffff8114e784>] perf_event_overflow+0x14/0x20
[  163.478576]  [<ffffffff8106a80e>] intel_pmu_handle_irq+0x1ce/0x430
[  163.478582]  [<ffffffff81061a96>] perf_event_nmi_handler+0x26/0x40
[  163.478587]  [<ffffffff81051d1b>] nmi_handle+0x7b/0x110
[  163.478590]  [<ffffffff81052230>] default_do_nmi+0x40/0x100
[  163.478592]  [<ffffffff810523d2>] do_nmi+0xe2/0x130
[  163.478596]  [<ffffffff81755011>] end_repeat_nmi+0x1a/0x1e
[  163.478602]  [<ffffffff810db2bc>] ?
native_queued_spin_lock_slowpath+0x15c/0x170
[  163.478604]  [<ffffffff810db2bc>] ?
native_queued_spin_lock_slowpath+0x15c/0x170
[  163.478607]  [<ffffffff810db2bc>] ?
native_queued_spin_lock_slowpath+0x15c/0x170
[  163.478612]  <<EOE>>  [<ffffffff81752907>]
_raw_spin_lock_irqsave+0x37/0x40
[  163.478617]  [<ffffffff813c223a>]
serial8250_console_write+0x1ea/0x220
[  163.478620]  [<ffffffff810ddda0>] ? print_prefix+0x50/0x90
[  163.478623]  [<ffffffff813bde76>] univ8250_console_write+0x26/0x30
[  163.478627]  [<ffffffff810dec72>]
call_console_drivers.constprop.4+0xf2/0x100
[  163.478630]  [<ffffffff810df011>] console_unlock+0x301/0x4d0
[  163.478633]  [<ffffffff810df484>] vprintk_emit+0x2a4/0x490
[  163.478636]  [<ffffffff810df78f>] vprintk_default+0x1f/0x30
[  163.478640]  [<ffffffff81152bd2>] printk+0x48/0x50
[  163.478643]  [<ffffffff810a41fc>] print_oops_end_marker+0x2c/0x60
[  163.478645]  [<ffffffff810a43c3>] oops_exit+0x13/0x20
[  163.478647]  [<ffffffff810515ad>] oops_end+0x7d/0xd0
[  163.478651]  [<ffffffff810934eb>] no_context+0x10b/0x350
[  163.478656]  [<ffffffff8131b540>] ? vsnprintf+0x340/0x510
[  163.478659]  [<ffffffff810937b0>] __bad_area_nosemaphore+0x80/0x1f0
[  163.478661]  [<ffffffff81093933>] bad_area_nosemaphore+0x13/0x20
[  163.478663]  [<ffffffff81093be7>] __do_page_fault+0xa7/0x3e0
[  163.478665]  [<ffffffff81093f42>] do_page_fault+0x22/0x30
[  163.478667]  [<ffffffff81754cb8>] page_fault+0x28/0x30
[  163.478671]  [<ffffffff813bbe1a>] ? __uart_start.isra.1+0x1a/0x40
[  163.478673]  [<ffffffff813bbe77>] ? uart_start+0x37/0x50
[  163.478676]  [<ffffffff813bbe9e>] uart_flush_chars+0xe/0x10
[  163.478679]  [<ffffffff813a56b9>]
n_tty_receive_buf_common+0x6e9/0xc90
[  163.478682]  [<ffffffff813a5c74>] n_tty_receive_buf2+0x14/0x20
[  163.478685]  [<ffffffff813a90aa>] flush_to_ldisc+0xda/0x170
[  163.478688]  [<ffffffff810b9684>] process_one_work+0x144/0x430
[  163.478691]  [<ffffffff810b99bb>] worker_thread+0x4b/0x4c0
[  163.478693]  [<ffffffff810b9970>] ? process_one_work+0x430/0x430
[  163.478696]  [<ffffffff810bf849>] kthread+0xc9/0xe0
[  163.478700]  [<ffffffff810bf780>] ? flush_kthread_worker+0x70/0x70
[  163.478703]  [<ffffffff8175315f>] ret_from_fork+0x3f/0x70
[  163.478707]  [<ffffffff810bf780>] ? flush_kthread_worker+0x70/0x70
[  163.478709] ---[ end trace 0e4d53c4437868b1 ]---
[  178.623346] INFO: rcu_sched detected stalls on CPUs/tasks:
[  178.623351] 	2: (71 GPs behind) idle=8d1/140000000000000/0
softirq=826/826 fqs=14905 
[  178.623357] 	(detected by 33, t=15002 jiffies, g=1537, c=1536,
q=11162)
[  178.623358] Task dump for CPU 2:
[  178.623362] kworker/u129:8  R  running task        0  2957      2
0x00000008
[  178.623374] Workqueue: events_unbound flush_to_ldisc
[  178.623378]  ffff88085f413400 ffff88085f433600 0000000000000000
ffff88105bac0808
[  178.623380]  ffff880858adbe60 ffffffff810b9684 0000000000000000
ffff88085b7481b0
[  178.623383]  ffff88085f413400 0000000000000088 ffff88085f413418
ffff88085b748180
[  178.623383] Call Trace:
[  178.623395]  [<ffffffff810b9684>] ? process_one_work+0x144/0x430
[  178.623398]  [<ffffffff810b99bb>] ? worker_thread+0x4b/0x4c0
[  178.623401]  [<ffffffff810b9970>] ? process_one_work+0x430/0x430
[  178.623405]  [<ffffffff810bf849>] ? kthread+0xc9/0xe0
[  178.623409]  [<ffffffff810bf780>] ? flush_kthread_worker+0x70/0x70
[  178.623420]  [<ffffffff8175315f>] ? ret_from_fork+0x3f/0x70
[  178.623424]  [<ffffffff810bf780>] ? flush_kthread_worker+0x70/0x70
[  225.093423] NMI watchdog: BUG: soft lockup - CPU#19 stuck for 22s!
[grub2-probe:9298]
[  225.093425] Modules linked in: x86_pkg_temp_thermal crc32c_intel
[  225.093426] CPU: 19 PID: 9298 Comm: grub2-probe Tainted: G      D W
4.3.0-dirty #679
[  225.093427] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
GRNDSDP1.86B.0046.R00.1502111331 02/11/2015
[  225.093428] task: ffff88105388d080 ti: ffff881056514000 task.ti:
ffff881056514000
[  225.093432] RIP: 0010:[<ffffffff81103f6f>]  [<ffffffff81103f6f>]
smp_call_function_many+0x1ef/0x240
[  225.093432] RSP: 0018:ffff881056517d68  EFLAGS: 00000202
[  225.093433] RAX: 0000000000000003 RBX: 0000000000000040 RCX:
0000000000000002
[  225.093433] RDX: ffff88085f859960 RSI: 0000000000000040 RDI:
ffff88107fa36108
[  225.093433] RBP: ffff881056517da8 R08: 0000000000000000 R09:
ffffffeffff7ffff
[  225.093434] R10: 0000000000000100 R11: 0000000000000206 R12:
ffff88107fa36100
[  225.093434] R13: ffff88107fa36108 R14: ffffffff811e41d0 R15:
0000000000000000
[  225.093435] FS:  00007fe156fdf800(0000) GS:ffff88107fa20000(0000)
knlGS:0000000000000000
[  225.093435] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  225.093436] CR2: 0000003002e42a10 CR3: 0000001057850000 CR4:
00000000001406e0
[  225.093436] Stack:
[  225.093437]  0000000000000000 00000000000160c0 01ffffff00000001
0000000000000013
[  225.093438]  ffff881056517df8 ffffffff811e41d0 0000000000000000
0000000000000040
[  225.093455]  ffff881056517dd8 ffffffff811040a8 0000000000000000
ffffffff81bfa4d8
[  225.093455] Call Trace:
[  225.093460]  [<ffffffff811e41d0>] ? __brelse+0x30/0x30
[  225.093461]  [<ffffffff811040a8>] on_each_cpu_mask+0x28/0x60
[  225.093463]  [<ffffffff811e3590>] ? mark_buffer_async_write+0x20/0x20
[  225.093464]  [<ffffffff8110416c>] on_each_cpu_cond+0x8c/0xb0
[  225.093465]  [<ffffffff811e41d0>] ? __brelse+0x30/0x30
[  225.093466]  [<ffffffff811e4629>] invalidate_bh_lrus+0x29/0x30
[  225.093468]  [<ffffffff811e7f7e>] invalidate_bdev+0x1e/0x40
[  225.093473]  [<ffffffff8130145d>] blkdev_ioctl+0x37d/0x690
[  225.093475]  [<ffffffff811e986d>] block_ioctl+0x3d/0x50
[  225.093478]  [<ffffffff811c4ee5>] do_vfs_ioctl+0x285/0x470
[  225.093481]  [<ffffffff811b8dda>] ? SyS_newfstat+0x2a/0x40
[  225.093483]  [<ffffffff811c5111>] SyS_ioctl+0x41/0x70
[  225.093485]  [<ffffffff81752dee>] entry_SYSCALL_64_fastpath+0x12/0x71
[  225.093494] Code: fc 21 00 3b 05 87 76 af 00 89 c1 0f 8d a2 fe ff ff
48 98 49 8b 14 24 48 03 14 c5 c0 9c bf 81 8b 42 18 a8 01 74 ca f3 90 8b
42 18 <a8> 01 75 f7 eb bf 4c 89 ea 48 89 de 44 89 e7 e8 6d cb 20 00 41 
