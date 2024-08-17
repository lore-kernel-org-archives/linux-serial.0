Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC191E511
	for <linux-serial@vger.kernel.org>; Sat, 17 Aug 2024 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912770; cv=none; b=hztDptYT6iXr8bsOQsyGh1dVXIWRNb+P2gpdY2PdfFO9I9F+Mtd2WaMH0LRiHczn8VZEy+fUc5zG0BRfqjBKShaJJYlgszvrMzGR7TVdMH6FWMnJVNYjphun1ho/6WHRw8n1y2m+HBqhDNX42RwVSzPFB0kgU8ibGfCSzfnFrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912770; c=relaxed/simple;
	bh=Pv3rs6YFl9WbJxzP1DwTXcIHBrDHy0ujIkxIkpKdBs8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pzWmAByUrlR/Nkroo4+dlFewerxuFpQVVNQW41e/q1sfVGkWYtwflAqMxw9sLrgrGVGlTyhHn8k6s7ysDXasBE4xD2B7oSdSzlruGEfLiXQGU2f5guv1sqsgAFgxqVyTxyks4YoRtSj5sadsZfYTT3ZZOMMgrp9kWf5vE33bdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso310404139f.0
        for <linux-serial@vger.kernel.org>; Sat, 17 Aug 2024 09:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912767; x=1724517567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgH0V0QVRMMJRrBYyPOLJQ/E/Op0mYtPfDHDngr+nJE=;
        b=N6hdNJ8J/QbIhDV4veRbiM+2j4O7sqWixpDK5oCy/ua1Ksa1oWl22wX/J2Rvy24j4g
         6tbeTDTJI46PgUrSlvislnPUIr+GF8ATKwZyHj8X15DsT85QlWqqXLGfmISyLhSEwIKQ
         yqmWfG/mp4dWUUj1Yz5c8j+xMlWSkd2cMtVk+ppUgaYwf8CHCNWsS57GXhsBnx9OdJzC
         wKLfFctJ/VpjxD1A59xY8U4L55LXaLukAmyxZueIZ7vIkXHeAcfe/ZtvnzhGqu9OYNof
         56jDir/QZvrTP5S2xclt1yicWHadmqTfZb0M2ZoM6DUMsqpDJa5QCp8aMAC0wr94a8lV
         MnAg==
X-Forwarded-Encrypted: i=1; AJvYcCXTh7Yl3MPBGoCrW+sx2riaOSfHFGiEY6ZtyEyhmd3v1VJBclyv8SNIAoAqZIJ5sQArOKvusthJF3bICLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyViGrla1x7ghDMmk1fk3gZ6B5ZcEaZXcWhF4jb993lY8UHOskI
	AwVjzKu/KsEo/EVhr7AvnK4NkjTuAUzbSVxef2o7XQ6G/RHK1xBjAKdVAr3PacZ5kogpTBpZ0jy
	eE/rhYtwh2HMCb/gSL0FPtDPYaB/0fmDPoCQ7NpChkeLB7b3kDWjnW8k=
X-Google-Smtp-Source: AGHT+IHIoPTHu10J87KhLVyuizV3TnxcR9Z1wbGnYxE5eX7oNlA16H23Mta84Y7KWwL1jhPWUA6rNKaUQ7dcun1KnQO4hS16mi1z
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39d26d9d506mr5107035ab.6.1723912767294; Sat, 17 Aug 2024
 09:39:27 -0700 (PDT)
Date: Sat, 17 Aug 2024 09:39:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e66f5061fe3b883@google.com>
Subject: [syzbot] [serial?] possible deadlock in console_lock_spinning_enable (5)
From: syzbot <syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11626d7d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bc88a9f65787e86
dashboard link: https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ef30d34e749/disk-8867bbd4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a21c2389ebfb/vmlinux-8867bbd4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9720b12c3f99/Image-8867bbd4.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com

sp0: Synchronizing with TNC
------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc2-syzkaller-g8867bbd4a056 #0 Tainted: G        W         
------------------------------------------------------
syz.2.1398/12737 is trying to acquire lock:
ffff80008f58d020 (console_owner){-.-.}-{0:0}, at: console_lock_spinning_enable+0x88/0xec kernel/printk/printk.c:1866

