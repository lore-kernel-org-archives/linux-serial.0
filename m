Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45185B1EB
	for <linux-serial@vger.kernel.org>; Sun,  9 Aug 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786234176; cv=none; b=Pzf6lwuoKh1eIcC1bX8aT41f1TVK4zGcizLdaHe4wWpCMXar13DPVLrvTqu4Whkc7jyy41N1D5/l/35HynDJt1f6PdstjkhqhKap4eNPo0NoBzAvwheLm5OHcqbk69it60dbZ4ONOj/5GzgXdkHtBXz4h/kuXUIZTDclePsfF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786234176; c=relaxed/simple;
	bh=FB5zTAvQKGNOanwZNzVm/MKdN5IjppiYZTb30I27sjI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mHJaAZ5L/Lu5Jy41ePDIa/7miPWzrHMtS8aOhZWRcUBOfPQAQh+/ewVTvhpDgTNj43KB8NkM+oHq6zw7EOJbXULSnf2iDEednXqEbQEN0PXdYt7xBrLg2pfbnt7eo7mIUEI8q8P/1l8uRD1nPCiVpiBGFTLtNSLJgV+0lHa1ElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7ec3b429610so1241634a34.1
        for <linux-serial@vger.kernel.org>; Sat, 08 Aug 2026 17:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786234173; x=1786838973;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qn5G+BpM3JVMKf5cXttBxqHsmxbUJ5UkdLuwKadV/As=;
        b=hgqUzRzL/rIybRzJWobO6SvJaN0jroWPfZvrazqjDRkskTvCsUeSsQqrQJOxiH8UIb
         yiyh/zdU1lh1BczkBSn5GAfTdbrI4/K6narcQp0Uy6O57eWfCM3lG9fY2weB+tq8Fdo7
         6lhN49RMz45Q8LqFc0uI0DIey/3s5pUC1/t+WUAGqFNpBnxb6FD0MLwz1qpqh9mWJ803
         F26QRQOVsV9sXZSn9bSigpqaU4jVMKjaRJ3nzOKHlK0XrvDTVilesTejJr1ihjh43kEN
         2rxRH3cIKv+rgoatfNJDHea+QTjx3eJ1MHCrUuOEec5FFvUHYucpMuzvcMIvkKNL0G4w
         ZyZg==
X-Forwarded-Encrypted: i=1; AHgh+Rqy30G67QUKNVmSnMnyuMUeLL3l1vtD6RaPqkJ7452Xx5lOCylcQcQEvU3ieopvo/xoSvkMiI7yat2s9Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJdUL6c8D2k8T1iQ7hP4A1RWz/oQcqL1p7sDQxMzjwmEmmrBO
	2xlHZ/hsn+V3vN5E2BR1RffIrJ9JGLY6ff/j1+hZksRFeafyrvDi/vXe0v8W0yaqjlVXgpc5Rql
	baSLJFjEhlUuCKefT0ePBGjt2XJ4fn2yjdfESNOEKXoz3xYy0fJelh206rjg=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e841:0:b0:6aa:2fbf:bf60 with SMTP id
 006d021491bc7-6ae96fe3c62mr18593352eaf.34.1786234173635; Sat, 08 Aug 2026
 17:09:33 -0700 (PDT)
Date: Sat, 08 Aug 2026 17:09:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a77c53d.01d0871a.3a0d52.0079.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in task_call_func
From: syzbot <syzbot+7345f1f964659d825165@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f57649580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7079b368dcec295
dashboard link: https://syzkaller.appspot.com/bug?extid=7345f1f964659d825165
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25bde0bfecb5/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a5ebf809884/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d1810845ac3/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7345f1f964659d825165@syzkaller.appspotmail.com

