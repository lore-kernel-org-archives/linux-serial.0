Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC478F3B
	for <linux-serial@vger.kernel.org>; Mon, 26 May 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267378; cv=none; b=akZiOjFvZSx5A9ugd4RwMn2NN7M0XhtUQszZRAJpb76JXqsNRSMLkmBT9RNNm9eM4UhJNAT6BcrRcBwvNQg7XwAMLflxYg7bJJfDja8oXCEgutdfX+hVUcKddKwbTXDFBuOQsLSsd8N1/2jTWvjeNSHGOfjY9tV/zOMsLE3+tLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267378; c=relaxed/simple;
	bh=cvnvZ3UrSz3r6535yN/sqSWAfLNCPfSiZ8OvJtfpOro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UPFNFzKn47TLJgn1OPRw8uMLdj01hsXbk8/KmOB5yZG5tEGq7qDZp/OceF/hwwPPzw15LOasPKxu6n3IfPoGDrDinsEyuv/npUXKptkd0CpcIKy5F44+xGE2az2HnMw0khxwx/VIIyJRARE31UJ+9ohElJ1tT9Z2WoBKatutDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b3b781313so446316339f.1
        for <linux-serial@vger.kernel.org>; Mon, 26 May 2025 06:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267376; x=1748872176;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmFokkzn5mcKbRnZHeTBezskT8hzunwZsF9u+hWNDQQ=;
        b=EiE9Rp+WPeT1bwdJmz+pXrS9mpN7LJMtBph+DdWpGGtuGuLdF3yPKBx+YQJ8RsJyvZ
         y63MOwfyHLBNE2GThFWWS5Qg6uLp7nkOWLutcUtRWX1k9c00ERxbTcJOcjORziBrZt6g
         xpT/BwwJV1fzf1peFKOYCjfMFdpB0BcIQonFpzxGVtgQ0tJ8OzvaHGlpsnxgSBf/Rm7U
         zymCxLrHvISrihAsQZfFlpBBvmfeTSjISlibpnE4jhhoyOE1UP0ouy6A/lg9GNataRQJ
         HAXzDakci17tPSzBU8d4KAFETEDGLZA2iSLVYlTRDLkZdMhl94PSaYAM4EdnATjQvB3l
         Xa8A==
X-Forwarded-Encrypted: i=1; AJvYcCX9J3LKX3XzcwU9qVZ6EzvG7GtOotdmCFd4qqwEDd5xEUWkWUYYgtbt+bHyidK3cDXm33eba1C6DO5r7Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapJgDeIK+mhHx4nhABukJ9+WyazXyKDumXL9veKPgTAXUeGK0
	Ib2hadnOd145PIZRB0WFRJnD8ra/j0ex3Aj80L0RQ6YhIrGIyVDOM2darpqQOMM3rAqgL/Syi9i
	viHgGREiiWbII9AKfojHaHksLFax0B7cYzxQDxSCNtBageavmwXO2CRf2d5g=
X-Google-Smtp-Source: AGHT+IH8EVUjQrNy6gHBsioPAj/7gSTRlKPS45Mp82NZzkF36zz4PXNQZDVakiwDhdwwNVBNOlSiuYlr6BOse4XG+P7QnpgxbvRf
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7211:b0:864:a1e9:f07 with SMTP id
 ca18e2360f4ac-86cbb80a7ecmr1068032539f.8.1748267375896; Mon, 26 May 2025
 06:49:35 -0700 (PDT)
Date: Mon, 26 May 2025 06:49:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6834716f.a70a0220.1765ec.016a.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in debug_check_no_obj_freed (2)
From: syzbot <syzbot+84186930788ce222de35@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    176e917e010c Add linux-next specific files for 20250523
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f2e8e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7902c752bef748
dashboard link: https://syzkaller.appspot.com/bug?extid=84186930788ce222de35
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f7692c642fa/disk-176e917e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/057a442d42d0/vmlinux-176e917e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f8ebdb4dd96/bzImage-176e917e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84186930788ce222de35@syzkaller.appspotmail.com

