Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684B48CD71
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525513; cv=none; b=PXWOlD8vnKjiey/8pc8f1KktCVRrOmPhmCALAObTP/sFepX4nnDtvbYTpz51b5NGCokRNfEr9wlFZukP3XmydiLhJL2wYN0QxM6NM7GyqAOm2hB0CTdGokuRyBcI7wvFytvYW0gxweW3cfng+gUQVyaqDNbE2eZ626kG+hYCTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525513; c=relaxed/simple;
	bh=SpaLZ03RIJGou3TA4o2D1zJ3OfKRLfVn0OAPE7ms6Uw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FcxwnrFVjEk3O0s38G8zCMOhb8zgMZi+ZwCZa9Zf8NU6+H2yvc9B54oSYScaR8iuV4651tvC0+tIDQNZ+C0IduI69vW/TzFAshSqlmlZvZmGrCdOPUeFQeajPq8CpRLTyyw8L80KK4c1VGl0MSf5Lrqtgedj+AbHM3yxFq+vmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6b34d7f21d0so921597eaf.3
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 05:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525509; x=1789130309;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9bHIdg+WFHf0wU/BxezX7jdfCJ1dyRmHj4gHXGLnu70=;
        b=F6EUqJudFqq5VjShU0fzJ7JLDyz7EQaqCeQp7IS57hA6RL0if41K7KH62A4AdHpQog
         7dNq9UW4p5keoj85WO0BWD1w/OaQKEmyy2D9dUcrNE4C7wg3Y0iU29aEJtp4x5eU56RN
         ROmx8OE5IrNwNOh9r/9sZ45IK6SjWWt+OZRE/yzt+hWlTIrKvhsEDQ4v1Z58wDfIH5HM
         pNWanG5Jb4gxGn8OOhApTltDz01YBb2bhE6QQ2ZkOfZv9hMBuy6ovSWOpUVByjXafbqk
         5e+jHxgaIt/DIfyu9YCOVXQEPUYxIKLpGLSP5ygnXi6B372JxBcWd3JEDeuUse7rFWZV
         SINQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZlY7U+vuRBfifLd22SL13b+dU9oOLZqu7lJJfFLiZ1/lkhu1wc/jhx9L3sWqoO7aDF9PNSjMOTtpRr5g=@vger.kernel.org
X-Gm-Message-State: AFuF++mC8P+K8fItXDk99Y2/YoJRuu8huevSFbIkdVwuTE+RKZ0mal6K
	ZUdxszK8ed5UCH0f1sJVdvtVRvXr0HNT6/7ZRVcbfOr2lCN54XA7X9IllHm/G4SssP3xVLGjgjn
	ojB56aLEn8hR3jKCoYNTB7M/yzOvafS4RK9KSLsPSH3GrLn57Kc1X8gI4uh8=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2912:b0:6b7:46fc:1cd with SMTP id
 006d021491bc7-6b746fc03a5mr2488644eaf.44.1788525509283; Fri, 04 Sep 2026
 05:38:29 -0700 (PDT)
Date: Fri, 04 Sep 2026 05:38:29 -0700
In-Reply-To: <6a6c3d48.5cf34cee.28a846.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9abbc5.efa90033.8a9e.0005.GAE@google.com>
Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Write in tty_init_dev
From: syzbot <syzbot+fe63e4d633540f230624@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    bc35965f6940 Merge tag 'mm-hotfixes-stable-2026-09-03-17-4..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11f508f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=fe63e4d633540f230624
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b638f9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe63e4d633540f230624@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in tty_init_dev.part.0+0x44f/0x470 drivers/tty/tty_io.c:1397
Write of size 8 at addr ffff888039c5f128 by task syz-executor411/6004

CPU: 2 UID: 0 PID: 6004 Comm: syz-executor411 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 tty_init_dev.part.0+0x44f/0x470 drivers/tty/tty_io.c:1397
 tty_init_dev include/linux/err.h:78 [inline]
 tty_open_by_driver drivers/tty/tty_io.c:2046 [inline]
 tty_open+0x953/0xe20 drivers/tty/tty_io.c:2093
 chrdev_open+0x234/0x6a0 fs/char_dev.c:411
 do_dentry_open+0x6ab/0x14d0 fs/open.c:996
 vfs_open+0x82/0x3f0 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x19fa/0x2440 fs/namei.c:5000
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd79f471dde
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007fd79f41c158 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd79f41c6c0 RCX: 00007fd79f471dde
RDX: 0000000000000102 RSI: 00007fd79f4c11a3 RDI: ffffffffffffff9c
RBP: 0000000000000021 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000010 R14: 00007ffe14e7e850 R15: 00007ffe14e7e938
 </TASK>

