Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA523B3BF2
	for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136389; cv=pass; b=PAxZj/V9qcnzgiePPfNAZGMUjXR4gr6rr9JakXS5bDOYWJwxs4u7lzrbGPN1fg99/jYF054TpKEKJbIdYEAI9Xv6NxX6wvfAStEVm0jTkVi/jchd8RxlPqSNb8z1dGLasuFFPjHjUy0pH4lTj/rwu7AZiTI+RjuJQhKSv2mP6kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136389; c=relaxed/simple;
	bh=jsvAt8gg309BQVZG4qwEEuEtU3T+usRJWUFr2tmjZrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCJabIrr1GaGjyYqTuefgqgH9PhFCZq7FvneQALK7PFdxTFCLteYotQOYbG4enF/VlQ0bNO0Sub3TNS7ymQwGr6xu5Y/yPYC+0Ps8NMO7+ZSQz8H24iLa4s1s7EageMCYgGXZW4smHf0kuPLcYJEmbGtP+UN2+roybaP1ZVi5Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKWdVoKX; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKWdVoKX"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8dea42b547eso49646396d6.1
        for <linux-serial@vger.kernel.org>; Mon, 22 Jun 2026 06:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782136387; cv=none;
        d=google.com; s=arc-20240605;
        b=AoqYqc0qoiM/yGJHkcfE7yMrvlRAgpU9Fo0lk1GCnoi22MlG/+QodlxdtoE5xWWeUy
         c1tfj4fP4TQAa0vCsVSgwfjovhne0z2h/Nq9Do0xAv4ZTaVtskhlvcUqxPoyR4EF13Kw
         51VmqYX0mt/FywiIbrbW27VEf2hbeitAbLNrBL/W9RfgrURsPbL67EBtXjAj9b2due5N
         MMteM2LV8qYgwu+nBgXU6mwxOSJKKJgNe31RlTnvVVvBpRNamxbvNmqMp5G3cAs0R8+J
         wdihJllBPG99rSpopshVftBx8mstWaAB7jdJSrTn1h1eIeg7pOjcc0T3KHKoyhwCZbBK
         LefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f1rJw0214nmdb473mMKyusfHfXseFnp+sYTuDw5eOm8=;
        fh=QyAamMv8TmirmGp4HCx41IRAUVkmB+FttWaxvk2xS0k=;
        b=WZD4oHfKD8On71qDU1VUsGz/fapTQ4FJG0A34vNh/RLyZ+Dd/96Jc24IbJuqoS3Vav
         xUF6DkcjTBLnhihQ+2vDAonA0g9M44xskCv+s3c18ZWgjAUP6XyBSPjlNPRaoXH8xoyF
         JaM81Bqgndsy5Li0gxn6vz1+ObbJNNqt7HL8RobgaDNid7aWA5sym/JVpsqYN8pxc2rM
         3lnvsYf9DFoJ93D/qc2jfAnefjs5a77unlBxYWHqyflv4NkCo4KoF/uxnhgKRWVn2qXa
         RJqmL1hyvdVt+nnsYbOTWPl6vx1TrDYK++6o2Af6uVSFKl6mj0z2z4KOBZIQB06fjiLe
         UZqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136387; x=1782741187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1rJw0214nmdb473mMKyusfHfXseFnp+sYTuDw5eOm8=;
        b=lKWdVoKXRZYuLSwHoe4vftuLfai1ltro2zsKOH4Jlp2vzesy8h0vnejVwRe/BuupaH
         49WNx8whVpj9kTUvVCVBpsB50paiJXJHBhWtWIlUuukcPlL8iEJfVDGdh5yH/OfOdcv3
         F7DRKFrfOjAQMYqR3U9OiTyoxqk+oHTSMzaEZWU6JfYuunUmsAbbwEGNpP3/t7rSnkiF
         LV7fl7SxF0minMVxFnsieP3sSTR1SFw/u1p3vmGc+mRkW30XQX6fiIfUtjwKfnVyGCTK
         x3S7JQqZIUi/PbbwqVAdvWL3Nz3XnDwLWFVe2xSaF+Qkx80kDzJbhvR1ASvIB+t/BsSr
         jszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136387; x=1782741187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1rJw0214nmdb473mMKyusfHfXseFnp+sYTuDw5eOm8=;
        b=TQvJ+nkYerlLw1T2iQ+Zc86amfMCDTQv5SymVWICXUpKsbTag7ev7036XUx2zbtzF4
         bVsh9hCjk49hwwtgSrcAAldDfSnTnYqdUAwxd51QWOtxgYn9Gz4HThWw03aZF40ZtZO0
         JEJTYPdoZDwHg744mrDk84gYSyav0gWFs+XYxU7DtOkkMipHZzFxvy6ccM+LT5pZesGu
         FtTG/GxfRFwvLAJMgXLleGd6D6sJoK9l+0Y4sho6JET7X9jOwKlZXyUBY0nJn4lD6uqT
         W+YaquasdQaKu6Hook+ZwWhR8inCjF5T+VArfoCmtYPCgTrB+IxuLhATr5ngaY62tx2T
         vjAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqq5uNUkbraMjdFBhbys4NQ5MS7OfSZmePVoAJRQhQo/p00IHJuzUyAgZkG+XEM2SGjTFf/+6Qnc5su7sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7xJtnDEphVnbyl6GzIFvkYceBsusw38wiQm0UMPqxOzO81VG
	2HXyhCe/mXJ1fzIDzRtVD/bW2HsWqqZwHHoAeVSvub4wx73jizQ87x6i/G1Fab8G0x5dGYuPyM1
	CYIqV99vAJd+QZ5kB8t3EI1lR/Fwayj1xYi4EWbQ=
