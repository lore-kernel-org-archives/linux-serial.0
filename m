Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B41E98F4
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935086; cv=none; b=mPPBAx77j0O3ba+yMlDhu9vGG2ukKKZSIGRRxnWCdlW4SyvRaBWhwuzIYDk2GQKmf+6qDFHLjTeiwHbLsZPPrb6o0U1PHxJRNcGSgYdgPc+MjDnTLJUcSHWspFyxR0pZB+ugHlwRMWq4mVfxjM7f1UjTNHlAw0wT7CngA+RD7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935086; c=relaxed/simple;
	bh=vMcFW5uLYu9Bjax4H/eU7A7kVbErCjcL/Kg6ta/d9Y0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kfJaqadbvVfG8vS8sj5aR3DFgauiku0T7mQrwx0oXM/5NpJfGyv2nG/m9ogBi4BSoaVVxBorxfiTlobUPm0i2AQLm2sznHTK/oN2shzQIekAB1XNOPg0bx4SWnsXO++XeQhZTTsF3yNdxI5pdVl2rOVqUog8dX5Mu1kfm+3mpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844ec271431so140411339f.1
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2025 05:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935083; x=1739539883;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5ratDbDIKLcXA7D/cHZRuyd7MISV+DrRFRat5RqUrI=;
        b=Y1W/wPHKeCEHE46SaUbvfBMCtTOsB7UsJh+LS7GO8Dv414SsAb9fD1Vz8vDbPZPOxq
         pg6nSV9Fei2A5UKdkBh6BEvAsaHbMgLUof42pN/Bv1GyoQMJZVd/ROPyoBpY2A5nbTHB
         uWWDsa6DfmMypOlvbTrFeuxIl0U0DNHTHsgHrPWGUSXnvK3FCYoXDMXZiAR8P5VwYiFT
         fQtogP2sLUhQ4V5d8mId2lt8fqyRKRpEpa4OF7q1l9YbTYUoFTfcXNHqtUxs4TffRckV
         PM0AwvdFN6I8c75wRjemjwyuxVMjou7Wt8ce7gcmYA9gGSHU6V4F2zDSmCvXVN+TvC1d
         QTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB4WSBo7mGhIguPKHIvrRPTqv2dBq5wJvfdl9kezpg+TrWPdRYXW5y1iIn2HVlSKgyxl55AJmN0hn8CVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhjOKOV2XfjrZiF0R1W2KEYLV4rH1azWUydGcWqZWbau9D0fc
	rpnIwoNsWrI2YcZEr+TqM3eO2aE9+oC9z1L8yBGzDrGmhOGpfFj7yKblDqKvZ2XYCfI4NrzzYTy
	mInrA+OmePbLBlZdcHcm68eiPDT6XYqzaTFulPBkOE0ljn4milyUClgQ=
X-Google-Smtp-Source: AGHT+IFSMrniJ5k5OyJZEDzeehheJ7faz1/PCCmtpapsrMn6FNErsyF5nvsYQXMNkz8QxLRaHw5Ka48e73ipAel4rs6TICrISr1i
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe2:b0:3d0:4b0d:b225 with SMTP id
 e9e14a558f8ab-3d13dd4d8b7mr19744335ab.13.1738935083408; Fri, 07 Feb 2025
 05:31:23 -0800 (PST)
Date: Fri, 07 Feb 2025 05:31:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a60b2b.050a0220.2b1e6.0025.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-out-of-bounds Write in do_con_write
From: syzbot <syzbot+8da8533727fc2b735c3e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2014c95afece Linux 6.14-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dd5724580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90331d51f9d6fa1c
dashboard link: https://syzkaller.appspot.com/bug?extid=8da8533727fc2b735c3e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e059c9dab7dc/disk-2014c95a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0bce0f9fa4d8/vmlinux-2014c95a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6576d9f586f6/bzImage-2014c95a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8da8533727fc2b735c3e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in vc_con_write_normal drivers/tty/vt/vt.c:3010 [inline]
BUG: KASAN: slab-out-of-bounds in do_con_write+0x33f8/0x7d00 drivers/tty/vt/vt.c:3096
Write of size 2 at addr ffff88807b055fc2 by task syz.3.678/8391

CPU: 1 UID: 0 PID: 8391 Comm: syz.3.678 Not tainted 6.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 vc_con_write_normal drivers/tty/vt/vt.c:3010 [inline]
 do_con_write+0x33f8/0x7d00 drivers/tty/vt/vt.c:3096
 con_write+0x23/0xb0 drivers/tty/vt/vt.c:3432
 process_output_block drivers/tty/n_tty.c:574 [inline]
 n_tty_write+0x419/0x1140 drivers/tty/n_tty.c:2389
 iterate_tty_write drivers/tty/tty_io.c:1015 [inline]
 file_tty_write.constprop.0+0x506/0x9a0 drivers/tty/tty_io.c:1090
 tty_write drivers/tty/tty_io.c:1111 [inline]
 redirected_tty_write drivers/tty/tty_io.c:1134 [inline]
 redirected_tty_write+0xcc/0x140 drivers/tty/tty_io.c:1114
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f452738cda9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f45251f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f45275a5fa0 RCX: 00007f452738cda9
RDX: 000000000000002b RSI: 0000000020000840 RDI: 0000000000000002
RBP: 00007f452740e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f45275a5fa0 R15: 00007ffda091f458
 </TASK>

Allocated by task 6754:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 vc_do_resize+0x1da/0x10f0 drivers/tty/vt/vt.c:1174
 vc_resize include/linux/vt_kern.h:49 [inline]
 vgacon_init+0x37c/0x440 drivers/video/console/vgacon.c:392
 visual_init+0x31d/0x620 drivers/tty/vt/vt.c:1011
 do_bind_con_driver.isra.0+0x57a/0xbf0 drivers/tty/vt/vt.c:3831
 do_unbind_con_driver+0x571/0x6d0 drivers/tty/vt/vt.c:3940
 vt_unbind drivers/tty/vt/vt.c:4026 [inline]
 store_bind+0x421/0x760 drivers/tty/vt/vt.c:4061
 dev_attr_store+0x55/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807b054000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 4130 bytes to the right of
 allocated 4000-byte region [ffff88807b054000, ffff88807b054fa0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b050
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b042140 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b042140 0000000000000000 0000000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001ec1401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u8:1), ts 161558148619, free_ts 161445411154
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x23d/0x330 mm/slub.c:2640
 ___slab_alloc+0xbfa/0x1600 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x520 mm/slub.c:4313
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:609
 __alloc_skb+0x164/0x380 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1331 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x2af/0xd20 drivers/net/netdevsim/dev.c:851
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 6547 tgid 6539 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 __put_partials+0x14c/0x170 mm/slub.c:3153
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x202/0x420 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 rxrpc_service_prealloc+0xda/0x1a0 net/rxrpc/call_accept.c:166
 rxrpc_listen+0x227/0x330 net/rxrpc/af_rxrpc.c:236
 afs_open_socket+0x24e/0x350 fs/afs/rxrpc.c:90
 afs_net_init+0x95d/0xc60 fs/afs/main.c:123
 ops_init+0x1df/0x5f0 net/core/net_namespace.c:138
 setup_net+0x21f/0x860 net/core/net_namespace.c:362
 copy_net_ns+0x2b4/0x6c0 net/core/net_namespace.c:516
 create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x45d/0xa40 kernel/fork.c:3342

Memory state around the buggy address:
 ffff88807b055e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807b055f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807b055f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                           ^
 ffff88807b056000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b056080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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
