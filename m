Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03784A1D
	for <linux-serial@vger.kernel.org>; Mon, 10 Jun 2024 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717978807; cv=none; b=E7CnGe8lT59/r2WahVQL7bFjU6mWsBZ6R4gqsOty0GW+u7Dhn5L+uQfMfdg0I4rYr/iYOLP96zahZX71jJNxJ8DpWq/bAE56Gf9kLVxGqhX1ouwhYa+h4uPtF4jVXoAsH1BwgnuER3WSKQDy+M9Bh/7xzxNKEWKDT2nmFeydOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717978807; c=relaxed/simple;
	bh=epuzfZNoL5legX1ezur/7fbUoj4PCjOINSlQR/jjdg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRrtl9imJSUVSQKcGjuhMN9AGiLNHOdIfdm9U0W8J3+085pzem8x6U/iByapu7peO7ceAeSMVJPntzTmSP3LOKGzoCU36K9e9led5LjM4ZOkcmPZNFtdSR6+HtSoxSGt1dHT5byTh3fx+bZo/U6swjOLsrHoMIGaiLKVgJdJTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.173])
	by sina.com (172.16.235.25) with ESMTP
	id 6666468A0000711C; Mon, 10 Jun 2024 08:19:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 36046234210254
X-SMAIL-UIID: 9A55A22873B844119570E362A7ADB9D6-20240610-081924-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0f558b549182d2711c75@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] possible deadlock in console_lock_spinning_enable (4)
Date: Mon, 10 Jun 2024 08:19:14 +0800
Message-Id: <20240610001914.2081-1-hdanton@sina.com>
In-Reply-To: <000000000000a8d9a7061a76a05f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 09 Jun 2024 08:24:24 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14d199ce980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
> dashboard link: https://syzkaller.appspot.com/bug?extid=0f558b549182d2711c75
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11493bc2980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146cff16980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6ea21f50498b/disk-8867bbd4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e2fed09364aa/vmlinux-8867bbd4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4860173c7a18/Image-8867bbd4.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0f558b549182d2711c75@syzkaller.appspotmail.com
> 
> sp0: Synchronizing with TNC
> ------------[ cut here ]------------
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.10.0-rc2-syzkaller-g8867bbd4a056 #0 Tainted: G        W         
> ------------------------------------------------------
> syz-executor196/6254 is trying to acquire lock:
> ffff80008f1bcea0 (console_owner){....}-{0:0}, at: console_lock_spinning_enable+0x88/0xec kernel/printk/printk.c:1866
> 
> but task is already holding lock:
> ffff800093bc1c58 (&port_lock_key){....}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
> ffff800093bc1c58 (&port_lock_key){....}-{2:2}, at: uart_write+0x114/0x2ec drivers/tty/serial/serial_core.c:624
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&port_lock_key){....}-{2:2}:
>        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>        _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
>        uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
>        pl011_console_write+0x148/0x724 drivers/tty/serial/amba-pl011.c:2316
>        console_emit_next_record kernel/printk/printk.c:2928 [inline]
>        console_flush_all+0x5cc/0xb74 kernel/printk/printk.c:2994
>        console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
>        vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
>        vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
>        vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
>        _printk+0xdc/0x128 kernel/printk/printk.c:2370
>        register_console+0x700/0xa8c kernel/printk/printk.c:3596
>        uart_configure_port drivers/tty/serial/serial_core.c:2664 [inline]
>        serial_core_add_one_port drivers/tty/serial/serial_core.c:3192 [inline]
>        serial_core_register_port+0x1428/0x1bf4 drivers/tty/serial/serial_core.c:3429
>        serial_ctrl_register_port+0x28/0x38 drivers/tty/serial/serial_ctrl.c:41
>        uart_add_one_port+0x28/0x38 drivers/tty/serial/serial_port.c:136
>        pl011_register_port+0x1b4/0x44c drivers/tty/serial/amba-pl011.c:2744
>        sbsa_uart_probe+0x488/0x608 drivers/tty/serial/amba-pl011.c:2914
>        platform_probe+0x148/0x1c0 drivers/base/platform.c:1404
>        really_probe+0x38c/0x8fc drivers/base/dd.c:656
>        __driver_probe_device+0x194/0x374 drivers/base/dd.c:798
>        driver_probe_device+0x78/0x330 drivers/base/dd.c:828
>        __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:956
>        bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
>        __device_attach+0x2b4/0x434 drivers/base/dd.c:1028
>        device_initial_probe+0x24/0x34 drivers/base/dd.c:1077
>        bus_probe_device+0x178/0x240 drivers/base/bus.c:532
>        device_add+0x728/0xa6c drivers/base/core.c:3721
>        platform_device_add+0x3e8/0x6e8 drivers/base/platform.c:716
>        platform_device_register_full+0x4ec/0x604 drivers/base/platform.c:844
>        acpi_create_platform_device+0x5bc/0x744 drivers/acpi/acpi_platform.c:177
>        acpi_default_enumeration+0x6c/0xdc drivers/acpi/scan.c:2184
>        acpi_bus_attach+0x8b8/0xaa8 drivers/acpi/scan.c:2293
>        acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1143
>        device_for_each_child+0xec/0x174 drivers/base/core.c:4050
>        acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1155
>        acpi_bus_attach+0x358/0xaa8 drivers/acpi/scan.c:2298
>        acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1143
>        device_for_each_child+0xec/0x174 drivers/base/core.c:4050
>        acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1155
>        acpi_bus_attach+0x358/0xaa8 drivers/acpi/scan.c:2298
>        acpi_bus_scan+0x118/0x4f0 drivers/acpi/scan.c:2579
>        acpi_scan_init+0x214/0x6b0 drivers/acpi/scan.c:2714
>        acpi_init+0x190/0x254 drivers/acpi/bus.c:1460
>        do_one_initcall+0x254/0x9e4 init/main.c:1267
>        do_initcall_level+0x154/0x214 init/main.c:1329
>        do_initcalls+0x58/0xac init/main.c:1345
>        do_basic_setup+0x8c/0xa0 init/main.c:1364
>        kernel_init_freeable+0x324/0x478 init/main.c:1578
>        kernel_init+0x24/0x2a0 init/main.c:1467
>        ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> 
> -> #0 (console_owner){....}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain kernel/locking/lockdep.c:3869 [inline]
>        __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
>        lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
>        console_lock_spinning_enable+0xb4/0xec kernel/printk/printk.c:1870
>        console_emit_next_record kernel/printk/printk.c:2922 [inline]
>        console_flush_all+0x58c/0xb74 kernel/printk/printk.c:2994
>        console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
>        vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
>        vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
>        vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
>        _printk+0xdc/0x128 kernel/printk/printk.c:2370
>        __report_bug lib/bug.c:195 [inline]
>        report_bug+0x3b8/0x5b0 lib/bug.c:219
>        bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:978
>        call_break_hook arch/arm64/kernel/debug-monitors.c:321 [inline]
>        brk_handler+0x17c/0x2e0 arch/arm64/kernel/debug-monitors.c:328
>        do_debug_exception+0x1e4/0x398 arch/arm64/mm/fault.c:909
>        el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:472
>        el1h_64_sync_handler+0x40/0xac arch/arm64/kernel/entry-common.c:512
>        el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
>        spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>        uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]

