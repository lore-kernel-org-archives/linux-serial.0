Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5B7462
	for <linux-serial@vger.kernel.org>; Sun, 25 Aug 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724555637; cv=none; b=b73LNdghm3xG68mu77kx7gXjbgpvP668bMDZegPLfKi06Zn6tMOOcGilQrsIQ5Pjbi9cq0L9PNpWGGg6bSXuMidcSlFL2+EHq2WBuSSKhqxVPp8xHPqeL6JpZLCn69gWCqqQIn0SGn+QJJOVO7mLdn+SbauS3jV3kbs1+0nR1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724555637; c=relaxed/simple;
	bh=2HcrxrTPpRYy1wiPzdskR2z5hUqngZElV4KLHFlJHbE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eFhBYtwAxisqM88b9jPK7AZcx3StNKFc28JAaK3nkYuWpH0DjOSRIFo4hsKS3zq8QEJhDJy4MIebrGUyrjFOpyMtj5bZwjx9FMzfJPhAv0pIMyEVFV6VtgZc1WmMz8791mYRnDiOLEq5+YcVbpGmoRAQf1qYkb06yrfaWRL3f9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=D93QlZTK; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=pU2vT4km; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="D93QlZTK";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pU2vT4km"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724555636; x=1756091636;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=2HcrxrTPpRYy1wiPzdskR2z5hUqngZElV4KLHFlJHbE=;
  b=D93QlZTKCE9iBkuqWnyAj+IGApMiLKmQGGUFSKYo15tHQAF0b3iaMujm
   WtqdeLuTR7S0qkooJHZVm/Zw+DhBZaFiKQfcsTChKk1oQZcmXp155Q9gA
   sheXz4GLu4NdSQHpvoE7rMIgJGS7Hh8BYM8yoJAeqXxUl3q2AwEmHTjJA
   64KTLe4siooGCoW/4YHGMkJOuuqN7TLFtcXIEfQiRjFYGZ+wBAlMeWkge
   EeVba0nBzsQD1+UeXzsem8w/OU1trb2CPdCnRltaEgTruV5yCc3uId3C8
   LcnKftJQE8pzRO1gYW5C1Edrr3WQta+PixhOIuqI4H/a33Bb0y+oN1P0g
   g==;
X-CSE-ConnectionGUID: NS0EmAXFQEi+nhfTqVdo4g==
X-CSE-MsgGUID: YhcUKrThRx2YSVJDiEfBXg==
Received: from mail-il1-f200.google.com ([209.85.166.200])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 20:13:55 -0700
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d505a087aso25831815ab.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Aug 2024 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724555634; x=1725160434; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmd79+zPur4h5adj/lU6dhclauG0toHNxgaNJjl4T6Y=;
        b=pU2vT4kmN9/B+TjfPU+orcvmoFrt8ut8XfP719bQ9EMDnp8mk478LmAo0Wlb+2pb+e
         GKH6RF7XlhUli/FOR1FuWp39wnXtioJqezWESIIvyi5DNiAwVAawPMS03pv08cCnv5MA
         PQiWNVQiQbT5o3FwHTdstgw+sP7s0msuKaXfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724555634; x=1725160434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmd79+zPur4h5adj/lU6dhclauG0toHNxgaNJjl4T6Y=;
        b=FJyDJWGfBhe/ca+SCcqXqT8VvphghCKIMajktM6sOFlysoSxxjn4A8GQ5pkpE5Eso6
         qD6gA9f8zD1JBCfH068TZePvbKoUIrYrcgiUfPcIjRlB4owa+Wab8foF0gwpNf8riqpj
         6uHdo1HwS7fUvOrdxkSY/1ki9dx+q/855R1JZeRI/Js0o5g8pI0LdsyggjH4avrdyVZd
         u6utXSG1mdeMkCTJviJxXK6OxA2CwlbG+UdvbiXpV9wlMZm7TbcC5sYFn/r8KycP2eJt
         nPTcttuRIL3/ysG7kAjyDlEgH9xZUsGTrAq1MISqO/UTO+tBRR0+sXksKBqOJquGbNCU
         sZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmwyuQDpnXQMJ86wsTp8QfB6i8p7X+y1Fj8H3wp4tY3H62Lr4qjzSP26HQjWU/NvO4QM/7sANkKIGUS10=@vger.kernel.org
X-Gm-Message-State: AOJu0YysG7pjMNq82A5DPP/Cfyt4qmHYc2qaJ22xlBSuxO+v7Zt/BNNJ
	mHl3LKqqGPie63w1oGrECZe76mMm1ATRchUW9wdQCC2CA/GXran5GaHUikOscRfBwZ/Wgc6o/4k
	7gO/kLf2brkslGrcipXtetJ2Yn2Km+PXLhgf6Va+YP6omm4nAysYNq7JtsnfxbYmtdVSuJODUr5
	4dZr8LwEGPQeFujW/bkN4oNnp8SClDFgYkuK70Mw==
X-Received: by 2002:a05:6e02:1a45:b0:39d:4b1e:cd82 with SMTP id e9e14a558f8ab-39d728cfdd7mr96016525ab.14.1724555633646;
        Sat, 24 Aug 2024 20:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGgZHq/Se8tOA9DZdl1/0yf87umuwYdDN6FWtcguHA7aB/bSFDofbbs3PnOUQFbjcjVr9CCg8R2rXfKn36lyU=
X-Received: by 2002:a05:6e02:1a45:b0:39d:4b1e:cd82 with SMTP id
 e9e14a558f8ab-39d728cfdd7mr96016445ab.14.1724555633225; Sat, 24 Aug 2024
 20:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 20:13:41 -0700
