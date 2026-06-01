Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E235C1BD
	for <linux-serial@vger.kernel.org>; Mon,  1 Jun 2026 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342288; cv=none; b=ko3UEp3TskjaXXaq8c4GbJBBQ5Q7zTDib6F3X4ciXMVAgokWzrG/zuaD2XRa8rAQjxIoZXYeBUOT74zDe5MjppBpC/4ugyeOW7lehraQNZnUK5jOvSGVtb/T/3wPGxfsZJns7tG76D7GbnWihRe+M+c9bUrKtRDc8f97T5gPTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342288; c=relaxed/simple;
	bh=+eywnNo/H7q+CETAbDc9vXQ3XmBV+/SkkLR8VBWR+f8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FQ9ID0HtVmvxi9EVjformFAx9fPghxDGhFIeDvURW6+DRd9ZVmadJ7hj9rcMnT4XBX1/cSM2/w1jI4tgi8MsoBik0ctOzcYZI/BkqXu0ZaI4TW4OIXi+8N3Dz6cnmKOAIUSgJJtilQ0V8XUjeKUstfBLuKvmkIIQ789snCnruz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-43d2c778510so212292fac.1
        for <linux-serial@vger.kernel.org>; Mon, 01 Jun 2026 12:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342285; x=1780947085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7wcM6URass6y6PwVcnbFMnixwus2dcbz2qq9qLwVK0=;
        b=o1q23J+WPrflQ/zaWvtq2I8nghpmvxvEqPVRF5rFcrn4Q5nDdrClyB/zmSNPTpUYB5
         /5zylxzpOwWCZxx09Ccl13GICtLe6X0YCGE6omnl1LzIWDG7qFbYQxTr4MPz7i/IuLLn
         SIM1SPveVv0OsLAT4luEkcuivjjNMFVJ91r73HDgx6AvOAQlHm7pfc8QBSJ0UmRIB76V
         Fn6r1Ip+iUStHeSHNn1RW4Ar/YpUiVBYhGH8iusJWE+rMPz8Oa6Gvzmc2zQ/53U/pDPN
         V7So/47xX1B0jJgVZ4swp7or6q3fIyh5P+VBqpuh5fGtnNSTyayO7L0o95BdgQOOaoay
         3WBA==
X-Forwarded-Encrypted: i=1; AFNElJ913R20e95a9NjmMgJrcWrXm7+rzutiPzDgHgBUXlI7jiKU/hxTuSd/WOKFGcr/0sIcmUKkKKxCBB3Gwm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNys7VDVLO7JN67h9Edv9oJIqxA/j+F9BYdEY5iGOzeURPpjcC
	lQU8a6wrCGmXUl8e328m3ysQjV7iJXzAwfgnzDc2SP7mGp8iLPUTJtFshdjQEI45AT7VRgCTARA
	VGPZPpwnmn/6z2aVDuJF0JB974JUmQ3zjZo4K+DnRwxJMpgjJrrsdEgXXcd4=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1897:b0:69d:e4c8:86f6 with SMTP id
 006d021491bc7-69e102ffa58mr7277358eaf.15.1780342285300; Mon, 01 Jun 2026
 12:31:25 -0700 (PDT)
Date: Mon, 01 Jun 2026 12:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1dde0d.bd48a97d.14881d.0005.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Read in stop_tty
From: syzbot <syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb3f4b7426cf Merge tag 'nfsd-7.1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110a02b6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd38685893011045
dashboard link: https://syzkaller.appspot.com/bug?extid=2932e8970a6398db95c3
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e8630fd2e70/disk-eb3f4b74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a23f2a3eb2a/vmlinux-eb3f4b74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e102c22c34c3/bzImage-eb3f4b74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in stop_t[   93.746644][ T5837] BUG: KASAN: slab-use-after-free in __stop_tty drivers/tty/tty_io.c:742 [inline]
BUG: KASAN: slab-use-after-free in stop_t[   93.746644][ T5837] BUG: KASAN: slab-use-after-free in stop_tty+0x115/0x140 drivers/tty/tty_io.c:766
Read of size 1 at addr ffff888037076480 by task syz.1.2/5837

CPU: 1 UID: 0 PID: 5837 Comm: syz.1.2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __stop_tty drivers/tty/tty_io.c:742 [inline]
 stop_tty+0x115/0x140 drivers/tty/tty_io.c:766
 kbd_keycode drivers/tty/vt/keyboard.c:1565 [inline]
 kbd_event+0x2f91/0x42f0 drivers/tty/vt/keyboard.c:1583
 input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2558
 input_pass_values+0x288/0x890 drivers/input/input.c:128
 input_event_dispose+0x330/0x6b0 drivers/input/input.c:342
 input_inject_event+0x1d7/0x320 drivers/input/input.c:424
 evdev_write+0x328/0x4c0 drivers/input/evdev.c:528
 vfs_write+0x2a3/0xba0 fs/read_write.c:686
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc7927ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdc7748c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fdc794f6180 RCX: 00007fdc7927ce59
RDX: 0000000000002250 RSI: 0000200000000040 RDI: 0000000000000008
RBP: 00007fdc79312d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdc794f6218 R14: 00007fdc794f6180 R15: 00007fff3e71db88
 </TASK>