Freezing user space processes
------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.7.70/6790 is trying to acquire lock:
ffffffff8eaf4160 (console_owner){-.-.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2026 [inline]
ffffffff8eaf4160 (console_owner){-.-.}-{0:0}, at: vprintk_emit+0x4c0/0x6b0 kernel/printk/printk.c:2478

but task is already holding lock:
ffff88802b8c6790 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x8b/0x380 kernel/sched/core.c:4476

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:166
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:571 [inline]
       try_to_wake_up+0xbd/0x1c90 kernel/sched/core.c:4292
       __wake_up_common+0x135/0x1f0 kernel/sched/wait.c:108
       __wake_up_common_lock kernel/sched/wait.c:125 [inline]
       __wake_up+0x31/0x60 kernel/sched/wait.c:146
       tty_port_default_wakeup+0x47/0x60 drivers/tty/tty_port.c:67
       serial8250_tx_chars+0x68f/0x860 drivers/tty/serial/8250/8250_port.c:1723
       serial8250_handle_irq_locked+0x770/0x9a0 drivers/tty/serial/8250/8250_port.c:1837
       serial8250_handle_irq.part.0+0xb4/0x530 drivers/tty/serial/8250/8250_port.c:1853
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1849 [inline]
       serial8250_default_handle_irq+0xc2/0x280 drivers/tty/serial/8250/8250_port.c:1867
       serial8250_interrupt+0xf8/0x1b0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x232/0x880 kernel/irq/handle.c:209
       handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:263
       handle_edge_irq+0x34c/0x950 kernel/irq/chip.c:859
       generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
       handle_irq arch/x86/kernel/irq.c:209 [inline]
       call_irq_handler arch/x86/kernel/irq.c:265 [inline]
       __common_interrupt+0xd8/0x2f0 arch/x86/kernel/irq.c:280
       common_interrupt+0xb9/0xe0 arch/x86/kernel/irq.c:273
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:665
       rcu_read_lock include/linux/rcupdate.h:841 [inline]
       page_table_check_clear+0x646/0x8f0 mm/page_table_check.c:77
       __page_table_check_pte_clear+0xf1/0x100 mm/page_table_check.c:155
       page_table_check_pte_clear include/linux/page_table_check.h:55 [inline]
       ptep_get_and_clear_full arch/x86/include/asm/pgtable.h:1263 [inline]
       get_and_clear_full_ptes include/linux/pgtable.h:879 [inline]
       zap_present_folio_ptes mm/memory.c:1648 [inline]
       zap_present_ptes mm/memory.c:1730 [inline]
       do_zap_pte_range mm/memory.c:1832 [inline]
       zap_pte_range mm/memory.c:1934 [inline]
       zap_pmd_range mm/memory.c:2020 [inline]
       zap_pud_range mm/memory.c:2048 [inline]
       zap_p4d_range mm/memory.c:2069 [inline]
       __zap_vma_range+0x2ccc/0x4a30 mm/memory.c:2109
       unmap_vmas+0x299/0x5f0 mm/memory.c:2178
       exit_mmap+0x1ef/0xa00 mm/mmap.c:1300
       __mmput+0x12a/0x410 kernel/fork.c:1187
       mmput+0x67/0x80 kernel/fork.c:1210
       setup_new_exec+0x1d9/0x2a0 fs/exec.c:1353
       load_elf_binary+0xa8f/0x51c0 fs/binfmt_elf.c:1024
       search_binary_handler fs/exec.c:1694 [inline]
       exec_binprm fs/exec.c:1726 [inline]
       bprm_execve fs/exec.c:1778 [inline]
       bprm_execve+0x8fb/0x1730 fs/exec.c:1754
       do_execveat_common.isra.0+0x4a5/0x580 fs/exec.c:1876
       __do_sys_execve fs/exec.c:1949 [inline]
       __se_sys_execve fs/exec.c:1943 [inline]
       __x64_sys_execve+0x93/0xd0 fs/exec.c:1943
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&tty->write_wait){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:166
       __wake_up_common_lock kernel/sched/wait.c:124 [inline]
       __wake_up+0x1c/0x60 kernel/sched/wait.c:146
       tty_port_default_wakeup+0x47/0x60 drivers/tty/tty_port.c:67
       serial8250_tx_chars+0x68f/0x860 drivers/tty/serial/8250/8250_port.c:1723
       serial8250_handle_irq_locked+0x770/0x9a0 drivers/tty/serial/8250/8250_port.c:1837
       serial8250_handle_irq.part.0+0xb4/0x530 drivers/tty/serial/8250/8250_port.c:1853
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1849 [inline]
       serial8250_default_handle_irq+0xc2/0x280 drivers/tty/serial/8250/8250_port.c:1867
       serial8250_interrupt+0xf8/0x1b0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x232/0x880 kernel/irq/handle.c:209
       handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:263
       handle_edge_irq+0x34c/0x950 kernel/irq/chip.c:859
       generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
       handle_irq arch/x86/kernel/irq.c:209 [inline]
       call_irq_handler arch/x86/kernel/irq.c:265 [inline]
       __common_interrupt+0xd8/0x2f0 arch/x86/kernel/irq.c:280
       common_interrupt+0xb9/0xe0 arch/x86/kernel/irq.c:273
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:665
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
       _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:198
       spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:790 [inline]
       uart_port_unlock_deref drivers/tty/serial/serial_core.c:91 [inline]
       uart_port_unlock_deref drivers/tty/serial/serial_core.c:88 [inline]
       uart_write+0x29d/0xb20 drivers/tty/serial/serial_core.c:630
       process_output_block drivers/tty/n_tty.c:557 [inline]
       n_tty_write+0x431/0x1160 drivers/tty/n_tty.c:2366
       iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
       file_tty_write.isra.0+0x4d2/0x890 drivers/tty/tty_io.c:1081
       tty_write drivers/tty/tty_io.c:1102 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1125 [inline]
       redirected_tty_write+0xd4/0x120 drivers/tty/tty_io.c:1105
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:166
       uart_port_lock_irqsave include/linux/serial_core.h:719 [inline]
       serial8250_console_write+0x177/0x1a50 drivers/tty/serial/8250/8250_port.c:3344
       console_emit_next_record kernel/printk/printk.c:3183 [inline]
       console_flush_one_record+0x790/0xe50 kernel/printk/printk.c:3269
       console_flush_all kernel/printk/printk.c:3343 [inline]
       __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
       console_unlock+0x103/0x260 kernel/printk/printk.c:3413
       vprintk_emit+0x407/0x6b0 kernel/printk/printk.c:2479
       _printk+0xcf/0x110 kernel/printk/printk.c:2504
       register_console.cold+0xc0/0x248 kernel/printk/printk.c:4208
       univ8250_console_init+0x6f/0x80 drivers/tty/serial/8250/8250_core.c:515
       console_init+0x3d5/0x5b0 kernel/printk/printk.c:4407
       start_kernel+0x314/0x490 init/main.c:1112
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
       x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
       common_startup_64+0x13e/0x158

-> #0 (console_owner){-.-.}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       console_trylock_spinning kernel/printk/printk.c:2026 [inline]
       vprintk_emit+0x4d1/0x6b0 kernel/printk/printk.c:2478
       _printk+0xcf/0x110 kernel/printk/printk.c:2504
       __report_bug.cold+0x34/0x141 lib/bug.c:248
       report_bug+0xb2/0x220 lib/bug.c:286
       handle_bug+0x16a/0x2a0 arch/x86/kernel/traps.c:436
       exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:490
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:593
       __set_task_frozen+0x211/0x2e0 kernel/freezer.c:139
       task_call_func+0x169/0x380 kernel/sched/core.c:4495
       __freeze_task kernel/freezer.c:150 [inline]
       freeze_task+0x151/0x270 kernel/freezer.c:169
       try_to_freeze_tasks+0x243/0x680 kernel/power/process.c:54
       freeze_processes+0xf2/0x1f0 kernel/power/process.c:137
       hibernate.cold+0xf0/0x6a2 kernel/power/hibernate.c:801
       state_store+0x1ff/0x240 kernel/power/main.c:821
       kobj_attr_store+0x58/0x80 lib/kobject.c:840
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  console_owner --> &tty->write_wait --> &p->pi_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->pi_lock);
                               lock(&tty->write_wait);
                               lock(&p->pi_lock);
  lock(console_owner);

 *** DEADLOCK ***

