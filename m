Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5347E361968
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478475; cv=none; b=HOLKNyfZioyomDTMmzZyFRAG9ATaCBTzq0Tpt/lP6ofmfpNHy6A4YwdHtQ+fP/HT3gC0o7/KftOx2Hd55om/V27/LexD/23CCGl6C42bR9e42MoI5Tfa/2WTOHImWRARaJG+1l+vuSLMpVNWgVuMoxqfg51s2y7437xt5cv1NOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478475; c=relaxed/simple;
	bh=H7MNrKi+mj2cg0MMhV3B/oWqg+fXdkiwU2V8kgUyti4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iruXA4822cdZzMl8txXOAjGOW8oBOLOvgjrKW4xtMNP1rBLgMP5uo0KjK0BYS6bYUMsOtASVec27gz714zDqA7cmO5/WT9E2I6yybit5OhQfag1Gcg0qAXO+5pVMoBLnVrh86VpZKMHBiTwo8wjpAELwA0yH/FUmGK1/4kPVIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4a41e3d6fe9so885498b6e.2
        for <linux-serial@vger.kernel.org>; Thu, 30 Jul 2026 23:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785478472; x=1786083272;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gr68kdbX02hkM+36W6qy0XfL72tz3DM0wOdhFb+OG+c=;
        b=EBGMRRxAXiT50GSuYOWi2aYOwQjQ0B8s3VhyZJtWDWlrVNyRF8sWme+4URcvU9+4fp
         eJASGYimrPAAJU97HfwxOfnkOKNXSnTe7c/LzbR0Wdi+DVK3ljftp/cl9j18TTkde8sd
         LKDWuw/Qmr91gEpui3R34DSGuvIFeFEE+f1GSJTlP69pHO+8YH3SNjDecevg+DF2JmlY
         0VfEtyMGDKrTVe+6ZcPHyWQA14x7CqNMS1TLu9eiasNyVFCY5L+Fnbw1VmphbUsAPn9p
         KJ58VGqYmn4flrj6F1vLdZ1uy7Fe+x9Ub9YCTN4uEYQnmETDvAOj+JpesZJ8EUUBjCYk
         JOGA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0X2/df2uWKxHFBTjP/6DAr+eGZZ++sc03+TNeKd42GEVg5II7TU7DVwLzajACMmGUUyG9M1SI0I4MmP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAxB8DR2D8CeXICVZgZ5kRfQJK1q0w/MVwhvbUXHb4cO91dw4
	DsIZXpPx6euL7GDnUQY1qwbEUa9lAc+h4yjtne1WRlYqKT1IFgVOdlqyjANgUv1KkfoQ/3lqf0U
	wwoT3I+q0shXsdoICLXvKVEHYgH/1anE5Gc12nT+LgFFlsEYK96T5urYQvtM=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5147:b0:4a3:d383:b3ea with SMTP id
 5614622812f47-4ae5ad1a897mr545264b6e.27.1785478472342; Thu, 30 Jul 2026
 23:14:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:14:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6c3d48.5cf34cee.28a846.0008.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-use-after-free Write in tty_init_dev
From: syzbot <syzbot+fe63e4d633540f230624@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fc02acf6ac0c Merge tag 'platform-drivers-x86-v7.2-4' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133e003e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=fe63e4d633540f230624
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/67251350dd03/disk-fc02acf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4edd57a8c61/vmlinux-fc02acf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04ff166cc853/bzImage-fc02acf6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe63e4d633540f230624@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in tty_init_dev.part.0+0x44f/0x470 drivers/tty/tty_io.c:1424
Write of size 8 at addr ffff88807ca6c128 by task syz.4.611/10653

CPU: 1 UID: 0 PID: 10653 Comm: syz.4.611 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 tty_init_dev.part.0+0x44f/0x470 drivers/tty/tty_io.c:1424
 tty_init_dev include/linux/err.h:78 [inline]
 tty_open_by_driver drivers/tty/tty_io.c:2073 [inline]
 tty_open+0xa63/0xfa0 drivers/tty/tty_io.c:2120
 chrdev_open+0x234/0x6a0 fs/char_dev.c:411
 do_dentry_open+0x6ab/0x14d0 fs/open.c:947
 vfs_open+0x82/0x3f0 fs/open.c:1052
 do_open fs/namei.c:4700 [inline]
 path_openat+0x2873/0x4280 fs/namei.c:4863
 do_file_open+0x20e/0x430 fs/namei.c:4892
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4bb7d9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4bb8ba3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f4bb8026270 RCX: 00007f4bb7d9de99
RDX: 0000000000000002 RSI: 0000200000000800 RDI: ffffffffffffff9c
RBP: 00007f4bb7e33eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4bb8026308 R14: 00007f4bb8026270 R15: 00007ffee78b82f8
 </TASK>

Allocated by task 10639:
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
 gser_alloc_inst+0x86/0x100 drivers/usb/gadget/function/f_serial.c:325
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

Freed by task 10641:
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
 gser_free_inst+0x3b/0x50 drivers/usb/gadget/function/f_serial.c:311
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

The buggy address belongs to the object at ffff88807ca6c000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 296 bytes inside of
 freed 2048-byte region [ffff88807ca6c000, ffff88807ca6c800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ca68
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe28000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe28000 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5609, tgid 5609 (syz-executor), ts 72918138577, free_ts 72897580454
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
 __kmalloc_cache_noprof+0x479/0x6c0 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 rxrpc_alloc_connection+0xa3/0x770 net/rxrpc/conn_object.c:62
 rxrpc_prealloc_service_connection+0x26/0x390 net/rxrpc/conn_service.c:123
 rxrpc_service_prealloc_one+0x2c5/0x1040 net/rxrpc/call_accept.c:86
 rxrpc_kernel_charge_accept+0xdd/0x120 net/rxrpc/call_accept.c:489
 afs_charge_preallocation+0xd8/0x360 fs/afs/rxrpc.c:766
 afs_open_socket+0x31e/0x3f0 fs/afs/rxrpc.c:112
 afs_net_init+0x825/0xb00 fs/afs/main.c:116
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
page last free pid 5618 tgid 5618 stack trace:
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
 __kmalloc_cache_noprof+0x265/0x6c0 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 netdev_name_node_alloc net/core/dev.c:276 [inline]
 netdev_name_node_head_alloc net/core/dev.c:290 [inline]
 register_netdevice+0x50c/0x25a0 net/core/dev.c:11359
 __ip_tunnel_create+0x52b/0x670 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x230/0x780 net/ipv4/ip_tunnel.c:1150
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:579
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0xf2/0x220 kernel/nsproxy.c:234
 ksys_unshare+0x438/0xab0 kernel/fork.c:3269
 __do_sys_unshare kernel/fork.c:3343 [inline]
 __se_sys_unshare kernel/fork.c:3341 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3341
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffff88807ca6c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ca6c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807ca6c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88807ca6c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ca6c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
