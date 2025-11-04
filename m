Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0C2BB1D
	for <linux-serial@vger.kernel.org>; Tue,  4 Nov 2025 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228770; cv=none; b=dWiohVkEaPVT/uGma2NDHL2Q505r4hRJ07x1ZFfkfJOix18NH0ex8ZZwu1n6JwtJjyrDK1QfQiv860SotXNtWXHyeqHge+HWvOHEir/MVWnQ1U+dGUbZZTNTZW/XeK8pNiJCDcXieqtn2WhSHpmFw1Bm5fy3NrEJ6BnKA2P9i+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228770; c=relaxed/simple;
	bh=HVe4+9fzfYkV+hiCubeRitRe7OlUONe98uP13qqWty4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=guaIQttLmf0ayS+miFn7TDJ7as5NcpwqoOcZXwIKl5BvGoyvOQQsyxcDUWYjr4VMtLg+hczxDTPmjfGSC8BzvN+UzzbKdEIpsm8/Aow37W2G2ueZbjJC7HZDgXemzW3VuZrHYgD/o7Fh8YF/sNwDlohvfh4LJTxgeodQAeCwxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-43331f93979so18803385ab.1
        for <linux-serial@vger.kernel.org>; Mon, 03 Nov 2025 19:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762228767; x=1762833567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/BLTt8yOsLtmCCX0erjBqsuGLQsoZJp5/TnrxT09NU=;
        b=JWdCako2THx4fllYCQc64SW1vAAgJSn5d/Z3OHDVGOVirnWVzWfyGoWjmy0IcfS1Xm
         k6FCrT9aj/ODusZwRzXAGCsiAidymK3785ejgcS5zlzCqG325JMIpyzBhgwGnErSacei
         r/myNz55jRpuUkLvbgpmpXQGDGPqn5FdKC+W3kehbi2L145d+BxQxjN+S/E/NWfybP0b
         hqv00Wo2gh4M5+Z8vEuUIy3Oww0ep1ppA8v+DLC1oSB/MXiIBHcyCHQ9VlF7u0CTvWxb
         yv8NiThJ87xW+uJeBKBK6gQuiWOwctoTxFc+zYMnX26tQbyeKE9hZ67r7nbBljCKzZeC
         0DYA==
X-Forwarded-Encrypted: i=1; AJvYcCUV3c3xrvhOBFLb3YtlU47t15b+76OQvYGy31NournY5SIiVPQ6xM3MNA4iU3O1I10w4XGICFfvwxGUCrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkqkKLAmd3WKs8DIae7Vq4Ru81U9CDMxJrQVlIWuIXsGIGomY
	HPCBmOodlApZpE9SW48TH22aKJJhLjxaNpHcR6SsxVCShc0ElDj3NEOETTSu6zic1Rq30b33oKl
	CDPXSVLIomKEyFQK+Ei/CXoBUAVzDyHULI6cJYAquCRQNisyc2uZMxref+ro=
X-Google-Smtp-Source: AGHT+IG0kygBMw0LWfaCE81AoHFlumS23wdJxZP8DwaQn+UWgTTCbrFPoDUjwVuZafTO9PrNlp8u7Sd8I2HBjkJPF8cycMSvNzUm
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4803:b0:433:37e9:c1ff with SMTP id
 e9e14a558f8ab-43337e9c2e5mr20833375ab.9.1762228766920; Mon, 03 Nov 2025
 19:59:26 -0800 (PST)
