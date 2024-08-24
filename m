Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8F43AB4
	for <linux-serial@vger.kernel.org>; Sat, 24 Aug 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724533578; cv=none; b=IEwnC3xiUaOLwX4WsURXqnAjxr21v5ySnuEmSzDACsz4fNIm4WCPlq5p72/5Kk1nJcqc7v8WFjJyZNIQm0NEH95944Mqq1eiTkcihKseE8Hm6S2SY0qODTRtNKS+5Wq4DNsnbEQZgyOQYQfawRvtmXmhUocUwG37Crjx+4lCFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724533578; c=relaxed/simple;
	bh=TA/Cz65zRxAjAfq7MjkUo5qbaN77MjBbibjMgDttlrE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oB24/pBYzOIQ36ChWOr3FIoahb9wt1AhB2q/01wbAZABBpogfWTlNZHRabEixG+ekMPcA4WA711tbYBQdIe9s9pgOAV6HscEgvIRu8+GiItvcXoXOx/MNKX1984lgav9BQ8TsKVNvmQ3mFdEQCIVHjtfaf55P3pXgNXDpcmkVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=PCVZdoF1; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=VvfsJHZH; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="PCVZdoF1";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="VvfsJHZH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724533576; x=1756069576;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=TA/Cz65zRxAjAfq7MjkUo5qbaN77MjBbibjMgDttlrE=;
  b=PCVZdoF1sBAIyajz1JSaq+SkT6/fAq3qNYAoyw7Cwb21Z3t+REDGmyc4
   HcK5Cjx9c/biMJeQab7owI8jWxlzc7WaR9WXhSAWyWOHPDUGjr9gwmncB
   Brx80hVbZh6EblJAvvuD69XT7KyC/VepIso2OiKREWGbNyjUdOC7TBrB6
   d8hxUyhCT82Wf//dwxSiQZcQIzrr47PDtBAasrq1EioWLijm7NHS2RWx5
   BOZI9ycrPfeu7j5iIt3AWQ+bydMyoPu6WUMBl9386IFoPuyfiGb0diXSf
   B38BvlqJUC01nX8nNqwMBqrI/3COY2+ak7bZYRp7I9yNN5EDlcmGWH7OX
   g==;
