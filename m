Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D41F4191
	for <linux-serial@vger.kernel.org>; Sat,  6 Sep 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757142034; cv=none; b=Us6qTbe87idDozVWH8Clxvmt4R7l3I+sMrcQ+ZELX5B7lq6DaQ91yMbwdDjRUYCujWz1tQ2Ldg2NBpaB2MW7KZRHbXaI0NC3olJqw1wHVSeih7KVq9Q5p0V9xqZ5K2MUdLmV2MIp5FjolTJ+NCjGQASHC9lia+szYLtnEZz58tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757142034; c=relaxed/simple;
	bh=SHgws0gGg+fNmvImD3TlMbp4DWJ4s0janFF8hqa/3E0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MH9ALWqtLgCWJ1l0nUJ18TPyukKF0sIyY4+pYX55d+xit87mvzfAjNbJd+7iNxSPP3CowrMJ4lsKMmF3tEgP68qJIiRZQ8lzNpM9W7gy0eTIin4SHd35cmb9AI2hGZ5cfOlIRitTcAox3w9gGH5bot7L5aXCWr9nnCbG6IEpBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8875e3b715bso627139639f.3
        for <linux-serial@vger.kernel.org>; Sat, 06 Sep 2025 00:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757142031; x=1757746831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGAIqqn4Kt7ezAKc89NxtvJYNMUZppmyY5pMx+h0tU0=;
        b=rOKMoOfVUINPe0MkRS8eNVAnxqwz/E/JDEVzarOzHbVHZgLcLOsj2zY2Qr8gCQxEYW
         i9kJmhdlajY5Ihwog288CVyJBaVE7qOr+sNilrjJVTyVBfJ2L5ssCUe10TeM54Qdyydj
         kBY4sS3XezsuYFLQK/Fv6aXA8MK2NjfYRwj/MJerJY2FIdq4nmqMXMJmNM6EHqXkZ6my
         +hi+UdZbO9uevjI9K7D+nKDZ3bxWW4q8++SBM+YpnMlMFH+Yog3VjFrG8aLUalnCbqOk
         3gWvEJR2H7+DKOtO/ayfFL4VSlotXT115Dupwp5hHGVsHXR9oGsG8aFrdqC/Yi0ZG/XB
         1IkA==
X-Forwarded-Encrypted: i=1; AJvYcCW0oKEWmvWLUfxLstz6f9Vrauqi0O+1GOHuttOCF8kThPWBD+L2AAVa7WSqt37PMnkP1Ko925HM2sUj+nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKs9eGFMVt6TRw0kuhhcrGy/4APv0lys2cuHbAnstW8FW8sBbN
	PCHa5RCqj/lc6hLwlJdOj9PpZdTrr4sayBCoD+kOfi9GDeQCm/zLYiQDr56749dHAC0c2hY2BC5
	j9Zlu2yNmk45B8M89W4PbI10K5CByDyz65sCZY565IMOflXCXYlUi85Mc4sg=
X-Google-Smtp-Source: AGHT+IG8nHuA8pmAHNIA/FYPwzRZiOvyNflxHsXtuDaueyNrEoqa2R+ztHL0GVKM2/FJquFf+QVietDwRwUjaNfMnrVpexr1e6qQ
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d11:b0:883:ee95:7266 with SMTP id
 ca18e2360f4ac-8877768cf57mr198023439f.9.1757142031570; Sat, 06 Sep 2025
 00:00:31 -0700 (PDT)
Date: Sat, 06 Sep 2025 00:00:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bbdc0f.050a0220.192772.01a8.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-out-of-bounds Write in do_con_write (2)
From: syzbot <syzbot+1046ca04f5ba70aa8206@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c8ed9b5c02a5 Merge tag 'drm-fixes-2025-09-05' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110ca962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
dashboard link: https://syzkaller.appspot.com/bug?extid=1046ca04f5ba70aa8206
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4da8d56aff3a/disk-c8ed9b5c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1366baa37dbc/vmlinux-c8ed9b5c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0674b31d870d/bzImage-c8ed9b5c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1046ca04f5ba70aa8206@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in vc_con_write_normal drivers/tty/vt/vt.c:3086 [inline]
BUG: KASAN: slab-out-of-bounds in do_con_write+0x3839/0x8280 drivers/tty/vt/vt.c:3178
Write of size 2 at addr ffff88803467ff96 by task syz.3.1321/12594

CPU: 0 UID: 0 PID: 12594 Comm: syz.3.1321 Tainted: G     U              syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 vc_con_write_normal drivers/tty/vt/vt.c:3086 [inline]
 do_con_write+0x3839/0x8280 drivers/tty/vt/vt.c:3178
 con_write+0x23/0xb0 drivers/tty/vt/vt.c:3516
 process_output_block drivers/tty/n_tty.c:561 [inline]
 n_tty_write+0x41c/0x11e0 drivers/tty/n_tty.c:2377
 iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
 file_tty_write.constprop.0+0x504/0x9b0 drivers/tty/tty_io.c:1081
 tty_write drivers/tty/tty_io.c:1102 [inline]
 redirected_tty_write drivers/tty/tty_io.c:1125 [inline]
 redirected_tty_write+0xd4/0x150 drivers/tty/tty_io.c:1105
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc5798ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc58815038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efc57bc5fa0 RCX: 00007efc5798ebe9
RDX: 0000000000000028 RSI: 00002000000005c0 RDI: 0000000000000003
RBP: 00007efc57a11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efc57bc6038 R14: 00007efc57bc5fa0 R15: 00007ffe3160a858
 </TASK>

Allocated by task 5865:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kvmalloc_node_noprof+0x27b/0x620 mm/slub.c:5067
 netif_alloc_rx_queues net/core/dev.c:10936 [inline]
 alloc_netdev_mqs+0xc82/0x1530 net/core/dev.c:11882
 rtnl_create_link+0xc08/0xf90 net/core/rtnetlink.c:3633
 rtnl_newlink_create net/core/rtnetlink.c:3815 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3942 [inline]
 rtnl_newlink+0xb69/0x2000 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 __sys_sendto+0x4a0/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803467e000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3990 bytes to the right of
 allocated 4096-byte region [ffff88803467e000, ffff88803467f000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34678
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b84b500 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b84b500 0000000000000000 0000000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000d19e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5239, tgid 5239 (udevd), ts 58016202013, free_ts 57921496167
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab mm/slub.c:2660 [inline]
 new_slab+0x247/0x330 mm/slub.c:2714
 ___slab_alloc+0xcf2/0x1750 mm/slub.c:3901
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3992
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kvmalloc_node_noprof+0x3b1/0x620 mm/slub.c:5067
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x826/0x12c0 fs/seq_file.c:210
 kernfs_fop_read_iter+0x40f/0x5a0 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:491 [inline]
 vfs_read+0x8bf/0xcf0 fs/read_write.c:572
 ksys_read+0x12a/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5242 tgid 5242 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 discard_slab mm/slub.c:2758 [inline]
 __put_partials+0x165/0x1c0 mm/slub.c:3223
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x1d4/0x510 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xc2/0x6e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2377
 vfs_getattr fs/stat.c:259 [inline]
 vfs_statx_path fs/stat.c:299 [inline]
 vfs_statx+0x121/0x3f0 fs/stat.c:356
 vfs_fstatat+0x7b/0xf0 fs/stat.c:375
 __do_sys_newfstatat+0x97/0x120 fs/stat.c:542
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803467fe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803467ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803467ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff888034680000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888034680080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
