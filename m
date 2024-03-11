Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B42AEFA
	for <linux-serial@vger.kernel.org>; Mon, 11 Mar 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167664; cv=none; b=unNTf0mecmk6EcgqAazQ6IMb7zmQcQy8gyyuTOxd10IU95xtqgR1icDlzUC5/LKa4I6dLKqPvpi8MmQtHWb8fMOcG0aSGhq2deM5+kkBC+eIWNI8SSZaLKNnsjvg8JODwkQPJSLTdlbKQqiYwVgp3nsUqQJ/J3REj1+QUnCumuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167664; c=relaxed/simple;
	bh=Muz2HkEuV2W5sUy7rgSdH24wlCpX0mbkWWCjYfbkGIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pJ5mWsk+DavU2ZTzqHxYG0ZpzUBwPbBV1DMvQ0gAd+ijgqSXZoh41yL/vZX5MmZ2nHOBQTcp/K5ejLw4Xp3nrTXuh9DVIrsSnAo2B06u4pNhnltx18Uuu7p9lhaf1O3tCIt9M8RD5bKK8P/usYIHZfa3OTdJOYgv8nse+QPNKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8a8d93507so151414439f.0
        for <linux-serial@vger.kernel.org>; Mon, 11 Mar 2024 07:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167662; x=1710772462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxjuhAqoOi3wIe760+n1vTOpLju+lhk+tlBCOkRQIQw=;
        b=lFW2rfLmmFPf34557UzR1qSv4MLYNxEBFHnDQXpbtFpWRhX8jJo8OjDiT6wqghJy64
         UVpf7js4Rn7XE8EbretNNu+BObEARpqWeVs8l67XG4XpME9AVqJK1m1QiOv9CVDrNNZW
         GrvQPpUnWsxOWb2d0Rb2w7YAmvWuu4kXIVI2kR9iQIvhqa4DTs/AfDpwB6jU7YSsWd0c
         /Ef8GHXeQO+G7IPPs5zHwMppNHwt4AfTB6tAbzyJq6zjG1lTTRvhg0wQxSswWwwgXBug
         nk8QUTU1jp0Ytq4RnQKhPixKx8S8NQvyBj666iOGNl0+eq25pCvqgSQDRPC+5698zBDL
         o93Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1e1wre3Mkl94hBq6VSW996jYHNiNxKU961JHRVJV3pg7FXm8Du8KuiOz1manTcygXvR9z1/PGmejWRaC7/99VNngx8YBrEIo+9e1f
X-Gm-Message-State: AOJu0YzttigvTNb+aE7u78om6fJzwy9p4qrOftNr9PJ17X02ZdJrgW+2
	8X2qGeWUrpwB/L4XQe0v9aEY3w+Wp2yfl2kwNtIJ6USZgecJDLcz2zMqk7h6wUrWKRa35mVtTVE
	w7nMsmJ310/+Eg0JedXuZHsamRx2lojxkgwfOQQqat9lqLXqWkoo4FE4=
X-Google-Smtp-Source: AGHT+IGY8NERYK7VAxbkNAPPkwPh1FZzJ8f/iWfqdZAQ/AO8UvjVR4GNbKRoDdhsSgmxOuxlvXq7G8kOeGhDDvM3lwp3wMr+7bUe
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3710:b0:474:c16c:45b5 with SMTP id
 k16-20020a056638371000b00474c16c45b5mr443957jav.5.1710167661815; Mon, 11 Mar
 2024 07:34:21 -0700 (PDT)
Date: Mon, 11 Mar 2024 07:34:21 -0700
In-Reply-To: <000000000000f3b90a060f1178f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd3d660613636f95@google.com>
Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Read in
 tty_write_room (2)
From: syzbot <syzbot+2a81fdd5c6ddffee3894@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e8f897f4afef Linux 6.8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1729f41a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba47157efb89052
dashboard link: https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f338d1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa5aa46d901e/disk-e8f897f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c87fe0fa468/vmlinux-e8f897f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/94beb1f39151/bzImage-e8f897f4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a81fdd5c6ddffee3894@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
==================================================================
BUG: KASAN: slab-use-after-free in tty_write_room+0x35/0x90 drivers/tty/tty_ioctl.c:68
Read of size 8 at addr ffff88801f7e6020 by task aoe_tx0/1238

