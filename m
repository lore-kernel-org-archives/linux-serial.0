Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5D2877E9
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857143; cv=none; b=IVkb+XT0SSKRgQfiNS47fYJBp7i5xPw/yfj3NXWS6n3k+nlKD4Df/C1nxmkxcZ3UMorzw2mPGlJN5hibELol2SDMEkGzjfPJQ8avbL+okW2zWn9Lz3vjx3kiDLs2aoyIV1hRt7Qqc51SjOc35s/FYlvA4BciXGeBw6b0+VXODY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857143; c=relaxed/simple;
	bh=a3muh3rL5VyUL97AINRZ4oq9t9ey4aN1fwiASR6VVRI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ij4NnxEujyRkR0oZbJHsUiHcisBhHjzMHtiZgIPhjEPox9tYd4srDDVz0pxtiU5IeOKKOBZuyESpn6Sqi9xx8OQ7CMJR+O8ofLd94xuWm9R7hO4T4BPPU311QkfCVGUpLYoh3wSYzqHCiOP4SxDaH3ewjdxvoyhgc9bIC0+nC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e6e61caf71so40967355ab.3
        for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 03:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857139; x=1756461939;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juGpK4kSjchRc2LkFcW3uTYahVs1DyJubiPrfmsEuGA=;
        b=R34Wk9DLuaLrwbfVsHvZhIRS+9ZloVAoV0B91Lj0M44c9dpEG57hdB1Z2cPJuNfXWu
         NNeXKTAAqItosllx2O0XzyQhuE4DJOOo6BdxpkCcFXENzJJWVx/aMhOIs6MZmn/YbnLK
         w7dsD7nCaZSQM38jFWeFqHh30JefkFZxvfMnZE1GEeSp1XOz2wAf/Hi/qWEdBaujkTPI
         ch0KzJblptwvoKYdVCnRBDInnIzU9x3omta18p5KibvTRuBn/qwd7EkWeOtgGGJky7ko
         GIgtvM0YvJPLG0okP3SvTIozsgCk80veGOQ0k94exYOyv+WwWU78q9alpoYDb4Tjrg5R
         vflA==
X-Forwarded-Encrypted: i=1; AJvYcCWRwJQ0UCVnRNfYwaqFll98Jq0i5USNa8THK9IGowoKw6ErUGeMMd+nTLeNadFerrUels87yjauPvGnF0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2F+y6SWeqEeePkSYbXNjBCdro80osT8jx37NTIEifwH5saGzZ
	A0BPi9lWe45ofKWvddP9SnH2fWJzZLeF2mkM17PFCaNxJWn3Pfj/YCfb5JLug+aaWKSHsOstnPw
	SeKQtz+u1nrLexzqd569J0cL9Y5YKov3D8CTZrEDkf8sbHO/jy85TPWqq3vE=
X-Google-Smtp-Source: AGHT+IFYX/e/xC4ZNjaIIOYEvn5cXgmC4kzJH9oM9hp/VYR/NxaQ2PWTZUn4QxbO6a2fPsikd4K3KaLvGysC2Z5Sb/XvJw/yL8e8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe1:b0:3e5:7e26:2f90 with SMTP id
 e9e14a558f8ab-3e922504b72mr41859795ab.24.1755857139359; Fri, 22 Aug 2025
 03:05:39 -0700 (PDT)
Date: Fri, 22 Aug 2025 03:05:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a840f3.a00a0220.33401d.0255.GAE@google.com>
Subject: [syzbot] [serial?] KASAN: slab-out-of-bounds Read in vc_do_resize (2)
From: syzbot <syzbot+23804718314de4b145d4@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d561baae505 Merge tag 'x86_urgent_for_v6.17_rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105f6ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a59f5ce3f5878f0
dashboard link: https://syzkaller.appspot.com/bug?extid=23804718314de4b145d4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c8e63656e52/disk-8d561baa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19f4251b8bfd/vmlinux-8d561baa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aca2c5602160/bzImage-8d561baa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23804718314de4b145d4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:38 [inline]
BUG: KASAN: slab-out-of-bounds in vc_do_resize+0x80a/0x10e0 drivers/tty/vt/vt.c:1245
Read of size 64 at addr ffff88807b47bfc0 by task syz.3.748/14193

