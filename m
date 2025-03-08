Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921C634
	for <linux-serial@vger.kernel.org>; Sat,  8 Mar 2025 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392208; cv=none; b=lhGOMAGEnbRE735DWSlDt0Cwv0/FaEYxxwql9XzrHnDwRBsdFgQeqOgpFPKbHLvn5hhsQaQyVOBsMneFlNfd83pXVA5dPq24TqMcHH64lLMTxYs35aNS/JpQtWug1ESplwMmFAEQq/qOitdzO2z8gAjocbn9whw+1WcKOq+zNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392208; c=relaxed/simple;
	bh=TJr0uCzJlIUA0s4maQFD2jszG2jCY7bmdUoN+9i5r+s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DHElqTuac5jo2diWfXVedm9F+FmmkdbTqz64rlsFozoniaLG8Gu/0WzAtAKVJceunoiGXwK9uC58MOeaMwAKOiWFyDbYxmmYgln5mdS2SJqW3rGn1PjjXydTbYZcSNY4G+WriS74XBFNjoZ+s8Y2RzIcoZA3Bkh5CA//pfEls0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so21510105ab.0
        for <linux-serial@vger.kernel.org>; Fri, 07 Mar 2025 16:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392205; x=1741997005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cu0Leuv9fI7EjwBb3Dj00V2VzWxA5MynD6TffJ7aeVM=;
        b=gkiZiBcbFzH66H9qBfRgq/v/dKrbW6gSf7s88mYBJuMjSmLYzkRNRPD19IRtp5fXfu
         rosk72D2eBKuBVIwKsNnpUn4Z83uOINUQFyAmrRLOHqMiMqtULqCvaaZrjss1ECqjddN
         /3r04moeJ6YtlgrwdidHzxu7FLIK5nueQQmFtmU2DbzdKAOJo+ZuFzef8FeaNECcyGh5
         nzb3Z6S4vRbip2/38gJuUMDX2GuoGClzp/03RuPQ688DSVciHNB3RgCH92yNhmh7wu/W
         oHX2ELWqzeXudpGzvb6XROQmWEJ3OKDGkUPCCRJhiPMSczKRsaAgc3Q+11Er1hgTOVfc
         ZA8w==
X-Forwarded-Encrypted: i=1; AJvYcCWaewB+7CpRFzMjehueB6hSTp+f1DvMmYURsJqJ4ZMZhJ39Ro8uE6EcaeqOgwrfYxkhGF/6+qS546nO5xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpifvdB2/17HMdkzoivEeQF8K8zbJClMzDnr58fN2sMAkjG73
	P8hhHe1O0BZJuKnD9BfVctd15YD+sP950j3UECc/llc1OUTwdwc5fn0Iy9yrjh6GPe58orBg1Mq
	uZrLLVtSb18//ZDZcP6MnKz7CmT5yWykWoP3giVo9T1zXo7X2MHEcunk=
X-Google-Smtp-Source: AGHT+IHplIVYMOM7Ubr2rM1fQuga6U6Iq2yks5ibNkXLx3LSMXUepJ7kfutm6sqy8r0Of+RAv20OZ7RUyK4HGeUS9nrhSD9VSOP8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:3d3:fa69:6763 with SMTP id
 e9e14a558f8ab-3d44194730cmr71823045ab.2.1741392205471; Fri, 07 Mar 2025
 16:03:25 -0800 (PST)
Date: Fri, 07 Mar 2025 16:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb894d.050a0220.d8275.0231.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-out-of-bounds Read in vc_uniscr_check
From: syzbot <syzbot+ad83bc4086a46e2b322b@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eb172143d55 Linux 6.14-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c4a7a0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bed8205d3b84ef81
dashboard link: https://syzkaller.appspot.com/bug?extid=ad83bc4086a46e2b322b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/06a492964134/disk-7eb17214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83adeaa22219/vmlinux-7eb17214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7386164633ed/bzImage-7eb17214.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad83bc4086a46e2b322b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in vc_uniscr_check+0x4bf/0x5b0 drivers/tty/vt/vt.c:513
Read of size 2 at addr ffff888062b96760 by task syz.3.7501/793

