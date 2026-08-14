Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D43546D8
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676864; cv=none; b=G/PAWik3G+5e+5RkiqjAuovWBZkjDlDnshjiKUdreJ9DgMAUFi4ga4eMyQ0mWF7p2AxYEZT0DnUvGx+zeV623KJyc93sxm1fz7PlROJKAhBKzY5SwTXvd8GTgkFAcdW/kJot8DjiHsWUbCWztxe0Itl2jj0oisDsctJcAkViA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676864; c=relaxed/simple;
	bh=bCpOcqbHtU10mfuqaRyfjl8tUHXL1EJx0UlkRJD2ulA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rPjPz38f86K6HT1LwIeB9F3EALRpCkfHXJ6haqU3YkHmDStQKAPOBUN7S5Goj7cS8dGXQ39oKmufIWem4azBbw87BkUPwfXDWlpxNiWGEAUM8eJltkOASoyBykL/G2sOWvriSn8WiwNAuutQcWs+kpfIpAjFv799pUotI4U2wZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7ee59eeb8c1so459077a34.0
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2026 20:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786676861; x=1787281661;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BoeRi7DeW1vMMRCqIUSCiXWASDlc5MpRLLqoK5J3pqA=;
        b=m6XJoZdODfgZRWH0O5/kVvuJFsuPlwNg8kP1TKWHCN5+TBBnJswhttPiUsly2WfYKR
         9BuEXgKa6omT/fOP5Hg/7zB7E/KrsyHYZ9gkdOy3XbpLABi4I+bTUrikHKNZBz3CTaaK
         ixa1Vm2LldXy8Hv1Nkl2j/yIJFNKjXQEA7aQjkqkaTkZLUYfa/U+3GDhwVYXSE5kmaSE
         kfNhaZhlOwKnJtWjfTWV/c4Hj8ecLHgfIADtYuETnjVXXiLLHf1nx7k5YHd/TR9T8uvz
         mAmd+ChjFYLW9DrornaidN9KOiz/oZ2bQsGeQf53c8Z5k3x8ALOq0NUZECj5fKP9P6w+
         971Q==
X-Forwarded-Encrypted: i=1; AHgh+RoLKeb60UcQAaA/VUnZtOVsVJk5b4J08XP97EF0SUAhS5hmSOIB3egbBwYOFqa3VO33MnAXNPssHqGb3Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDcclMF5BhGcJP996ufxjwpgGymZXHNJxZRanQRa/b135bZK9v
	0ajAwahRsztNWtQzITdurcvooH6NSNhPv1fhkZU4Z04lZikeafOFwDTp5mTYqFf+YX/nYQNi+Vg
	U3hMXVgI7RGgLJ7M39Ia1Jnars/r/1fzv/lymNhH/7TJLdLNDfMjcHxfv1l8=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1889:b0:6b0:1b86:fb0 with SMTP id
 006d021491bc7-6b0d68c187cmr2619526eaf.31.1786676861669; Thu, 13 Aug 2026
 20:07:41 -0700 (PDT)
Date: Thu, 13 Aug 2026 20:07:41 -0700
In-Reply-To: <6a7a82f8.01d0871a.3a0d52.00b9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7e867d.e5d9fd66.2f6faa.0012.GAE@google.com>
Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Write in release_tty
From: syzbot <syzbot+bca09f5d8b843bbf7571@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3aa1dcaa4f6f Revert "wifi: mt76: Disable napi when removin..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13405279580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158601bb8cb292dd
dashboard link: https://syzkaller.appspot.com/bug?extid=bca09f5d8b843bbf7571
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115c5ac6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13320279580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b68a8c2f502/disk-3aa1dcaa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/facf5b434f86/vmlinux-3aa1dcaa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51aa0bb3bd0b/bzImage-3aa1dcaa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bca09f5d8b843bbf7571@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in release_tty+0x36b/0x560 drivers/tty/tty_io.c:1584
Write of size 8 at addr ffff888027479120 by task syz-executor331/5612

