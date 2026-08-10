Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82F1E9B1A
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786321470; cv=none; b=PppXxO7NvqUDyTw5cHn7CJ7tSYyiFN1I+B21PZAY/kRvgKgzpMGxsYfxoY5mRVvsbCcs47T1yh6Aij5b7WOT6W++ob2t03sra68tlvvQjGgYGyd1iYA0gwCBM2+MHp9DAVq0VmcIuqofK2lYmnE3YK3YvFxKcPM6GEOP6BHgZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786321470; c=relaxed/simple;
	bh=MJihiC8nhDmzUdon/QfJIW5MayRSL05PND3vKShXBOw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P/jMRlNbhx2wD/rd3QwObefl1QJ2XSuGiKhg/NTmhHRcvsm2e1YLhAgvOOzZyHWwLZJx9/H/1Xcjvg9TBIE5xMQsq1wEHzJBBUOBr1drV4/YOQN3/RfHRoi87pKIFsdd5rfsULMwGmluM8SswMhwBmfBSHZTMop5JkrKxh/WZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6ae34317b7eso308653eaf.1
        for <linux-serial@vger.kernel.org>; Sun, 09 Aug 2026 17:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786321467; x=1786926267;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zBAPaX6K32lddLGBoQTPstIwiqPmSlrUv7rG4jADdx4=;
        b=SdYiswvkqVcWXkJcm1JHKq99U+vhn4WCe7cIBlfR4pN7igdQdnzDPRKzE46triXdZa
         5Qgxpkcf9z9Q0Fg2dX2jARt3AE9OnI76+peb62BLfPB3c99E1LfeWj5EkNM+BLm4SEvZ
         HigpBUmLJtURM1MkOeqqjA3HzGa17FZKGC/H2Z7Skrf6jUQKW9Iwx1qyL3GZ6U77nMwE
         1Q4+PCQ2UYCCsLXx+C3ZOY3YYeC1oTJwEo+FAp3C9Rpd68qBPJkj4AOqMBm4Fn5DbfX/
         BEzkSd9uqUKi5ObSWNb7ilHUW+7uIBdO2ay43CFC2jaSk9dp3kUQEX4X8NkVBUizloda
         JSMA==
X-Forwarded-Encrypted: i=1; AHgh+Rre1NVem28FpJPuSUh4H5BVoO47lJKMkHiq5GyCCAFtDEthx2GkrfjIOL/8c/iystZhYkAk0EGUC4Xt64A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfCPqLLtgL6FPcgpjstiad4FU2W5+4nzmZBMzmVItNdut+4uC
	7WYeTS3fz9+x0W27W1lTPKpvBQD9tNnkJo6DnXZgVheK0S6zzVEx3osArp8kCZivdo/HfjMcPgq
	z55xyHIdHem5fA7OcYP+oy1Hx5pAI4e/cvbBoFRMdlMt+Jpnt7zoe3v/d6cs=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e908:0:b0:6a3:d77e:725a with SMTP id
 006d021491bc7-6b04213b952mr8472137eaf.20.1786321467372; Sun, 09 Aug 2026
 17:24:27 -0700 (PDT)
Date: Sun, 09 Aug 2026 17:24:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a791a3b.9c11d2ce.289b96.00e4.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in n_tty_receive_buf_common (2)
From: syzbot <syzbot+087f6a513e0d60ee6ee4@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12785bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f221a1b5d497ed15
dashboard link: https://syzkaller.appspot.com/bug?extid=087f6a513e0d60ee6ee4
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31f94fe4d67f/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/391ba15cbf42/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+087f6a513e0d60ee6ee4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u33:3/62 is trying to acquire lock:
ffff88804b3fe2c8 (&tty->termios_rwsem){++++}-{4:4}, at: class_rwsem_read_constructor include/linux/rwsem.h:259 [inline]
ffff88804b3fe2c8 (&tty->termios_rwsem){++++}-{4:4}, at: n_tty_receive_buf_common+0x85/0x1930 drivers/tty/n_tty.c:1678