ODEBUG: object ffffc90014597b90 is on stack ffffc90014590000, but NOT annotated.
======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc7-next-20250523-syzkaller #0 Not tainted
------------------------------------------------------
bch-copygc/loop/7681 is trying to acquire lock:
ffffffff8e133280 (console_owner){-...}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2048 [inline]
ffffffff8e133280 (console_owner){-...}-{0:0}, at: vprintk_emit+0x444/0x7a0 kernel/printk/printk.c:2449

but task is already holding lock:
ffffffff99c703d8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init+0x85/0x3c0 lib/debugobjects.c:741

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}-{2:2}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       __debug_check_no_obj_freed lib/debugobjects.c:1088 [inline]
       debug_check_no_obj_freed+0x17a/0x470 lib/debugobjects.c:1129
       free_pages_prepare mm/page_alloc.c:1255 [inline]
       __free_frozen_pages+0x509/0xe70 mm/page_alloc.c:2706
       stack_depot_save_flags+0x445/0x900 lib/stackdepot.c:678
       kasan_save_stack mm/kasan/common.c:48 [inline]
       kasan_save_track+0x4f/0x80 mm/kasan/common.c:68
       poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
       __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
       kasan_kmalloc include/linux/kasan.h:260 [inline]
       __do_kmalloc_node mm/slub.c:4327 [inline]
       __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4339
       kmalloc_noprof include/linux/slab.h:909 [inline]
       tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
       __tty_buffer_request_room+0x1c8/0x520 drivers/tty/tty_buffer.c:273
       __tty_insert_flip_string_flags+0xb8/0x430 drivers/tty/tty_buffer.c:309
       tty_insert_flip_string_fixed_flag include/linux/tty_flip.h:35 [inline]
       tty_insert_flip_string include/linux/tty_flip.h:83 [inline]
       tty_insert_flip_string_and_push_buffer+0xa3/0x1f0 drivers/tty/tty_buffer.c:559
       pty_write+0xa7/0xe0 drivers/tty/pty.c:118
       tty_put_char+0x10e/0x160 drivers/tty/tty_io.c:3154
       n_tty_process_echo_ops drivers/tty/n_tty.c:647 [inline]
       __process_echoes+0x40a/0xa20 drivers/tty/n_tty.c:693
       commit_echoes drivers/tty/n_tty.c:756 [inline]
       n_tty_receive_char+0x89e/0xc30 drivers/tty/n_tty.c:1421
       n_tty_receive_buf_standard+0x5e2/0x5150 drivers/tty/n_tty.c:1590
       __receive_buf drivers/tty/n_tty.c:1624 [inline]
       n_tty_receive_buf_common+0xab3/0x12f0 drivers/tty/n_tty.c:1723
       tty_port_default_receive_buf+0x6e/0xa0 drivers/tty/tty_port.c:37
       receive_buf drivers/tty/tty_buffer.c:445 [inline]
       flush_to_ldisc+0x2c5/0x810 drivers/tty/tty_buffer.c:495
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
       kthread+0x711/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&port->lock#2){-.-.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       tty_port_tty_get drivers/tty/tty_port.c:307 [inline]
       tty_port_default_wakeup+0x21/0xf0 drivers/tty/tty_port.c:66
       serial8250_tx_chars+0x72e/0x970 drivers/tty/serial/8250/8250_port.c:1838
       serial8250_handle_irq+0x633/0xbb0 drivers/tty/serial/8250/8250_port.c:1946
       serial8250_default_handle_irq+0xbf/0x1b0 drivers/tty/serial/8250/8250_port.c:1966
       serial8250_interrupt+0xa2/0x1d0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x289/0x980 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x8b/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x267/0x9c0 kernel/irq/chip.c:789
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
       file_tty_write+0x4fe/0x990 drivers/tty/tty_io.c:1081
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x548/0xa90 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
       serial8250_console_write+0x17e/0x1ba0 drivers/tty/serial/8250/8250_port.c:3415
       console_emit_next_record kernel/printk/printk.c:3138 [inline]
       console_flush_all+0x728/0xc40 kernel/printk/printk.c:3226
       __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
       console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
       vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
       _printk+0xcf/0x120 kernel/printk/printk.c:2475
       register_console+0xa8b/0xf90 kernel/printk/printk.c:4125
       univ8250_console_init+0x52/0x90 drivers/tty/serial/8250/8250_core.c:513
       console_init+0x1a1/0x670 kernel/printk/printk.c:4323
       start_kernel+0x2cc/0x500 init/main.c:1035
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:307
       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:288
       common_startup_64+0x13e/0x147

