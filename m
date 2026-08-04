Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27A247280
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802177; cv=none; b=I+TJzwsTcVJb5/hLSxHxWGNKi8es5P3pURu6/cpH3zFCFFSbE0bocmR8Hxdi2bEpINTx4YpqkRlXXhY4n7XNYgU0krUZ4Z/5ZV3tpa88pVAkoSF83ny1EsBY4ANWqh58GJ7Gu/NbgisbrAdeSEJ2xc87xbeZYPN4HYFdUxstkBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802177; c=relaxed/simple;
	bh=OAJXogA/NTVll2Bh4BXvweQXRrLbn3CTZ3vWWSGTgLs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MTESGpV4crydz08geFDEM8vkVCJMklVlkiRee6vKowgglrZ+sAeyG6v4iO67GEaDFF5z9Sr9/0IqX3AQS5XCbWLREv9GrQfA5mSMRW69jQrRKnqnV/rwzvkvgULBrW4cWrUXIAak/v2W0Lk5Nq/1ZwopkbdxNGvnH6qCwRwPVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4ab4af22d09so5488122b6e.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Aug 2026 17:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785802174; x=1786406974;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRZtTcSwO+GYpwnkW+BJAr2OICZ/jU1w/iJTGig4zqc=;
        b=ej/O+FnSr+iYslwKtaKB3ZCcora3CrBD1pXQ0+x2KFhHAM8VQzf21CQSiKaNUrS2lJ
         ll4+q99qH5MmbkzJoEl/qrnVe2UAm6YtSJW6mEg9KVM+C+dIMEPuZDt0tvl2nzglPjpB
         mLZdI67P/fE7+YbGL+9v1XxoJXeAhK56JyDqKTJeQtrnyS/yKqgUIqfmp99iuTB1id0L
         lGCYbquA9rM3YkcQ3mekwBxwYuaAaHwT7iidZdpvvDmuatfSRNkklVRkfWRpQ2SVjqtG
         ZrqtQg7aSTtIPYVZcjYl+6oWxEgObtlzHvZH6r88Xh/BGcEOEvNO7astX52i4R8gcOoq
         /hXg==
X-Forwarded-Encrypted: i=1; AHgh+RpzMUytAWUNGBxp5/jppDVu5FA7GJrPV2EDnqqvlpPJhgZTW7sYzORPtaC5gqVXFEEyppmhKoL2ojRnDyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRTQC7edXzKZfdekkGkGvTPTLg6Yw95b3YfEw1PGi77CwnRZd
	qglpNjJnfW7BYa9rKloaCT7dORc+OJQFbHKm+xKPTASvipLFPuSXAwtWWBIZ+OWW0xMCcD+5VRI
	PneoKWqXykSD+TN+5fHKW+KAyT4I4MV8HiGOWg3e5o9q2DRlbfmowgwLHA3k=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6808:b0:4a4:ade8:a287 with SMTP id
 5614622812f47-4af5e1f02a2mr18224805b6e.13.1785802174207; Mon, 03 Aug 2026
 17:09:34 -0700 (PDT)
Date: Mon, 03 Aug 2026 17:09:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a712dbe.9511d2ce.1fc5b9.032b.GAE@google.com>
Subject: [syzbot] [serial?] INFO: task hung in tty_release_struct (8)
From: syzbot <syzbot+02452abfa3790d12a1a1@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110225b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=02452abfa3790d12a1a1
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f16cbd41159/disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/db871e136723/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ea04d1772cc/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02452abfa3790d12a1a1@syzkaller.appspotmail.com

INFO: task syz.0.691:10235 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.691       state:D stack:25640 pid:10235 tgid:10235 ppid:9867   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 tty_release_struct+0xae/0xd0 drivers/tty/tty_io.c:1691
 tty_release+0xc62/0x1670 drivers/tty/tty_io.c:1852
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1fa/0x730 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a4919df99
RSP: 002b:00007fffc75ea538 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f8a49427da0 RCX: 00007f8a4919df99
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f8a49427da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007f8a49427cb0 R11: 0000000000000246 R12: 000000000006994d
R13: 00007f8a49425fac R14: 00000000000696cf R15: 00007f8a49425fa0
 </TASK>