X-CSE-ConnectionGUID: hFnISF3DTMyznx21jGps3g==
X-CSE-MsgGUID: 3hXTCWCgQpagwVELtjhxEA==
Received: from mail-io1-f70.google.com ([209.85.166.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 14:05:08 -0700
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81faf98703eso342460739f.3
        for <linux-serial@vger.kernel.org>; Sat, 24 Aug 2024 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724533507; x=1725138307; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=It2SBHCkREFPrVbJXjBwm2w6igz9uIpTeTCDbfBbJro=;
        b=VvfsJHZH+FxQyjMD7HX2xkE09ykn1w0rPoKdIUVavFSFW66xG4zUk6D+Hq4/wJ34X+
         qOBPyGyLf/0oksFtTdmrdYZRPpiRahG9DSs0Q2xxNfLVdsO67AhzM9RyNFG2tJekdu0R
         TKOKIg+7cOyMJWlbCu4gFHlV/IMmv2vZevyGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724533507; x=1725138307;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It2SBHCkREFPrVbJXjBwm2w6igz9uIpTeTCDbfBbJro=;
        b=EAVbuizqexRTSZZ/c45JcPdYJWLIK3ApLGVqYOdZxtqXofioiTzn4Ik7jG5egavn2k
         RJ5fcvd3rVreALwsr48xiyvpf0BHbMSNPduBHUgyWNkhw2rLn11Hg0DLHotbQv+ihw4d
         d6WkVAGJ2Otxy5qnb28DjTArp3s1VFK5WqdmlppVXbGXjciNp3JoOAXdXs70CBFB29P9
         xzbvm3w/1Hs2ayHWyn6JkJvWXDStcEYoCDaLTPzak4UngEJFZE5guztSTInCZcKqG0x6
         m1sOKDeGSo697tkLDt0bFZAvQWxr/we8NvN6bqQj30rKfo0R20dSkqn9bOxB+mXVpwQN
         MDgA==
X-Forwarded-Encrypted: i=1; AJvYcCXQRxvTuYe/btYFuO9xG9AFaJpfW4xNPTS6kQwtpEpubzFRXVXuRLFC/xIb9Ztln0xkcoZ81QcrvVhFvaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7kTDR8tVTrVxdqPcdiW+iyqn8GEUfKQsO+7U4K1Pw0tq7iEAK
	A6SzNsRF4VOFT3YTs92lsw68wM4Xogqx3tUnp6Um0AuRstCWijNLZwPbu12KVF1J153zNq/mL/M
	+AHYagZV74TNpFm7d/PBi5X80mNDTvxVjjM6Nn7BmYezGcYYERRYULD/RkOpznk8qYe0DQjrxyR
	/rfRmIv19QOZTfKghridWcwYVW112QYVLLGjViOw==
X-Received: by 2002:a05:6602:3429:b0:805:3d47:19d6 with SMTP id ca18e2360f4ac-8278731d742mr749430239f.6.1724533507534;
        Sat, 24 Aug 2024 14:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh1WytsX9vb6S0Fq6cbm62QwZOTitShDAke3V40ewupwNIw/kzd6cj6GxoWxvouZTrOyU8jo4Rvx1bJ/EnDTQ=
X-Received: by 2002:a05:6602:3429:b0:805:3d47:19d6 with SMTP id
 ca18e2360f4ac-8278731d742mr749428939f.6.1724533507230; Sat, 24 Aug 2024
 14:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 14:04:55 -0700
Message-ID: <CANikGpcUOLC06-Mfq296LeXxudpO6732vWM58-Zfv14GqoJE7w@mail.gmail.com>
Subject: BUG: INFO: task hung in gsm_cleanup_mux
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.

In function `gsm_cleanup_mux`,  the kernel hangs when waiting for
`dlci->state` to become `DLCI_CLOSED`. It seems that
`gsm_dlci_begin_close` failed to close the dlci.

The full report including the Syzkaller reproducer:
https://gist.github.com/TomAPU/38bb00292b33d52a6dd2d1b629247146

The brief report is below:

INFO: task syz.1.466:13387 blocked for more than 143 seconds.
      Not tainted 6.10.0 #13
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.466       state:D stack:27400 pid:13387 tgid:13304
ppid:8048   flags:0x00004004
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
RIP: 0033:0x7fafaef809b9
RSP: 002b:00007fafafe0a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fafaf146130 RCX: 00007fafaef809b9
RDX: 0000000020000100 RSI: 00000000404c4701 RDI: 0000000000000004
RBP: 00007fafaeff4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fafaf146130 R15: 00007ffd1b6e06a8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x54/0x2d0 kernel/locking/lockdep.c:6614
1 lock held by systemd-journal/4495:
1 lock held by systemd-udevd/4507:
1 lock held by in:imklog/7662:
2 locks held by agetty/7949:
 #0: ffff88802e7850a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900040dc2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at:
n_tty_read+0x712/0x1e80 drivers/tty/n_tty.c:2211
2 locks held by syz-executor/8032:
2 locks held by syz.1.466/13387:
 #0: ffff8880285170a0 (&tty->ldisc_sem){++++}-{0:0}, at:
tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffff8880193520b0 (&gsm->mutex){+.+.}-{3:3}, at:
gsm_cleanup_mux+0xb7/0x930 drivers/tty/n_gsm.c:3130
1 lock held by syz.1.796/18097:
2 locks held by syz-executor/18310:
1 lock held by systemd-sysctl/18525:
1 lock held by syz.0.834/18561:
 #0: ffff888020337398 (&mm->mmap_lock){++++}-{3:3}, at:
mmap_read_lock_killable+0x18/0x60 include/linux/mmap_lock.h:153
2 locks held by syz.0.834/18562:
 #0: ffff888020337398 (&mm->mmap_lock){++++}-{3:3}, at:
mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff888020337398 (&mm->mmap_lock){++++}-{3:3}, at:
vm_mmap_pgoff+0x173/0x3a0 mm/util.c:571
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #1: ffffffff8db383f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
synchronize_rcu_expedited+0x37c/0x810 kernel/rcu/tree_exp.h:939