-> #0 (console_owner){-...}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       console_trylock_spinning kernel/printk/printk.c:2048 [inline]
       vprintk_emit+0x460/0x7a0 kernel/printk/printk.c:2449
       _printk+0xcf/0x120 kernel/printk/printk.c:2475
       debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
       lookup_object_or_alloc lib/debugobjects.c:688 [inline]
       __debug_object_init+0x2c8/0x3c0 lib/debugobjects.c:743
       rhashtable_init_noprof+0x7c0/0xbb0 lib/rhashtable.c:1085
       bch2_copygc_thread+0x116/0xdc0 fs/bcachefs/movinggc.c:355
       kthread+0x711/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  console_owner --> &port->lock#2 --> &obj_hash[i].lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&obj_hash[i].lock);
                               lock(&port->lock#2);
                               lock(&obj_hash[i].lock);
  lock(console_owner);

 *** DEADLOCK ***

1 lock held by bch-copygc/loop/7681:
 #0: ffffffff99c703d8 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init+0x85/0x3c0 lib/debugobjects.c:741

stack backtrace:
CPU: 0 UID: 0 PID: 7681 Comm: bch-copygc/loop Not tainted 6.15.0-rc7-next-20250523-syzkaller #0 PREEMPT(full) 
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
 debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
 lookup_object_or_alloc lib/debugobjects.c:688 [inline]
 __debug_object_init+0x2c8/0x3c0 lib/debugobjects.c:743
 rhashtable_init_noprof+0x7c0/0xbb0 lib/rhashtable.c:1085
 bch2_copygc_thread+0x116/0xdc0 fs/bcachefs/movinggc.c:355
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7681 at lib/debugobjects.c:655 debug_object_is_on_stack lib/debugobjects.c:655 [inline]
WARNING: CPU: 0 PID: 7681 at lib/debugobjects.c:655 lookup_object_or_alloc lib/debugobjects.c:688 [inline]
WARNING: CPU: 0 PID: 7681 at lib/debugobjects.c:655 __debug_object_init+0x2c9/0x3c0 lib/debugobjects.c:743
Modules linked in:
CPU: 0 UID: 0 PID: 7681 Comm: bch-copygc/loop Not tainted 6.15.0-rc7-next-20250523-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:655 [inline]
RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:688 [inline]
RIP: 0010:__debug_object_init+0x2c9/0x3c0 lib/debugobjects.c:743
Code: cc cc cc 41 ff c7 44 89 3d a4 18 14 15 48 c7 c1 80 9b e2 8b 48 c7 c7 e0 9b e2 8b 84 c0 48 0f 45 f9 48 89 de e8 48 2b 61 fc 90 <0f> 0b 90 e9 c0 fe ff ff e8 3a 1c 00 00 8b 05 1c 9c c6 09 3b 05 1a
RSP: 0018:ffffc900145976e0 EFLAGS: 00010046
RAX: 0000000000000050 RBX: ffffc90014597b90 RCX: 64ea118d10585500
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff8880535b8020 R08: ffffffff8e133223 R09: 1ffffffff1c26644
R10: dffffc0000000000 R11: fffffbfff1c26645 R12: ffff8880774b08d8
R13: ffff888075dce8f8 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125c56000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000057f000 CR3: 0000000075822000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rhashtable_init_noprof+0x7c0/0xbb0 lib/rhashtable.c:1085
 bch2_copygc_thread+0x116/0xdc0 fs/bcachefs/movinggc.c:355
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
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
