Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA911632E6
	for <linux-serial@vger.kernel.org>; Mon,  2 Dec 2024 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157211; cv=none; b=Veoc4giIybodXSf+pmRGMtZ9KLfRlwp7N0EqkJFAS8Xx4JcSFBWFXeFRQ/iwCxQvYGJofqvnEWaDDOL6lW0+Rvi134nH/gww3E7elCbrachIKoNP+FDRSxH9QhCYOkCGZpqXxhJYJ2lnaIZ46nFT6w18juByHh+RPYdjvuGJ5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157211; c=relaxed/simple;
	bh=+ZT9YPou4RMvhF3BjYEnFFXH9Kx2B5O7yVrylbZWwRU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ES6Ofax7l5vqnMdpDZLtioIQ7Mojj0BckAImhlFDp3ce2xTVj++SgQhKWnJSnwd3CTtah9i2EXf43mGx+6eF7Waz4FAieQjGtu5YY1Tq7azHVmwYjpX572nqKPWy+FKBvl8mZDk22wuP8Oc9XzZunz1al70u0vtUhCJj/PlSpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-843d837321fso358612839f.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Dec 2024 08:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733157209; x=1733762009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JAztXcFy5dsyfU7L2urwazIeTlncRkamK1s7kgmq4GA=;
        b=MEzSQ836+ZKkqOV7KSwepsR6T+mK/oQze5IhfcGM5wX2NKw24DgFulGoF6H4FkF6nw
         WmLNdqgNtKmjYTPUN5aBL8ttmY/v8hxrS+kp3J5kdOw3MqxBQ3oG6PPKpFhIjFpJuJGK
         9VeVEUTHU2JUgOh+BQ81Vw5wvGsvuxrKpQuA5fmI0ykTyBP/ZToPJJxHcAfUQ9AdmSB1
         he7G64lPQCv1PAF2Efcn0fOVpddXHHzs1UX0e0vhzT17aGxFO7HBJ+mwJZgflScp7wDL
         Zjalu2hDXBgKxYcjEAfNZjP0PZj3s6G+sE/4lkR34g5aX3Ijzy/oRmrhlqgjGQQFAI8+
         gmig==
X-Forwarded-Encrypted: i=1; AJvYcCXh00KD7N3fdeRSiCA8sez44ywXDe00pHYAmUfcKUgxuAicwwUCPnAVzYTez5r6gAmVkeyIBfTFeGeKxJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+0xfFYD1epxPTUMpRyoFrUgDf9V9R3B5pfB1EDDCysmY2iXk
	gLtIhQDBhoMjmtO/Hi3kVHlMgsEFNiJI7asvQooV0oaBw20aqG1Fg1vlssK1+bXVi0QUNthwtT+
	fjehhwQm54yM6Nu/XXILTNmiuobUxW4DuVsCc0H8imIwDN+DIs9svfkI=
X-Google-Smtp-Source: AGHT+IGluNMmHiosfyn4WtUNOLpswYsS1BFdfhN3YfczxUdJVTnQvQT22aRNl2V2qdtXBs0vDl/mOsxQWrctl9U1Be7PpAgTNdjo
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:3a7:bcbf:ba99 with SMTP id
 e9e14a558f8ab-3a7c553fe53mr262818175ab.6.1733157208866; Mon, 02 Dec 2024
 08:33:28 -0800 (PST)
Date: Mon, 02 Dec 2024 08:33:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674de158.050a0220.ad585.0057.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Read in uart_write
From: syzbot <syzbot+7e89e4811726b862fd98@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f91f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89e59b772d80e74b
dashboard link: https://syzkaller.appspot.com/bug?extid=7e89e4811726b862fd98
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b86545e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/547617924f85/vmlinux-b86545e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2157113e5b9/bzImage-b86545e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e89e4811726b862fd98@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in uart_write+0x9ff/0xb30 drivers/tty/serial/serial_core.c:614
Read of size 8 at addr ffff888065d185f8 by task aoe_tx0/1412