8 locks held by syz.7.70/6790:
 #0: ffff88807f88eb70 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff8880758ea450 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff88802cf98880 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffff8880202a1968 (kn->active#62){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #3: ffff8880202a1968 (kn->active#62){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x332/0x5f0 fs/kernfs/file.c:337
 #4: ffffffff8ea9fc80 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x56/0x70 kernel/power/main.c:71
 #5: ffffffff8e80a098 (tasklist_lock){.+.+}-{3:3}, at: try_to_freeze_tasks+0x148/0x680 kernel/power/process.c:52
 #6: ffffffff8ec181f8 (freezer_lock){....}-{3:3}, at: freeze_task+0x71/0x270 kernel/freezer.c:168
 #7: ffff88802b8c6790 (&p->pi_lock){-.-.}-{2:2}, at: task_call_func+0x8b/0x380 kernel/sched/core.c:4476

stack backtrace:
CPU: 0 UID: 0 PID: 6790 Comm: syz.7.70 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
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
 console_trylock_spinning kernel/printk/printk.c:2026 [inline]
 vprintk_emit+0x4d1/0x6b0 kernel/printk/printk.c:2478
 _printk+0xcf/0x110 kernel/printk/printk.c:2504
 __report_bug.cold+0x34/0x141 lib/bug.c:248
 report_bug+0xb2/0x220 lib/bug.c:286
 handle_bug+0x16a/0x2a0 arch/x86/kernel/traps.c:436
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:490
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:593
RIP: 0010:__set_task_frozen+0x211/0x2e0 kernel/freezer.c:139
Code: 0f b6 04 02 84 c0 74 09 3c 03 7f 05 e8 18 9a 85 00 8b ab 98 0b 00 00 31 ff 89 ee e8 29 02 16 00 85 ed 74 09 e8 b0 07 16 00 90 <0f> 0b 90 e8 a7 07 16 00 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48
RSP: 0018:ffffc90003d2f990 EFLAGS: 00010046
RAX: 0000000000080000 RBX: ffff88802b8c5d00 RCX: ffffc900200ea000
RDX: 0000000000080000 RSI: ffffffff81f44c10 RDI: ffff88807aa5be00
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000000 R12: ffff88802b8c5d18
R13: 0000000000000002 R14: dffffc0000000000 R15: ffff88802b8c6778
 task_call_func+0x169/0x380 kernel/sched/core.c:4495
 __freeze_task kernel/freezer.c:150 [inline]
 freeze_task+0x151/0x270 kernel/freezer.c:169
 try_to_freeze_tasks+0x243/0x680 kernel/power/process.c:54
 freeze_processes+0xf2/0x1f0 kernel/power/process.c:137
 hibernate.cold+0xf0/0x6a2 kernel/power/hibernate.c:801
 state_store+0x1ff/0x240 kernel/power/main.c:821
 kobj_attr_store+0x58/0x80 lib/kobject.c:840
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f63e7f9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f63e8e70028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f63e8225fa0 RCX: 00007f63e7f9e019
RDX: 0000000000000005 RSI: 0000200000000140 RDI: 0000000000000003
RBP: 00007f63e803500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f63e8226038 R14: 00007f63e8225fa0 R15: 00007fffbeef79e8
 </TASK>
