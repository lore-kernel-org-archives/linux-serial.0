Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590EB13B5B3
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413819; cv=none; b=F5BQ960Qv12W3um85n5vWCSz47rtrQh7yc1GrmOHIHtld0tMzNM8d7F68wQoIafCOj9nwmtaSbkNsP1SYJFVxQYbGcHm7o/lIhjtKImwBnFSbdUq4gR9N9Y8lshQaufrGZ5NRIJkmA8VhxnVz/Bi5GCVSBIksE25xI3beuBgSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413819; c=relaxed/simple;
	bh=SlJjTB+YIQvAt+z02Plq6Bgm52OSfDvuXvRr/+/ibqI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SFeQ7P8pnWACp/2ct1wAtUdQhl3kkVmlXSBFc3hujKkKWqa/bErM9HRYA/QBzI6BccnWpy0DvPWBl/2nQeLBXKd68Yy5vNhBI392zRNfuc2MyxBByHkg4PC/y//9pZ96/BN/o091KO6rRvqQjr9O/OeaikarnrKCB6qDsOi4B14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4b1bd347d5fso1302993b6e.3
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 19:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786413816; x=1787018616;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UQsqHFgL/0ZoLBd7YRXwd1+3/f3CqWnhCe2OnHGDZcs=;
        b=G3LtdJbz/oD3qoPCxVXgdetOMztCCjVGz5fgrjP0P9kaS5jwQ9PYW3kwQPPCFM4ehs
         mp1Hk96DFseeonYEt7RR4JAS0fWL4VzwZYsgkWC0ePVfw5OCBwZ9Oa1+c7+IOfFeyG44
         Ttmjnms1TL11WWSG+RzCBNXUMAjTlh4+20dbU+vonCtEdSHbCfoHMQR1mUZmwS4Eda+3
         kdAFA8WBldqOkWBT+QMFFlsgNaWp+kxz8ggyctzWBvWJiOH/r/2eYxFM5Uc3gXotcdq5
         Eka8aEe4FDMqIgzyHNhU9yO0EIh9GwVocLAn4hIvWv4SBI55pKAmDSTN/0fgMqRweemq
         apLw==
X-Forwarded-Encrypted: i=1; AHgh+Rpr74f/FUyrWvQyFyFwQs67tfGFe2JGgOVhcaxr5E1W1jFXlj0FUP1VaSFYkBw3U0EVsm7QkpQ0i4G/3zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eQs54WU1QB8TRm1VqG3xwQiET1v9s8QU+NtME37aFYF599bw
	Ggvj0TN8DcNO/j9Tmt1jBnyY/726eu8ikTO0E11Sdeok74Ln8oE4s9riZ8iVROtz6BluWySamP5
	3Zw7Zd9KLKvRLgfZj0UbOGnBgNeG97ZgIX5jUeuy+p2LzkCnSsXSSbwMdoVg=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6716:b0:495:f79d:b08e with SMTP id
 5614622812f47-4afae1af074mr27547709b6e.21.1786413816106; Mon, 10 Aug 2026
 19:03:36 -0700 (PDT)
Date: Mon, 10 Aug 2026 19:03:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a82f8.01d0871a.3a0d52.00b9.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Write in release_tty
From: syzbot <syzbot+bca09f5d8b843bbf7571@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160e929e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=bca09f5d8b843bbf7571
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ecb6d42b95f/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53481594a62a/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11ad64300b74/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bca09f5d8b843bbf7571@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in release_tty+0x5a8/0x5f0 drivers/tty/tty_io.c:1584
Write of size 8 at addr ffff88803487f128 by task syz.4.4594/23193

CPU: 0 UID: 0 PID: 23193 Comm: syz.4.4594 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 release_tty+0x5a8/0x5f0 drivers/tty/tty_io.c:1584
 tty_release_struct+0xb7/0xe0 drivers/tty/tty_io.c:1692
 tty_release+0xd7a/0x1300 drivers/tty/tty_io.c:1852
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 get_signal+0x1bd/0x21e0 kernel/signal.c:2818
 arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x139/0x6f0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad4599e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad468d8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: fffffffffffffe00 RBX: 00007fad45c26090 RCX: 00007fad4599e0d9
RDX: 0000000000000001 RSI: 0000200000000a00 RDI: 0000000000000006
RBP: 00007fad45a35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fad45c26128 R14: 00007fad45c26090 R15: 00007ffe36320cc8
 </TASK>

