Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4B15689B
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455920; cv=none; b=YBJjIxgcOfAnuj9I8SqmbDLhy4fmoaJ7udDhoJFkLBiF/JlPNrg5S4oqC9pVPWBGT4jvOwOHPGm2vDsQ72739Y4bX6wxwLDdPNPV9VowmjfeqP4QDgu8Amu735RhD5WLbuSUPd+i28tcs2s9v+PvZd1+nJgW/vKQNJVytRgDZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455920; c=relaxed/simple;
	bh=Vt8ebfo8aJgePQ5shIVSSqA0HGRanxiF2Y3/eLEHNI4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r9SeIrgdKFOh/B6HiGFVBAwb3Muxhtgs+sPZVd5GIkfGFcezAARdK+vf2ebYHNpPPRz9mkkW2pMlaXzMGCLS2b3iccJ2xEyG+2cLjD3HRA0j95qgWqUqHfPpWUqnrg4Myhc/hF97do7aO4fDnrf1e0CE6eDm2uPONQoSPpKprOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so528669539f.2
        for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 02:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723455917; x=1724060717;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j36PlpWjmdfVbBokcHei3pw+tRIVHo+3I9Y1MdIeud4=;
        b=T1i4JifDg99PFWU1622CmMk4fw0eitUO8e2r266e9IsWS5w7tmcVYLDaVgcNJxdCFE
         /Sy5UQd6p6aHPA2vqhPmxJ56I/ejkeDqcW2LGEjUlLK8vu07U0XFv6de8J4PZ6qWgSL+
         KMEZXvFJpz+naWfv1nh27aIrABHGxxJHhRx90ThmIPzWYrrvcyJ3dcLDJwdlDSyTvDuJ
         BfdkWQLTnHf9jMNENsq410cH2sIsP94ikFO6ywxmyrnd/FKyB0CVbEhut+ptZIAu2+C+
         npQ5dkRHoV+ilJs2Jmj6vod3Ma3T8zFGbZpGqnskpP7Mn9iAI8Oykfv0dmFh+k5y1+3+
         0s8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBwclB1Ri/1F8Htk6vAgHsCxVA8pcXAevJvG2IIL60a1oaV9DjIk2f/F728p1cqTdEYwfuIqGLy7SQPQK+SuF6ge3miwm5pDLe5Pt8
X-Gm-Message-State: AOJu0Yy5rOLPuR3W2hrAc229r/YuvL0uEzTUafLVOSNkTfDCAYG6cSOL
	ITZLW3htstu1jhvmRtWeEdiG8mN4SS5fv1LwW+vG9DBifcSt/WKRiM9HbIXrGKmrxqNoK9iCD1p
	qAfvl+dTF/IuT6hkDNeWpU+xqo889vptffEpNSLRPulP6UkgS6y00e+s=
X-Google-Smtp-Source: AGHT+IF/Irxd+FreqzY2G0Dkh05T0EqrUKVeSpieN4l7+L1bMF2orunjg1xCfnAVSsTVq7CRFKRBXpUbg7gDzSqIwLNmIzBWidCb
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:398:d1fe:9868 with SMTP id
 e9e14a558f8ab-39b7a75252dmr8277705ab.4.1723455917663; Mon, 12 Aug 2024
 02:45:17 -0700 (PDT)