CPU: 0 UID: 0 PID: 1412 Comm: aoe_tx0 Not tainted 6.12.0-syzkaller-10553-gb86545e02e8c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 uart_write+0x9ff/0xb30 drivers/tty/serial/serial_core.c:614
 handle_tx+0x203/0x630 drivers/net/caif/caif_serial.c:236
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0x9a/0x7b0 net/core/dev.c:3606
 __dev_queue_xmit+0x7f0/0x43e0 net/core/dev.c:4434
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 tx+0xcc/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1e7/0x3c0 drivers/block/aoe/aoecmd.c:1237
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 10254:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 alloc_tty_struct+0x98/0x8d0 drivers/tty/tty_io.c:3116
 tty_init_dev.part.0+0x1e/0x660 drivers/tty/tty_io.c:1409
 tty_init_dev include/linux/err.h:67 [inline]
 tty_open_by_driver drivers/tty/tty_io.c:2082 [inline]
 tty_open+0xac1/0xf80 drivers/tty/tty_io.c:2129
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0xf59/0x1ea0 fs/open.c:945
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_compat_sys_openat fs/open.c:1479 [inline]
 __se_compat_sys_openat fs/open.c:1477 [inline]
 __ia32_compat_sys_openat+0x16e/0x210 fs/open.c:1477
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 1327:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4746
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:544
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x1080 kernel/workqueue.c:2339
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2390
 kref_put include/linux/kref.h:65 [inline]
 tty_kref_put drivers/tty/tty_io.c:1566 [inline]
 tty_kref_put drivers/tty/tty_io.c:1563 [inline]
 release_tty+0x4de/0x5d0 drivers/tty/tty_io.c:1602
 tty_release_struct+0xb7/0xe0 drivers/tty/tty_io.c:1701
 tty_release+0xe25/0x1410 drivers/tty/tty_io.c:1861
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x2576/0x2610 kernel/signal.c:3016
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888065d18000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 1528 bytes inside of
 freed 2048-byte region [ffff888065d18000, ffff888065d18800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x65d18
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88804a2b0e01
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801ac50140 ffffea0001377600 dead000000000002
raw: 0000000000000000 0000000000080008 00000001f5000000 ffff88804a2b0e01
head: 04fff00000000040 ffff88801ac50140 ffffea0001377600 dead000000000002
head: 0000000000000000 0000000000080008 00000001f5000000 ffff88804a2b0e01
head: 04fff00000000003 ffffea0001974601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 8425, tgid 8425 (syz-executor), ts 105968917948, free_ts 105959451209
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab mm/slub.c:2574 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2627
 ___slab_alloc+0xd1d/0x16e0 mm/slub.c:3815
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x520 mm/slub.c:4302
 kmemdup_noprof+0x29/0x60 mm/util.c:135
 neigh_sysctl_register+0xb3/0x640 net/core/neighbour.c:3734
 addrconf_sysctl_register+0xb9/0x1f0 net/ipv6/addrconf.c:7265
 ipv6_add_dev+0xa1a/0x13e0 net/ipv6/addrconf.c:456
 addrconf_notify+0x53e/0x19c0 net/ipv6/addrconf.c:3655
 notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 register_netdevice+0x1728/0x1e20 net/core/dev.c:10626
page last free pid 8425 tgid 8425 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 __put_partials+0x14c/0x170 mm/slub.c:3142
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x1ca/0x3b0 mm/slub.c:4205
 __alloc_skb+0x2b3/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 nlmsg_new include/net/netlink.h:1018 [inline]
 netlink_ack+0x164/0xb20 net/netlink/af_netlink.c:2478
 netlink_rcv_skb+0x327/0x410 net/netlink/af_netlink.c:2547
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 __sys_sendto+0x488/0x4f0 net/socket.c:2197
 __do_compat_sys_socketcall+0x5e2/0x700 net/compat.c:475
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Memory state around the buggy address:
 ffff888065d18480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888065d18500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888065d18580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888065d18600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888065d18680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