X-Gm-Gg: AfdE7cm2wfMiHc1frZSUE/TPWet/uMaTe5nlwhVQlGKHh+PC94tcs9kHlrXCucPlE11
	wdRFzxu7H3Hftj9LzWUXMGvdiNpwQOw/u/fK6NQ9FwSVHALlBgLVwYFVZ46LS3108YUKGtxq/ea
	u1ZCV9bsBRFqXuFO2YULThycbcB1vR0XdtieKoXnib3C5HH+9DpHIm4HAy+YagLPeBLEVuTYImd
	OoayW7/sJKQnhkNnZ+0YTaIAEBoWeDNnHAfo7s1f14Ph7t/eQoLdEBB5aQWHxbJMQFFtzuwHw==
X-Received: by 2002:a0c:ef0f:0:b0:8cc:d501:532f with SMTP id
 6a1803df08f44-8de3ecd8fd9mr161107896d6.7.1782136386524; Mon, 22 Jun 2026
 06:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmzFQPFCom1Ng-FhbeRm=maLsKW1T4ZasGm40OkrxJfuwg@mail.gmail.com>
 <2026060919-unchanged-raking-9225@gregkh>
In-Reply-To: <2026060919-unchanged-raking-9225@gregkh>
From: Longxing Li <coregee2000@gmail.com>
Date: Mon, 22 Jun 2026 21:53:02 +0800
X-Gm-Features: AVVi8CcRicAgpHvL1ojP5MFw7HssvegNU_SJ8dSSJkMnpc0u1JXxSWNXx2JdY5o
Message-ID: <CAHPqNmztcnHLLEV0v8JK1zspgWqaveaTpDtEMh8ehuv-3hZPqA@mail.gmail.com>
Subject: Re: [Kernel Bug] INFO: task hung in show_cons_active
To: Greg KH <gregkh@linuxfoundation.org>
Cc: syzkaller@googlegroups.com, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux kernel developers and maintainers,

Thank you for the feedback. I've added some analysis on this bug, and
also added the original report, which is at the bottom of this email.

Analysis Summary:

The hang involves two tasks blocking on console_sem while holding
console_mutex, and a third task path (unregister_console) that
acquires console_mutex and then blocks on console_sem via
__pr_flush(). The core problem is a lock inversion: __pr_flush()
blocks on console_sem while holding console_list_lock (->
console_mutex).

