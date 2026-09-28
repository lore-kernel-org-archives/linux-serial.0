Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65397547075
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790556337; cv=none; b=iKhe/zGFuqjgO5jQ05K/zuke/9dGHbx0jc54UjdhNV7eYFeVuIew+qXHB/r5U2FjI51hYt5elNN8Ws/oKqOwWtY8quqE2P9ullHOxwU4G2ROwD8AuSzofEQ55kEQSD9LYYIizBKVZk0ZMRs/TOkET4FIQXAFrdBUYYryuUiMJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790556337; c=relaxed/simple;
	bh=BnIGEibz8Xw+DjOIycdXq11EkeD2j6Syg+GjYw8qM5U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wgx+nDwCrsE/aw3BTZdJgCDeOUjQi4jkfer7TAMpl5gbG11MS6igctB89TaxF5YQsodFLVV5n79bIJ+NDauly8c7b+gNyr149WIZfndz9OM18ta20i+qcw5iZjz5yhQK7/7BXVI94vAUx/wX+DXp+EGbYl2m9USUOP2WVuI58ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cbf700ddccso2817971b6e.0
        for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 17:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790556334; x=1791161134;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=09MBUf3G+zc8XVi1unMtT7iI4bGusWQamBoaPObpOc8=;
        b=vryniNTNw9wHZwqwRujSkwBK03Oj1smN/XEnqZSjjlroQUYtlzuj2R7tGXWNPQJpvD
         J0lbdpvDboJFSXqjh8u+OIKvAG8fRXynuUQ+lmgukDzefBFg5fI4b0fzbVZiJ89mHxDj
         mGd/c5P6VMpQ7kj3GUH4jsnMhkLcn/IEO8HtBnreu+MWlIdCIF0awUdx9L2/u2hkk4lE
         wh5jVsSNjMblageTZLGpTJ7Zgh2Y0R9PXwHv5qILXyrfg/QIvpQ3Oqsr0OsfxOHyeBlv
         2OQ5U1CGgOF8AYVQeRwnpkKNL6ZRNNyzNnrkD5prfRSa4x/COSjikq34C9VHliKo00va
         S0ag==
X-Forwarded-Encrypted: i=1; AKwUvBzF5mPpcSsRPzzhCeUdS3GRKnuzeTMRLHsFUUSIjOoiysdX9+59NLkF5i5ybFU+cDRld9L3qE7FNgoph3g=@vger.kernel.org
X-Gm-Message-State: AFuF++mKzchElvxIantb6YmKhjR91I/NbAFMYsOT87+H8v6kEj+H3mjZ
	9bPWdlQWD9BaeJntXgsR8lJqZB2h4rvmG8/wYx/04sFDUYnMiFJiudRDTtSptEIAnzJG04G3jj7
	U56pBsuXo1i83JiBPxzxiARRLCjZYfNKxr1K34ycQxp+NNVot68TsRULsDJM=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1e:b0:4d6:92b3:5c84 with SMTP id
 5614622812f47-4dc69d1c59amr7708046b6e.65.1790556334344; Sun, 27 Sep 2026
 17:45:34 -0700 (PDT)
Date: Sun, 27 Sep 2026 17:45:34 -0700
In-Reply-To: <69d56a91.050a0220.28fc4.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab9b8ae.dc2998a4.2261f5.0071.GAE@google.com>
Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Read in kbd_event (2)
From: syzbot <syzbot+098cefc0911c68db5dab@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tahernady45@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    efb44d93a620 Merge tag 'x86-urgent-2026-09-27' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=132c325e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=718e346eb0b8f38
dashboard link: https://syzkaller.appspot.com/bug?extid=098cefc0911c68db5dab
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150fe605580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+098cefc0911c68db5dab@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:181
Read of size 1 at addr ffff88803a627418 by task syz-executor104/5953