Date: Mon, 03 Nov 2025 19:59:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69097a1e.a70a0220.88fb8.0008.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in stop_tty
From: syzbot <syzbot+7ca5a40e8164fe2609fd@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    131f3d9446a6 Add linux-next specific files for 20251030
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f07e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55e89517f3847929
dashboard link: https://syzkaller.appspot.com/bug?extid=7ca5a40e8164fe2609fd
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b7788ed217f3/disk-131f3d94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07b46756c4f4/vmlinux-131f3d94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf9ac153d5ee/bzImage-131f3d94.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ca5a40e8164fe2609fd@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
syzkaller #0 Not tainted
--------------------------------------------------------
acpid/5181 just changed the state of lock:
ffff88807af51468 (&tty->flow.lock){..-.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
ffff88807af51468 (&tty->flow.lock){..-.}-{3:3}, at: stop_tty+0x2f/0x150 drivers/tty/tty_io.c:765
but this lock took another, SOFTIRQ-READ-unsafe lock in the past:
 (tasklist_lock){.+.+}-{3:3}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
  &tty->flow.lock --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&tty->flow.lock);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&tty->flow.lock);

 *** DEADLOCK ***

3 locks held by acpid/5181:
 #0: ffff88807d3b1230 (&dev->event_lock#2){..-.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
 #0: ffff88807d3b1230 (&dev->event_lock#2){..-.}-{3:3}, at: input_event+0x76/0xe0 drivers/input/input.c:395
 #1: ffffffff8e33d8a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8e33d8a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #1: ffffffff8e33d8a0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 #1: ffffffff8e33d8a0 (rcu_read_lock){....}-{1:3}, at: input_pass_values+0x8d/0x890 drivers/input/input.c:119
 #2: ffffffff8eb76878 (kbd_event_lock){..-.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8eb76878 (kbd_event_lock){..-.}-{3:3}, at: kbd_event+0xd2/0x3f70 drivers/tty/vt/keyboard.c:1528