This can lead to a deadlock when any code path holds console_sem and
subsequently needs console_mutex.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Lock Chain Analysis

Three locks are involved in this deadlock scenario:

1. console_mutex (acquired via console_list_lock())
   - Protects the console_list linked list
   - Used in show_cons_active and unregister_console paths

2. console_sem (binary semaphore)
   - Ensures exclusive console output access
   - Acquired via console_lock() -> down(&console_sem)

3. tty->termios_rwsem
   - Already held by flush_to_ldisc's receive_buf path


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Task 1 (systemd/1) - currently blocked

show_cons_active() [drivers/tty/tty_io.c:3533]
  console_list_lock()         [-> mutex_lock(&console_mutex)] [HELD]
  ...
  console_lock()              [-> down(&console_sem)]         [BLOCKING]

Location: drivers/tty/tty_io.c:3547, 3566


Task 2 (kworker/u4:4/68) - currently blocked

flush_to_ldisc() [drivers/tty/tty_buffer.c:462]
  tty->termios_rwsem                  [HELD]
  tty->ldisc_sem                      [HELD]
  con_flush_chars() [drivers/tty/vt/vt.c:3646]
    guard(console_lock)() [-> console_lock() -> down(&console_sem)] [BLOCKI=
NG]

Location: drivers/tty/vt/vt.c:3653


Critical Path - unregister_console() [trigger point]

register_console() [kernel/printk/printk.c:4060]
  console_list_lock()
  ...
  console_sysfs_notify()              [called while holding console_list_lo=
ck]
  unregister_console() [kernel/printk/printk.c:4325]
    console_list_lock()               [-> mutex_lock(&console_mutex)]
    unregister_console_locked() [line 4228]
      __pr_flush(console, 1000, true) [kernel/printk/printk.c:4469]
[BLOCKING CALL]

The __pr_flush() function internally (printk.c:4517):
  console_lock()       [-> down(&console_sem)] [BLOCKS!]

This is the key issue: __pr_flush() BLOCKS on console_sem while called from
within a context that holds console_list_lock (which IS console_mutex).


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The Problem

unregister_console_locked() calls __pr_flush() while holding console_mutex/
console_list_lock. Inside __pr_flush(), console_lock() will block waiting f=
or
console_sem.

Deadlock condition (ABBA):
  A =3D console_mutex (console_list_lock)
  B =3D console_sem

  Path A (show_cons_active):   holds A, waits for B
  Path B (flush_to_ldisc):     holds C, waits for B  [C =3D
termios_rwsem, ldisc_sem]
  Path T (some console write): holds B, needs A       [if this path exists]

The kernel itself acknowledges this risk in console_unblank()
(printk.c:3458-3461):

  /*
   * Attempting to trylock the console lock can deadlock
   * if another CPU was stopped while modifying the
   * semaphore. "Hope and pray" that this is not the
   * current situation.
   */


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
__pr_flush() performs a blocking console_lock() (via console_lock() ->
down(&console_sem)) while its caller (unregister_console_locked) holds
console_list_lock (which is console_mutex).

This is a lock ordering violation: if any code path holds console_sem and t=
hen
needs console_mutex, we have a deadlock. The syzkaller test conditions crea=
te
exactly the extreme timing needed to trigger this scenario.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Suggested Fix

1. Move __pr_flush() outside the console_list_lock critical section:
   In unregister_console(), perform the flush BEFORE acquiring
console_list_lock(),
   with appropriate changes to prevent console re-registration during the w=
ait.

2. Use console_trylock() with retry in __prflush() when called from a conte=
xt
   that already holds console_list_lock (similar to the console_unblank app=
roach
   for oops_in_progress).

3. Two-phase __pr_flush():
   (a) Release console_list_lock
   (b) Wait for console_lock
   (c) Re-acquire console_list_lock only when safe

4. Consider whether unregister_console_locked() really needs to call
__pr_flush()
   while continuing to hold the list lock - the flush could arguably
