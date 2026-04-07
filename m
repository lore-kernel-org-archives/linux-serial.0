Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62B377566
	for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594131; cv=none; b=l22rIlJJ9Sm3DvJxpvdZ8lebMSb4yfccRxw6CsqoTuzEVkkc3E3oAI84/ASAIJCMTWu2b23tU4KGYXJs8Wed8YfSYlA5ApgUm6UNkII3Nr+zEUPqhIaDTndHkBZ12PxoUVq81cPAzNr4QiKRgEQeAo/UgJZijOPvjXKtEwuN/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594131; c=relaxed/simple;
	bh=qCpPd5f4jJ7jcN/lTsiwxrmybMJ+l1fSj6KXO+/NGVw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NDs4CqHxcA1sKCHglNzz+60cHxaj6b5nCpLDGeiHkLkpi6VCjPxB6bSAlICMzwFL5esT+LiLbYlz1h4JFwtlrYfT2+/g4tN5rgGxqrCmd6DNyWKXeIcbJpYO4OklTa6VJ2beycFEwRQKbG4gX44t69IE4sp3CRjZtzfU7cPX1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6857678bcbeso2530903eaf.2
        for <linux-serial@vger.kernel.org>; Tue, 07 Apr 2026 13:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775594129; x=1776198929;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDEKSqj1p6VSKZK2YYyeQNPDJJGLD0agkj31jxkJpfY=;
        b=jsgRXTdGh5XuOr0AJFyyhBBHAwCU1wX5vQgqZgaF2f8dvwEa6cvPMNv7gtreoFPASt
         nLv57BrjGKkL2BJl3Q+RIJJqhajiNx6Nc7ZtBEyEcUvufBQRT/+fqZsNJVsXJqloStYd
         kXZmZFHFrVMNqT7xwSvtckkSu+fVKUOT1tepLKujcJUM95EyChGgeKgwr9yN5EkRYlJK
         9NgeV+jMAv1ATSpc1C8AsKnbFYMH2SQ7+Bbk+VodFTy2mP+WqknimysTPK9SyBaRDDMY
         V2TJxcLQFliu4120e5M6GRcSxPGpUg7+OjiEyzRkJtFTY7GP24dHawkPEj+BJJ+Ap7YD
         snMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLYHCiGqFbDfpLcONLxvO69MdhihCayp5xbkwUm0xxBEgWEXT3mmo7X9NyOzm5mNMciK3G9DboGXMYZ0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhj3CAIUrlrh7Mj1CYOvk9U8LQ/bPwVddBnymmwUGoAP7L2b2u
	x8crAHxNHm6pk3VifCunQ7Gu+mqHOBaSdTwzu8ASAIc6Is1Kz6s43BwLGDBCNiVAwczxvtcO0ss
	4HolgqOftEdqQMy/38Ap+SEmIWtcRFx3BB35EyhNiDRPb0xRV6NnQHy+khN4=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e911:0:b0:689:180c:64d0 with SMTP id
 006d021491bc7-689180c68admr440311eaf.11.1775594129190; Tue, 07 Apr 2026
 13:35:29 -0700 (PDT)
Date: Tue, 07 Apr 2026 13:35:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d56a91.050a0220.28fc4.0003.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Read in kbd_event (2)
From: syzbot <syzbot+098cefc0911c68db5dab@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5619b098e2fb Merge tag 'for-7.0-rc6-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101c41ca580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
dashboard link: https://syzkaller.appspot.com/bug?extid=098cefc0911c68db5dab
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63964c15e763/disk-5619b098.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86e80eed2888/vmlinux-5619b098.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17dba94dbc66/bzImage-5619b098.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+098cefc0911c68db5dab@syzkaller.appspotmail.com

==================================================================
BUG: KASA[  730.192938][ T7920] BUG: KASAN: slab-use-after-free in kbd_keycode drivers/tty/vt/keyboard.c:1435 [inline]
BUG: KASA[  730.192938][ T7920] BUG: KASAN: slab-use-after-free in kbd_event+0x3330/0x40d0 drivers/tty/vt/keyboard.c:1515
Read of size 4 at addr ffff88806944e35c by task syz.2.13424/7920