INFO: task syz.0.691:10238 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.691       state:D stack:27568 pid:10238 tgid:10235 ppid:9867   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 ___down_common kernel/locking/semaphore.c:293 [inline]
 __down_common+0x3b7/0x850 kernel/locking/semaphore.c:318
 down+0x80/0xd0 kernel/locking/semaphore.c:100
 console_lock+0x58/0x90 kernel/printk/printk.c:2896
 class_console_lock_constructor include/linux/console.h:734 [inline]
 con_install+0x97/0x770 drivers/tty/vt/vt.c:3743
 tty_driver_install_tty drivers/tty/tty_io.c:1295 [inline]
 tty_init_dev+0xd7/0x4d0 drivers/tty/tty_io.c:1407
 tty_open_by_driver drivers/tty/tty_io.c:2073 [inline]
 tty_open+0x7d9/0xcc0 drivers/tty/tty_io.c:2120
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:947
 vfs_open+0x3b/0x340 fs/open.c:1052
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2e44/0x3830 fs/namei.c:4863
 do_file_open+0x23e/0x4a0 fs/namei.c:4892
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a4915e7ce
RSP: 002b:00007f8a4a12fb28 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f8a4a1306c0 RCX: 00007f8a4915e7ce
RDX: 0000000000000002 RSI: 00007f8a4a12fc00 RDI: ffffffffffffff9c
RBP: 00007f8a49234ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8a49426128 R14: 00007f8a49426090 R15: 00007fffc75ea3d8
 </TASK>
INFO: task syz.5.696:10272 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.696       state:D stack:28336 pid:10272 tgid:10270 ppid:9376   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 tty_open_by_driver drivers/tty/tty_io.c:2037 [inline]
 tty_open+0x204/0xcc0 drivers/tty/tty_io.c:2120
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:947
 vfs_open+0x3b/0x340 fs/open.c:1052
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2e44/0x3830 fs/namei.c:4863
 do_file_open+0x23e/0x4a0 fs/namei.c:4892
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc316d5e7ce
RSP: 002b:00007fc317c22b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc317c236c0 RCX: 00007fc316d5e7ce
RDX: 0000000000000002 RSI: 00007fc317c22c00 RDI: ffffffffffffff9c
RBP: 00007fc316e34ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc317026038 R14: 00007fc317025fa0 R15: 00007fff2e470178
 </TASK>
INFO: task syz.5.696:10273 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.696       state:D stack:28424 pid:10273 tgid:10270 ppid:9376   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 tty_open_by_driver drivers/tty/tty_io.c:2037 [inline]
 tty_open+0x204/0xcc0 drivers/tty/tty_io.c:2120
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:947
 vfs_open+0x3b/0x340 fs/open.c:1052
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2e44/0x3830 fs/namei.c:4863
 do_file_open+0x23e/0x4a0 fs/namei.c:4892
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc316d5e7ce
RSP: 002b:00007fc317c01b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc317c026c0 RCX: 00007fc316d5e7ce
RDX: 0000000000000002 RSI: 00007fc317c01c00 RDI: ffffffffffffff9c
RBP: 00007fc316e34ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc317026128 R14: 00007fc317026090 R15: 00007fff2e470178
 </TASK>
