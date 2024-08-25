Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6D3D62
	for <linux-serial@vger.kernel.org>; Sun, 25 Aug 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724556034; cv=none; b=Ue770zpQYBC0cSxVtyza7/QfJgliXc9kQGwpnmPojD/lyzoE8DfPYhHfPXZhb5ukIbU0AjRUB40FtuvKJQPZH7Xqq+qfNiY1hoO2Y+NJRFaBKQ2qQ9Xl4kW+2KlxMIpENv5oGPWlJnF5PzgvliaiEIHQUUQ4G+705XQ3w6NNHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724556034; c=relaxed/simple;
	bh=3yXmNUtk9CJvZ64wC1TNaci2t3TeCujWnpP1OhHR/FI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WLwo7flX418qj9mAJkU1xx+YZIyTdnLcc62CrolZ2sos+RhX/kthrMyrJmaPzfY97in19qFYUgeLgY8rAzKpKAGkLKcz87LPTi/zbT32GRcUdGfOcn/z9GSVxQUue1wIy42uyeooNErQtinXihGrn7Pouf124XSnEY7QswcZu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=QQFitWzj; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=tV/Mj+T4; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QQFitWzj";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tV/Mj+T4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724556031; x=1756092031;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=3yXmNUtk9CJvZ64wC1TNaci2t3TeCujWnpP1OhHR/FI=;
  b=QQFitWzj+/9ZLAQAZeQQQFTjwZHLjHsJgF/qwG9yDt+NGR0RO+ZlVBKg
   TnvPgg8y17t3RYTH3XsVwK6+XdlpE2aeC+ek3SmofMCZL+8ibZYAXl87J
   uNFVcL1AsM3CdUQgcbDdbneUh+shiFuQnwdJBykUPTBMOJYlUShbmykvq
   B+JUXzekSV559gokjJsqkfsHxlrzgFoyCF8IjJl/2/KHXwVv6dzAQVk2i
   sLBzus4VmM89EGe1aPk/++LAhHAiUQc3nJHduYNV5tto/gfyAv07NKgzY
   R7NloxePc7B47qunX8HQg9H06Ws4LS+V/N8ps1133NOYM8a+vxwfQeIwP
   w==;
X-CSE-ConnectionGUID: zsJkrMIET7O96Pt/1IdTTQ==
X-CSE-MsgGUID: W5gkI5EpTfKSU+5aOzogIA==
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 20:20:30 -0700
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso350979539f.2
        for <linux-serial@vger.kernel.org>; Sat, 24 Aug 2024 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724556030; x=1725160830; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgkgLLbGGEclDIItlhG/kAGqUPgJRxl4aj/Ejz+mD8c=;
        b=tV/Mj+T4DFPYf/dXanRKKkuRivNiWPygzzwb6rxZ25wbo1iDaPw2yB7QhEe4gOAlAh
         wxiI3w2iD4EfTLXwAPUqXbhM6YW5zmZ6tVnTDBA8fSHVJMZbrst+TnpL0n54btZIwuHh
         kF7RJQ/Y6BOb0dxelxG5Rjsc506fDXS81q7GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724556030; x=1725160830;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgkgLLbGGEclDIItlhG/kAGqUPgJRxl4aj/Ejz+mD8c=;
        b=BQ5zygfhZB8doF0aIDYZ1SXYyYHTzYrmzmP66kwHdgKY5XFl3VDlFOx1R1/FLM8KUX
         stklmQmPQ6T6KVpJy8gZ2K4+E1zxdMRFnxSgT2uA7k9oC5vukONgFhEkBSYVi9CTmI+c
         +F5sUfReJumS2w5Fyvn1e9yawqIef6MLZV+H2PJmT42EkC1MD2f8GvfN3v8DxUQSUoz8
         mxbAWtaDFnMUxft8154mnqG2hLYiLdgl7sVcj6ORTa+a4K/ETgDUXBDm8XPgjxCDhKuG
         EDwmbqB0hkibPQO0KTc12/Yz3Q8Vnl238j3UV1m67Tyyk45IjUAa37By9r2bsjq3szft
         3etA==