CPU: 1 UID: 0 PID: 7920 Comm: syz.2.13424 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 kbd_keycode drivers/tty/vt/keyboard.c:1435 [inline]
 kbd_event+0x3330/0x40d0 drivers/tty/vt/keyboard.c:1515
 input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
 input_pass_values+0x288/0x890 drivers/input/input.c:128
 input_event_dispose+0x330/0x6b0 drivers/input/input.c:342
 input_inject_event+0x1d8/0x330 drivers/input/input.c:424
 evdev_write+0x328/0x4c0 drivers/input/evdev.c:528
 vfs_write+0x2a3/0xba0 fs/read_write.c:686
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5547bac819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5545dfe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5547e25fa0 RCX: 00007f5547bac819
RDX: 0000000000002250 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007f5547c42c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5547e26038 R14: 00007f5547e25fa0 R15: 00007ffe04f8cf48
 </TASK>

Allocated by task 7915:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3a6/0x690 mm/slub.c:5380
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 alloc_tty_struct+0xa6/0x7b0 drivers/tty/tty_io.c:3102
 tty_init_dev+0x59/0x4d0 drivers/tty/tty_io.c:1400
 tty_open_by_driver drivers/tty/tty_io.c:2073 [inline]
 tty_open+0x86e/0xd80 drivers/tty/tty_io.c:2120
 chrdev_open+0x4d0/0x5f0 fs/char_dev.c:411
 do_dentry_open+0x83d/0x13e0 fs/open.c:949
 vfs_open+0x3b/0x350 fs/open.c:1081
 do_open fs/namei.c:4677 [inline]
 path_openat+0x2e43/0x38a0 fs/namei.c:4836
 do_file_open+0x23e/0x4a0 fs/namei.c:4865
 do_sys_openat2+0x113/0x200 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15095:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6165 [inline]
 kfree+0x1c1/0x6c0 mm/slub.c:6483
 process_one_work kernel/workqueue.c:3276 [inline]
 process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2199
 __queue_work+0xcc6/0xff0 kernel/workqueue.c:2354
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
 tty_release_struct+0xb8/0xd0 drivers/tty/tty_io.c:1692
 tty_release+0xcb6/0x1710 drivers/tty/tty_io.c:1852
 __fput+0x461/0xa90 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88806944e000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 860 bytes inside of
 freed 2048-byte region [ffff88806944e000, ffff88806944e800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x69448
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888069448811
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813fe363c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000100000080008 00000000f5000000 ffff888069448811
head: 0080000000000040 ffff88813fe363c0 dead000000000100 dead000000000122
head: 0000000000000000 0000100000080008 00000000f5000000 ffff888069448811
head: 0080000000000003 ffffea0001a51201 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5878, tgid 5878 (syz-executor), ts 463972954830, free_ts 463959021215
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x28bb/0x2950 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3292 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3481
 new_slab mm/slub.c:3539 [inline]
 refill_objects+0x334/0x3c0 mm/slub.c:7175
 refill_sheaf mm/slub.c:2812 [inline]
 __pcs_replace_empty_main+0x35c/0x710 mm/slub.c:4615
 alloc_from_pcs mm/slub.c:4717 [inline]
 slab_alloc_node mm/slub.c:4851 [inline]
 __do_kmalloc_node mm/slub.c:5259 [inline]
 __kvmalloc_node_noprof+0x6f4/0x8e0 mm/slub.c:6752
 alloc_fdtable+0x101/0x2c0 fs/file.c:219
 dup_fd+0x879/0xb70 fs/file.c:420
 copy_files+0xc8/0x120 kernel/fork.c:1636
 copy_process+0x1767/0x3cd0 kernel/fork.c:2211
 kernel_clone+0x249/0x840 kernel/fork.c:2653
 __do_sys_clone kernel/fork.c:2794 [inline]
 __se_sys_clone kernel/fork.c:2778 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2778
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1186 tgid 1186 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xfe3/0x1170 mm/page_alloc.c:2978
 __folio_put+0x25d/0x310 mm/swap.c:112
 put_netmem include/net/netmem.h:420 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x4cb/0x940 net/core/skbuff.c:1122
 skb_release_all net/core/skbuff.c:1203 [inline]
 __kfree_skb+0x5d/0x210 net/core/skbuff.c:1217
 skb_defer_free_flush+0x191/0x260 net/core/dev.c:6837
 net_rx_action+0x4a6/0xe00 net/core/dev.c:7910
 handle_softirqs+0x1de/0x6f0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 irq_forced_thread_fn+0xe9/0x120 kernel/irq/manage.c:1168
 irq_thread+0x4c9/0x740 kernel/irq/manage.c:1271
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88806944e200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806944e280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806944e300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88806944e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806944e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
