Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C321B18E
	for <linux-serial@vger.kernel.org>; Mon,  9 Dec 2024 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743700; cv=none; b=sFsBuNyeDroifVZxZHuIleB+HezPecInnYBBkxXZmcYqgX1T4eARmu8cOpAy2v2pg81cw2yNbbLnUulm/LUoB7xKmlqilPFFRZO7CdgnQZxHM7VvVDLLlY0blBar4uirxjFpnImsutCzeqBT/BpGdqi7t4Z5mjhjYJ0qpNCcaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743700; c=relaxed/simple;
	bh=gkA8NshzQsVvhXDxjfdCoi5f3ZBS+uCPdv+FRi2f1fE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=of4hMbVz/Ws8qVVj8/MHfQstmgz5RxxFgxkUeol67pbu+5haXVnOjMK6cjTCNCXGCha+j1JS/D4y09Kx7pUKxw/4XMvtDU8BNzi2AZATVQhgkUxnvNat3VPlQij0l6No5Rlckj7J9418vl1ZzVXS6QYNgjnXq87h/NkUmjR/CtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8419aa81d6aso396464839f.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Dec 2024 03:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743698; x=1734348498;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a24o7LRDJDLS84sYRjnedwKb04ZM6nfdNB4ltcikrsI=;
        b=EOaT0QsybBc9j4bOWYjNtw+2BYmLKL2/tGl8Q1zhW1O9yipWCOfc25gxqPVbI6guiQ
         S3jMNy6yGiBsjq00nyy2EEM/cM/EzAsPXsMMmW/WCCpMrDQWHx56jUsxfFj+68kMiwN6
         b5SX+Krjr3D41zdwkh1pECoE219rxSiOkaLRJjOT3rjPTX5Rvd+HUgMPiDd7Z/uVUzXA
         Pgw9ek5P38TyM6ZzlHbE5RPWUlnWnoRgYv8x56cBHuIWESO1dSeLBhvK/2vGo3g2wENq
         xe5pgpgy/5NnpGlGUZE8IGKtM/YEIkZ8BfKXuZxST6PLishUoddZ1ItCxRBN4LprciRh
         r+vA==
X-Forwarded-Encrypted: i=1; AJvYcCWOh3JAwO7UqGOjxYujy0kxGmaC+mJQIeLfLFdQH3asWj+zi1Gak0m4LrKmJSFo9KV1VQRYmFJAWps7Qy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERWjKP+UAOdoC0SsdV86PKCDPpJI2S0myG1X0TtsrAnvCoepY
	MwYB4maqxfxhsbkCzFCbvg4sPXLzAp6sLWf9hOukSRSr/mHTNR/zpAHFtG5bOcmkbMNecdkeMB6
	sTB9NZRaVkIZrW9odDMUaN0MV6P0DkjALvk2eY6ilnYtVoL6PNuPfauM=
X-Google-Smtp-Source: AGHT+IFaE1PYiOM8BeCe9i8RhO2fzzQ4QBSWGIOr+J7/2BnEZuV+mCGIIPYM514qGbtUGzTxKgzAtz5y1nRdFr5bWI9J57kCgnt8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b12:b0:844:7896:9faa with SMTP id
 ca18e2360f4ac-844b522dca1mr15949439f.11.1733743698218; Mon, 09 Dec 2024
 03:28:18 -0800 (PST)
Date: Mon, 09 Dec 2024 03:28:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756d452.050a0220.2477f.0042.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Read in uart_write_room
From: syzbot <syzbot+22c0e08c1e0f773fbfaa@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ceb8bf2ceaa7 module: Convert default symbol namespace to s..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e8c330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b225920bfb690d77
dashboard link: https://syzkaller.appspot.com/bug?extid=22c0e08c1e0f773fbfaa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ceb8bf2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f40ba9ac43dc/vmlinux-ceb8bf2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb33a07856f6/bzImage-ceb8bf2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+22c0e08c1e0f773fbfaa@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
==================================================================
BUG: KASAN: slab-use-after-free in uart_write_room+0x85e/0x940 drivers/tty/serial/serial_core.c:642
Read of size 8 at addr ffff888069a3e5f8 by task aoe_tx0/1412

CPU: 0 UID: 0 PID: 1412 Comm: aoe_tx0 Not tainted 6.13.0-rc1-syzkaller-00005-gceb8bf2ceaa7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 uart_write_room+0x85e/0x940 drivers/tty/serial/serial_core.c:642
 tty_write_room+0x63/0x90 drivers/tty/tty_ioctl.c:69
 handle_tx+0x151/0x630 drivers/net/caif/caif_serial.c:226
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

Allocated by task 6035:
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

Freed by task 58:
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
 get_signal+0x2576/0x2610 kernel/signal.c:3017
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888069a3e000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 1528 bytes inside of
 freed 2048-byte region [ffff888069a3e000, ffff888069a3e800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888069a3a000 pfn:0x69a38
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88805ade6581
flags: 0x4fff00000000240(workingset|head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000240 ffff88801ac50140 ffffea00013d6010 ffffea0001a45a10
raw: ffff888069a3a000 0000000000080007 00000001f5000000 ffff88805ade6581
head: 04fff00000000240 ffff88801ac50140 ffffea00013d6010 ffffea0001a45a10
head: ffff888069a3a000 0000000000080007 00000001f5000000 ffff88805ade6581
head: 04fff00000000003 ffffea0001a68e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6010, tgid 6009 (syz.0.1), ts 54029321825, free_ts 53980284476
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
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
 __devinet_sysctl_register+0xbc/0x360 net/ipv4/devinet.c:2618
 devinet_init_net+0x33d/0x8f0 net/ipv4/devinet.c:2763
 ops_init+0x1df/0x5f0 net/core/net_namespace.c:138
 setup_net+0x21f/0x860 net/core/net_namespace.c:362
 copy_net_ns+0x2b4/0x6b0 net/core/net_namespace.c:500
 create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
page last free pid 5950 tgid 5950 stack trace:
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
 __kmalloc_cache_node_noprof+0x1ee/0x3f0 mm/slub.c:4322
 kmalloc_node_noprof include/linux/slab.h:924 [inline]
 __get_vm_area_node+0x101/0x2f0 mm/vmalloc.c:3127
 __vmalloc_node_range_noprof+0x26a/0x1530 mm/vmalloc.c:3804
 __vmalloc_node_noprof mm/vmalloc.c:3909 [inline]
 vmalloc_noprof+0x6b/0x90 mm/vmalloc.c:3942
 xt_compat_init_offsets+0xe1/0x1f0 net/netfilter/x_tables.c:733
 compat_table_info+0xb7/0x5f0 net/ipv6/netfilter/ip6_tables.c:950
 get_info+0x2ed/0x750 net/ipv6/netfilter/ip6_tables.c:987
 do_ip6t_get_ctl+0x16a/0xaf0 net/ipv6/netfilter/ip6_tables.c:1668
 nf_getsockopt+0x79/0xe0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x1f7/0x280 net/ipv6/ipv6_sockglue.c:1493
 tcp_getsockopt+0x9e/0x100 net/ipv4/tcp.c:4671

Memory state around the buggy address:
 ffff888069a3e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888069a3e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888069a3e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888069a3e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888069a3e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
