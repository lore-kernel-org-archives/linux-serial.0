Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9253427991E
	for <linux-serial@vger.kernel.org>; Thu, 26 Feb 2026 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094685; cv=none; b=p7A9IjZneO6Qxn5QOAN+b/kJlv5Ta9RxG6c9jDvcqpUMkRaq530yhDD4ZnpZ6lT6VHV+7eBxuQ4H1Bq3JCd4tVqfxNAP9aYKAHnHhqwCXKz3SHzyhQGAoDIgSji6V8LzCKvo03FfP7wVHyJ+iqgBuh2LHpb8rSzj2fubLPApOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094685; c=relaxed/simple;
	bh=w83dKX727K2gGA2sGJFxcKZuqvwHZre5h8ZRz01FsN8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WktPkSewvm51R/UdOJ792TwqnMYyaEQN2bH7XfUXSCvx8RbjPXgEUbVxZN8/qvY9Gx2HETVaRgyrlLio+wCQ7vNRLX0UPzVa/RB1ap5qnrV/8qgycQLRmkVoukriPVKdeshOEbQrPubRwLp8/n+/ytCV5f1yd5yBpLnD1LCQDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679dcff168dso5923507eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 26 Feb 2026 00:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094682; x=1772699482;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtJRnETKEUskQ2P/odSFcUJYlLbt7Hi+G7In7kvC2Mk=;
        b=wydbTOaBJH5vab2qFLllDphTNLxYUFGqVdJEW89uTxSt/tvo+8FoZQHyGGV3tPA0sQ
         3si9iMffQpfkwMGP6nzEodUsciYCgJ58o9wPQItS3Inhv5FG/H6dln5YD00NbQOf5pSl
         1cBjSA9y5Tzhd9m9/F/TmFQIQtFoTPCLqKhUDXU/9yMip6JE+CXHKvH2lAam10++4O5I
         j1lUiBuDeQiYynAYlT1FeBqViTl6FpHDWoAMbYIf542PPryEEpRQHAUUVI46cgM2cbXE
         WIrmHEQFJyzO6OODn7BNdIoHaL52NC7typxGrOHZQbh7ZPN3sdhzCdInKFayFSnhX3tp
         n6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWYe8Gf4EzXbJcymrtwE0+kufnSNl+cIuGX9U+5UQ3Usz3Xz3oZYgxM/H7MDoLuAJYbl5OwyWQRIxsx+UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mZWAmE4US4eHOhLpcpCFrpWBo1oEGBQbwb1LO7z5YsN5m2zU
	lAgTGNHQNOvtsOgXbKTDwlIU3r6ICxPWjKEK0hYygvhb3KN9791Uo0xNhLApS0UIDrk0zNBOvs5
	EohI5NLWil5XtB9lXRplB7OBPhJRVc42r0vyasiBti12aqf/ku+aJh6W5WOE=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b07:b0:66e:58f3:b500 with SMTP id
 006d021491bc7-679ef929cdfmr1506830eaf.29.1772094682610; Thu, 26 Feb 2026
 00:31:22 -0800 (PST)
Date: Thu, 26 Feb 2026 00:31:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a004da.050a0220.1cd54b.000e.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-out-of-bounds Write in do_con_write (3)
From: syzbot <syzbot+8e9c1abac3ceb45abffe@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d9d32e5bd5a4 Merge tag 'ata-7.0-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1253f152580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af6ed0125ed44356
dashboard link: https://syzkaller.appspot.com/bug?extid=8e9c1abac3ceb45abffe
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ade1e7548f1e/disk-d9d32e5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6abd23967034/vmlinux-d9d32e5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fde04bd3e374/bzImage-d9d32e5b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8e9c1abac3ceb45abffe@syzkaller.appspotmail.com

BUG: KASAN: slab-out-of-bounds in vc_con_write_normal drivers/tty/vt/vt.c:3135 [inline]
BUG: KASAN: slab-out-of-bounds in do_con_write+0x386f/0x8540 drivers/tty/vt/vt.c:3226
Write of size 2 at addr ffff888037925fb0 by task syz.2.556/8668

CPU: 1 UID: 0 PID: 8668 Comm: syz.2.556 Tainted: G     U       L      syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1e0 mm/kasan/report.c:595
 vc_con_write_normal drivers/tty/vt/vt.c:3135 [inline]
 do_con_write+0x386f/0x8540 drivers/tty/vt/vt.c:3226
 con_write+0x23/0xb0 drivers/tty/vt/vt.c:3558
 process_output_block drivers/tty/n_tty.c:557 [inline]
 n_tty_write+0x44f/0x12d0 drivers/tty/n_tty.c:2366
 iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
 file_tty_write.isra.0+0x4d2/0x890 drivers/tty/tty_io.c:1081
 tty_write drivers/tty/tty_io.c:1102 [inline]
 redirected_tty_write drivers/tty/tty_io.c:1125 [inline]
 redirected_tty_write+0xd4/0x120 drivers/tty/tty_io.c:1105
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f93fa79c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f93fb676028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f93faa15fa0 RCX: 00007f93fa79c629
RDX: 000000000000fdef RSI: 0000200000000000 RDI: 0000000000000005
RBP: 00007f93fa832b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f93faa16038 R14: 00007f93faa15fa0 R15: 00007ffc82d1ce98
 </TASK>