but task is already holding lock:
ffff800094049db8 (&port_lock_key){-.-.}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
ffff800094049db8 (&port_lock_key){-.-.}-{2:2}, at: uart_write+0x114/0x2ec drivers/tty/serial/serial_core.c:624

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
       pl011_console_write+0x148/0x724 drivers/tty/serial/amba-pl011.c:2316
       console_emit_next_record kernel/printk/printk.c:2928 [inline]
       console_flush_all+0x5cc/0xb74 kernel/printk/printk.c:2994
       console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
       vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
       vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
       vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
       _printk+0xdc/0x128 kernel/printk/printk.c:2370
       register_console+0x700/0xa8c kernel/printk/printk.c:3596
       uart_configure_port drivers/tty/serial/serial_core.c:2664 [inline]
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3192 [inline]
       serial_core_register_port+0x1428/0x1bf4 drivers/tty/serial/serial_core.c:3429
       serial_ctrl_register_port+0x28/0x38 drivers/tty/serial/serial_ctrl.c:41
       uart_add_one_port+0x28/0x38 drivers/tty/serial/serial_port.c:136
       pl011_register_port+0x1b4/0x44c drivers/tty/serial/amba-pl011.c:2744
       sbsa_uart_probe+0x488/0x608 drivers/tty/serial/amba-pl011.c:2914
       platform_probe+0x148/0x1c0 drivers/base/platform.c:1404
       really_probe+0x38c/0x8fc drivers/base/dd.c:656
       __driver_probe_device+0x194/0x374 drivers/base/dd.c:798
       driver_probe_device+0x78/0x330 drivers/base/dd.c:828
       __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:956
       bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
       __device_attach+0x2b4/0x434 drivers/base/dd.c:1028
       device_initial_probe+0x24/0x34 drivers/base/dd.c:1077
       bus_probe_device+0x178/0x240 drivers/base/bus.c:532
       device_add+0x728/0xa6c drivers/base/core.c:3721
       platform_device_add+0x3e8/0x6e8 drivers/base/platform.c:716
       platform_device_register_full+0x4ec/0x604 drivers/base/platform.c:844
       acpi_create_platform_device+0x5bc/0x744 drivers/acpi/acpi_platform.c:177
       acpi_default_enumeration+0x6c/0xdc drivers/acpi/scan.c:2184
       acpi_bus_attach+0x8b8/0xaa8 drivers/acpi/scan.c:2293
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1143
       device_for_each_child+0xec/0x174 drivers/base/core.c:4050
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1155
       acpi_bus_attach+0x358/0xaa8 drivers/acpi/scan.c:2298
       acpi_dev_for_one_check+0xa0/0xb4 drivers/acpi/bus.c:1143
       device_for_each_child+0xec/0x174 drivers/base/core.c:4050
       acpi_dev_for_each_child+0xc4/0x108 drivers/acpi/bus.c:1155
       acpi_bus_attach+0x358/0xaa8 drivers/acpi/scan.c:2298
       acpi_bus_scan+0x118/0x4f0 drivers/acpi/scan.c:2579
       acpi_scan_init+0x214/0x6b0 drivers/acpi/scan.c:2714
       acpi_init+0x190/0x254 drivers/acpi/bus.c:1460
       do_one_initcall+0x254/0x9e4 init/main.c:1267
       do_initcall_level+0x154/0x214 init/main.c:1329
       do_initcalls+0x58/0xac init/main.c:1345
       do_basic_setup+0x8c/0xa0 init/main.c:1364
       kernel_init_freeable+0x324/0x478 init/main.c:1578
       kernel_init+0x24/0x2a0 init/main.c:1467
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #0 (console_owner){-.-.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
       console_lock_spinning_enable+0xb4/0xec kernel/printk/printk.c:1870
       console_emit_next_record kernel/printk/printk.c:2922 [inline]
       console_flush_all+0x58c/0xb74 kernel/printk/printk.c:2994
       console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
       vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
       vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
       vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
       _printk+0xdc/0x128 kernel/printk/printk.c:2370
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x3b8/0x5b0 lib/bug.c:219
       bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:978
       call_break_hook arch/arm64/kernel/debug-monitors.c:321 [inline]
       brk_handler+0x17c/0x2e0 arch/arm64/kernel/debug-monitors.c:328
       do_debug_exception+0x1e4/0x398 arch/arm64/mm/fault.c:909
       el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:472
       el1h_64_sync_handler+0x40/0xac arch/arm64/kernel/entry-common.c:512
       el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
       spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]
       uart_write+0x280/0x2ec drivers/tty/serial/serial_core.c:626
       tnc_init drivers/net/hamradio/6pack.c:531 [inline]
       sixpack_open+0x5d8/0x8b0 drivers/net/hamradio/6pack.c:628
       tty_ldisc_open+0x9c/0x14c drivers/tty/tty_ldisc.c:432
       tty_set_ldisc+0x2f8/0x4e0 drivers/tty/tty_ldisc.c:563
       tiocsetd+0x100/0x13c drivers/tty/tty_io.c:2439
       tty_ioctl+0xba0/0xd8c drivers/tty/tty_io.c:2739
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
       __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
       el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port_lock_key);
                               lock(console_owner);
                               lock(&port_lock_key);
  lock(console_owner);

 *** DEADLOCK ***