in include/linux/spinlock_api_smp.h
static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
{
	spin_release(&lock->dep_map, _RET_IP_);
	do_raw_spin_unlock(lock);
	local_irq_restore(flags);
	preempt_enable();
}

Because spin_release() goes before restoring local irq, the port_lock
should have been ruled out of lockdep that triggered this report. But
it was delivered to lore.

>        uart_write+0x280/0x2ec drivers/tty/serial/serial_core.c:626
>        tnc_init drivers/net/hamradio/6pack.c:531 [inline]
>        sixpack_open+0x5d8/0x8b0 drivers/net/hamradio/6pack.c:628
>        tty_ldisc_open+0x9c/0x14c drivers/tty/tty_ldisc.c:432
>        tty_set_ldisc+0x2f8/0x4e0 drivers/tty/tty_ldisc.c:563
>        tiocsetd+0x100/0x13c drivers/tty/tty_io.c:2439
>        tty_ioctl+0xba0/0xd8c drivers/tty/tty_io.c:2739
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:907 [inline]
>        __se_sys_ioctl fs/ioctl.c:893 [inline]
>        __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
>        __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>        invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
>        el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
>        do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
>        el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>        el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>        el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&port_lock_key);
>                                lock(console_owner);
>                                lock(&port_lock_key);
>   lock(console_owner);
> 
>  *** DEADLOCK ***