Message-ID: <CANikGpciuP_rh0KrwcZG=yH1e3FG=31D=XT-F8E3z32docZu8w@mail.gmail.com>
Subject: BUG: INFO: task hung in tty_ldisc_hangup
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `ttty_ldisc_hangup` the task hung when trying to execute the
`tty_ldisc_lock` function.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

INFO: task syz.1.1480:25893 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1480      state:D stack:25768 pid:25893 tgid:25892
ppid:22615  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_timeout+0xac/0x300 kernel/time/timer.c:2557
 down_write_failed drivers/tty/tty_ldsem.c:262 [inline]
 __ldsem_down_write_nested+0x3cb/0x910 drivers/tty/tty_ldsem.c:324
 __tty_ldisc_lock drivers/tty/tty_ldisc.c:289 [inline]
 tty_ldisc_lock+0x6a/0xb0 drivers/tty/tty_ldisc.c:313
 tty_ldisc_hangup+0x23c/0x4c0 drivers/tty/tty_ldisc.c:718
 __tty_hangup+0x407/0x6c0 drivers/tty/tty_io.c:630
 tty_vhangup drivers/tty/tty_io.c:700 [inline]
 tty_ioctl+0x726/0xdb0 drivers/tty/tty_io.c:2743
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fbbaa1809b9
RSP: 002b:00007fbbaaedc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbbaa345f80 RCX: 00007fbbaa1809b9
RDX: 0000000000000000 RSI: 0000000000005437 RDI: 0000000000000004
RBP: 00007fbbaa1f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbbaa345f80 R15: 00007ffd9f1583d8
 </TASK>
INFO: task syz.1.1480:25961 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1480      state:D stack:27224 pid:25961 tgid:25892
ppid:22615  flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5407 [inline]
 __schedule+0xf4a/0x15e0 kernel/sched/core.c:6748
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 gsm_cleanup_mux+0x344/0x930 drivers/tty/n_gsm.c:3136
 gsm_config drivers/tty/n_gsm.c:3408 [inline]
 gsmld_ioctl+0x13c4/0x2540 drivers/tty/n_gsm.c:3839
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fbbaa1809b9
RSP: 002b:00007fbba9bff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbbaa346130 RCX: 00007fbbaa1809b9
RDX: 0000000020000100 RSI: 00000000404c4701 RDI: 0000000000000004
RBP: 00007fbbaa1f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fbbaa346130 R15: 00007ffd9f1583d8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x54/0x2d0 kernel/locking/lockdep.c:6614
1 lock held by in:imklog/7649:
2 locks held by syz-executor/8034:
2 locks held by agetty/13559:
 #0: ffff88803d8e50a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900041d32f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by systemd-udevd/18316:
2 locks held by systemd-udevd/18325:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
2 locks held by systemd-udevd/18326:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
2 locks held by systemd-udevd/18382:
2 locks held by systemd-udevd/18500:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
1 lock held by systemd-udevd/18504:
2 locks held by systemd-udevd/18505:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
1 lock held by systemd-udevd/18822:
1 lock held by systemd-udevd/18860:
1 lock held by systemd-udevd/18902:
1 lock held by systemd-udevd/18908:
1 lock held by systemd-udevd/18925:
1 lock held by systemd-udevd/19029:
 #0: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock_shared include/linux/fs.h:801 [inline]
 #0: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3573 [inline]
 #0: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7c9/0x3580 fs/namei.c:3810
2 locks held by systemd-udevd/19104:
 #0: ffff88801ed3e420 (sb_writers#7){.+.+}-{0:0}, at:
mnt_want_write+0x3b/0x80 fs/namespace.c:409
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
inode_lock include/linux/fs.h:791 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
open_last_lookups fs/namei.c:3571 [inline]
 #1: ffff888025385d48 (&type->i_mutex_dir_key#5){++++}-{3:3}, at:
path_openat+0x7d8/0x3580 fs/namei.c:3810
2 locks held by agetty/20613:
 #0: ffff888042a120a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002de82f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by agetty/22206:
 #0: ffff8880451e10a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900018482f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by syz.1.1480/25893:
 #0: ffff88803ff751c0 (&tty->legacy_mutex){+.+.}-{3:3}, at:
__tty_hangup+0xcc/0x6c0 drivers/tty/tty_io.c:590
 #1: ffff88803ff750a0 (&tty->ldisc_sem){++++}-{0:0}, at:
__tty_ldisc_lock drivers/tty/tty_ldisc.c:289 [inline]
 #1: ffff88803ff750a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_lock+0x6a/0xb0 drivers/tty/tty_ldisc.c:313
2 locks held by syz.1.1480/25961:
 #0: ffff88803ff750a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffff88804484f0b0 (&gsm->mutex){+.+.}-{3:3}, at:
gsm_cleanup_mux+0xb7/0x930 drivers/tty/n_gsm.c:3130
1 lock held by syz.1.1868/30326:
1 lock held by systemd-sysctl/30475:
2 locks held by systemd-sysctl/30480:
2 locks held by syz.0.1895/30484:
 #0: ffffffff8e8387a8 (input_mutex){+.+.}-{3:3}, at:
__input_unregister_device+0x2ff/0x630 drivers/input/input.c:2293
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
synchronize_rcu_expedited+0x37c/0x810 kernel/rcu/tree_exp.h:939
3 locks held by syz.0.1895/30488:
2 locks held by apt-config/30483:

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
