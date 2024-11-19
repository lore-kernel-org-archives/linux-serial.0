Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0A13C82E
	for <linux-serial@vger.kernel.org>; Tue, 19 Nov 2024 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731993859; cv=none; b=EToL/Kztg9UpZBKU4BJqXTcoRT5TOSy2iaZp6uQ2k/ovatsAUW8zrgA9jSJCUKkaC6LyTdscV9JHRKkDgv4fYgMGx8+9OyOGmGIydOVaV0RarGBY2wq3qe8oVvH7FpcdwYe95pUgDoReN2GihdopGGTIqK1dtcRPlYas7wlsgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731993859; c=relaxed/simple;
	bh=RSIWF9dWhK5bG+0/7bgkNz1VCaANPiyJxvYDBREv8/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=D1i59grMA1JXqDb0wXdPkJt60GoI9Bb8p/ORrOGLLHjn0aMfwg2lsYCYqgbNNHNrzeGqNJvPelujTR0QMOC0VDPi5mJUXYD1IohrmFrT2dLEy8ni+73Nh2NMbhCsn4AuL6MsQ6klPxxFPS8Mfpq7vJEwY0sOsJPUlHQvtzTQO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Wg6BiVUn; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=J6b/IQqL; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Wg6BiVUn";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="J6b/IQqL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1731993857; x=1763529857;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=RSIWF9dWhK5bG+0/7bgkNz1VCaANPiyJxvYDBREv8/w=;
  b=Wg6BiVUn0rqU4f3LNa+2ksditxVhvJkInghpNJ90/tbxNgpQMTMf3XI2
   sYcmHPdGLQ3bIB8ATn7ZustRe3pTySfR4O3xPy/xFILAl7o0R4lWFE2Vs
   YExTdRivnPnhDY4gx1anaCYvubQy/ratPI6eczoF5umWyxwPjyZKOfZ08
   62AvrxSKI57kJlCVd8B6f7Izz3HIiBXJRNHfGpswQwuCtJj+3A8Pod0tG
   5NFX5/t/kkij1FQtR0skI2Pf4gnCFkDtVWLVAyJbvDufQRzbk2fDoeB7r
   T/+tW3rB6HFJA41C9I8hyAX91EwMiA8h2aKZTO1zVr57i1zRm5vKOfQfd
   Q==;
X-CSE-ConnectionGUID: RZPihEO3RsC9xuVGssKXGg==
X-CSE-MsgGUID: KH7aspHaQ7+c/wORdeuYLA==
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 18 Nov 2024 21:23:08 -0800
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abd63a132so430638539f.1
        for <linux-serial@vger.kernel.org>; Mon, 18 Nov 2024 21:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1731993786; x=1732598586; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z7RSfGOcNLlRwLMd+5dBsRSHhdnFAckzvVBCNqgl1Iw=;
        b=J6b/IQqLRLI69xSV144+6lwxtW296PkD74R+5OUpbHDL+lmZB7rfc/2sUHBmtGGbwa
         DxansFT+CgfCzITixHUEPH0IHTA0/jYeVW5teVBMlyy0broNgyNvsF3aL9BNLxIYNG1I
         KhtnPMTZydG61c3BoHJuOW0esP8Cb7cZyBI0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731993786; x=1732598586;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7RSfGOcNLlRwLMd+5dBsRSHhdnFAckzvVBCNqgl1Iw=;
        b=HVSufkC50IZ4038M6q2Xrw/TLjIH9dC2+AeLQTndtKkgnnZGNyGFKxXrLEuAo7+6d0
         mnss5p00QjD8jwd5igeoxSPY76uJrGXLm2mU7n1drD1wbLM4YvhqvulX0z+R/EdMg48t
         5wA/lTd3F1pD83t5ARycBjZ/Y5o6odpwgJ7ks3WDy29CNKThocHUzRR9NVdiPstYEc5d
         qGGW+VllN8N9pZ1XYZ4OImU6nlXsHIo1RM8XXQXrspXL3r9MELF2jxhJsmR9hGigsVRs
         KbqMmcsakgPmXFPcARAu+B/OWTp81IAnkjx0V3v9mBPN9/qZjz+5rwpmoqkoNDzB3d+I
         xpug==
X-Forwarded-Encrypted: i=1; AJvYcCX4x/f1+nL6hnKTBNPjSGqCbe0ejDAGLaDsuGzvCeo58QTXeGuEErhGDPzOYp5w0j7Rt5sGgYAuOPGnz1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIkNZekeTc+Hkt2Fb9kjHbRirk5zsg0cbft0n1ffTzUg1rNx6
	qf5Waim6WH/56sokSdWgcfN2Kn9oEcEZ+5IBgJB27IY1A31b6+qWxR/pCSl5YMfK4X0YDLQh7eu
	qHVmtBIV7G6sU+FMyMeLcZxtt809LvRwbhpwNyQG7ILeb6vi1zQnJXGvJ2bHHE+25LkklAloAm3
	eGPBBRo0TKBN+AUEHGGnZqvZQGN0iPJv3peQ4KxNkB6Hxj6e4G