X-Forwarded-Encrypted: i=1; AJvYcCXEtvG2C42IFZGFpAOzpDRK62mQN48UTPdtvUZKTuRcyymiCwq09uQh4uuqp5hwSyo1SWx+GM0LFSfFH7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0qkxd7WpPY89Y8USMTPYoQPRGXzCVO5VKtSKxHYJLV0KEs8z
	H3LjWx5oR3OavoAjugQhMQTpklBCHJcH+q6gnR75vGfA/OxmN6B0kDBysekJb2TpSURcGMxxyys
	D9WICaYfVa2w0m+qkhL8gPekG7k8NXPXnUY98QB+/haxcI4OIV4C9JnF5AktDxGKTsE+lToK7yC
	VT2bBledaiMuoclGLVHX2G0nUF7mquMXNH9XmdzQ==
X-Received: by 2002:a05:6602:6d12:b0:827:87c4:363a with SMTP id ca18e2360f4ac-82787c437e9mr613261239f.7.1724556029849;
        Sat, 24 Aug 2024 20:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8XFtq8mM7uy97d/dMK/OkpaRE+9e3VojRNlgd8ODEGtnGVzjt6lI78W8dKmBwHoDII6mrJpEpw2v2n6z/ON4=
X-Received: by 2002:a05:6602:6d12:b0:827:87c4:363a with SMTP id
 ca18e2360f4ac-82787c437e9mr613259839f.7.1724556029435; Sat, 24 Aug 2024
 20:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 20:20:17 -0700
Message-ID: <CANikGpePfASOV5YnRf6tEUv2=aMTYxHkbXXG5NvJF=Vs0HtNuQ@mail.gmail.com>
Subject: BUG: INFO: task hung in tty_release_struct
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `tty_release_struct` the task hung when trying to acquire the lock
`tty_mutex`