the shortest dependencies between 2nd lock and 1st lock:
   -> (tasklist_lock){.+.+}-{3:3} {
      HARDIRQ-ON-R at:
                          lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                          __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                          _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                          __do_wait+0xde/0x740 kernel/exit.c:1665
                          do_wait+0x1f8/0x510 kernel/exit.c:1709
                          kernel_wait+0xab/0x170 kernel/exit.c:1885
                          call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                          call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                          process_one_work+0x94a/0x15d0 kernel/workqueue.c:3267
                          process_scheduled_works kernel/workqueue.c:3350 [inline]
                          worker_thread+0x9b0/0xee0 kernel/workqueue.c:3431
                          kthread+0x711/0x8a0 kernel/kthread.c:463
                          ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
                          ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
      SOFTIRQ-ON-R at:
                          lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                          __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                          _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                          __do_wait+0xde/0x740 kernel/exit.c:1665
                          do_wait+0x1f8/0x510 kernel/exit.c:1709
                          kernel_wait+0xab/0x170 kernel/exit.c:1885
                          call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                          call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                          process_one_work+0x94a/0x15d0 kernel/workqueue.c:3267
                          process_scheduled_works kernel/workqueue.c:3350 [inline]
                          worker_thread+0x9b0/0xee0 kernel/workqueue.c:3431
                          kthread+0x711/0x8a0 kernel/kthread.c:463
                          ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
                          ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
      INITIAL USE at:
                         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                         __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                         _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                         copy_process+0x224f/0x3c00 kernel/fork.c:2327
                         kernel_clone+0x21e/0x840 kernel/fork.c:2609
                         user_mode_thread+0xdd/0x140 kernel/fork.c:2685
                         rest_init+0x23/0x300 init/main.c:722
                         start_kernel+0x3a7/0x410 init/main.c:1206
                         x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
                         x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
                         common_startup_64+0x13e/0x147
      INITIAL READ USE at:
                              lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                              __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                              _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                              __do_wait+0xde/0x740 kernel/exit.c:1665
                              do_wait+0x1f8/0x510 kernel/exit.c:1709
                              kernel_wait+0xab/0x170 kernel/exit.c:1885
                              call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                              call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                              process_one_work+0x94a/0x15d0 kernel/workqueue.c:3267
                              process_scheduled_works kernel/workqueue.c:3350 [inline]
                              worker_thread+0x9b0/0xee0 kernel/workqueue.c:3431
                              kthread+0x711/0x8a0 kernel/kthread.c:463
                              ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
                              ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
    }
    ... key      at: [<ffffffff8e00c058>] tasklist_lock+0x18/0x40
    ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   send_sigio+0x101/0x370 fs/fcntl.c:919
   kill_fasync_rcu fs/fcntl.c:1131 [inline]
   kill_fasync+0x24d/0x4d0 fs/fcntl.c:1146
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6a5/0x1620 fs/locks.c:1592
   vfs_truncate+0x428/0x520 fs/open.c:112
   do_sys_truncate+0xdb/0x190 fs/open.c:141
   __do_sys_truncate fs/open.c:153 [inline]
   __se_sys_truncate fs/open.c:151 [inline]
   __x64_sys_truncate+0x5b/0x70 fs/open.c:151
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  -> (&f_owner->lock){....}-{3:3} {
     INITIAL USE at:
                       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                       _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                       __f_setown+0x67/0x370 fs/fcntl.c:136
                       generic_add_lease fs/locks.c:1874 [inline]
                       generic_setlease+0xd60/0x1240 fs/locks.c:1942
                       do_fcntl_add_lease fs/locks.c:2047 [inline]
                       fcntl_setlease+0x3a2/0x4c0 fs/locks.c:2069
                       do_fcntl+0x6a9/0x1910 fs/fcntl.c:534
                       __do_sys_fcntl fs/fcntl.c:589 [inline]
                       __se_sys_fcntl+0xc8/0x150 fs/fcntl.c:574
                       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                       entry_SYSCALL_64_after_hwframe+0x77/0x7f
     INITIAL READ USE at:
                            lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                            __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                            _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
                            send_sigio+0x38/0x370 fs/fcntl.c:905
                            kill_fasync_rcu fs/fcntl.c:1131 [inline]
                            kill_fasync+0x24d/0x4d0 fs/fcntl.c:1146
                            lease_break_callback+0x26/0x30 fs/locks.c:558
                            __break_lease+0x6a5/0x1620 fs/locks.c:1592
                            vfs_truncate+0x428/0x520 fs/open.c:112
                            do_sys_truncate+0xdb/0x190 fs/open.c:141
                            __do_sys_truncate fs/open.c:153 [inline]
                            __se_sys_truncate fs/open.c:151 [inline]
                            __x64_sys_truncate+0x5b/0x70 fs/open.c:151
                            do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                            do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                            entry_SYSCALL_64_after_hwframe+0x77/0x7f
   }
   ... key      at: [<ffffffff99ca88e0>] file_f_owner_allocate.__key+0x0/0x20
   ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
   send_sigio+0x38/0x370 fs/fcntl.c:905
   kill_fasync_rcu fs/fcntl.c:1131 [inline]
   kill_fasync+0x24d/0x4d0 fs/fcntl.c:1146
   lease_break_callback+0x26/0x30 fs/locks.c:558
   __break_lease+0x6a5/0x1620 fs/locks.c:1592
   vfs_truncate+0x428/0x520 fs/open.c:112
   do_sys_truncate+0xdb/0x190 fs/open.c:141
   __do_sys_truncate fs/open.c:153 [inline]
   __se_sys_truncate fs/open.c:151 [inline]
   __x64_sys_truncate+0x5b/0x70 fs/open.c:151
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&new->fa_lock){....}-{3:3} {
    INITIAL USE at:
                     lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:326
                     fasync_remove_entry+0xf1/0x1c0 fs/fcntl.c:999
                     lease_modify+0x1ca/0x3c0 fs/locks.c:1455
                     locks_remove_lease fs/locks.c:2675 [inline]
                     locks_remove_file+0x4bf/0xea0 fs/locks.c:2700
                     __fput+0x3ab/0xa70 fs/file_table.c:460
                     task_work_run+0x1d4/0x260 kernel/task_work.c:227
                     resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
                     exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
                     exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
                     syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
                     syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
                     do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:1122 [inline]
                          kill_fasync+0x199/0x4d0 fs/fcntl.c:1146
                          lease_break_callback+0x26/0x30 fs/locks.c:558
                          __break_lease+0x6a5/0x1620 fs/locks.c:1592
                          vfs_truncate+0x428/0x520 fs/open.c:112
                          do_sys_truncate+0xdb/0x190 fs/open.c:141
                          __do_sys_truncate fs/open.c:153 [inline]
                          __se_sys_truncate fs/open.c:151 [inline]
                          __x64_sys_truncate+0x5b/0x70 fs/open.c:151
                          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                          do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff99ca8900>] fasync_insert_entry.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1122 [inline]
   kill_fasync+0x199/0x4d0 fs/fcntl.c:1146
   tty_wakeup drivers/tty/tty_io.c:515 [inline]
   __start_tty+0x18c/0x220 drivers/tty/tty_io.c:777
   start_tty+0x2b/0x70 drivers/tty/tty_io.c:794
   n_tty_set_termios+0xa7c/0x1090 drivers/tty/n_tty.c:1858
   tty_set_termios+0xda4/0x17e0 drivers/tty/tty_ioctl.c:348
   set_termios+0x516/0x6c0 drivers/tty/tty_ioctl.c:516
   tty_mode_ioctl+0x47e/0x740 drivers/tty/tty_ioctl.c:-1
   tty_ioctl+0x9c6/0xde0 drivers/tty/tty_io.c:2801
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&tty->flow.lock){..-.}-{3:3} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
                    class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
                    stop_tty+0x2f/0x150 drivers/tty/tty_io.c:765
                    kbd_keycode drivers/tty/vt/keyboard.c:1515 [inline]
                    kbd_event+0x2b72/0x3f70 drivers/tty/vt/keyboard.c:1534
                    input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
                    input_pass_values+0x288/0x890 drivers/input/input.c:128
                    input_event_dispose+0x3e5/0x6b0 drivers/input/input.c:353
                    input_event+0x89/0xe0 drivers/input/input.c:396
                    hidinput_hid_event+0x145e/0x1e50 drivers/hid/hid-input.c:1730
                    hid_process_event+0x4be/0x620 drivers/hid/hid-core.c:1565
                    hid_input_array_field+0x297/0x5f0 drivers/hid/hid-core.c:1669
                    hid_process_report drivers/hid/hid-core.c:1719 [inline]
                    hid_report_raw_event+0xdd9/0x1720 drivers/hid/hid-core.c:2074
                    __hid_input_report drivers/hid/hid-core.c:2144 [inline]
                    hid_input_report+0x44b/0x580 drivers/hid/hid-core.c:2166
                    hid_irq_in+0x47e/0x6d0 drivers/hid/usbhid/hid-core.c:286
                    __usb_hcd_giveback_urb+0x376/0x540 drivers/usb/core/hcd.c:1661
                    dummy_timer+0x85f/0x45b0 drivers/usb/gadget/udc/dummy_hcd.c:1995
                    __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
                    __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1841
                    hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
                    handle_softirqs+0x286/0x870 kernel/softirq.c:626
                    __do_softirq kernel/softirq.c:660 [inline]
                    invoke_softirq kernel/softirq.c:496 [inline]
                    __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:727
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:743
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
                    syscall_enter_from_user_mode_work include/linux/entry-common.h:92 [inline]
                    syscall_enter_from_user_mode include/linux/entry-common.h:125 [inline]
                    do_syscall_64+0xc3/0xfa0 arch/x86/entry/syscall_64.c:90
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL USE at:
                   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
                   class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
                   start_tty+0x20/0x70 drivers/tty/tty_io.c:793
                   n_tty_set_termios+0xa7c/0x1090 drivers/tty/n_tty.c:1858
                   tty_set_termios+0xda4/0x17e0 drivers/tty/tty_ioctl.c:348
                   set_termios+0x516/0x6c0 drivers/tty/tty_ioctl.c:516
                   tty_mode_ioctl+0x47e/0x740 drivers/tty/tty_ioctl.c:-1
                   tty_ioctl+0x9c6/0xde0 drivers/tty/tty_io.c:2801
                   vfs_ioctl fs/ioctl.c:51 [inline]
                   __do_sys_ioctl fs/ioctl.c:597 [inline]
                   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff99f85e40>] alloc_tty_struct.__key.35+0x0/0x20
 ... acquired at:
   mark_lock+0x11b/0x190 kernel/locking/lockdep.c:4753
   mark_usage kernel/locking/lockdep.c:-1 [inline]
   __lock_acquire+0x680/0xd20 kernel/locking/lockdep.c:5191
   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
   class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
   stop_tty+0x2f/0x150 drivers/tty/tty_io.c:765
   kbd_keycode drivers/tty/vt/keyboard.c:1515 [inline]
   kbd_event+0x2b72/0x3f70 drivers/tty/vt/keyboard.c:1534
   input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
   input_pass_values+0x288/0x890 drivers/input/input.c:128
   input_event_dispose+0x3e5/0x6b0 drivers/input/input.c:353
   input_event+0x89/0xe0 drivers/input/input.c:396
   hidinput_hid_event+0x145e/0x1e50 drivers/hid/hid-input.c:1730
   hid_process_event+0x4be/0x620 drivers/hid/hid-core.c:1565
   hid_input_array_field+0x297/0x5f0 drivers/hid/hid-core.c:1669
   hid_process_report drivers/hid/hid-core.c:1719 [inline]
   hid_report_raw_event+0xdd9/0x1720 drivers/hid/hid-core.c:2074
   __hid_input_report drivers/hid/hid-core.c:2144 [inline]
   hid_input_report+0x44b/0x580 drivers/hid/hid-core.c:2166
   hid_irq_in+0x47e/0x6d0 drivers/hid/usbhid/hid-core.c:286
   __usb_hcd_giveback_urb+0x376/0x540 drivers/usb/core/hcd.c:1661
   dummy_timer+0x85f/0x45b0 drivers/usb/gadget/udc/dummy_hcd.c:1995
   __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
   __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1841
   hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
   handle_softirqs+0x286/0x870 kernel/softirq.c:626
   __do_softirq kernel/softirq.c:660 [inline]
   invoke_softirq kernel/softirq.c:496 [inline]
   __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:727
   irq_exit_rcu+0x9/0x30 kernel/softirq.c:743
   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
   syscall_enter_from_user_mode_work include/linux/entry-common.h:92 [inline]
   syscall_enter_from_user_mode include/linux/entry-common.h:125 [inline]
   do_syscall_64+0xc3/0xfa0 arch/x86/entry/syscall_64.c:90
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 1 UID: 0 PID: 5181 Comm: acpid Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_irq_inversion_bug+0x1d2/0x1e0 kernel/locking/lockdep.c:4125
 mark_lock_irq+0x35f/0x390 kernel/locking/lockdep.c:-1
 mark_lock+0x11b/0x190 kernel/locking/lockdep.c:4753
 mark_usage kernel/locking/lockdep.c:-1 [inline]
 __lock_acquire+0x680/0xd20 kernel/locking/lockdep.c:5191
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 class_spinlock_irqsave_constructor include/linux/spinlock.h:585 [inline]
 stop_tty+0x2f/0x150 drivers/tty/tty_io.c:765
 kbd_keycode drivers/tty/vt/keyboard.c:1515 [inline]
 kbd_event+0x2b72/0x3f70 drivers/tty/vt/keyboard.c:1534
 input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
 input_pass_values+0x288/0x890 drivers/input/input.c:128
 input_event_dispose+0x3e5/0x6b0 drivers/input/input.c:353
 input_event+0x89/0xe0 drivers/input/input.c:396
 hidinput_hid_event+0x145e/0x1e50 drivers/hid/hid-input.c:1730
 hid_process_event+0x4be/0x620 drivers/hid/hid-core.c:1565
 hid_input_array_field+0x297/0x5f0 drivers/hid/hid-core.c:1669
 hid_process_report drivers/hid/hid-core.c:1719 [inline]
 hid_report_raw_event+0xdd9/0x1720 drivers/hid/hid-core.c:2074
 __hid_input_report drivers/hid/hid-core.c:2144 [inline]
 hid_input_report+0x44b/0x580 drivers/hid/hid-core.c:2166
 hid_irq_in+0x47e/0x6d0 drivers/hid/usbhid/hid-core.c:286
 __usb_hcd_giveback_urb+0x376/0x540 drivers/usb/core/hcd.c:1661
 dummy_timer+0x85f/0x45b0 drivers/usb/gadget/udc/dummy_hcd.c:1995
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1858
 handle_softirqs+0x286/0x870 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:727
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:743
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:syscall_enter_from_user_mode_work include/linux/entry-common.h:94 [inline]
RIP: 0010:syscall_enter_from_user_mode include/linux/entry-common.h:125 [inline]
RIP: 0010:do_syscall_64+0xc3/0xfa0 arch/x86/entry/syscall_64.c:90
Code: 00 48 8b 7d 08 48 89 7b 18 e8 b9 72 00 00 0f 1f 44 00 00 0f 1f 44 00 00 90 e8 59 84 6b f6 90 90 e8 02 84 6b f6 fb 49 8b 57 08 <f6> c2 3f 74 0e 4c 89 f7 4c 89 ee e8 ad eb 4d f6 49 89 c4 90 90 41
RSP: 0018:ffffc90002f27ee0 EFLAGS: 00000282
RAX: 6d6ab0ac25070200 RBX: ffffc90002f27ee0 RCX: 6d6ab0ac25070200
RDX: 0000000000000000 RSI: ffffffff8da75c2f RDI: ffffffff8be0f0c0
RBP: ffffc90002f27f38 R08: ffffffff8fbef977 R09: 1ffffffff1f7df2e
R10: dffffc0000000000 R11: fffffbfff1f7df2f R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90002f27f48 R15: ffff88805e6edac0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f540059d407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffc332318f0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f5400513740 RCX: 00007f540059d407
RDX: 0000000000000018 RSI: 00007ffc33231940 RDI: 000000000000000a
RBP: 00007ffc33231940 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000560eec9311e4
R13: 0000560f26edd360 R14: 0000000000000006 R15: 000000000000000a
 </TASK>
keytouch 0003:0926:3333.009D: usb_submit_urb(ctrl) failed: -19
dummy_hcd dummy_hcd.8: timer fired with no URBs pending?
----------------
Code disassembly (best guess):
   0:	00 48 8b             	add    %cl,-0x75(%rax)
   3:	7d 08                	jge    0xd
   5:	48 89 7b 18          	mov    %rdi,0x18(%rbx)
   9:	e8 b9 72 00 00       	call   0x72c7
   e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  18:	90                   	nop
  19:	e8 59 84 6b f6       	call   0xf66b8477
  1e:	90                   	nop
  1f:	90                   	nop
  20:	e8 02 84 6b f6       	call   0xf66b8427
  25:	fb                   	sti
  26:	49 8b 57 08          	mov    0x8(%r15),%rdx
* 2a:	f6 c2 3f             	test   $0x3f,%dl <-- trapping instruction
  2d:	74 0e                	je     0x3d
  2f:	4c 89 f7             	mov    %r14,%rdi
  32:	4c 89 ee             	mov    %r13,%rsi
  35:	e8 ad eb 4d f6       	call   0xf64debe7
  3a:	49 89 c4             	mov    %rax,%r12
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	41                   	rex.B


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
