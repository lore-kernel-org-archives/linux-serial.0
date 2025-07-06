Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391B946C
	for <linux-serial@vger.kernel.org>; Sun,  6 Jul 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822914; cv=none; b=bNLKTjmggsie+cEPcrirqUtYa3IEuFGYWaK2GtLgDyAdEt4mDiRfcSwTnhORO+SfhisFZhO8zTVdGGIJcbZdlQeyFMWKm54rfLxWocmtvg+f4jeogHB7TlZ1HQwTTZWiLkmuBf339AhiC3jQz1Y0vhH2H1VWk4ma4VOfLMLdOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822914; c=relaxed/simple;
	bh=Q3bUQd1t4mluLUSGw7P9kDhCIOU4UhMx5uGfsM9jgUk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CzbU0wsK/treLB3z3XRsMzcthdD1PKC0grSyfE8dq3ApsBQ5xusdBLa6rzSvWvUAHUBecBOTTIc5531bh5lrvjXHHIQUClmUmPhF7fbHKd7Z1WbjhbU6mhfFOt4e+V1IVHL8eVR1KaNDctzpKSvawD6/KKx4qyijqPL0wZwG1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddcc7e8266so31942425ab.0
        for <linux-serial@vger.kernel.org>; Sun, 06 Jul 2025 10:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751822911; x=1752427711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SA0KRF7Gm0oF5MNKAT+Ddz8GhM4arWtEZ2d06nst8yQ=;
        b=VETunPvJiw94s8LJnImdLC+DsAoQytlnV9nIZDJeWz+uVSbZd5qLH8QgQFgY8zYbY6
         l4Q/nZTJdTRjT9OIv/H+uzc+n5Dd4HlhwgodrAfl+oiy1xTN88x478xwrPAQ3SA3r8Mx
         6kW2N5GBX3nEoSWGa2IaDNya0z/1g74kmO+omJXwLxtznqanic+fD6U/udsnNTX3PrQK
         3sOYIZ7CgFiXvUWtoNxnZF68bn+oMg1OZLrZvZjBurYPG5sYn1BA/wdSRkkJv7ycbc6e
         r6lWKCNjLw/vf1aAVOBrSvJSYxJ9gUleSgfLYgleti0JCGFJd4LCLs1VTjYODavzSa1v
         7xeA==
X-Forwarded-Encrypted: i=1; AJvYcCWuscMllmgnVBuxTC4I/PRjienHLxl72D58jet06U2JDOA2d2sh97QhYW9gcKTt8iVYua/iz9HuvL5JFkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznkvmPDLdzQyrqZv+tdwIyuAV6ncDI4c3ZmgFGswZsrv6XYFuH
	TV4yVZ6wDIkArJJfdm8jX+I/Y1ttZuXevEuz2bgtbxZ104QWmlPSqVV8RVbTlWcvfCMhbyi23uZ
	kzijBKnyao7xUaCjIQd8wDL+jFmAVKr7Tuulo/C23PAxzIDl5nQlvNyw0wEA=
X-Google-Smtp-Source: AGHT+IFRgmXf7+2+jbNqiRrRMdBbN7xg+/+5uSfIFtv7SviPlLzuzG/5+8cdmsN1DTl5DH7UtsuWYfoOMTF3OcXI7/ENHF0XMbky
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:85:b0:3dc:875e:ed8d with SMTP id
 e9e14a558f8ab-3e1347bc200mr97451205ab.4.1751822911599; Sun, 06 Jul 2025
 10:28:31 -0700 (PDT)
Date: Sun, 06 Jul 2025 10:28:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ab23f.a00a0220.c7b3.005f.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in get_partial_node (3)
From: syzbot <syzbot+b02653606401c5d318a2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e433d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d831c9dfe03f77ec
dashboard link: https://syzkaller.appspot.com/bug?extid=b02653606401c5d318a2
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb40fda2e0ca/disk-50c8770a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cba4d214940c/vmlinux-50c8770a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b23ed647866/bzImage-50c8770a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b02653606401c5d318a2@syzkaller.appspotmail.com