be done after
   dropping the list lock with careful ordering.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Report:

INFO: task systemd:1 blocked for more than 143 seconds.
      Not tainted 7.0.6 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd         state:D stack:21448 pid:1     tgid:1     ppid:0
   task_flags:0x400100 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7008
 schedule_timeout+0x245/0x280 kernel/time/sleep_timeout.c:75
 ___down_common kernel/locking/semaphore.c:268 [inline]
 __down_common+0x353/0x780 kernel/locking/semaphore.c:293
 down+0x74/0xa0 kernel/locking/semaphore.c:100
 console_lock+0x5b/0xa0 kernel/printk/printk.c:2896
 show_cons_active+0x1f5/0x6e0 drivers/tty/tty_io.c:3566
 dev_attr_show+0x56/0xe0 drivers/base/core.c:2421
 sysfs_kf_seq_show+0x1f5/0x400 fs/sysfs/file.c:65
 seq_read_iter+0x516/0x12e0 fs/seq_file.c:231
 kernfs_fop_read_iter+0x46d/0x620 fs/kernfs/file.c:297
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x865/0xc70 fs/read_write.c:574
 ksys_read+0x121/0x240 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efece3174ac
RSP: 002b:00007ffe0fbc9010 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055850dc62190 RCX: 00007efece3174ac
RDX: 0000000000001000 RSI: 000055850de46180 RDI: 000000000000000d
RBP: 00007efece3f7480 R08: 0000000000000000 R09: 00007efece3fabe0
R10: 0000000000000010 R11: 0000000000000246 R12: 00007efecdec06c8
R13: 00007efece3f6880 R14: 0000000000000d68 R15: 0000000000000d68
 </TASK>
INFO: task kworker/u4:4:68 blocked for more than 143 seconds.
      Not tainted 7.0.6 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:4    state:D stack:23976 pid:68    tgid:68    ppid:2
   task_flags:0x4208060 flags:0x00080000
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7008
 schedule_timeout+0x245/0x280 kernel/time/sleep_timeout.c:75
 ___down_common kernel/locking/semaphore.c:268 [inline]
 __down_common+0x353/0x780 kernel/locking/semaphore.c:293
 down+0x74/0xa0 kernel/locking/semaphore.c:100
 console_lock+0x5b/0xa0 kernel/printk/printk.c:2896
 class_console_lock_constructor include/linux/console.h:736 [inline]
 con_flush_chars+0x5e/0x80 drivers/tty/vt/vt.c:3653
 __receive_buf drivers/tty/n_tty.c:1620 [inline]
 n_tty_receive_buf_common+0x535/0x1770 drivers/tty/n_tty.c:1715
 tty_ldisc_receive_buf+0xa3/0x1b0 drivers/tty/tty_buffer.c:387
 tty_port_default_receive_buf+0x72/0xa0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x227/0x6c0 drivers/tty/tty_buffer.c:495
 process_one_work+0x9de/0x1c60 kernel/workqueue.c:3288
 process_scheduled_works kernel/workqueue.c:3371 [inline]
 worker_thread+0x693/0xeb0 kernel/workqueue.c:3452
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
4 locks held by systemd/1:
 #0: ffff8880207b62f0 (&p->lock){+.+.}-{4:4}, at:
seq_read_iter+0xe7/0x12e0 fs/seq_file.c:183
 #1: ffff888052332c88 (&of->mutex){+.+.}-{4:4}, at:
kernfs_seq_start+0x4f/0x2a0 fs/kernfs/file.c:172
 #2: ffff88801e8750f8 (kn->active){.+.+}-{0:0}, at:
kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff88801e8750f8 (kn->active){.+.+}-{0:0}, at:
kernfs_seq_start+0xbc/0x2a0 fs/kernfs/file.c:173
 #3: ffffffff8e5d3548 (console_mutex){+.+.}-{4:4}, at:
show_cons_active+0x80/0x6e0 drivers/tty/tty_io.c:3547
4 locks held by kworker/0:0/9:
1 lock held by khungtaskd/25:
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
5 locks held by kworker/u4:4/68:
 #0: ffff88801b894148 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
