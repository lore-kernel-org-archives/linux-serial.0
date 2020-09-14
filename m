Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A6C433E2
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915BD217BA
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 08:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgINIER (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 04:04:17 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60694 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgINIED (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 04:04:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5838D8030867;
        Mon, 14 Sep 2020 08:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xv_X1TcoB6cJ; Mon, 14 Sep 2020 11:03:51 +0300 (MSK)
Date:   Mon, 14 Sep 2020 11:03:45 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: lockdep warning in 5.9 caused by "serial: 8250_dw: Fix common
 clocks usage race condition"
Message-ID: <20200914080345.4nbjafp55kt3lqjh@mobilestation>
References: <f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f1cd5c75-9cda-6896-a4e2-42c5bfc3f5c3@redhat.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Hans,

On Fri, Sep 11, 2020 at 11:03:41PM +0200, Hans de Goede wrote:
> Hi Serge,
> 
> I noticed that on various Cherry Trail (x86) based
> devices, which use a 8250_dw UART for their blue-tooth,
> I'm now (with 5.9) seeing a lockdep warning on suspend/resume",
> see below.
> 
> This is caused by commit cc816969d7b5 ("serial: 8250_dw: Fix common
> clocks usage race condition"). If I revert that commit the lockdep
> warning goes away.

Thanks for reporting this. I'll have a look at the problem tomorrow or
in two days.

-Sergey

> 
> Regards,
> 
> Hans
> 
> Here is the promised lockdep output:
> 
> [  843.852886] ======================================================
> [  843.852888] WARNING: possible circular locking dependency detected
> [  843.852894] 5.9.0-rc3+ #38 Tainted: G        W   E
> [  843.852896] ------------------------------------------------------
> [  843.852900] systemd-sleep/1628 is trying to acquire lock:
> [  843.852905] ffff935e30344d80 ((work_completion)(&data->clk_work)){+.+.}-{0:0}, at: __flush_work+0x2e6/0x460
> [  843.852922]
>                but task is already holding lock:
> [  843.852924] ffff935e302f1420 (&port->mutex){+.+.}-{3:3}, at: uart_suspend_port+0x3f/0x1f0
> [  843.852938]
>                which lock already depends on the new lock.
> 
> [  843.852940]
>                the existing dependency chain (in reverse order) is:
> [  843.852943]
>                -> #1 (&port->mutex){+.+.}-{3:3}:
> [  843.852954]        __mutex_lock+0x7b/0x820
> [  843.852959]        serial8250_update_uartclk+0x34/0x1b0
> [  843.852965]        process_one_work+0x23f/0x570
> [  843.852969]        worker_thread+0x55/0x3c0
> [  843.852974]        kthread+0x138/0x160
> [  843.852981]        ret_from_fork+0x22/0x30
> [  843.852984]
>                -> #0 ((work_completion)(&data->clk_work)){+.+.}-{0:0}:
> [  843.852995]        __lock_acquire+0x1238/0x2080
> [  843.852999]        lock_acquire+0xa7/0x3d0
> [  843.853003]        __flush_work+0x30d/0x460
> [  843.853008]        uart_suspend_port+0x1b9/0x1f0
> [  843.853014]        dw8250_suspend+0x10/0x20
> [  843.853020]        dpm_run_callback+0x51/0xc0
> [  843.853025]        __device_suspend+0x1f9/0x450
> [  843.853029]        dpm_suspend+0x13d/0x1e0
> [  843.853033]        dpm_suspend_start+0x77/0x80
> [  843.853040]        suspend_devices_and_enter+0xe6/0x620
> [  843.853044]        pm_suspend.cold+0x333/0x389
> [  843.853048]        state_store+0x71/0xd0
> [  843.853056]        kernfs_fop_write+0xdc/0x1c0
> [  843.853063]        vfs_write+0xec/0x230
> [  843.853068]        ksys_write+0x58/0xd0
> [  843.853075]        do_syscall_64+0x33/0x40
> [  843.853079]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  843.853081]
>                other info that might help us debug this:
> 
> [  843.853083]  Possible unsafe locking scenario:
> 
> [  843.853087]        CPU0                    CPU1
> [  843.853090]        ----                    ----
> [  843.853091]   lock(&port->mutex);
> [  843.853095]                                lock((work_completion)(&data->clk_work));
> [  843.853098]                                lock(&port->mutex);
> [  843.853101]   lock((work_completion)(&data->clk_work));
> [  843.853105]
>                 *** DEADLOCK ***
> 
> [  843.853109] 7 locks held by systemd-sleep/1628:
> [  843.853111]  #0: ffff935e302a9488 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x1a0/0x230
> [  843.853123]  #1: ffff935e0e56a290 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write+0xa5/0x1c0
> [  843.853134]  #2: ffff935e392a7848 (kn->active#206){.+.+}-{0:0}, at: kernfs_fop_write+0xad/0x1c0
> [  843.853144]  #3: ffffffffb487b0b0 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend.cold+0xee/0x389
> [  843.853155]  #4: ffffffffb4a42370 (acpi_scan_lock){+.+.}-{3:3}, at: acpi_s2idle_begin+0xa/0x10
> [  843.853167]  #5: ffff935e39ee29a0 (&dev->mutex){....}-{3:3}, at: __device_suspend+0xe8/0x450
> [  843.853178]  #6: ffff935e302f1420 (&port->mutex){+.+.}-{3:3}, at: uart_suspend_port+0x3f/0x1f0
> [  843.853187]
>                stack backtrace:
> [  843.853195] CPU: 3 PID: 1628 Comm: systemd-sleep Tainted: G        W   E     5.9.0-rc3+ #38
> [  843.853199] Hardware name: Acer One S1003/One S1003, BIOS V1.19 03/20/2018
> [  843.853203] Call Trace:
> [  843.853213]  dump_stack+0x8b/0xb8
> [  843.853222]  check_noncircular+0x134/0x150
> [  843.853234]  __lock_acquire+0x1238/0x2080
> [  843.853244]  ? lock_acquire+0xa7/0x3d0
> [  843.853252]  lock_acquire+0xa7/0x3d0
> [  843.853257]  ? __flush_work+0x2e6/0x460
> [  843.853265]  ? lockdep_hardirqs_on_prepare+0x116/0x190
> [  843.853270]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  843.853276]  ? trace_hardirqs_on+0x1c/0xe0
> [  843.853284]  __flush_work+0x30d/0x460
> [  843.853289]  ? __flush_work+0x2e6/0x460
> [  843.853295]  ? sched_clock+0x5/0x10
> [  843.853300]  ? sched_clock_cpu+0xc/0xb0
> [  843.853311]  ? __mutex_unlock_slowpath+0x35/0x270
> [  843.853321]  ? clk_notifier_unregister+0xf8/0x120
> [  843.853328]  uart_suspend_port+0x1b9/0x1f0
> [  843.853337]  ? acpi_pm_notify_work_func+0x30/0x30
> [  843.853342]  dw8250_suspend+0x10/0x20
> [  843.853346]  dpm_run_callback+0x51/0xc0
> [  843.853353]  __device_suspend+0x1f9/0x450
> [  843.853360]  dpm_suspend+0x13d/0x1e0
> [  843.853367]  dpm_suspend_start+0x77/0x80
> [  843.853373]  suspend_devices_and_enter+0xe6/0x620
> [  843.853381]  ? rcu_read_lock_sched_held+0x3f/0x80
> [  843.853388]  pm_suspend.cold+0x333/0x389
> [  843.853394]  state_store+0x71/0xd0
> [  843.853405]  kernfs_fop_write+0xdc/0x1c0
> [  843.853413]  vfs_write+0xec/0x230
> [  843.853420]  ksys_write+0x58/0xd0
> [  843.853427]  do_syscall_64+0x33/0x40
> [  843.853432]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  843.853441] RIP: 0033:0x7f2a99d184b7
> [  843.853450] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  843.853453] RSP: 002b:00007ffedaca0ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  843.853459] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f2a99d184b7
> [  843.853462] RDX: 0000000000000004 RSI: 00007ffedaca0fe0 RDI: 0000000000000004
> [  843.853465] RBP: 00007ffedaca0fe0 R08: 000000000000c0d0 R09: 00007f2a99daf0c0
> [  843.853468] R10: 00007f2a99daefc0 R11: 0000000000000246 R12: 0000000000000004
> [  843.853471] R13: 000055f1a8c67330 R14: 0000000000000004 R15: 00007f2a99dec720
> 