but task is already holding lock:
ffff88801404a8b8 (&buf->lock){+.+.}-{4:4}, at: flush_to_ldisc+0x34/0x730 drivers/tty/tty_buffer.c:474

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&buf->lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:236
       tty_ldisc_flush+0xd2/0xf0 drivers/tty/tty_ldisc.c:388
       __do_SAK+0x368/0x480 drivers/tty/tty_io.c:3025
       vc_SAK+0x7f/0x320 drivers/tty/vt/vt_ioctl.c:994
       process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (console_lock){+.+.}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       console_lock+0x7a/0xa0 kernel/printk/printk.c:2896
       uart_configure_port drivers/tty/serial/serial_core.c:2530 [inline]
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3101 [inline]
       serial_core_register_port+0xe65/0x16f0 drivers/tty/serial/serial_core.c:3322
       serial8250_register_8250_port+0x15af/0x2330 drivers/tty/serial/8250/8250_core.c:828
       serial_pnp_probe+0x436/0x930 drivers/tty/serial/8250/8250_pnp.c:480
       pnp_device_probe+0x2b3/0x4a0 drivers/pnp/driver.c:111
       call_driver_probe drivers/base/dd.c:628 [inline]
       really_probe+0x241/0xa60 drivers/base/dd.c:706
       __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
       driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
       __driver_attach+0x21f/0x5b0 drivers/base/dd.c:1292
       bus_for_each_dev+0x13e/0x1d0 drivers/base/bus.c:383
       bus_add_driver+0x305/0x5b0 drivers/base/bus.c:763
       driver_register+0x1e2/0x360 drivers/base/driver.c:174
       serial8250_init+0xcc/0x1c0 drivers/tty/serial/8250/8250_platform.c:317
       do_one_initcall+0x11d/0x700 init/main.c:1347
       do_initcall_level init/main.c:1409 [inline]
       do_initcalls init/main.c:1425 [inline]
       do_basic_setup init/main.c:1445 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1658
       kernel_init+0x1f/0x1e0 init/main.c:1548
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (&port->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       class_mutex_constructor include/linux/mutex.h:253 [inline]
       uart_set_termios+0x8e/0x690 drivers/tty/serial/serial_core.c:1645
       tty_set_termios+0x64d/0x980 drivers/tty/tty_ioctl.c:341
       set_termios+0x5c8/0x880 drivers/tty/tty_ioctl.c:516
       tty_mode_ioctl+0x17e/0xd40 drivers/tty/tty_ioctl.c:803
       n_tty_ioctl_helper+0x47/0x2b0 drivers/tty/tty_ioctl.c:982
       n_tty_ioctl+0x53/0x340 drivers/tty/n_tty.c:2496
       tty_ioctl+0x11b4/0x1640 drivers/tty/tty_io.c:2801
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x840 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&tty->termios_rwsem){++++}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       class_rwsem_read_constructor include/linux/rwsem.h:259 [inline]
       n_tty_receive_buf_common+0x85/0x1930 drivers/tty/n_tty.c:1678
       tty_ldisc_receive_buf+0xaa/0x1a0 drivers/tty/tty_buffer.c:394
       tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
       receive_buf drivers/tty/tty_buffer.c:452 [inline]
       flush_to_ldisc+0x26b/0x730 drivers/tty/tty_buffer.c:502
       process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
       process_scheduled_works kernel/workqueue.c:3405 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &tty->termios_rwsem --> console_lock --> &buf->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&buf->lock);
                               lock(console_lock);
                               lock(&buf->lock);
  rlock(&tty->termios_rwsem);

 *** DEADLOCK ***

4 locks held by kworker/u33:3/62:
 #0: ffff88801bce4140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x12b1/0x1940 kernel/workqueue.c:3297
 #1: ffffc900009efd08 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_one_work+0x988/0x1940 kernel/workqueue.c:3298
 #2: ffff88801404a8b8 (&buf->lock){+.+.}-{4:4}, at: flush_to_ldisc+0x34/0x730 drivers/tty/tty_buffer.c:474
 #3: ffff88804b3fe0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x21/0x90 drivers/tty/tty_ldisc.c:263

stack backtrace:
CPU: 0 UID: 0 PID: 62 Comm: kworker/u33:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
 class_rwsem_read_constructor include/linux/rwsem.h:259 [inline]
 n_tty_receive_buf_common+0x85/0x1930 drivers/tty/n_tty.c:1678
 tty_ldisc_receive_buf+0xaa/0x1a0 drivers/tty/tty_buffer.c:394
 tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:452 [inline]
 flush_to_ldisc+0x26b/0x730 drivers/tty/tty_buffer.c:502
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
