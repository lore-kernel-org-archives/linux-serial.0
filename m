Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C42E2F0E
	for <linux-serial@vger.kernel.org>; Wed, 29 Jul 2026 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289052; cv=none; b=MCTEKDOvT+xdA8ABWfelHbQiZamjwlIc0fvs1bVTiwQaHW8kK7RaQ9Befmu9lwTgs8HpgpF0Mf9pOxaBDDsfM/kNJ2GPwJnYowmpuMut0bjrHUPvhkBSdg7q6B5Ve+2OcMANRwBJHJxTYK7If3l1IztilHM1y+EkIaqtuEphjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289052; c=relaxed/simple;
	bh=8z6yHIDodbK2/evBqFmmIA9Bubk1/OAjd3g7R+GWeJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=by+P2PqXKlTHH9P6/6o7nXfM4xpJ1mUsAYZRoEP/IOf2H3PKmWSj1jD7gMaf5Uhpb3Iw25E56KgnxQq4QZuDE/Wg5n7pdjIRrqqjoHl25Hft/wMGAFOdZN+ZO0+cvyMN6pKgHc12UnsZ8AY/ve/Yw7nqvfu5NcBSuGzytKAiTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-485ebc5706cso2287520b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 28 Jul 2026 18:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785289049; x=1785893849;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYfwPz3va9wjPu0vwpAwWo2GAzIYZiu1aqE4+GFrFnA=;
        b=Ki8XnOUpO2y+mZyp2GeLoA3TuG2s7MbwZ+f3V43adkOmrUKunpwZx89NssEun78onW
         +AWpWnwQfoi+lPgB48us07HRiYfnz9nr33p8/TefX9dEkxNj0lesj6v1uLB2oBk+yC4C
         9ztEW4nzyGPHPlhwbBOO28mvNKWcfgHTbD8fEofwdzeBzlCq54+64pFLo0BIGzC82KEq
         xNpTqRPihkNFWeSI46fQMPjaeVZ7DDNmcxWatgVbRjVBlitu9FMLGbK7rdWFegUqbmPm
         nv6Lba+jlT7x32xQnhxbTAi/udvGbzqp6BmeiRxoKV+41JI1oTg0JVc0oRnGfjc1Mwd6
         i5qQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnOjJMZmYBuI/eFXpv5gE5pmCNQ0J6qAPP0Aw5wMy8rjGRihfe9x7idvNFcMTX1zvxT80EaLTDuEmMfKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzrZd8PodVr+m7f4n/erNyKRxbp+b4m95y4IelZe2q+6ak1Fn
	naNZHi7D3tVB+yc1s6mnJ6SQzYBSO4FlFVl9NL5HPTbesjHLvewm40JazTJ0cqAbiJ+Jw5jsBlz
	ohAuxcoCrUuvf9cmgrLzcKtriTQSfKr1skGBabWizV568wHsIbRvRoAmAl4o=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1183:b0:4a4:933:dc11 with SMTP id
 5614622812f47-4ad73345dafmr158760b6e.20.1785289049589; Tue, 28 Jul 2026
 18:37:29 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:37:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a695959.d9e86bb5.297b12.0047.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Read in serial_core_unregister_port
From: syzbot <syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4235cb24ec1e Merge tag 'vfs-7.2-rc5.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13121632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=9f57c1b2792029198fcf
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4235cb24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec3ae6d544eb/vmlinux-4235cb24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9fdf37e3c4b/bzImage-4235cb24.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5333 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x40c/0x560 lib/fault-inject.c:174
 should_failslab+0xa8/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4539 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0xfe/0x720 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 serial_core_add_one_port drivers/tty/serial/serial_core.c:3109 [inline]
 serial_core_register_port+0xe73/0x2840 drivers/tty/serial/serial_core.c:3322
 serial8250_unregister_port+0x39c/0x720 drivers/tty/serial/8250/8250_core.c:892
 serial8250_remove+0x87/0xc0 drivers/tty/serial/8250/8250_platform.c:241
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 unbind_store+0x1a1/0x1d0 drivers/base/bus.c:244
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde8d99de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde8e8aafe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fde8dc25fa0 RCX: 00007fde8d99de99
RDX: 000000000000000a RSI: 0000200000000600 RDI: 0000000000000003
RBP: 00007fde8e8ab050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fde8dc26038 R14: 00007fde8dc25fa0 R15: 00007ffee26ea9b8
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in serial_core_get_ctrl_dev drivers/tty/serial/serial_core.c:3236 [inline]
BUG: KASAN: slab-use-after-free in serial_core_ctrl_find drivers/tty/serial/serial_core.c:3259 [inline]
BUG: KASAN: slab-use-after-free in serial_core_unregister_port+0x93f/0xb40 drivers/tty/serial/serial_core.c:3358
Read of size 8 at addr ffff88801f578040 by task syz.0.0/5333