Allocated by task 8740:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2e5/0x6c0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 gs_port_alloc drivers/usb/gadget/function/u_serial.c:1218 [inline]
 gserial_alloc_line_no_console+0xac/0x710 drivers/usb/gadget/function/u_serial.c:1298
 obex_alloc_inst+0x86/0x100 drivers/usb/gadget/function/f_obex.c:434
 try_get_usb_function_instance+0x136/0x1f0 drivers/usb/gadget/functions.c:28
 usb_get_function_instance+0x16/0x70 drivers/usb/gadget/functions.c:44
 function_make+0x18c/0x3f0 drivers/usb/gadget/configfs.c:626
 configfs_mkdir+0x51e/0xb70 fs/configfs/dir.c:1360
 vfs_mkdir+0x361/0x850 fs/namei.c:5276
 filename_mkdirat+0x48b/0x5e0 fs/namei.c:5309
 __do_sys_mkdirat fs/namei.c:5330 [inline]
 __se_sys_mkdirat fs/namei.c:5327 [inline]
 __x64_sys_mkdirat+0x89/0xc0 fs/namei.c:5327
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23197:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x22b/0x6c0 mm/slub.c:6692
 gserial_free_port+0x146/0x2f0 drivers/usb/gadget/function/u_serial.c:1262
 gserial_free_line+0xf8/0x1e0 drivers/usb/gadget/function/u_serial.c:1279
 obex_free_inst+0x3b/0x50 drivers/usb/gadget/function/f_obex.c:420
 usb_put_function_instance+0x89/0xc0 drivers/usb/gadget/functions.c:77
 config_item_cleanup+0x146/0x240 fs/configfs/item.c:128
 config_item_release fs/configfs/item.c:137 [inline]
 kref_put include/linux/kref.h:65 [inline]
 config_item_put fs/configfs/item.c:149 [inline]
 config_item_put+0x93/0xb0 fs/configfs/item.c:146
 configfs_rmdir+0x5e3/0x950 fs/configfs/dir.c:1571
 vfs_rmdir fs/namei.c:5381 [inline]
 vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
 filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
 __do_sys_rmdir fs/namei.c:5461 [inline]
 __se_sys_rmdir fs/namei.c:5458 [inline]
 __x64_sys_rmdir+0x46/0x70 fs/namei.c:5458
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803487f000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 296 bytes inside of
 freed 2048-byte region [ffff88803487f000, ffff88803487f800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88803487c000 pfn:0x34878
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88813fe28000 ffffea0001fa6a10 ffffea000158d010
raw: ffff88803487c000 0000000800080006 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88813fe28000 ffffea0001fa6a10 ffffea000158d010
head: ffff88803487c000 0000000800080006 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5608, tgid 5608 (syz-executor), ts 68804263185, free_ts 68789261014
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0xf48/0x3530 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x299/0x2dc0 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab mm/slub.c:3380 [inline]
 new_slab+0xa2/0x640 mm/slub.c:3426
 refill_objects+0xe3/0x410 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_node_track_caller_noprof+0x679/0x830 mm/slub.c:5471
 kmalloc_reserve+0xe8/0x350 net/core/skbuff.c:637
 pskb_expand_head+0x249/0x10e0 net/core/skbuff.c:2312
 netlink_trim+0x22d/0x2f0 net/netlink/af_netlink.c:1300
 netlink_broadcast_filtered+0x6d/0xf20 net/netlink/af_netlink.c:1518
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0xb1/0x290 net/netlink/af_netlink.c:2599
 rtnl_notify net/core/rtnetlink.c:963 [inline]
 rtmsg_ifinfo_send net/core/rtnetlink.c:4553 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4569 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4556 [inline]
 rtnetlink_event+0x1b3/0x1f0 net/core/rtnetlink.c:7136
 notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2250
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 netif_set_mac_address+0x370/0x4a0 net/core/dev.c:10002
page last free pid 5730 tgid 5730 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4584 [inline]
 slab_alloc_node mm/slub.c:4917 [inline]
 kmem_cache_alloc_node_noprof+0x27d/0x6b0 mm/slub.c:4989
 __alloc_skb+0x140/0x710 net/core/skbuff.c:704
 alloc_skb include/linux/skbuff.h:1384 [inline]
 mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1789
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1900
 add_grec+0x1389/0x1930 net/ipv6/mcast.c:2039
 mld_send_initial_cr+0x156/0x320 net/ipv6/mcast.c:2284
 mld_dad_work+0x32/0x1f0 net/ipv6/mcast.c:2310
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88803487f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803487f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803487f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88803487f180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803487f200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
