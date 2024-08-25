Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD94A2C
	for <linux-serial@vger.kernel.org>; Sun, 25 Aug 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724554752; cv=none; b=YZVArXFX+vp2oaU52DTJO+7sG+evHMftq+S8c+kt06kTpePeqf5uUNLg0YSxYBqpb8fkzkgv7z91O87E5WWLLKmm1fGiorEFpZWVBwH/bVFcr8/+UUyHzd4GVDiIVqMKL4SWD4IXXzvwozlt4yv5gQf3AJrrlJVpWAnQQQ/goaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724554752; c=relaxed/simple;
	bh=fZFpUStijfzfp8t+fLKfNFmYpBZ6unBu0C1PNq3NVKc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Cx6TVmlCBLps0Zw+9b6yXufjL9/J4YvaLI9AOUg+qJR9wJ88tLksKUKAaHA0P0+erxnZhi9XJCn0tCMFVbW0cF6myx4Ofsz7ZYo7DvRk7/ZDkY9V+4ZEqKyvp4cxwsm6dZI1ZJcxXlZxd2qIOvrF1+0Ni8MZqB44Qc/sRArdvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=XZtIZ8GY; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kbaZ9nZY; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XZtIZ8GY";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kbaZ9nZY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724554750; x=1756090750;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=fZFpUStijfzfp8t+fLKfNFmYpBZ6unBu0C1PNq3NVKc=;
  b=XZtIZ8GYqUdmGlONn1pxAJdKcZDn0hYHQSA+3rsw7B5b3FYnVrVvYKBs
   ErW9VZk83GWw+VZNVTxTaWmTjf2F2TshJipyMYNSAQbfrYdq88SWUfGsy
   71KqmWjG7vflS5aSAINE6U8R9MkBfu4GyvxI/UwLFluIJlrAbegZdX6zo
   erO1v9NpExvXVqV3q8IpJCBsNJjcFl1lNGYMVwu2Nt+4VLcKASb+3rmeM
   eO0zgH7J+hjDJBl2rrCaGuUCWUYkej7evwP0HDmnOjin2NrnXuzGM4Gsx
   C3+/yqO1FygfyNNnyoQwxXDYghcyRqHbRPp4JhK3apxb2VLsh0OdG7iex
   g==;
X-CSE-ConnectionGUID: 8JlzTBkLRnKW8kGvpVhknQ==
X-CSE-MsgGUID: aLeOiAqOT6eeKQ6zEe9nfw==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 19:59:09 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8252a16781eso342477539f.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Aug 2024 19:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724554748; x=1725159548; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uGG1b6EFOZjuanG9XBctddu6ZSqL4PxjrsDdukn+VgI=;
        b=kbaZ9nZYY2sc6nhKrzkEV5lSPALPLYchrRFqQwWF0XjGoTMAkPJTH9q6tOIlHLmwXc
         2zVxF0/NEGCI6qVlvX/iJ4WbVDQ0fa8m+sJQBeXtGzak01F8KqqnUEIytbEA6OB0osHv
         lkEtAezdmVgPWy/vFx4tYtkCm+Qa0TTgwzYQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724554748; x=1725159548;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGG1b6EFOZjuanG9XBctddu6ZSqL4PxjrsDdukn+VgI=;
        b=gGbsdAIhfrAf7oJNeU298O9JOMhw2vyfWtDORcf0pULUZ9OhbUgBQvm0faiHmy0TA5
         pwW5DsqCQZKak/2PbVEzMZaxGVC/cdIibykX0TqeaNSx/f4LMp1MCMttzQccfLXLjvmf
         zq6PVDSf8cXgfFlx/VqGuzHJWKfff35BmtocBiRTO8czKiJz15CBP5W31QQ+Al2dXrJq
         amL0MFoXNy6m1+6adZuR0lZ8LSpUyWxlN1yafmEGFxs+rCWK9UFqd2b+YnrhmPNSGPqd
         ajGCk7+lbfnsVG2OYxsApnM5lm2LLeN+BqA4Z04Fr00Az0mtbNAwXg5PHn0Zw86yvVK4
         sZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfjx8rSK9TGDYo1Jt1+0xlo4250WatGlesiJAQaSOWjHKpIIuD1CvCyuXj3Vz6orWN2pW5ImipZ5akyXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymqF7kNagDdc/vg0rhVw/gLU54YSMlRPtLLEOFNn8XIiZDhpS8
	ccjeX//w14Y4/IRj/rMpV08U6QVVxWFE2Zqf2CajoGff/+hxEdk35P7DdNrfFb4mC5Vbki+umXJ
	E/N2Ao3k9iLbe0/nlwb4rc9/zv8pjd5kH0tngttDeBq/M4Ska2O5Sl+as4mOWeO+GQPz7U2xJzG
	IRkxAd1FZe6fLCZtZqWorVzGt+42n2hLW9pravgw==
X-Received: by 2002:a05:6602:6210:b0:81f:75bf:6570 with SMTP id ca18e2360f4ac-8278731c917mr803362339f.5.1724554748122;
        Sat, 24 Aug 2024 19:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENZkR7DacYk8BBrWhezxNQh58licG6jHu2ICL/deecxmVsIPLL+c58Q5sYkIW5KhOoqaa9lXHcfbIudyWKS9E=