debug_locks && p->lockdep_depth
WARNING: kernel/freezer.c:139 at __set_task_frozen+0x211/0x2e0 kernel/freezer.c:139, CPU#0: syz.7.70/6790
Modules linked in:
CPU: 0 UID: 0 PID: 6790 Comm: syz.7.70 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:__set_task_frozen+0x211/0x2e0 kernel/freezer.c:139
Code: 0f b6 04 02 84 c0 74 09 3c 03 7f 05 e8 18 9a 85 00 8b ab 98 0b 00 00 31 ff 89 ee e8 29 02 16 00 85 ed 74 09 e8 b0 07 16 00 90 <0f> 0b 90 e8 a7 07 16 00 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48
RSP: 0018:ffffc90003d2f990 EFLAGS: 00010046
RAX: 0000000000080000 RBX: ffff88802b8c5d00 RCX: ffffc900200ea000
RDX: 0000000000080000 RSI: ffffffff81f44c10 RDI: ffff88807aa5be00
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000000 R12: ffff88802b8c5d18
R13: 0000000000000002 R14: dffffc0000000000 R15: ffff88802b8c6778
FS:  00007f63e8e706c0(0000) GS:ffff888123dd9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f70009556c8 CR3: 00000000551b8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 task_call_func+0x169/0x380 kernel/sched/core.c:4495
 __freeze_task kernel/freezer.c:150 [inline]
 freeze_task+0x151/0x270 kernel/freezer.c:169
 try_to_freeze_tasks+0x243/0x680 kernel/power/process.c:54
 freeze_processes+0xf2/0x1f0 kernel/power/process.c:137
 hibernate.cold+0xf0/0x6a2 kernel/power/hibernate.c:801
 state_store+0x1ff/0x240 kernel/power/main.c:821
 kobj_attr_store+0x58/0x80 lib/kobject.c:840
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f63e7f9e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f63e8e70028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f63e8225fa0 RCX: 00007f63e7f9e019
RDX: 0000000000000005 RSI: 0000200000000140 RDI: 0000000000000003
RBP: 00007f63e803500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f63e8226038 R14: 00007f63e8225fa0 R15: 00007fffbeef79e8
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