CPU: 0 UID: 0 PID: 5333 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 serial_core_get_ctrl_dev drivers/tty/serial/serial_core.c:3236 [inline]
 serial_core_ctrl_find drivers/tty/serial/serial_core.c:3259 [inline]
 serial_core_unregister_port+0x93f/0xb40 drivers/tty/serial/serial_core.c:3358
 serial8250_unregister_port+0x27d/0x720 drivers/tty/serial/8250/8250_core.c:883
 serial8250_remove+0x87/0xc0 drivers/tty/serial/8250/8250_platform.c:241
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 unbind_store+0x1a1/0x1d0 drivers/base/bus.c:244
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fde8d99de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde8e8aafe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fde8dc25fa0 RCX: 00007fde8d99de99
RDX: 000000000000000a RSI: 0000200000000600 RDI: 0000000000000003
RBP: 00007fde8e8ab050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fde8dc26038 R14: 00007fde8dc25fa0 R15: 00007ffee26ea9b8
 </TASK>

Allocated by task 5333:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x32d/0x660 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 serial_base_port_add+0x5b/0x270 drivers/tty/serial/serial_base_bus.c:159
 serial_core_port_device_add drivers/tty/serial/serial_core.c:3275 [inline]
 serial_core_register_port+0x37f/0x2840 drivers/tty/serial/serial_core.c:3314
 serial8250_unregister_port+0x39c/0x720 drivers/tty/serial/8250/8250_core.c:892
 serial8250_remove+0x87/0xc0 drivers/tty/serial/8250/8250_platform.c:241
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 unbind_store+0x1a1/0x1d0 drivers/base/bus.c:244
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5333:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6692
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 serial_core_register_port+0x55b/0x2840 drivers/tty/serial/serial_core.c:3329
 serial8250_unregister_port+0x39c/0x720 drivers/tty/serial/8250/8250_core.c:892
 serial8250_remove+0x87/0xc0 drivers/tty/serial/8250/8250_platform.c:241
 device_remove drivers/base/dd.c:616 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x48b/0x880 drivers/base/dd.c:1372
 unbind_store+0x1a1/0x1d0 drivers/base/bus.c:244
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801f578000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 64 bytes inside of
 freed 2048-byte region [ffff88801f578000, ffff88801f578800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f578
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u4:0), ts 100787266514, free_ts 99036531444
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_node_track_caller_noprof+0x557/0x730 mm/slub.c:5471
 kmalloc_reserve net/core/skbuff.c:637 [inline]
 __alloc_skb+0x2bd/0x7a0 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 mld_newpack+0x165/0xcb0 net/ipv6/mcast.c:1789
 add_grhead net/ipv6/mcast.c:1900 [inline]
 add_grec+0x119f/0x19d0 net/ipv6/mcast.c:2039
 mld_send_initial_cr+0x288/0x550 net/ipv6/mcast.c:2284
 ipv6_mc_dad_complete+0x87/0x410 net/ipv6/mcast.c:2295
 addrconf_dad_completed+0x8af/0xe60 net/ipv6/addrconf.c:4375
 addrconf_dad_work+0xcf8/0x15c0 net/ipv6/addrconf.c:-1
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
page last free pid 75 tgid 75 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_unref_folios+0xd84/0x14a0 mm/page_alloc.c:3011
 shrink_folio_list+0x2b7d/0x5330 mm/vmscan.c:1513
 evict_folios+0x3821/0x4b40 mm/vmscan.c:4835
 try_to_shrink_lruvec+0xb4f/0xed0 mm/vmscan.c:4983
 shrink_one+0x233/0x730 mm/vmscan.c:5024
 shrink_many mm/vmscan.c:5087 [inline]
 lru_gen_shrink_node mm/vmscan.c:5165 [inline]
 shrink_node+0x3303/0x3b60 mm/vmscan.c:6154
 kswapd_shrink_node mm/vmscan.c:7008 [inline]
 balance_pgdat mm/vmscan.c:7186 [inline]
 kswapd+0x17b6/0x31c0 mm/vmscan.c:7462
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88801f577f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801f577f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801f578000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88801f578080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f578100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