X-Received: by 2002:a05:6602:6210:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-8278731c917mr803361039f.5.1724554747701; Sat, 24 Aug 2024
 19:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 19:58:55 -0700
Message-ID: <CANikGpcFAw6DWr0b3c8_s5f+KaMCqUnVv-xvPEnA__OOGENUPQ@mail.gmail.com>
Subject: BUG: INFO: task hung in tty_buffer_flush
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `tty_buffer_flush`,  the task hangs when trying to acquire lock
`buf->lock`.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

INFO: task kworker/0:5:8495 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:24400 pid:8495  tgid:8495  ppid:2
   flags:0x00004000
Workqueue: events vc_SAK
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6897
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x69a/0xd50 kernel/locking/mutex.c:752
 tty_buffer_flush+0x75/0x3f0 drivers/tty/tty_buffer.c:229
 tty_ldisc_flush+0x66/0xc0 drivers/tty/tty_ldisc.c:388
 __do_SAK+0xc4/0x710 drivers/tty/tty_io.c:3038
 vc_SAK+0x73/0x210 drivers/tty/vt/vt_ioctl.c:993
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u4:27:17406 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:27   state:D stack:20472 pid:17406 tgid:17406 ppid:2
   flags:0x00004000
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_timeout+0xac/0x300 kernel/time/timer.c:2557
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x31c/0x510 kernel/locking/semaphore.c:246
 down+0x7e/0xb0 kernel/locking/semaphore.c:63
 console_lock+0x140/0x1a0 kernel/printk/printk.c:2665
 con_flush_chars+0x67/0x260 drivers/tty/vt/vt.c:3503
 __receive_buf drivers/tty/n_tty.c:1644 [inline]
 n_tty_receive_buf_common+0xd30/0x1370 drivers/tty/n_tty.c:1739
 tty_port_default_receive_buf+0x69/0x90 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x2ef/0x850 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.0.1346:24748 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1346      state:D stack:24680 pid:24748 tgid:24748
ppid:22281  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_timeout+0xac/0x300 kernel/time/timer.c:2557
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x31c/0x510 kernel/locking/semaphore.c:246
 down+0x7e/0xb0 kernel/locking/semaphore.c:63
 console_lock+0x140/0x1a0 kernel/printk/printk.c:2665
 con_shutdown+0x44/0x80 drivers/tty/vt/vt.c:3567
 release_tty+0xbf/0x560 drivers/tty/tty_io.c:1595
 tty_release_struct+0xb8/0xd0 drivers/tty/tty_io.c:1707
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
RIP: 0033:0x7faaf81809b9
RSP: 002b:00007ffd386bad68 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007faaf8347a80 RCX: 00007faaf81809b9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007faaf8347a80 R08: 0000000000000006 R09: 00007ffd386bb04f
R10: 00000000003ffc40 R11: 0000000000000246 R12: 000000000009e184
R13: 00007ffd386bae60 R14: 00007ffd386bae80 R15: ffffffffffffffff
 </TASK>
INFO: task syz.0.1346:24760 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1346      state:D stack:27400 pid:24760 tgid:24748
ppid:22281  flags:0x00004006
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
RIP: 0033:0x7faaf81809b9
RSP: 002b:00007faaf9013038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 00007faaf8346058 RCX: 00007faaf81809b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007faaf81f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faaf8346058 R15: 00007ffd386bac08
 </TASK>
INFO: task syz.1.1347:24771 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1347      state:D stack:24680 pid:24771 tgid:24771
ppid:19241  flags:0x00004004
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
RIP: 0033:0x7f80957809b9
RSP: 002b:00007fff493e0918 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f8095947a80 RCX: 00007f80957809b9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f8095947a80 R08: 0000000000000006 R09: 00007fff493e0bff
R10: 00000000003ffc0c R11: 0000000000000246 R12: 000000000009e315
R13: 00007fff493e0a10 R14: 00007fff493e0a30 R15: ffffffffffffffff
 </TASK>
INFO: task syz.1.1347:24776 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1347      state:D stack:27400 pid:24776 tgid:24771
ppid:19241  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_timeout+0xac/0x300 kernel/time/timer.c:2557
 ___down_common kernel/locking/semaphore.c:225 [inline]
 __down_common+0x31c/0x510 kernel/locking/semaphore.c:246
 down+0x7e/0xb0 kernel/locking/semaphore.c:63
 console_lock+0x140/0x1a0 kernel/printk/printk.c:2665
 do_con_write+0x150/0x4ca0 drivers/tty/vt/vt.c:3056
 con_write+0x22/0x40 drivers/tty/vt/vt.c:3434
 process_output_block drivers/tty/n_tty.c:574 [inline]
 n_tty_write+0xda5/0x12d0 drivers/tty/n_tty.c:2389
 iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
 file_tty_write+0x589/0xa00 drivers/tty/tty_io.c:1096
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x8a1/0xc70 fs/read_write.c:590
 ksys_write+0x19b/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f80957809b9
RSP: 002b:00007f80951ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8095946058 RCX: 00007f80957809b9
RDX: 000000000000fdef RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007f80957f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8095946058 R15: 00007fff493e07b8
 </TASK>
INFO: lockdep is turned off.
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
