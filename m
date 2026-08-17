Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44042465C
	for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786971939; cv=none; b=cjGHNCAQCyb8bz6DaFN0s0JfObJCTQ7Fu5YneZWrBs3Z1uQmrxJGDuLgTzidvX9Amkv2VohZW0ssK4lgn2sVOxDrTbq3WT3N0b371sJi9oHX62dSznaJ2LdCT+RsYKjL6id3dfuSufG5q+cW9IhXRKK5f9931F/d4zHUgtm3B1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786971939; c=relaxed/simple;
	bh=pKCgjH748e1AQJwFsN5nBhYLBvR0ccXNLnmA/OiQBog=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cXyVzpl0l7UZPeEmgjfr5AWVlnSPw4y/Xgx85+fgYYTXeM2D7GVrRcpE+qnJTy5cu2ADfYy4hiQ8nAI9LPanDCq4DHUk8YsVWHpkf+l73vPIHleQ7eqceB2t1djMVZp5pjqUQqnHQC0neK44hREcMqy6Zs3EwgBF8vsAu5mwsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-7e9db59c430so1366808a34.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 06:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786971936; x=1787576736;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d3qqApgDbwjm3SVNMKUuWKrjSXgYT+AN4NCmX4ojbD8=;
        b=KdsdEC9Z80PwaF8Bk/FJaEGL/Uo0o32krvpj+Or2GQakRtfovXBo8SBjJT7yyuG5Jb
         ORTiHfIgE54svh2dPHUuB30h+Y54/Ux9jKoGXBZ1OrOQKf4SEBEw+lWMiJMdQ6xNsvi3
         Rfi/Xyh+Kg/3NYFZkRGAEeMd8YskLgjdSyk4XTuLF+ZEfqEQXgv6CuPJd0L3HUKY7zcc
         02//4UCFf8dxCO1Hipk5o24zsyJMS8Q5iXt6DyJK4l8gMf4nNfNJOGJ59OoT2wF5CWxZ
         3DkyAp/mLkcSY7NX7uQv+mDjA/RbLxxAH9S+9JY0GwQmr/xI9yNvWd3AL4QhPKaJx/TQ
         lWnQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSV/hOLkvlRbceN+s4LbFI10ouHf1WY/L0s6wt0aAR9VKoEPDe/MolJOQjs1qnP7bUjJDR5nDe+TK09WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFRg1QXJXDkZB2iHU3iTtwp6kYwlf+KgRHtRR6nQ1ztGVgpVN
	f30xv5h+AVp3v2CnOGOvKVqWVgOREMHvd+iqo8VVENkKHdSqbzm1mlan+0eoGXHgYhKLZYjr9b1
	lKc9uIwIU0reSx8LCiBq2UQ6XVfHcwAE8+5fpTgGgmwKDo9uwpTEyblyGu98=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2086:b0:6ac:a994:8794 with SMTP id
 006d021491bc7-6b11dce8389mr129600eaf.7.1786971936247; Mon, 17 Aug 2026
 06:05:36 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:05:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a830720.dbb3a75c.20434b.005b.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Read in check_tty_count
From: syzbot <syzbot+39a2135de1558208d3b3@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12961c79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=39a2135de1558208d3b3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171ff479580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f92c79580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3d6d8176.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f486efba4dfc/vmlinux-3d6d8176.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b9dcf9ee9f3/bzImage-3d6d8176.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39a2135de1558208d3b3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:82 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in tty_port_kopened include/linux/tty_port.h:234 [inline]
BUG: KASAN: slab-use-after-free in check_tty_count+0x134/0x2b0 drivers/tty/tty_io.c:287
Read of size 8 at addr ffff88802e4c4230 by task syz.2.21/6005

CPU: 0 UID: 0 PID: 6005 Comm: syz.2.21 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 tty_port_kopened include/linux/tty_port.h:234 [inline]
 check_tty_count+0x134/0x2b0 drivers/tty/tty_io.c:287
 tty_release+0x95/0x1300 drivers/tty/tty_io.c:1728
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x6f0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce91f9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8e0021f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fce92227da0 RCX: 00007fce91f9e0d9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fce92227da0 R08: 00007fce92226038 R09: 0000000000000000
R10: 000000000003fd94 R11: 0000000000000246 R12: 000000000000e659
R13: 00007fce92225fac R14: 000000000000e352 R15: 00007ffc8e002300
 </TASK>

Allocated by task 6007:
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
 gserial_alloc_line+0x16/0xa0 drivers/usb/gadget/function/u_serial.c:1332
 acm_alloc_instance+0xd9/0x160 drivers/usb/gadget/function/f_acm.c:891
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

Freed by task 6007:
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
 acm_free_instance+0x3b/0x60 drivers/usb/gadget/function/f_acm.c:875
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

The buggy address belongs to the object at ffff88802e4c4000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 560 bytes inside of
 freed 2048-byte region [ffff88802e4c4000, ffff88802e4c4800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2e4c0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801bc42f00 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801bc42f00 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5827, tgid 5827 (kworker/2:4), ts 58184228669, free_ts 57556351194
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
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 mld_newpack.isra.0+0x18e/0xa20 net/ipv6/mcast.c:1789
 add_grhead+0x299/0x340 net/ipv6/mcast.c:1900
 add_grec+0x1389/0x1930 net/ipv6/mcast.c:2039
 mld_send_cr net/ipv6/mcast.c:2164 [inline]
 mld_ifc_work+0x3c5/0xc10 net/ipv6/mcast.c:2710
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
page last free pid 5850 tgid 5850 stack trace:
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
 kmem_cache_alloc_noprof+0x26b/0x6a0 mm/slub.c:4931
 __kernfs_new_node+0xd2/0xa10 fs/kernfs/dir.c:665
 kernfs_new_node+0x117/0x150 fs/kernfs/dir.c:751
 __kernfs_create_file+0x53/0x350 fs/kernfs/file.c:1050
 sysfs_add_file_mode_ns+0x207/0x3c0 fs/sysfs/file.c:316
 create_files fs/sysfs/group.c:82 [inline]
 internal_create_group+0x593/0xfb0 fs/sysfs/group.c:189
 internal_create_groups+0x9d/0x150 fs/sysfs/group.c:229
 device_add_groups drivers/base/core.c:2907 [inline]
 device_add_attrs drivers/base/core.c:2971 [inline]
 device_add+0x71a/0x1970 drivers/base/core.c:3711
 netdev_register_kobject+0x1df/0x410 net/core/net-sysfs.c:2340
 register_netdevice+0x15b6/0x25a0 net/core/dev.c:11446
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1070 [inline]
 nsim_create+0xc93/0x1420 drivers/net/netdevsim/netdev.c:1152
 __nsim_dev_port_add+0x3ba/0x8f0 drivers/net/netdevsim/dev.c:1509

Memory state around the buggy address:
 ffff88802e4c4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e4c4180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802e4c4200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802e4c4280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e4c4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