=============================================================================
======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc4-next-20250702-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor/5829 is trying to acquire lock:
ffffffff8e130220 (console_owner){-.-.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2048 [inline]
ffffffff8e130220 (console_owner){-.-.}-{0:0}, at: vprintk_emit+0x444/0x7a0 kernel/printk/printk.c:2449

but task is already holding lock:
ffff888031e7ca98 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffff888031e7ca98 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:5897 [inline]
ffff888031e7ca98 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0xa9/0x250 mm/slub.c:5934

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&n->list_lock){-.-.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       get_partial_node+0x37/0x390 mm/slub.c:2899
       get_partial mm/slub.c:3013 [inline]
       ___slab_alloc+0xb3f/0x1410 mm/slub.c:3871
       __slab_alloc mm/slub.c:3981 [inline]
       __slab_alloc_node mm/slub.c:4056 [inline]
       slab_alloc_node mm/slub.c:4217 [inline]
       __do_kmalloc_node mm/slub.c:4364 [inline]
       __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4377
       kmalloc_noprof include/linux/slab.h:909 [inline]
       tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
       __tty_buffer_request_room+0x1c8/0x520 drivers/tty/tty_buffer.c:273
       __tty_insert_flip_string_flags+0xb8/0x430 drivers/tty/tty_buffer.c:309
       tty_insert_flip_string_fixed_flag include/linux/tty_flip.h:35 [inline]
       tty_insert_flip_string include/linux/tty_flip.h:83 [inline]
       tty_insert_flip_string_and_push_buffer+0xa3/0x1f0 drivers/tty/tty_buffer.c:559
       pty_write+0xa7/0xe0 drivers/tty/pty.c:118
       tty_put_char+0x111/0x160 drivers/tty/tty_io.c:3154
       __process_echoes+0x193/0xa20 drivers/tty/n_tty.c:708
       flush_echoes drivers/tty/n_tty.c:791 [inline]
       __receive_buf drivers/tty/n_tty.c:1626 [inline]
       n_tty_receive_buf_common+0xc29/0x12f0 drivers/tty/n_tty.c:1723
       tty_port_default_receive_buf+0x6e/0xa0 drivers/tty/tty_port.c:37
       receive_buf drivers/tty/tty_buffer.c:445 [inline]
       flush_to_ldisc+0x24a/0x720 drivers/tty/tty_buffer.c:495
       process_one_work kernel/workqueue.c:3239 [inline]
       process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
       kthread+0x70e/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&port->lock#2){-.-.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       tty_port_tty_get drivers/tty/tty_port.c:307 [inline]
       tty_port_default_wakeup+0x21/0xf0 drivers/tty/tty_port.c:66
       serial8250_tx_chars+0x72e/0x970 drivers/tty/serial/8250/8250_port.c:1728
       serial8250_handle_irq+0x633/0xbb0 drivers/tty/serial/8250/8250_port.c:1836
       serial8250_default_handle_irq+0xbf/0x1e0 drivers/tty/serial/8250/8250_port.c:1856
       serial8250_interrupt+0x8d/0x160 drivers/tty/serial/8250/8250_core.c:82
       __handle_irq_event_percpu+0x28c/0x980 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x267/0x9c0 kernel/irq/chip.c:797
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq arch/x86/kernel/irq.c:254 [inline]
       call_irq_handler arch/x86/kernel/irq.c:266 [inline]
       __common_interrupt+0x140/0x250 arch/x86/kernel/irq.c:292
       common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:285
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
       _raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
       spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:788 [inline]
       uart_port_unlock_deref+0x111/0x2f0 drivers/tty/serial/serial_core.c:91
       uart_write+0xe8/0x130 drivers/tty/serial/serial_core.c:637
       process_output_block drivers/tty/n_tty.c:561 [inline]
       n_tty_write+0xd35/0x11d0 drivers/tty/n_tty.c:2377
       iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
       file_tty_write+0x500/0x990 drivers/tty/tty_io.c:1081
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x54b/0xa90 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
       serial8250_console_write+0x17e/0x1ba0 drivers/tty/serial/8250/8250_port.c:3355
       console_emit_next_record kernel/printk/printk.c:3138 [inline]
       console_flush_all+0x728/0xc40 kernel/printk/printk.c:3226
       __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
       console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
       vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
       _printk+0xcf/0x120 kernel/printk/printk.c:2475
       register_console+0xa8b/0xf90 kernel/printk/printk.c:4126
       univ8250_console_init+0x52/0x90 drivers/tty/serial/8250/8250_core.c:516
       console_init+0x1a1/0x670 kernel/printk/printk.c:4325
       start_kernel+0x2cc/0x500 init/main.c:1035
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
       common_startup_64+0x13e/0x147

-> #0 (console_owner){-.-.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       console_trylock_spinning kernel/printk/printk.c:2048 [inline]
       vprintk_emit+0x460/0x7a0 kernel/printk/printk.c:2449
       _printk+0xcf/0x120 kernel/printk/printk.c:2475
       __slab_bug+0x6e/0xd0 mm/slub.c:1065
       slab_bug+0x57/0x80 mm/slub.c:1076
       list_slab_objects+0x35/0x1c0 mm/slub.c:5866
       free_partial mm/slub.c:5903 [inline]
       __kmem_cache_shutdown+0xd4/0x250 mm/slub.c:5934
       kmem_cache_destroy+0x76/0x160 mm/slab_common.c:523
       bio_put_slab block/bio.c:155 [inline]
       bioset_exit+0x583/0x690 block/bio.c:1764
       bch2_fs_io_read_exit+0x67/0x80 fs/bcachefs/io_read.c:1513
       __bch2_fs_free fs/bcachefs/super.c:607 [inline]
       bch2_fs_release+0x24c/0x830 fs/bcachefs/super.c:667
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x22b/0x480 lib/kobject.c:737
       deactivate_locked_super+0xb9/0x130 fs/super.c:474
       cleanup_mnt+0x425/0x4c0 fs/namespace.c:1417
       task_work_run+0x1d1/0x260 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
       exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
       do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  console_owner --> &port->lock#2 --> &n->list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&n->list_lock);
                               lock(&port->lock#2);
                               lock(&n->list_lock);
  lock(console_owner);

 *** DEADLOCK ***

4 locks held by syz-executor/5829:
 #0: ffffffff8e890948 (bio_slab_lock){+.+.}-{4:4}, at: bio_put_slab block/bio.c:140 [inline]
 #0: ffffffff8e890948 (bio_slab_lock){+.+.}-{4:4}, at: bioset_exit+0x44a/0x690 block/bio.c:1764
 #1: ffffffff8dfd41f0 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy+0x3e/0x160 mm/slab_common.c:510
 #2: ffffffff8e22bc30 (slab_mutex){+.+.}-{4:4}, at: kmem_cache_destroy+0x4c/0x160 mm/slab_common.c:511
 #3: ffff888031e7ca98 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #3: ffff888031e7ca98 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:5897 [inline]
 #3: ffff888031e7ca98 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0xa9/0x250 mm/slub.c:5934

stack backtrace:
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor Not tainted 6.16.0-rc4-next-20250702-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 console_trylock_spinning kernel/printk/printk.c:2048 [inline]
 vprintk_emit+0x460/0x7a0 kernel/printk/printk.c:2449
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 __slab_bug+0x6e/0xd0 mm/slub.c:1065
 slab_bug+0x57/0x80 mm/slub.c:1076
 list_slab_objects+0x35/0x1c0 mm/slub.c:5866
 free_partial mm/slub.c:5903 [inline]
 __kmem_cache_shutdown+0xd4/0x250 mm/slub.c:5934
 kmem_cache_destroy+0x76/0x160 mm/slab_common.c:523
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x583/0x690 block/bio.c:1764
 bch2_fs_io_read_exit+0x67/0x80 fs/bcachefs/io_read.c:1513
 __bch2_fs_free fs/bcachefs/super.c:607 [inline]
 bch2_fs_release+0x24c/0x830 fs/bcachefs/super.c:667
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 deactivate_locked_super+0xb9/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1417
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1da98fc57
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffad2fdc88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fd1daa10925 RCX: 00007fd1da98fc57
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffad2fdd40
RBP: 00007fffad2fdd40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffad2fedd0
R13: 00007fd1daa10925 R14: 00000000000519af R15: 00007fffad2fee10
 </TASK>
BUG bio-488 (Not tainted): Objects remaining on __kmem_cache_shutdown()
-----------------------------------------------------------------------------

Object 0xffff888079362000 @offset=0
Object 0xffff888079362280 @offset=640
Slab 0xffffea0001e4d880 objects=12 used=2 fp=0xffff888079362500 flags=0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
------------[ cut here ]------------
WARNING: mm/slub.c:1171 at __slab_err+0x15/0x20 mm/slub.c:1171, CPU#1: syz-executor/5829
Modules linked in:
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor Tainted: G    B               6.16.0-rc4-next-20250702-syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__slab_err+0x15/0x20 mm/slub.c:1171
Code: 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 bb ff ff ff bf 05 00 00 00 be 01 00 00 00 e8 0c 6c 5b 00 90 <0f> 0b 90 e9 03 38 4a 0a cc 66 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000404fba8 EFLAGS: 00010093
RAX: ffffffff81836dfa RBX: ffff8880610763c0 RCX: ffff888026ac9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff92a69fc7 R09: 1ffffffff254d3f8
R10: dffffc0000000000 R11: fffffbfff254d3f9 R12: ffff888031e7cac8
R13: ffffea0001e4d880 R14: ffffea0001b20a10 R15: ffff888031e7ca80
FS:  000055555575d500(0000) GS:ffff888125d1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff8d2bb3000 CR3: 0000000078e02000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_partial mm/slub.c:5903 [inline]
 __kmem_cache_shutdown+0xd4/0x250 mm/slub.c:5934
 kmem_cache_destroy+0x76/0x160 mm/slab_common.c:523
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x583/0x690 block/bio.c:1764
 bch2_fs_io_read_exit+0x67/0x80 fs/bcachefs/io_read.c:1513
 __bch2_fs_free fs/bcachefs/super.c:607 [inline]
 bch2_fs_release+0x24c/0x830 fs/bcachefs/super.c:667
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 deactivate_locked_super+0xb9/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1417
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1da98fc57
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffad2fdc88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fd1daa10925 RCX: 00007fd1da98fc57
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffad2fdd40
RBP: 00007fffad2fdd40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffad2fedd0
R13: 00007fd1daa10925 R14: 00000000000519af R15: 00007fffad2fee10
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