Allocated by task 5997:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2f8/0x6d0 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 gs_port_alloc drivers/usb/gadget/function/u_serial.c:1218 [inline]
 gserial_alloc_line_no_console+0xac/0x710 drivers/usb/gadget/function/u_serial.c:1298
 gserial_alloc_line+0x16/0xa0 drivers/usb/gadget/function/u_serial.c:1332
 gser_alloc_inst+0x86/0x100 drivers/usb/gadget/function/f_serial.c:325
 try_get_usb_function_instance+0x136/0x1f0 drivers/usb/gadget/functions.c:28
 usb_get_function_instance+0x16/0x70 drivers/usb/gadget/functions.c:44
 function_make+0x18c/0x3f0 drivers/usb/gadget/configfs.c:626
 configfs_mkdir+0x525/0xd40 fs/configfs/dir.c:1360
 vfs_mkdir+0x364/0x850 fs/namei.c:5410
 filename_mkdirat+0x48b/0x5e0 fs/namei.c:5443
 __do_sys_mkdir fs/namei.c:5470 [inline]
 __se_sys_mkdir fs/namei.c:5467 [inline]
 __x64_sys_mkdir+0x6b/0x90 fs/namei.c:5467
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6005:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6792
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
 vfs_rmdir fs/namei.c:5515 [inline]
 vfs_rmdir+0x328/0x8a0 fs/namei.c:5488
 filename_rmdir+0x31a/0x5c0 fs/namei.c:5572
 __do_sys_rmdir fs/namei.c:5595 [inline]
 __se_sys_rmdir fs/namei.c:5592 [inline]
 __x64_sys_rmdir+0x46/0x70 fs/namei.c:5592
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888039c5f000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 296 bytes inside of
 freed 2048-byte region [ffff888039c5f000, ffff888039c5f800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888039c5b000 pfn:0x39c58
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801c042f00 ffffea00011fe010 ffffea0000d4be10
raw: ffff888039c5b000 0000000000080007 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801c042f00 ffffea00011fe010 ffffea0000d4be10
head: ffff888039c5b000 0000000000080007 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5536, tgid 5536 (getty), ts 27613485294
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_node_track_caller_noprof+0x6a8/0x870 mm/slub.c:5545
 kmalloc_reserve+0xe8/0x350 net/core/skbuff.c:637
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 audit_buffer_alloc kernel/audit.c:1846 [inline]
 audit_log_start+0x350/0x930 kernel/audit.c:1965
 common_lsm_audit+0xb2/0x2b0 security/lsm_audit.c:442
 slow_avc_audit+0x186/0x210 security/selinux/avc.c:778
 avc_audit security/selinux/include/avc.h:131 [inline]
 avc_has_perm+0x1a6/0x1e0 security/selinux/avc.c:1197
 inode_has_perm+0x166/0x1d0 security/selinux/hooks.c:1694
 __file_has_perm+0x39c/0x460 security/selinux/hooks.c:1800
 file_has_perm security/selinux/hooks.c:1816 [inline]
 selinux_file_fcntl+0x111/0x170 security/selinux/hooks.c:4212
page last free pid 5536 tgid 5536 ts 27612066419 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x2cc/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2166 [inline]
 tomoyo_supervisor+0x65d/0x1340 security/tomoyo/common.c:2238
 tomoyo_audit_path_number_log security/tomoyo/file.c:239 [inline]
 tomoyo_path_number_perm+0x445/0x580 security/tomoyo/file.c:739
 tomoyo_path_chown+0x14b/0x1b0 security/tomoyo/tomoyo.c:384
 security_path_chown+0x12a/0x2d0 security/security.c:1598
 chown_common+0x3da/0x6e0 fs/open.c:820
 vfs_fchown fs/open.c:890 [inline]
 vfs_fchown+0xcd/0x110 fs/open.c:882
 ksys_fchown fs/open.c:902 [inline]
 __do_sys_fchown fs/open.c:907 [inline]
 __se_sys_fchown fs/open.c:905 [inline]
 __x64_sys_fchown+0xad/0x130 fs/open.c:905
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888039c5f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039c5f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888039c5f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888039c5f180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888039c5f200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
