Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15725136A
	for <linux-serial@vger.kernel.org>; Wed, 22 Jan 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544886; cv=none; b=g98vLhL/mq1jFFDUREGP6kFHwhpml5LZSEH8ZfGsOA5fbuGLlVFVeRwvxXeyMEMJWShk2AOMwQYeJ8K1Le94DdcWSfUrblj7yWwCZwZTKMC6kQqRbHP1+b5bFtvPRQ839GGBgM9mT7nR4Zdy6JDnuE4+MUUVicFG2n4kbDoTNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544886; c=relaxed/simple;
	bh=Za7anPt463p1CLJVYxXcZiN/74L8iU5Q4FAZwxMCT0A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hsd88Er3ikedk09+qTbBpnKBHeJ7YfzMAe7NEYcEWu5a3mYWqR1UJLg5GwR3+b9X/vjyO6GjANBy8Qt8sMDZAJNT+HHUdUnn95/nBx6fEiPtJFKdg9M8q1R7W1fvrdtEJStmNtDOh60AmQ7NJuiCjz4i1Wsrq2YL8INLni5yP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso50307945ab.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Jan 2025 03:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737544884; x=1738149684;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+azH2lJ2vbz0PGCGo4JOkJnJU40DbtAmUhZNAUXNo80=;
        b=WvMzKINBDY2dMrCzL0Dc4AQ3zITc33rZRZqWE8lkp2GkO9eN6m3RLdLLY2/1vy9/dS
         zBYjMEJACE3X++2Sh1F1rOTT3b+04vWr8XAeuRrvdTYpsRpQ3CqNZf0GlbrArN1+1aRr
         owuPPfjBg5a2dBP0+Obi9EccEFOHvW4PkQP9A3dy5bcXbJ4LtAshIlGutmEvyzL5HFu/
         YQFqWM/yzvsESDjUeOgjNaFMANQaHWU2wMN3eO0ydW2v0Iy8NUUZikIxdffnL4Fqd/SA
         qBpFUcHkE3k+SmZu0Lqf7DgFWhOl5zFBzmjGpRkDOAgo97J4HhobdoumJDG3trHI/QNz
         Yvzg==
X-Forwarded-Encrypted: i=1; AJvYcCVzBxG3N/e7Q5tHj57Cfxh+lHo0fc2ZXl1HSOQsGkrDrwfNihnMxq/SLsywxbQvBpA/9NA/35lmXjHjJbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGL9UJMG1JdOuLaXsPyeuP0cuK+fZ9YO/9RRNkmPHd01AXXj+p
	Aw6NKH+nqcpLQxbMV4sDRoYGOduzGH/+hSc1QXDklTE10fCqK8Lgu0xO73teXMjkWJtUAxfT3bc
	Xv3Ed2vqHtqyD/5e/F4P+PrfiDfuqePCUEBOuhXFVU1cQi2O/ssNaywM=
X-Google-Smtp-Source: AGHT+IH4Lj/PJSByYBZX5pkOkEw+Do1QnoTV2Qd6CAtM0J1cd3SRN4pdLwP93hQA3SBYjr3ruZvNZ7Z6N2EJCeywzAvM7qwcZiUh
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3cf74493955mr170248015ab.19.1737544884165; Wed, 22 Jan 2025
 03:21:24 -0800 (PST)
Date: Wed, 22 Jan 2025 03:21:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6790d4b4.050a0220.15cac.020d.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in n_tty_flush_buffer
From: syzbot <syzbot+d84934b4184d7f9a1aed@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    595523945be0 Merge tag 'devicetree-fixes-for-6.13-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110a3fc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=d84934b4184d7f9a1aed
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a0fa18580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aa62b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f7863c08b5c/disk-59552394.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06971b2686d0/vmlinux-59552394.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66c751022d90/bzImage-59552394.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d84934b4184d7f9a1aed@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc7-syzkaller-00189-g595523945be0 #0 Not tainted
------------------------------------------------------
kworker/0:2/1207 is trying to acquire lock:
ffff88801c7ff2e8 (&tty->termios_rwsem){++++}-{4:4}, at: n_tty_flush_buffer+0x25/0x1b0 drivers/tty/n_tty.c:358