5 locks held by syz.2.1398/12737:
 #0: ffff0000ed2011c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_lock+0x78/0xc8 drivers/tty/tty_mutex.c:18
 #1: ffff0000ed2010a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_write+0x3c/0x4c drivers/tty/tty_ldsem.c:366
 #2: ffff800094049db8 (&port_lock_key){-.-.}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
 #2: ffff800094049db8 (&port_lock_key){-.-.}-{2:2}, at: uart_write+0x114/0x2ec drivers/tty/serial/serial_core.c:624
 #3: ffff80008f474940 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x1d0/0x350 kernel/printk/printk.c:2344
 #4: ffff80008f474570 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire+0x10/0x4c include/linux/rcupdate.h:333

stack backtrace:
CPU: 0 PID: 12737 Comm: syz.2.1398 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
 console_lock_spinning_enable+0xb4/0xec kernel/printk/printk.c:1870
 console_emit_next_record kernel/printk/printk.c:2922 [inline]
 console_flush_all+0x58c/0xb74 kernel/printk/printk.c:2994
 console_unlock+0xec/0x3d4 kernel/printk/printk.c:3063
 vprintk_emit+0x1ec/0x350 kernel/printk/printk.c:2345
 vprintk_default+0xa0/0xe4 kernel/printk/printk.c:2360
 vprintk+0x200/0x2d4 kernel/printk/printk_safe.c:45
 _printk+0xdc/0x128 kernel/printk/printk.c:2370
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x3b8/0x5b0 lib/bug.c:219
 bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:978
 call_break_hook arch/arm64/kernel/debug-monitors.c:321 [inline]
 brk_handler+0x17c/0x2e0 arch/arm64/kernel/debug-monitors.c:328
 do_debug_exception+0x1e4/0x398 arch/arm64/mm/fault.c:909
 el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:472
 el1h_64_sync_handler+0x40/0xac arch/arm64/kernel/entry-common.c:512
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:593
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]
 uart_write+0x280/0x2ec drivers/tty/serial/serial_core.c:626
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x5d8/0x8b0 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open+0x9c/0x14c drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x2f8/0x4e0 drivers/tty/tty_ldisc.c:563
 tiocsetd+0x100/0x13c drivers/tty/tty_io.c:2439
 tty_ioctl+0xba0/0xd8c drivers/tty/tty_io.c:2739
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
WARNING: CPU: 0 PID: 12737 at drivers/tty/serial/serial_core.c:625 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
WARNING: CPU: 0 PID: 12737 at drivers/tty/serial/serial_core.c:625 uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]
WARNING: CPU: 0 PID: 12737 at drivers/tty/serial/serial_core.c:625 uart_write+0x280/0x2ec drivers/tty/serial/serial_core.c:626
Modules linked in:
CPU: 0 PID: 12737 Comm: syz.2.1398 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : uart_write+0x280/0x2ec include/linux/spinlock.h:406
lr : uart_write+0x278/0x2ec drivers/tty/serial/serial_core.c:625
sp : ffff800097fc7ad0
x29: ffff800097fc7ad0 x28: 1ffff00012ff8f68 x27: dfff800000000000
x26: 0000000000000001 x25: dfff800000000000 x24: ffff0000c9708f48
x23: 0000000000000000 x22: ffff800094049da0 x21: ffff800097fc7b60
x20: 0000000000000001 x19: ffff0000c9708be8 x18: ffff800097fc7780
x17: 00000000000411dd x16: ffff8000803514ec x15: ffff700012ff8f40
x14: 1ffff00012ff8f40 x13: 0000000000000004 x12: ffffffffffffffff
x11: 0000000000040000 x10: 000000000001f74c x9 : ffff8000ab01c000
x8 : 000000000001f74d x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000020 x4 : 0000000000000000 x3 : ffff80008035161c
x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff800094049da0
Call trace:
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]
 uart_write+0x280/0x2ec drivers/tty/serial/serial_core.c:626
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x5d8/0x8b0 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open+0x9c/0x14c drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x2f8/0x4e0 drivers/tty/tty_ldisc.c:563
 tiocsetd+0x100/0x13c drivers/tty/tty_io.c:2439
 tty_ioctl+0xba0/0xd8c drivers/tty/tty_io.c:2739
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 1952
hardirqs last  enabled at (1951): [<ffff8000803794d8>] __up_console_sem kernel/printk/printk.c:341 [inline]
hardirqs last  enabled at (1951): [<ffff8000803794d8>] __console_unlock kernel/printk/printk.c:2746 [inline]
hardirqs last  enabled at (1951): [<ffff8000803794d8>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3065
hardirqs last disabled at (1952): [<ffff80008b2f9ba8>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (1952): [<ffff80008b2f9ba8>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (1800): [<ffff8000893ef2dc>] neigh_parms_alloc+0x330/0x464 net/core/neighbour.c:1738
softirqs last disabled at (1798): [<ffff8000893ef230>] neigh_parms_alloc+0x284/0x464 net/core/neighbour.c:1736
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