CPU: 1 UID: 0 PID: 793 Comm: syz.3.7501 Not tainted 6.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xd9/0x110 mm/kasan/report.c:634
 vc_uniscr_check+0x4bf/0x5b0 drivers/tty/vt/vt.c:513
 vcs_read_buf_uni drivers/tty/vt/vc_screen.c:254 [inline]
 vcs_read+0x6c5/0xbd0 drivers/tty/vt/vc_screen.c:436
 vfs_read+0x1df/0xbf0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa8c5d8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa8c6c94038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fa8c5fa5fa0 RCX: 00007fa8c5d8d169
RDX: 0000000000000080 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fa8c5e0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa8c5fa5fa0 R15: 00007fff5809c238
 </TASK>

Allocated by task 31685:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 batadv_hardif_add_interface net/batman-adv/hard-interface.c:882 [inline]
 batadv_hard_if_event+0xb94/0x1640 net/batman-adv/hard-interface.c:970
 notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2206
 call_netdevice_notifiers_extack net/core/dev.c:2244 [inline]
 call_netdevice_notifiers net/core/dev.c:2258 [inline]
 register_netdevice+0x17c2/0x1eb0 net/core/dev.c:10978
 macvlan_common_newlink+0x1046/0x1940 drivers/net/macvlan.c:1536
 rtnl_newlink_create net/core/rtnetlink.c:3796 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3907 [inline]
 rtnl_newlink+0xb95/0x1d60 net/core/rtnetlink.c:4022
 rtnetlink_rcv_msg+0x95b/0xea0 net/core/rtnetlink.c:6912
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2533
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1882
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg net/socket.c:733 [inline]
 __sys_sendto+0x488/0x4f0 net/socket.c:2187
 __do_sys_sendto net/socket.c:2194 [inline]
 __se_sys_sendto net/socket.c:2190 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2190
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888062b96000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 1048 bytes to the right of
 allocated 840-byte region [ffff888062b96000, ffff888062b96348)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888062b92000 pfn:0x62b90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b041dc0 ffffea0001a1cc10 ffffea0000a5c210
raw: ffff888062b92000 0000000000100008 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801b041dc0 ffffea0001a1cc10 ffffea0000a5c210
head: ffff888062b92000 0000000000100008 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea00018ae401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5831, tgid 5831 (syz-executor), ts 72139438838, free_ts 24347774881
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x23d/0x330 mm/slub.c:2640
 ___slab_alloc+0xc5d/0x1720 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_node_noprof+0x2f0/0x510 mm/slub.c:4300
 kmalloc_node_noprof include/linux/slab.h:928 [inline]
 qdisc_alloc+0xbb/0xc50 net/sched/sch_generic.c:947
 qdisc_create_dflt+0x73/0x430 net/sched/sch_generic.c:1009
 attach_one_default_qdisc net/sched/sch_generic.c:1175 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2590 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1193 [inline]
 dev_activate+0x63a/0x12b0 net/sched/sch_generic.c:1252
 __dev_open+0x3e4/0x540 net/core/dev.c:1644
 __dev_change_flags+0x561/0x720 net/core/dev.c:9254
 dev_change_flags+0x8f/0x160 net/core/dev.c:9326
 do_setlink.constprop.0+0x699/0x3f80 net/core/rtnetlink.c:3118
 rtnl_changelink net/core/rtnetlink.c:3733 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3885 [inline]
 rtnl_newlink+0x1306/0x1d60 net/core/rtnetlink.c:4022
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 free_contig_range+0x133/0x3f0 mm/page_alloc.c:6678
 destroy_args+0x66f/0x830 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x130f/0x2d60 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x128/0x700 init/main.c:1257
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1354 [inline]
 kernel_init_freeable+0x5c7/0x900 init/main.c:1568
 kernel_init+0x1c/0x2b0 init/main.c:1457
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888062b96600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888062b96680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888062b96700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff888062b96780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888062b96800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