Although Syzbot has found a similar bug
(https://syzkaller.appspot.com/bug?id=032fedbb29b936d9b3f5b03409cee10ad9caee9b)
, the bug we discovered can be triggered on Linux v6.10. Meanwhile,
Syzbot failed to trigger the crash for 617 days. Thus, it looks like
this is a new bug.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

INFO: task syz.0.5537:72598 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.5537      state:D stack:24680 pid:72598 tgid:72598
ppid:66970  flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6897
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x69a/0xd50 kernel/locking/mutex.c:752
 tty_release_struct+0xad/0xd0 drivers/tty/tty_io.c:1706
 tty_release+0xb66/0xd70 drivers/tty/tty_io.c:1867
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x239/0x2f0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x12d/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fd9a67809b9
RSP: 002b:00007ffecb0e3b18 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fd9a6947a80 RCX: 00007fd9a67809b9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fd9a6947a80 R08: 0000000000000006 R09: 00007ffecb0e3dff
R10: 00000000003ffcb0 R11: 0000000000000246 R12: 00000000002241f4
R13: 00007ffecb0e3c10 R14: 00007ffecb0e3c30 R15: ffffffffffffffff
 </TASK>
INFO: task syz.0.5537:72599 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.5537      state:D stack:26536 pid:72599 tgid:72598
ppid:66970  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6897
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x69a/0xd50 kernel/locking/mutex.c:752
 tty_release_struct+0xad/0xd0 drivers/tty/tty_io.c:1706
 tty_release+0xb66/0xd70 drivers/tty/tty_io.c:1867
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x239/0x2f0 kernel/task_work.c:180
 get_signal+0x15d5/0x1730 kernel/signal.c:2681
 arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fd9a67809b9
RSP: 002b:00007fd9a7605038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 000000000017c800 RBX: 00007fd9a6945f80 RCX: 00007fd9a67809b9
RDX: 00000000fffffde3 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007fd9a67f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd9a6945f80 R15: 00007ffecb0e39b8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x54/0x2d0 kernel/locking/lockdep.c:6614
1 lock held by in:imklog/7643:
2 locks held by agetty/38872:
 #0: ffff88801b0ac0a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffff88801b0ac130 (&tty->atomic_write_lock){+.+.}-{3:3}, at:
tty_write_lock drivers/tty/tty_io.c:954 [inline]
 #1: ffff88801b0ac130 (&tty->atomic_write_lock){+.+.}-{3:3}, at:
iterate_tty_write drivers/tty/tty_io.c:973 [inline]
 #1: ffff88801b0ac130 (&tty->atomic_write_lock){+.+.}-{3:3}, at:
file_tty_write+0x1e8/0xa00 drivers/tty/tty_io.c:1096
2 locks held by kworker/u4:22/60168:
2 locks held by kworker/u4:23/60169:
 #0: ffff888018d66948 ((wq_completion)iou_exit){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888018d66948 ((wq_completion)iou_exit){+.+.}-{0:0}, at:
process_scheduled_works+0x8fb/0x1410 kernel/workqueue.c:3329
 #1: ffffc9000971fd20
((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work
kernel/workqueue.c:3224 [inline]
 #1: ffffc9000971fd20
((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at:
process_scheduled_works+0x922/0x1410 kernel/workqueue.c:3329
2 locks held by kworker/u4:25/60173:
 #0: ffff888018d66948 ((wq_completion)iou_exit){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888018d66948 ((wq_completion)iou_exit){+.+.}-{0:0}, at:
process_scheduled_works+0x8fb/0x1410 kernel/workqueue.c:3329
 #1: ffffc9000973fd20
((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work
kernel/workqueue.c:3224 [inline]
 #1: ffffc9000973fd20
((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at:
process_scheduled_works+0x922/0x1410 kernel/workqueue.c:3329
1 lock held by syz.0.4591/61848:
1 lock held by syz.1.4603/61926:
2 locks held by agetty/63190:
 #0: ffff88803c8260a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90007a8b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
1 lock held by syz.1.4836/64293:
1 lock held by syz.1.5065/66967:
3 locks held by kworker/0:4/67207:
 #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff88801307a948 ((wq_completion)events){+.+.}-{0:0}, at:
process_scheduled_works+0x8fb/0x1410 kernel/workqueue.c:3329
 #1: ffffc90004b8fd20
((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at:
process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc90004b8fd20
((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at:
process_scheduled_works+0x922/0x1410 kernel/workqueue.c:3329
 #2: ffff88802f4a0240 (&data->fib_lock){+.+.}-{3:3}, at:
nsim_fib_event_work+0x2de/0x4050 drivers/net/netdevsim/fib.c:1489
2 locks held by syz.1.5398/70778:
2 locks held by syz.1.5488/71784:
1 lock held by syz.0.5537/72598:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_release_struct+0xad/0xd0 drivers/tty/tty_io.c:1706
1 lock held by syz.0.5537/72599:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_release_struct+0xad/0xd0 drivers/tty/tty_io.c:1706
4 locks held by syz.1.5536/72606:
1 lock held by syz.0.5541/73119:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.1.5542/73125:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5543/73605:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
ptmx_open+0xc7/0x2c0 drivers/tty/pty.c:823
1 lock held by syz.1.5544/73619:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5545/74100:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
ptmx_open+0xc7/0x2c0 drivers/tty/pty.c:823
1 lock held by syz.1.5547/74121:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
ptmx_open+0xc7/0x2c0 drivers/tty/pty.c:823
1 lock held by syz.1.5547/74122:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.1.5547/74123:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.1.5547/74124:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5551/74612:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5551/74617:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5551/74621:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5551/74625:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5551/74626:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at: tty_open_by_driver
drivers/tty/tty_io.c:2052 [inline]
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
tty_open+0x232/0xe20 drivers/tty/tty_io.c:2135
1 lock held by syz.0.5553/75389:
 #0: ffffffff8e2aa648 (tty_mutex){+.+.}-{3:3}, at:
ptmx_open+0xc7/0x2c0 drivers/tty/pty.c:823

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 25 Comm: khungtaskd Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x451/0x480 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x181/0x2d0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xdbd/0xe00 kernel/hung_task.c:379
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