CPU: 1 PID: 1238 Comm: aoe_tx0 Not tainted 6.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 tty_write_room+0x35/0x90 drivers/tty/tty_ioctl.c:68
 handle_tx+0x164/0x640 drivers/net/caif/caif_serial.c:226
 __netdev_start_xmit include/linux/netdevice.h:4986 [inline]
 netdev_start_xmit include/linux/netdevice.h:5000 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x244/0x770 net/core/dev.c:3563
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3169 [inline]
 tx+0x6a/0x110 drivers/block/aoe/aoenet.c:62
 kthread+0x23b/0x440 drivers/block/aoe/aoecmd.c:1229
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 8605:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d6/0x360 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 alloc_tty_struct+0xa9/0x7d0 drivers/tty/tty_io.c:3116
 tty_init_dev+0x5b/0x4c0 drivers/tty/tty_io.c:1415
 ptmx_open+0xda/0x2c0 drivers/tty/pty.c:824
 chrdev_open+0x5b2/0x630 fs/char_dev.c:414
 do_dentry_open+0x909/0x15a0 fs/open.c:953
 do_open fs/namei.c:3645 [inline]
 path_openat+0x285f/0x3240 fs/namei.c:3802
 do_filp_open+0x234/0x490 fs/namei.c:3829
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1430
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 5161:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x380 mm/slub.c:4409
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x915/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:551
 insert_work+0x3e/0x330 kernel/workqueue.c:1653
 __queue_work+0xbf4/0x1000 kernel/workqueue.c:1802
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1837
 tty_release_struct+0xbc/0xe0 drivers/tty/tty_io.c:1707
 tty_release+0xd0c/0x12c0 drivers/tty/tty_io.c:1867
 __fput+0x42b/0x8a0 fs/file_table.c:376
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1539
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff88801f7e6000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 32 bytes inside of
 freed 2048-byte region [ffff88801f7e6000, ffff88801f7e6800)

The buggy address belongs to the physical page:
page:ffffea00007df800 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801f7e5000 pfn:0x1f7e0
head:ffffea00007df800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880217f6b81
flags: 0xfff00000000a40(workingset|slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000a40 ffff888014c4f3c0 ffffea0001ae3e10 ffffea0001ac3610
raw: ffff88801f7e5000 0000000000080006 00000001ffffffff ffff8880217f6b81
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5098, tgid 5098 (syz-executor.4), ts 200401248275, free_ts 200027547453
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node+0x2d6/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x72/0x190 mm/util.c:617
 kvmalloc include/linux/slab.h:728 [inline]
 kvmalloc_array include/linux/slab.h:746 [inline]
 alloc_fdtable+0xe7/0x280 fs/file.c:136
 dup_fd+0x839/0xc50 fs/file.c:354
 copy_files+0x14f/0x2a0 kernel/fork.c:1789
 copy_process+0x1c14/0x3fc0 kernel/fork.c:2485
 kernel_clone+0x21d/0x8d0 kernel/fork.c:2902
 __do_sys_clone kernel/fork.c:3045 [inline]
 __se_sys_clone kernel/fork.c:3029 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:3029
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
page last free pid 5111 tgid 5111 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 __slab_free+0x349/0x410 mm/slub.c:4211
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_lru+0x172/0x350 mm/slub.c:3879
 alloc_inode_sb include/linux/fs.h:3018 [inline]
 alloc_inode fs/inode.c:262 [inline]
 new_inode_pseudo+0x8b/0x1e0 fs/inode.c:1005
 new_inode+0x22/0x1d0 fs/inode.c:1031
 debugfs_get_inode fs/debugfs/inode.c:72 [inline]
 __debugfs_create_file+0x14d/0x490 fs/debugfs/inode.c:437
 add_sta_files net/mac80211/debugfs_netdev.c:850 [inline]
 add_files net/mac80211/debugfs_netdev.c:959 [inline]
 ieee80211_debugfs_add_netdev net/mac80211/debugfs_netdev.c:1012 [inline]
 ieee80211_debugfs_recreate_netdev+0xc5a/0x1400 net/mac80211/debugfs_netdev.c:1045
 ieee80211_if_add+0x988/0x1770 net/mac80211/iface.c:2169
 ieee80211_register_hw+0x2fc7/0x3b80 net/mac80211/main.c:1418
 mac80211_hwsim_new_radio+0x250e/0x4400 drivers/net/wireless/virtual/mac80211_hwsim.c:5329
 hwsim_new_radio_nl+0xe4c/0x21d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6010
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xad8/0xe50 net/netlink/genetlink.c:1208

Memory state around the buggy address:
 ffff88801f7e5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801f7e5f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801f7e6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88801f7e6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f7e6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