CPU: 0 UID: 0 PID: 5953 Comm: syz-executor104 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x7d/0x350 kernel/locking/lockdep.c:5916
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:155 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:181
 rt_mutex_slowunlock+0xbf/0xa30 kernel/locking/rtmutex.c:1430
 rt_spin_unlock+0x10f/0x200 kernel/locking/spinlock_rt.c:84
 kbd_keycode drivers/tty/vt/keyboard.c:1574 [inline]
 kbd_event+0x2e8d/0x41f0 drivers/tty/vt/keyboard.c:1592
 input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2614
 input_pass_values+0x288/0x890 drivers/input/input.c:128
 input_event_dispose+0x35f/0x700 drivers/input/input.c:342
 input_event+0x87/0xb0 drivers/input/input.c:396
 uinput_inject_events drivers/input/misc/uinput.c:660 [inline]
 uinput_write+0x3be/0xfe0 drivers/input/misc/uinput.c:682
 vfs_write+0x29f/0xbb0 fs/read_write.c:685
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb964fdc25e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fb962f82168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb962f826c0 RCX: 00007fb964fdc25e
RDX: 0000000000000030 RSI: 00007fb962f821d0 RDI: 0000000000000003
RBP: 0000000100460001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000000 R14: 00007ffec9fa4910 R15: 00007ffec9fa49f8
 </TASK>

Allocated by task 5950:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 alloc_tty_struct+0xa6/0x7a0 drivers/tty/tty_io.c:3075
 tty_init_dev+0x59/0x4d0 drivers/tty/tty_io.c:1373
 tty_open_by_driver drivers/tty/tty_io.c:2046 [inline]
 tty_open+0x7e5/0xcd0 drivers/tty/tty_io.c:2093
 chrdev_open+0x4dc/0x600 fs/char_dev.c:411
 do_dentry_open+0x849/0x1420 fs/open.c:996
 vfs_open+0x3b/0x350 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1448/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 31:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6801
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 insert_work+0x3d/0x330 kernel/workqueue.c:2272
 __queue_work+0xd4b/0x1120 kernel/workqueue.c:2448
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2501
 tty_open_by_driver drivers/tty/tty_io.c:2042 [inline]
 tty_open+0x988/0xcd0 drivers/tty/tty_io.c:2093
 chrdev_open+0x4dc/0x600 fs/char_dev.c:411
 do_dentry_open+0x849/0x1420 fs/open.c:996
 vfs_open+0x3b/0x350 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1448/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803a627000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 1048 bytes inside of
 freed 2048-byte region [ffff88803a627000, ffff88803a627800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3a620
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ff073c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000200080008 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ff073c0 dead000000000100 dead000000000122
head: 0000000000000000 0000000200080008 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5620, tgid 5620 (syz-executor), ts 116331677010
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2591/0x2600 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x230/0x5c0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab+0x7d/0x620 mm/slub.c:3462
 new_slab mm/slub.c:3513 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x339/0x690 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x54b/0x790 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 __register_sysctl_table+0x6f/0x1370 fs/proc/proc_sysctl.c:1378
 __devinet_sysctl_register+0x36d/0x470 net/ipv4/devinet.c:2745
 devinet_sysctl_register+0x187/0x200 net/ipv4/devinet.c:2785
 inetdev_init+0x29e/0x4d0 net/ipv4/devinet.c:291
 inetdev_event+0x307/0x15e0 net/ipv4/devinet.c:1590
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
 call_netdevice_notifiers net/core/dev.c:2327 [inline]
 register_netdevice+0x18c0/0x1ed0 net/core/dev.c:11552
 register_netdev+0x40/0x60 net/core/dev.c:11631
 vti6_init_net+0x259/0x3b0 net/ipv6/ip6_vti.c:1173
page last free pid 5434 tgid 5434 ts 92300899086 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xf8e/0x1070 mm/page_alloc.c:2962
 __slab_free+0x250/0x2a0 mm/slub.c:5823
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x360/0x690 mm/slub.c:5010
 alloc_buffer_head+0x2a/0x280 fs/buffer.c:2872
 folio_alloc_buffers+0x1fa/0x6f0 fs/buffer.c:743
 create_empty_buffers+0x3a/0x520 fs/buffer.c:1576
 ext4_block_write_begin+0x610/0x1560 fs/ext4/inode.c:1193
 ext4_da_write_begin+0x879/0xd70 fs/ext4/inode.c:3167
 generic_perform_write+0x2ad/0x8b0 mm/filemap.c:4374
 ext4_buffered_write_iter+0xd5/0x380 fs/ext4/file.c:354
 ext4_file_write_iter+0xafc/0x1d00 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739

Memory state around the buggy address:
 ffff88803a627300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803a627380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803a627400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88803a627480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803a627500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