CPU: 0 UID: 0 PID: 14193 Comm: syz.3.748 Not tainted 6.17.0-rc1-syzkaller-00224-g8d561baae505 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x100/0x1b0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 scr_memcpyw include/linux/vt_buffer.h:38 [inline]
 vc_do_resize+0x80a/0x10e0 drivers/tty/vt/vt.c:1245
 vt_resizex drivers/tty/vt/vt_ioctl.c:717 [inline]
 vt_ioctl+0x2ca4/0x30a0 drivers/tty/vt/vt_ioctl.c:937
 tty_ioctl+0x65e/0x1680 drivers/tty/tty_io.c:2792
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl fs/ioctl.c:584 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ffab8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ffba5a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0ffadb6090 RCX: 00007f0ffab8ebe9
RDX: 0000000000000038 RSI: 000000000000560a RDI: 0000000000000003
RBP: 00007f0ffac11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0ffadb6128 R14: 00007f0ffadb6090 R15: 00007ffeb7398ce8
 </TASK>

Allocated by task 5857:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kvmalloc_node_noprof+0x27b/0x620 mm/slub.c:5052
 kvmalloc_array_node_noprof include/linux/slab.h:1065 [inline]
 __ptr_ring_init_queue_alloc_noprof include/linux/ptr_ring.h:471 [inline]
 ptr_ring_init_noprof include/linux/ptr_ring.h:489 [inline]
 skb_array_init_noprof include/linux/skb_array.h:182 [inline]
 pfifo_fast_init+0x125/0x3b0 net/sched/sch_generic.c:869
 qdisc_create_dflt+0x122/0x490 net/sched/sch_generic.c:1019
 attach_one_default_qdisc net/sched/sch_generic.c:1178 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2660 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1196 [inline]
 dev_activate+0x63f/0x12d0 net/sched/sch_generic.c:1255
 __dev_open+0x432/0x7c0 net/core/dev.c:1691
 __dev_change_flags+0x55d/0x720 net/core/dev.c:9537
 netif_change_flags+0x8d/0x160 net/core/dev.c:9600
 do_setlink.constprop.0+0xb53/0x4380 net/core/rtnetlink.c:3143
 rtnl_changelink net/core/rtnetlink.c:3761 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3920 [inline]
 rtnl_newlink+0x1446/0x2000 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 __sys_sendto+0x4a3/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807b478000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 8320 bytes to the right of
 allocated 8000-byte region [ffff88807b478000, ffff88807b479f40)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b478
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b842280 ffffea0001ea8000 0000000000000005
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b842280 ffffea0001ea8000 0000000000000005
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001ed1e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x528c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP), pid 5857, tgid 5857 (syz-executor), ts 75907413730, free_ts 75889157643
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab mm/slub.c:2655 [inline]
 new_slab+0x247/0x330 mm/slub.c:2709
 ___slab_alloc+0xcf2/0x1740 mm/slub.c:3891
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3981
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kvmalloc_node_noprof+0x3b1/0x620 mm/slub.c:5052
 kvmalloc_array_node_noprof include/linux/slab.h:1065 [inline]
 __ptr_ring_init_queue_alloc_noprof include/linux/ptr_ring.h:471 [inline]
 ptr_ring_init_noprof include/linux/ptr_ring.h:489 [inline]
 skb_array_init_noprof include/linux/skb_array.h:182 [inline]
 pfifo_fast_init+0x125/0x3b0 net/sched/sch_generic.c:869
 qdisc_create_dflt+0x122/0x490 net/sched/sch_generic.c:1019
 attach_one_default_qdisc net/sched/sch_generic.c:1178 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2660 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1196 [inline]
 dev_activate+0x63f/0x12d0 net/sched/sch_generic.c:1255
 __dev_open+0x432/0x7c0 net/core/dev.c:1691
 __dev_change_flags+0x55d/0x720 net/core/dev.c:9537
 netif_change_flags+0x8d/0x160 net/core/dev.c:9600
 do_setlink.constprop.0+0xb53/0x4380 net/core/rtnetlink.c:3143
 rtnl_changelink net/core/rtnetlink.c:3761 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3920 [inline]
 rtnl_newlink+0x1446/0x2000 net/core/rtnetlink.c:4057
page last free pid 5854 tgid 5854 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 __kmalloc_cache_noprof+0x1f1/0x3e0 mm/slub.c:4391
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vlan_info_alloc net/8021q/vlan_core.c:153 [inline]
 vlan_vid_add+0x2ee/0x750 net/8021q/vlan_core.c:329
 vlan_vid0_add net/8021q/vlan.c:370 [inline]
 vlan_device_event+0x1a39/0x2620 net/8021q/vlan.c:411
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2229
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9576
 netif_change_flags+0x108/0x160 net/core/dev.c:9605
 do_setlink.constprop.0+0xb53/0x4380 net/core/rtnetlink.c:3143
 rtnl_changelink net/core/rtnetlink.c:3761 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3920 [inline]
 rtnl_newlink+0x1446/0x2000 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346

Memory state around the buggy address:
 ffff88807b47be80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807b47bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807b47bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                           ^
 ffff88807b47c000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b47c080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
