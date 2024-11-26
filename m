Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0533FE4
	for <linux-serial@vger.kernel.org>; Tue, 26 Nov 2024 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732584868; cv=none; b=Ba6ICGvefjLEWZXcMo/+Xe5WOdkl1Pf1UUKO7ZkeeOCGyWNKi0EUzs2xfO0ZCUYCPF4AFnN9gP6LnUTXnMgNi2Gt/cXWfKt3hlTibDOGWzbk/rtkpvq3XYx/n4kPqs/cKyXabXHeGCRqecMqiBC0JHJYkvw0UiT14eU/biWbrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732584868; c=relaxed/simple;
	bh=i8ZdNYsGcN2jhiUF2j1jdxECtFzWd05VRbk6Y70AXBE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tTn9yltAgyVn8IIlK9Ijf7qIUsctT8JtzUPPYXNWQOzclUvv0YsYWRmJSpRmQIVNHC3/Ah70DxwwCUkYb+yhk2oL1kO0iywfQ+f5uMBhPXsRqpOa1M0xkDmmmCDbk7d1KmE+52JVyt4O0Ws9ZUOG4c+BG3pv44mHwJibRQc8tvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a777d47a8eso56981055ab.3
        for <linux-serial@vger.kernel.org>; Mon, 25 Nov 2024 17:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732584866; x=1733189666;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJpq7EPUbV8Mc9lwd/fQm9VBYWsCfgxUt2Ut614mEj4=;
        b=s1ngFQ+jaypkXLxfmX0SYJCPpqMOq621UTISXMG8NpDtFw4irgEaQ+OsVMXpcpkPGw
         fyINlN7y2SRzfGw2VsZAz752Jb8YiDe7BSRxJyGjFZWgyj+/W3nlqy3rF0qT+WZYLW7J
         BHdwS22omyh6v0r3EeyQXcnsaV3tiu7XaM/zpAnSG7Ymw6mGTtWN7dbBNmnCn8AiatDG
         iMlOqSgUDuxTJKviQV0yHda2ONXSBou4ExEN6QjxLwPS60bDEElCHKM8vC9JCzNRbDEE
         vRpvYOlaxgkibSXUiMqUWCDC0FYGoA2WB54t8Q0XZdJFKQQMCe8WnMBqyTqxPE0wSq2J
         66ww==
X-Forwarded-Encrypted: i=1; AJvYcCWmO3endDJ0JXkjATgSzruMk0qeJPEDhJBrjr3X8VvDAKscxEay1Q6mObUPB+HNIRV830u0TkDUMWrbsVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYRXtnACi/uPbhN8ACB72WdsEjBMko1mDMVZ1fXEyVomE90HL
	ucAttpA0YWLY94bUi5gWiSy1pGWowv8DmwDNelOrPiGta4NH3NXXlZqkplS2jgP08GondRZ2ARq
	HFPL7EQCnQ1PqhZuysjpIOzpEr+EGVvSqGPsVLsiIYM6o5as0MIIA9lI=
X-Google-Smtp-Source: AGHT+IEE4McgxBVVt6D6vzO88CSRBxrmvuSUUGDQkRz4mZ52+OK9dI7+HacDCt37ekQOaMIff5qqOPNwcbmTItIJXIa/HoatAs23
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3a7:95e4:a165 with SMTP id
 e9e14a558f8ab-3a79aceab1cmr158540975ab.2.1732584866083; Mon, 25 Nov 2024
 17:34:26 -0800 (PST)
Date: Mon, 25 Nov 2024 17:34:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674525a2.050a0220.1286eb.000b.GAE@google.com>
Subject: [syzbot] [serial?] INFO: task hung in console_callback (5)
From: syzbot <syzbot+1fb20cf68d15e7c2388d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a068f9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd768013789223fa
dashboard link: https://syzkaller.appspot.com/bug?extid=1fb20cf68d15e7c2388d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1499b23d099/disk-786c8248.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a2ccae57b0f3/vmlinux-786c8248.xz
kernel image: https://storage.googleapis.com/syzbot-assets/501a769c268d/bzImage-786c8248.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fb20cf68d15e7c2388d@syzkaller.appspotmail.com