Allocated by task 5835:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5420
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 alloc_tty_struct+0xa6/0x7b0 drivers/tty/tty_io.c:3102
 tty_init_dev+0x59/0x4d0 drivers/tty/tty_io.c:1400
 tty_open_by_driver drivers/tty/tty_io.c:2073 [inline]
 tty_open+0x86e/0xd80 drivers/tty/tty_io.c:2120
 chrdev_open+0x4d0/0x5f0 fs/char_dev.c:411
 do_dentry_open+0x83d/0x13e0 fs/open.c:947
 vfs_open+0x3b/0x350 fs/open.c:1079
 do_open fs/namei.c:4699 [inline]
 path_openat+0x2e43/0x38a0 fs/namei.c:4858
 do_file_open+0x23e/0x4a0 fs/namei.c:4887
 do_sys_openat2+0x113/0x200 fs/open.c:1364
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_openat fs/open.c:1386 [inline]
 __se_sys_openat fs/open.c:1381 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1381
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5800:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0x1c5/0x6c0 mm/slub.c:6566
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2226
 __queue_work+0xd1d/0x1090 kernel/workqueue.c:2393
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2444
 tty_release_struct+0xb8/0xd0 drivers/tty/tty_io.c:1692
 tty_release+0xcb6/0x1710 drivers/tty/tty_io.c:1852
 __fput+0x461/0xa70 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x193/0x680 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888037076000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 1152 bytes inside of
 freed 2048-byte region [ffff888037076000, ffff888037076800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x37070
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888037070811
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813fe263c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000100000080008 00000000f5000000 ffff888037070811
head: 0080000000000040 ffff88813fe263c0 dead000000000100 dead000000000122
head: 0000000000000000 0000100000080008 00000000f5000000 ffff888037070811
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5805, tgid 5803 (syz.0.1), ts 93327144778, free_ts 93319793659
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x28b2/0x2930 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x33c/0x3d0 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x373/0x720 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 __do_kmalloc_node mm/slub.c:5295 [inline]
 __kmalloc_node_track_caller_noprof+0x60b/0x7e0 mm/slub.c:5408
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:763 [inline]
 neigh_sysctl_register+0xae/0xa90 net/core/neighbour.c:3861
 addrconf_sysctl_register+0xb3/0x1c0 net/ipv6/addrconf.c:7379
 ipv6_add_dev+0xd64/0x1400 net/ipv6/addrconf.c:460
 addrconf_notify+0x771/0x1050 net/ipv6/addrconf.c:3662
 notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
 call_netdevice_notifiers net/core/dev.c:2301 [inline]
 register_netdevice+0x18d5/0x1ed0 net/core/dev.c:11461
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1069 [inline]
 nsim_create+0xbff/0x1170 drivers/net/netdevsim/netdev.c:1151
 __nsim_dev_port_add+0x857/0xd30 drivers/net/netdevsim/dev.c:1509
page last free pid 5805 tgid 5803 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0xfe5/0x10d0 mm/page_alloc.c:2938
 __slab_free+0x252/0x2a0 mm/slub.c:5613
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4570 [inline]
 slab_alloc_node mm/slub.c:4899 [inline]
 __kmalloc_cache_noprof+0x338/0x690 mm/slub.c:5415
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x5a/0x180 lib/kobject.c:1008
 register_queue_kobjects net/core/net-sysfs.c:2091 [inline]
 netdev_register_kobject+0x1a2/0x310 net/core/net-sysfs.c:2347
 register_netdevice+0x146d/0x1ed0 net/core/dev.c:11423
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1069 [inline]
 nsim_create+0xbff/0x1170 drivers/net/netdevsim/netdev.c:1151
 __nsim_dev_port_add+0x857/0xd30 drivers/net/netdevsim/dev.c:1509
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1570
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1622 [inline]
 nsim_dev_reload_up+0x45f/0x7c0 drivers/net/netdevsim/dev.c:1058
 devlink_reload+0x501/0x8d0 net/devlink/dev.c:475
 devlink_nl_reload_doit+0xaaa/0xc80 net/devlink/dev.c:585
 genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114

Memory state around the buggy address:
 ffff888037076380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888037076400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888037076480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888037076500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888037076580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