but task is already holding lock:
ffff88801b0990b8 (&buf->lock){+.+.}-{4:4}, at: tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&buf->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229
       tty_ldisc_flush+0x64/0xe0 drivers/tty/tty_ldisc.c:388
       __do_SAK+0x6a1/0x800 drivers/tty/tty_io.c:3038
       vc_SAK+0x7f/0x310 drivers/tty/vt/vt_ioctl.c:993
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
       process_scheduled_works kernel/workqueue.c:3317 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (console_lock){+.+.}-{0:0}:
       console_lock+0x7a/0xa0 kernel/printk/printk.c:2833
       uart_configure_port drivers/tty/serial/serial_core.c:2615 [inline]
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3182 [inline]
       serial_core_register_port+0xe9c/0x2570 drivers/tty/serial/serial_core.c:3419
       serial8250_register_8250_port+0x158f/0x2370 drivers/tty/serial/8250/8250_core.c:823
       serial_pnp_probe+0x44f/0x930 drivers/tty/serial/8250/8250_pnp.c:490
       pnp_device_probe+0x2a5/0x4d0 drivers/pnp/driver.c:111
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __driver_attach+0x283/0x580 drivers/base/dd.c:1216
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:370
       bus_add_driver+0x2e9/0x690 drivers/base/bus.c:675
       driver_register+0x15c/0x4b0 drivers/base/driver.c:246
       serial8250_init+0xc9/0x1e0 drivers/tty/serial/8250/8250_platform.c:324
       do_one_initcall+0x128/0x700 init/main.c:1266
       do_initcall_level init/main.c:1328 [inline]
       do_initcalls init/main.c:1344 [inline]
       do_basic_setup init/main.c:1363 [inline]
       kernel_init_freeable+0x5c7/0x900 init/main.c:1577
       kernel_init+0x1c/0x2b0 init/main.c:1466
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&port->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       class_mutex_constructor include/linux/mutex.h:201 [inline]
       uart_set_termios+0x8e/0x6a0 drivers/tty/serial/serial_core.c:1704
       tty_set_termios+0x667/0x9b0 drivers/tty/tty_ioctl.c:345
       set_termios+0x5ba/0x7f0 drivers/tty/tty_ioctl.c:520
       tty_mode_ioctl+0x57a/0xd20 drivers/tty/tty_ioctl.c:807
       n_tty_ioctl_helper+0x4b/0x2b0 drivers/tty/tty_ioctl.c:986
       n_tty_ioctl+0x7f/0x370 drivers/tty/n_tty.c:2521
       tty_ioctl+0x6ee/0x15d0 drivers/tty/tty_io.c:2812
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&tty->termios_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       n_tty_flush_buffer+0x25/0x1b0 drivers/tty/n_tty.c:358
       tty_buffer_flush+0x236/0x310 drivers/tty/tty_buffer.c:241
       tty_ldisc_flush+0x64/0xe0 drivers/tty/tty_ldisc.c:388
       __do_SAK+0x6a1/0x800 drivers/tty/tty_io.c:3038
       vc_SAK+0x7f/0x310 drivers/tty/vt/vt_ioctl.c:993
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
       process_scheduled_works kernel/workqueue.c:3317 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &tty->termios_rwsem --> console_lock --> &buf->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&buf->lock);
                               lock(console_lock);
                               lock(&buf->lock);
  lock(&tty->termios_rwsem);

 *** DEADLOCK ***

5 locks held by kworker/0:2/1207:
 #0: ffff88801b078948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3211
 #1: ffffc900045efd80 ((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3212
 #2: ffffffff8e1a9040 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x13/0x310 drivers/tty/vt/vt_ioctl.c:983
 #3: ffff88801c7ff0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref drivers/tty/tty_ldisc.c:263 [inline]
 #3: ffff88801c7ff0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_flush+0x1c/0xe0 drivers/tty/tty_ldisc.c:386
 #4: ffff88801b0990b8 (&buf->lock){+.+.}-{4:4}, at: tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229

stack backtrace:
CPU: 0 UID: 0 PID: 1207 Comm: kworker/0:2 Not tainted 6.13.0-rc7-syzkaller-00189-g595523945be0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events vc_SAK
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 down_write+0x93/0x200 kernel/locking/rwsem.c:1577
 n_tty_flush_buffer+0x25/0x1b0 drivers/tty/n_tty.c:358
 tty_buffer_flush+0x236/0x310 drivers/tty/tty_buffer.c:241
 tty_ldisc_flush+0x64/0xe0 drivers/tty/tty_ldisc.c:388
 __do_SAK+0x6a1/0x800 drivers/tty/tty_io.c:3038
 vc_SAK+0x7f/0x310 drivers/tty/vt/vt_ioctl.c:993
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
tty tty1: SAK: killed process 5963 (syz-executor367): by fd#4
usb 5-1: USB disconnect, device number 25
usb 5-1: new high-speed USB device number 26 using dummy_hcd
usb 5-1: config 0 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 5-1: New USB device found, idVendor=0926, idProduct=3333, bcdDevice= 0.40
usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 5-1: config 0 descriptor??
keytouch 0003:0926:3333.0079: fixing up Keytouch IEC report descriptor
input: HID 0926:3333 as /devices/platform/dummy_hcd.4/usb5/5-1/5-1:0.0/0003:0926:3333.0079/input/input125
keytouch 0003:0926:3333.0079: input,hidraw0: USB HID v0.00 Keyboard [HID 0926:3333] on usb-dummy_hcd.4-1/input0
usb 4-1: USB disconnect, device number 26
usb 4-1: new high-speed USB device number 27 using dummy_hcd
usb 4-1: config 0 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 4-1: New USB device found, idVendor=0926, idProduct=3333, bcdDevice= 0.40
usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 4-1: config 0 descriptor??
keytouch 0003:0926:3333.0080: fixing up Keytouch IEC report descriptor
input: HID 0926:3333 as /devices/platform/dummy_hcd.3/usb4/4-1/4-1:0.0/0003:0926:3333.0080/input/input132
keytouch 0003:0926:3333.0080: input,hidraw2: USB HID v0.00 Keyboard [HID 0926:3333] on usb-dummy_hcd.3-1/input0
usb 5-1: USB disconnect, device number 27
usb 5-1: new high-speed USB device number 28 using dummy_hcd
usb 5-1: config 0 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 5-1: New USB device found, idVendor=0926, idProduct=3333, bcdDevice= 0.40
usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 5-1: config 0 descriptor??
keytouch 0003:0926:3333.0084: fixing up Keytouch IEC report descriptor
input: HID 0926:3333 as /devices/platform/dummy_hcd.4/usb5/5-1/5-1:0.0/0003:0926:3333.0084/input/input136
keytouch 0003:0926:3333.0084: input,hidraw1: USB HID v0.00 Keyboard [HID 0926:3333] on usb-dummy_hcd.4-1/input0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