process_one_work+0x139e/0x1c60 kernel/workqueue.c:3263
 #1: ffffc90000bf7d08 ((work_completion)(&buf->work)){+.+.}-{0:0}, at:
process_one_work+0x938/0x1c60 kernel/workqueue.c:3264
 #2: ffff8880126cc0b8 (&buf->lock){+.+.}-{4:4}, at:
flush_to_ldisc+0x3a/0x6c0 drivers/tty/tty_buffer.c:467
 #3: ffff888000b7f0a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref+0x21/0x90 drivers/tty/tty_ldisc.c:263
 #4: ffff888000b7f2e8 (&tty->termios_rwsem){++++}-{4:4}, at:
class_rwsem_read_constructor include/linux/rwsem.h:259 [inline]
 #4: ffff888000b7f2e8 (&tty->termios_rwsem){++++}-{4:4}, at:
n_tty_receive_buf_common+0x8c/0x1770 drivers/tty/n_tty.c:1678
1 lock held by in:imklog/9029:
 #0: ffff88804fc6b7f8 (&f->f_pos_lock){+.+.}-{4:4}, at:
fdget_pos+0x2a0/0x370 fs/file.c:1261
5 locks held by kworker/0:4/9728:
 #0: ffff88801d361d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x139e/0x1c60 kernel/workqueue.c:3263
 #1: ffffc9000d08fd08 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: process_one_work+0x938/0x1c60 kernel/workqueue.c:3264
 #2: ffff8880224de1e0 (&dev->mutex){....}-{4:4}, at: device_lock
include/linux/device.h:994 [inline]
 #2: ffff8880224de1e0 (&dev->mutex){....}-{4:4}, at:
hub_event+0x1af/0x5020 drivers/usb/core/hub.c:5899
 #3: ffff8880527841e0 (&dev->mutex){....}-{4:4}, at: device_lock
include/linux/device.h:994 [inline]
 #3: ffff8880527841e0 (&dev->mutex){....}-{4:4}, at:
__device_attach+0x7d/0x4f0 drivers/base/dd.c:1088
 #4: ffff88804d6791a8 (&dev->mutex){....}-{4:4}, at: device_lock
include/linux/device.h:994 [inline]
 #4: ffff88804d6791a8 (&dev->mutex){....}-{4:4}, at:
__device_attach+0x7d/0x4f0 drivers/base/dd.c:1088

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 7.0.6 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x2a0/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x133/0x180 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xeac/0x11e0 kernel/hung_task.c:515
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Attachments:

https://drive.google.com/file/d/1Bx2unEf-QntjVi8g6Zw7QNO6OP4cjGO_/view?usp=
=3Ddrive_link

https://drive.google.com/file/d/11hRSaOi-v5Ova5uFzNwCHD2qwF3C-dTV/view?usp=
=3Ddrive_link

https://drive.google.com/file/d/1VsRjuOkgL9Gp3uqRFVnCg9V4KUWLsVYP/view?usp=
=3Ddrive_link

https://drive.google.com/file/d/1P8ALUdJVTdZqwWjlLv11As0b0qJEp1hN/view?usp=
=3Ddrive_link

Best regards,
Longxing Li

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2026=E5=B9=B46=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 20:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 09, 2026 at 07:49:13PM +0800, Longxing Li wrote:
> > Dear Linux kernel developers and maintainers,
> >
> > We would like to report a new kernel bug found by our tool. INFO: task
> > hung in show_cons_active. Details are as follows.
> >
> > Kernel commit: v7.0.6
> > Kernel config: see attachment
> > report: see attachment
> > C repro and Syz repro: see attachment
>
> There are no attachments here, nor any real information.
>
> > We are currently analyzing the root cause and  working on a
> > reproducible PoC. We will provide further updates in this thread as
> > soon as we have more information.
>
> Please just send a fix for the issue, that's the best way to get this
> resolved.
>
> thanks,
>
> greg k-h