Allocated by task 8646:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kmalloc_noprof include/linux/slab.h:962 [inline]
 kzalloc_noprof include/linux/slab.h:1200 [inline]
 kobject_uevent_env+0x263/0x18b0 lib/kobject_uevent.c:540
 rx_queue_add_kobject net/core/net-sysfs.c:1280 [inline]
 net_rx_queue_update_kobjects+0x1dd/0x760 net/core/net-sysfs.c:1322
 register_queue_kobjects net/core/net-sysfs.c:2114 [inline]
 netdev_register_kobject+0x290/0x3d0 net/core/net-sysfs.c:2362
 register_netdevice+0x12e0/0x2210 net/core/dev.c:11411
 __ip_tunnel_create+0x52b/0x670 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x230/0x780 net/ipv4/ip_tunnel.c:1147
 vti_init_net+0x2e/0x140 net/ipv4/ip_vti.c:517
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:581
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:130
 unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x473/0xad0 kernel/fork.c:3174
 __do_sys_unshare kernel/fork.c:3245 [inline]
 __se_sys_unshare kernel/fork.c:3243 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3243
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8646:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2687 [inline]
 slab_free mm/slub.c:6124 [inline]
 kfree+0x1f6/0x6b0 mm/slub.c:6442
 kobject_uevent_env+0x2e2/0x18b0 lib/kobject_uevent.c:640
 rx_queue_add_kobject net/core/net-sysfs.c:1280 [inline]
 net_rx_queue_update_kobjects+0x1dd/0x760 net/core/net-sysfs.c:1322
 register_queue_kobjects net/core/net-sysfs.c:2114 [inline]
 netdev_register_kobject+0x290/0x3d0 net/core/net-sysfs.c:2362
 register_netdevice+0x12e0/0x2210 net/core/dev.c:11411
 __ip_tunnel_create+0x52b/0x670 net/ipv4/ip_tunnel.c:268
 ip_tunnel_init_net+0x230/0x780 net/ipv4/ip_tunnel.c:1147
 vti_init_net+0x2e/0x140 net/ipv4/ip_vti.c:517
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:446
 copy_net_ns+0x46f/0x7c0 net/core/net_namespace.c:581
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:130
 unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x473/0xad0 kernel/fork.c:3174
 __do_sys_unshare kernel/fork.c:3245 [inline]
 __se_sys_unshare kernel/fork.c:3243 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3243
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888037924000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 4016 bytes to the right of
 allocated 4096-byte region [ffff888037924000, ffff888037925000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x37920
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe3d140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe3d140 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000de4801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5207, tgid 5207 (udevd), ts 53624826174, free_ts 53538236869
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x111d/0x3140 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x27c/0x2ba0 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3255 [inline]
 allocate_slab mm/slub.c:3444 [inline]
 new_slab+0xa6/0x6d0 mm/slub.c:3502
 refill_objects+0x26b/0x400 mm/slub.c:7134
 refill_sheaf mm/slub.c:2804 [inline]
 alloc_full_sheaf mm/slub.c:2825 [inline]
 __pcs_replace_empty_main+0x19f/0x600 mm/slub.c:4588
 alloc_from_pcs mm/slub.c:4681 [inline]
 slab_alloc_node mm/slub.c:4815 [inline]
 __do_kmalloc_node mm/slub.c:5218 [inline]
 __kmalloc_noprof+0x688/0x850 mm/slub.c:5231
 kmalloc_noprof include/linux/slab.h:966 [inline]
 tomoyo_realpath_from_path+0xb6/0x690 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2af/0x3c0 security/tomoyo/file.c:776
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0xb5/0x1e0 security/security.c:2636
 do_dentry_open+0x5aa/0x1660 fs/open.c:926
 vfs_open+0x82/0x3f0 fs/open.c:1081
 do_open fs/namei.c:4671 [inline]
 path_openat+0x208c/0x31a0 fs/namei.c:4830
 do_file_open+0x20e/0x430 fs/namei.c:4859
 do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
page last free pid 5207 tgid 5207 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x7e1/0x10d0 mm/page_alloc.c:2978
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xe0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4501 [inline]
 slab_alloc_node mm/slub.c:4830 [inline]
 __do_kmalloc_node mm/slub.c:5218 [inline]
 __kmalloc_noprof+0x2b9/0x850 mm/slub.c:5231
 kmalloc_noprof include/linux/slab.h:966 [inline]
 tomoyo_realpath_from_path+0xb6/0x690 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2af/0x3c0 security/tomoyo/file.c:776
 tomoyo_file_open+0x6b/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0xb5/0x1e0 security/security.c:2636
 do_dentry_open+0x5aa/0x1660 fs/open.c:926
 vfs_open+0x82/0x3f0 fs/open.c:1081
 do_open fs/namei.c:4671 [inline]
 path_openat+0x208c/0x31a0 fs/namei.c:4830
 do_file_open+0x20e/0x430 fs/namei.c:4859
 do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffff888037925e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888037925f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888037925f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff888037926000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888037926080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