INFO: task syz.8.710:10350 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.8.710       state:D stack:28304 pid:10350 tgid:10329 ppid:8064   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7383
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 tty_open_by_driver drivers/tty/tty_io.c:2037 [inline]
 tty_open+0x204/0xcc0 drivers/tty/tty_io.c:2120
 chrdev_open+0x4d9/0x600 fs/char_dev.c:411
 do_dentry_open+0x816/0x1380 fs/open.c:947
 vfs_open+0x3b/0x340 fs/open.c:1052
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2e44/0x3830 fs/namei.c:4863
 do_file_open+0x23e/0x4a0 fs/namei.c:4892
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f081099df99
RSP: 002b:00007f080e3f2028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0810c26360 RCX: 00007f081099df99
RDX: 0000000000000002 RSI: 0000200000000400 RDI: ffffffffffffff9c
RBP: 00007f0810a34ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0810c263f8 R14: 00007f0810c26360 R15: 00007ffdfed09868
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/32:
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5370:
 #0: ffff8880364ff0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
2 locks held by kworker/u8:8/5687:
 #0: ffff88801b064140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801b064140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc9000416fc40 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc9000416fc40 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
4 locks held by kworker/u8:9/5823:
 #0: ffff88801c28e140 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #0: ffff88801c28e140 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #1: ffffc90003cefc40 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3297 [inline]
 #1: ffffc90003cefc40 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0xa20/0x14e0 kernel/workqueue.c:3405
 #2: ffffffff9001ed08 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf5/0x810 net/core/net_namespace.c:673
 #3: ffffffff8fd7d9e8 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_exit_net+0x8f/0x340 drivers/infiniband/core/device.c:1133
4 locks held by kworker/0:9/6535:
1 lock held by syz.0.691/10235:
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_release_struct+0xae/0xd0 drivers/tty/tty_io.c:1691
2 locks held by syz.0.691/10238:
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open_by_driver drivers/tty/tty_io.c:2037 [inline]
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open+0x204/0xcc0 drivers/tty/tty_io.c:2120
 #1: ffff888059a291b0 (&tty->legacy_mutex){+.+.}-{4:4}, at: tty_init_dev+0x74/0x4d0 drivers/tty/tty_io.c:1406
1 lock held by syz.5.696/10272:
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open_by_driver drivers/tty/tty_io.c:2037 [inline]
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open+0x204/0xcc0 drivers/tty/tty_io.c:2120
1 lock held by syz.5.696/10273:
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open_by_driver drivers/tty/tty_io.c:2037 [inline]
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open+0x204/0xcc0 drivers/tty/tty_io.c:2120
1 lock held by syz.8.710/10350:
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open_by_driver drivers/tty/tty_io.c:2037 [inline]
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: tty_open+0x204/0xcc0 drivers/tty/tty_io.c:2120
1 lock held by syz.2.743/11017:
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffffffff8f458680 (tty_mutex){+.+.}-{4:4}, at: ptmx_open+0xdc/0x2e0 drivers/tty/pty.c:800
5 locks held by syz.3.889/11938:
3 locks held by syz-executor/12067:
 #0: ffffffff9001ed08 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4e2/0x720 net/core/net_namespace.c:575
 #1: ffffffff8fd7d828 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x200/0x2f0 drivers/infiniband/core/device.c:1189
 #2: ffffffff8fd7d9e8 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x238/0x2f0 drivers/infiniband/core/device.c:1194
3 locks held by syz-executor/12081:
 #0: ffffffff9001ed08 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4e2/0x720 net/core/net_namespace.c:575
 #1: ffffffff8fd7d828 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x200/0x2f0 drivers/infiniband/core/device.c:1189
 #2: ffffffff8fd7d9e8 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x238/0x2f0 drivers/infiniband/core/device.c:1194
3 locks held by syz-executor/12143:
 #0: ffffffff9001ed08 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x4e2/0x720 net/core/net_namespace.c:575
 #1: ffffffff8fd7d828 (devices_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x200/0x2f0 drivers/infiniband/core/device.c:1189
 #2: ffffffff8fd7d9e8 (rdma_nets_rwsem){++++}-{4:4}, at: rdma_dev_init_net+0x238/0x2f0 drivers/infiniband/core/device.c:1194
2 locks held by syz.0.922/12195:
1 lock held by sed/12233:
2 locks held by modprobe/12235:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:122
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:65
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
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