Date: Mon, 12 Aug 2024 02:45:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c23d15061f79592d@google.com>
Subject: [syzbot] [serial?] KMSAN: kernel-infoleak in tty_read
From: syzbot <syzbot+aa7ddf2352c316bb08d0@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a0e38264012 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1489f27d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=305509ad8eb5f9b8
dashboard link: https://syzkaller.appspot.com/bug?extid=aa7ddf2352c316bb08d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82fdd1f77a94/disk-6a0e3826.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc02539b71e6/vmlinux-6a0e3826.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f2caa5e7e58/bzImage-6a0e3826.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa7ddf2352c316bb08d0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_iovec include/linux/iov_iter.h:51 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:247 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x7c7/0x24a0 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_iovec include/linux/iov_iter.h:51 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:247 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x7c7/0x24a0 lib/iov_iter.c:185
 copy_to_iter include/linux/uio.h:196 [inline]
 iterate_tty_read drivers/tty/tty_io.c:882 [inline]
 tty_read+0x42c/0xe10 drivers/tty/tty_io.c:937
 do_iter_readv_writev+0x8a1/0xa40
 vfs_readv+0x36c/0xef0 fs/read_write.c:932
 do_readv+0x251/0x5c0 fs/read_write.c:994
 __do_sys_readv fs/read_write.c:1085 [inline]
 __se_sys_readv fs/read_write.c:1082 [inline]
 __x64_sys_readv+0x98/0xe0 fs/read_write.c:1082
 x64_sys_call+0x3889/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:20
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 copy_from_read_buf drivers/tty/n_tty.c:1978 [inline]
 n_tty_read+0x2196/0x3260 drivers/tty/n_tty.c:2304
 iterate_tty_read drivers/tty/tty_io.c:862 [inline]
 tty_read+0x327/0xe10 drivers/tty/tty_io.c:937
 do_iter_readv_writev+0x8a1/0xa40
 vfs_readv+0x36c/0xef0 fs/read_write.c:932
 do_readv+0x251/0x5c0 fs/read_write.c:994
 __do_sys_readv fs/read_write.c:1085 [inline]
 __se_sys_readv fs/read_write.c:1082 [inline]
 __x64_sys_readv+0x98/0xe0 fs/read_write.c:1082
 x64_sys_call+0x3889/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:20
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 n_tty_receive_buf_real_raw drivers/tty/n_tty.c:1532 [inline]
 __receive_buf drivers/tty/n_tty.c:1618 [inline]
 n_tty_receive_buf_common+0xe6e/0x2490 drivers/tty/n_tty.c:1739
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1785
 tty_ldisc_receive_buf+0xd0/0x290 drivers/tty/tty_buffer.c:387
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x473/0xdb0 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3312
 worker_thread+0xea5/0x1520 kernel/workqueue.c:3390
 kthread+0x3dd/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3994 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x661/0xf30 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
 __tty_buffer_request_room+0x36e/0x6d0 drivers/tty/tty_buffer.c:273
 __tty_insert_flip_string_flags+0x140/0x570 drivers/tty/tty_buffer.c:309
 tty_insert_flip_string_fixed_flag include/linux/tty_flip.h:35 [inline]
 tty_insert_flip_string include/linux/tty_flip.h:83 [inline]
 puts_queue drivers/tty/vt/keyboard.c:333 [inline]
 k_fn+0x154/0x1e0 drivers/tty/vt/keyboard.c:776
 k_pad+0x461/0xc40
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0x5e2c/0x6010 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x128/0x1f0 drivers/input/input.c:2552
 input_pass_values+0x216/0x990 drivers/input/input.c:126
 input_event_dispose+0x552/0x6e0 drivers/input/input.c:352
 input_handle_event+0xf3c/0x1430 drivers/input/input.c:369
 input_event+0xe2/0x120 drivers/input/input.c:398
 hidinput_hid_event+0x256d/0x2960 drivers/hid/hid-input.c:1746
 hid_process_event+0x766/0x930 drivers/hid/hid-core.c:1540
 hid_input_array_field+0x768/0x850 drivers/hid/hid-core.c:1652
 hid_process_report drivers/hid/hid-core.c:1694 [inline]
 hid_report_raw_event+0x1d22/0x2820 drivers/hid/hid-core.c:2015
 __hid_input_report drivers/hid/hid-core.c:2085 [inline]
 hid_input_report+0x5a2/0x610 drivers/hid/hid-core.c:2107
 hid_irq_in+0x737/0xd00 drivers/hid/usbhid/hid-core.c:285
 __usb_hcd_giveback_urb+0x572/0x840 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x157/0x720 drivers/usb/core/hcd.c:1734
 dummy_timer+0xd3f/0x6aa0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x564/0xe40 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x3ab/0x1490 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0xa6/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x7e/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702

Bytes 8-11 of 20 are uninitialized
Memory access of size 20 starts at ffff88813f5ebb40
Data copied to user address 0000000020000280

CPU: 1 UID: 0 PID: 6504 Comm: syz.3.387 Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
=====================================================


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