X-Received: by 2002:a05:6602:611a:b0:82c:ec0f:a081 with SMTP id ca18e2360f4ac-83ea8abcdbemr206901039f.4.1731993786339;
        Mon, 18 Nov 2024 21:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr7JIuo+Q8xum+7MTkOOdjvwMuhzU3MUjpVITuW3scWIk+NPW/z5/EqehSYHebQuGWYDaVDYWhsNEwCsr03w8=
X-Received: by 2002:a05:6602:611a:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-83ea8abcdbemr206899939f.4.1731993786028; Mon, 18 Nov 2024
 21:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Mon, 18 Nov 2024 21:22:54 -0800
Message-ID: <CANikGpf8mkdZ+MVjLWoBEg0XZOBmwHVGaZVKX6eBSst+a2-Y8w@mail.gmail.com>
Subject: BUG: KASAN: slab-use-after-free Read in gsm_dlci_config
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.11.
In function `gsm_dlci_config`, a use-after-free on object `dlci` has
been detected.
Since the reproducer takes around 10 seconds to trigger the bug, it
might be a race condition one.
The C reproducer is available
at:https://gist.github.com/TomAPU/2ef61db5e741daa2b4b040fd874b9e92#file-gsmvuln-c

==================================================================
BUG: KASAN: slab-use-after-free in gsm_dlci_config+0x7b7/0x1020
drivers/tty/n_gsm.c:2588
Read of size 4 at addr ffff88803dab000c by task syz.0.361/12086

CPU: 0 PID: 12086 Comm: syz.0.361 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 print_address_description+0x77/0x360 mm/kasan/report.c:377
 print_report+0xfd/0x210 mm/kasan/report.c:488
 kasan_report+0x13f/0x170 mm/kasan/report.c:601
 gsm_dlci_config+0x7b7/0x1020 drivers/tty/n_gsm.c:2588
 gsmld_ioctl+0xbbc/0x2540 drivers/tty/n_gsm.c:3880
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f86c25809b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f86c3429038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f86c2745f80 RCX: 00007f86c25809b9
RDX: 0000000020000200 RSI: 0000000040384708 RDI: 0000000000000003
RBP: 00007f86c25f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f86c2745f80 R15: 00007ffd81f1d488
 </TASK>

Allocated by task 12086:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3b/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x94/0xa0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19e/0x2b0 mm/slub.c:4154
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 gsm_dlci_alloc+0x53/0x6c0 drivers/tty/n_gsm.c:2643
 gsmld_ioctl+0xb99/0x2540 drivers/tty/n_gsm.c:3876
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f

Freed by task 12087:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3b/0x70 mm/kasan/common.c:68
 kasan_save_free_info+0x3c/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x140 mm/kasan/common.c:240
 __kasan_slab_free+0x33/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kfree+0x118/0x2a0 mm/slub.c:4559
 dlci_put drivers/tty/n_gsm.c:2706 [inline]
 gsm_dlci_release drivers/tty/n_gsm.c:2739 [inline]
 gsm_cleanup_mux+0x5a2/0x930 drivers/tty/n_gsm.c:3156
 gsm_config drivers/tty/n_gsm.c:3408 [inline]
 gsmld_ioctl+0x13c4/0x2540 drivers/tty/n_gsm.c:3839
 tty_ioctl+0x98f/0xdb0 drivers/tty/tty_io.c:2812
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f

The buggy address belongs to the object at ffff88803dab0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 12 bytes inside of
 freed 2048-byte region [ffff88803dab0000, ffff88803dab0800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3dab0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888013042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888013042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0000f6ac01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 8050, tgid 8050 (syz-executor), ts 139463488880, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1db/0x220 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x7e5/0x860 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x25a/0x580 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x67/0x130 mm/slub.c:2265
 allocate_slab+0x5c/0x240 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xc6b/0x10c0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 kmalloc_node_track_caller_noprof+0x268/0x410 mm/slub.c:4143
 kmalloc_reserve+0x10e/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1e8/0x430 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 inet6_ifinfo_notify+0x6e/0x110 net/ipv6/addrconf.c:6161
 addrconf_notify+0xca7/0x1000 net/ipv6/addrconf.c:3762
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 __dev_notify_flags+0x201/0x400
 dev_change_flags+0xe8/0x190 net/core/dev.c:8858
 do_setlink+0xcc7/0x41e0 net/core/rtnetlink.c:2900
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803daaff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803daaff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803dab0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88803dab0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803dab0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