INFO: task kworker/0:5:5161 blocked for more than 146 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:23680 pid:5161  tgid:5161  ppid:2      flags:0x00004000
Workqueue: events console_callback
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x343/0x7f0 kernel/locking/semaphore.c:246
 down+0x84/0xc0 kernel/locking/semaphore.c:63
 console_lock+0x145/0x1b0 kernel/printk/printk.c:2735
 console_callback+0x68/0x460 drivers/tty/vt/vt.c:3120
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/11:
3 locks held by kworker/u8:1/12:
1 lock held by khungtaskd/30:
 #0: ffffffff8e337660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e337660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e337660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
3 locks held by kworker/u8:2/35:
3 locks held by kworker/1:1/46:
3 locks held by kworker/u8:3/52:
3 locks held by kworker/u8:4/58:
3 locks held by kworker/u8:5/68:
4 locks held by kworker/0:2/922:
 #0: ffff888015079948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015079948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003b4fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003b4fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
 #3: ffff88801eb68768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
 #3: ffff88801eb68768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_leave_invalid_chans net/wireless/reg.c:2468 [inline]
 #3: ffff88801eb68768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_check_chans_work+0x164/0xfd0 net/wireless/reg.c:2483
2 locks held by kworker/0:3/925:
3 locks held by kworker/1:2/1106:
3 locks held by kworker/u8:7/2439:
3 locks held by kworker/u8:8/2461:
3 locks held by kworker/u8:9/2821:
2 locks held by getty/4851:
 #0: ffff88802a1050a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
2 locks held by kworker/0:5/5161:
 #0: ffff888015078948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015078948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90002f9fd00 (console_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90002f9fd00 (console_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
2 locks held by kworker/1:4/5162:
3 locks held by kworker/u8:10/5354:
3 locks held by kworker/u8:11/5355:
2 locks held by syz-executor/5752:
6 locks held by syz.2.322/6485:
1 lock held by syz.0.343/6548:
3 locks held by kworker/u8:12/6549:
1 lock held by syz-executor/6550:
2 locks held by kworker/u8:15/6555:
 #0: ffff888015081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90002d0fd00 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90002d0fd00 (connector_reaper_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
2 locks held by kworker/u8:16/6556:
 #0: ffff888015081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000468fd00 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000468fd00 ((reaper_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
3 locks held by kworker/u8:18/6562:
 #0: ffff888029a6b148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888029a6b148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000483fd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000483fd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f608748 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4734
2 locks held by kworker/u8:19/6565:
1 lock held by udevd/6568:
2 locks held by syz-executor/6569:
1 lock held by syz-executor/6571:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 925 Comm: kworker/0:3 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_power_efficient wg_ratelimiter_gc_entries
RIP: 0010:__lock_acquire+0xe9b/0x2040
Code: 81 e3 00 60 00 00 09 c3 4c 89 f0 48 c1 e8 20 29 c3 89 c1 c1 c1 04 31 d9 44 01 f0 41 29 ce 89 ca c1 c2 06 44 31 f2 01 c1 29 d0 <89> d6 c1 c6 08 31 c6 01 ca 29 f1 89 f3 c1 c3 10 31 cb 01 d6 29 da
RSP: 0018:ffffc90003bb78f0 EFLAGS: 00000093
RAX: 00000000e59244ab RBX: 00000000221d1659 RCX: 00000000b459bc7b
RDX: 00000000d295587c RSI: 0000000000000008 RDI: dffffc0000000000
RBP: ffff888020b12930 R08: ffffffff930028df R09: 1ffffffff260051b
R10: dffffc0000000000 R11: fffffbfff260051c R12: 0000000000000000
R13: ffff888020b128d8 R14: 00000000de128d43 R15: ffff888020b12950
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbf6f706000 CR3: 000000005543e000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 wg_ratelimiter_gc_entries+0x60/0x470 drivers/net/wireguard/ratelimiter.c:63
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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