CPU: 1 UID: 0 PID: 5612 Comm: syz-executor331 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 release_tty+0x36b/0x560 drivers/tty/tty_io.c:1584
 tty_release_struct+0xb8/0xd0 drivers/tty/tty_io.c:1692
 tty_release+0xc6b/0x1680 drivers/tty/tty_io.c:1852
 __fput+0x42a/0xa80 fs/file_table.c:512
 fput_close_sync+0x11f/0x240 fs/file_table.c:617
 __do_sys_close fs/open.c:1511 [inline]
 __se_sys_close fs/open.c:1496 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1496
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5468aadc0e
Code: 08 0f 85 65 e1 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007ffe95c075a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 000055558acba400 RCX: 00007f5468aadc0e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000182c2
R13: 00000000000182f4 R14: 00007f5468b4ab2c R15: 00007f5468b4ab20
 </TASK>

Allocated by task 5613:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d2/0x6b0 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 gs_port_alloc drivers/usb/gadget/function/u_serial.c:1218 [inline]
 gserial_alloc_line_no_console+0x23a/0x6e0 drivers/usb/gadget/function/u_serial.c:1298
 gserial_alloc_line+0x18/0x90 drivers/usb/gadget/function/u_serial.c:1332
 acm_alloc_instance+0xc7/0x140 drivers/usb/gadget/function/f_acm.c:891
 try_get_usb_function_instance drivers/usb/gadget/functions.c:28 [inline]
 usb_get_function_instance+0xe3/0x2f0 drivers/usb/gadget/functions.c:44
 function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
 configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
 vfs_mkdir+0x402/0x620 fs/namei.c:5276
 filename_mkdirat+0x289/0x520 fs/namei.c:5309
 __do_sys_mkdirat fs/namei.c:5330 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5613:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x1c5/0x6c0 mm/slub.c:6692
 gserial_free_port+0x248/0x2c0 drivers/usb/gadget/function/u_serial.c:1262
 gserial_free_line+0xc3/0x1f0 drivers/usb/gadget/function/u_serial.c:1279
 acm_free_instance+0x39/0x60 drivers/usb/gadget/function/f_acm.c:875
 usb_put_function_instance+0x90/0xb0 drivers/usb/gadget/functions.c:77
 config_item_cleanup fs/configfs/item.c:128 [inline]
 config_item_release+0x13a/0x2d0 fs/configfs/item.c:137
 configfs_rmdir+0x885/0x950 fs/configfs/dir.c:1571
 vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5381
 filename_rmdir+0x292/0x520 fs/namei.c:5438
 __do_sys_rmdir fs/namei.c:5461 [inline]
 __se_sys_rmdir+0x2e/0x140 fs/namei.c:5458
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888027479000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 288 bytes inside of
 freed 2048-byte region [ffff888027479000, ffff888027479800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27478
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ffb2000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ffb2000 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 765, tgid 765 (kworker/u8:6), ts 8666777166, free_ts 8122171962
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x262a/0x26a0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x330/0x690 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x544/0x780 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 scsi_alloc_target+0x138/0xbc0 drivers/scsi/scsi_scan.c:505
 __scsi_scan_target+0x164/0xe10 drivers/scsi/scsi_scan.c:1780
 scsi_scan_channel drivers/scsi/scsi_scan.c:1885 [inline]
 scsi_scan_host_selected+0x36e/0x680 drivers/scsi/scsi_scan.c:1914
 do_scsi_scan_host drivers/scsi/scsi_scan.c:2047 [inline]
 do_scan_async+0x10e/0x660 drivers/scsi/scsi_scan.c:2057
 async_run_entry_fn+0x9d/0x430 kernel/async.c:129
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
page last free pid 10 tgid 10 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_pages_prepare+0x946/0xa40 mm/page_alloc.c:1451
 __free_contig_range_common+0x174/0x340 mm/page_alloc.c:6897
 __free_contig_range mm/page_alloc.c:6942 [inline]
 free_pages_bulk+0x48/0x120 mm/page_alloc.c:5257
 vm_area_free_pages mm/vmalloc.c:3461 [inline]
 vfree+0x26f/0x510 mm/vmalloc.c:3510
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3414
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888027479000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027479080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027479100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888027479180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027479200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
