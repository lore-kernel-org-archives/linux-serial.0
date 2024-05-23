Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519713B584
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445409; cv=none; b=r/aY4CIILIpoaWcqTGRRnzuPXnxClZY3hGB59QETQimRPYkiCLkX3gRQXCEuG8CQJDQjFbQlCpm/I5Nhw5OyFQgcxk6aVOQuabUW9OKjWVFzuxMqXKazpaI9l24pr3T/pt/48WkNhDkRwnTZxKOBi4bQKB9pbjhNlUMaln78H+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445409; c=relaxed/simple;
	bh=0Ps/ANO7fGli6TROrZEAsKSunwS9h7zlQ0i5hXgbpdc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qldZUXrZsT7ZbL9MBWS1T0qVS3hNRM2LP28ig/vjb0YZJswB7s/9bzwfVRQ+Dgcq4voWOzj+5LtRwCop8Ya44JUaXGvrqZ7MP+OIgMgYooIurcahop+ocjWDcJWD7Cvj7GmsGXpuoSy1Aq0K/K5flP9HxUj8G3w4N8hRjyTdhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36db491a90fso15892675ab.3
        for <linux-serial@vger.kernel.org>; Wed, 22 May 2024 23:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716445406; x=1717050206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBMuUqX5kuVar7C8mlUR6O3NJrHuRZwGA97dxRcFh+o=;
        b=px3M9geu+s/iWOZWoTT8W5rNsUXv5sFIDY5+jlvh2G0p+Lierr7WSp7tGVeTgZH1hd
         qBqIgMoLPMjjS30WZeH6wvLj6cx5Z1S1XbnRWOq/vu+L0Bds5f+GvTz5LmOK1wMDyYx5
         iSVVCp9mfJJz94PBzp7K9aeYM823zCjyRmngvrUDp67bOxwUlzgORf7AEeIwHwyEJFNW
         QEJV9BaX1nX1cSfSjUzLMudle6YO9LECVP1neszCEF21NTdXGAbj0theXLARRWatLr6E
         67fZRW699O9RFDNLGP5Q6bJfJO0vkD8z0FAhf8U3xfnpX9O2LPfZmFWyEfYcSVpECAre
         Gp3A==
X-Forwarded-Encrypted: i=1; AJvYcCX20oYMvSS1pvXZXy2vcD3wmPuHHwGF0sBtvn7WbsOXrtBCeKo8uOyaeJXko43frmISBvfI6AOrP+NKsWMoejq6UnFf0po9cAwIDzQT
X-Gm-Message-State: AOJu0Ywqh2vBItuXfKk86tspi8EM+mNbz7BBQuvoSEymHZW5tCPiFish
	RirDYhxXJ5rp5Pk6VtznZzzjlyu4wNJRZBt+iwBEVJhYyaN7uslMeXOrn2dB1lPvDW6rpyO6fiV
	9ehyjsUSIpTmfB9y/ZVe5mZJr6GXpsahF/PWk7/nmdJLEv4jqK7GS6FY=
X-Google-Smtp-Source: AGHT+IFs3s6TP+BHm6o2I8f1h1FGKe6aPqgpDeTRxFh1MT96XB+BkLhjeRFfJUBUE851dQypE+iVu6F7teJL6nYgKb11wJRYZTxj
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:371:30f1:96be with SMTP id
 e9e14a558f8ab-371f403f129mr2698855ab.0.1716445406705; Wed, 22 May 2024
 23:23:26 -0700 (PDT)
Date: Wed, 22 May 2024 23:23:26 -0700
In-Reply-To: <0000000000006588730616e3d3d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be49b106191916f0@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in uart_write (2)
From: syzbot <syzbot+57cc2f20a84cb4346354@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    de7e71ef8bed mm: simplify and improve print_vma_addr() out..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1358d748980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45d62832ec0fc911
dashboard link: https://syzkaller.appspot.com/bug?extid=57cc2f20a84cb4346354
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cd9414980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140480ec980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-de7e71ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c97829b07ce/vmlinux-de7e71ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e91040d0f4f3/bzImage-de7e71ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57cc2f20a84cb4346354@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-11924-gde7e71ef8bed #0 Not tainted
------------------------------------------------------
syz-executor379/5188 is trying to acquire lock:
ffffffff8dabed20 (console_owner){....}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1994 [inline]
ffffffff8dabed20 (console_owner){....}-{0:0}, at: vprintk_emit kernel/printk/printk.c:2344 [inline]
ffffffff8dabed20 (console_owner){....}-{0:0}, at: vprintk_emit+0x42d/0x5a0 kernel/printk/printk.c:2300

but task is already holding lock:
ffffffff94de6f38 (&port_lock_key){-...}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
ffffffff94de6f38 (&port_lock_key){-...}-{2:2}, at: uart_write+0x134/0x3e0 drivers/tty/serial/serial_core.c:624

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&port_lock_key){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
       serial8250_console_write+0xaa6/0x1090 drivers/tty/serial/8250/8250_port.c:3352
       console_emit_next_record kernel/printk/printk.c:2928 [inline]
       console_flush_all+0x53f/0xd70 kernel/printk/printk.c:2994
       console_unlock+0xae/0x290 kernel/printk/printk.c:3063
       vprintk_emit kernel/printk/printk.c:2345 [inline]
       vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2300
       vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2370
       register_console+0xa88/0x10a0 kernel/printk/printk.c:3596
       univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:719
       console_init+0xcc/0x680 kernel/printk/printk.c:3742
       start_kernel+0x295/0x4c0 init/main.c:1038
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x148

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       console_trylock_spinning kernel/printk/printk.c:1994 [inline]
       vprintk_emit kernel/printk/printk.c:2344 [inline]
       vprintk_emit+0x442/0x5a0 kernel/printk/printk.c:2300
       vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2370
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x4ac/0x580 lib/bug.c:219
       handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       uart_write+0x2bf/0x3e0 drivers/tty/serial/serial_core.c:625
       tnc_init drivers/net/hamradio/6pack.c:531 [inline]
       sixpack_open+0x93b/0xb30 drivers/net/hamradio/6pack.c:628
       tty_ldisc_open+0x9c/0x120 drivers/tty/tty_ldisc.c:432
       tty_set_ldisc+0x318/0x720 drivers/tty/tty_ldisc.c:563
       tiocsetd drivers/tty/tty_io.c:2439 [inline]
       tty_ioctl+0xbdc/0x15f0 drivers/tty/tty_io.c:2739
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl fs/ioctl.c:893 [inline]
       __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port_lock_key);
                               lock(console_owner);
                               lock(&port_lock_key);
  lock(console_owner);

 *** DEADLOCK ***

3 locks held by syz-executor379/5188:
 #0: ffff888011ccc1c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_set_ldisc+0x8b/0x720 drivers/tty/tty_ldisc.c:528
 #1: ffff888011ccc0a0 (&tty->ldisc_sem){++++}-{0:0}, at: __tty_ldisc_lock drivers/tty/tty_ldisc.c:289 [inline]
 #1: ffff888011ccc0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock+0x65/0xb0 drivers/tty/tty_ldisc.c:313
 #2: ffffffff94de6f38 (&port_lock_key){-...}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
 #2: ffffffff94de6f38 (&port_lock_key){-...}-{2:2}, at: uart_write+0x134/0x3e0 drivers/tty/serial/serial_core.c:624

stack backtrace:
CPU: 2 PID: 5188 Comm: syz-executor379 Not tainted 6.9.0-syzkaller-11924-gde7e71ef8bed #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 console_trylock_spinning kernel/printk/printk.c:1994 [inline]
 vprintk_emit kernel/printk/printk.c:2344 [inline]
 vprintk_emit+0x442/0x5a0 kernel/printk/printk.c:2300
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2370
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x4ac/0x580 lib/bug.c:219
 handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:uart_write+0x2bf/0x3e0 drivers/tty/serial/serial_core.c:625
Code: 6b fc e9 4e ff ff ff e8 ef e1 90 fc 90 0f 0b 90 49 c7 c4 d2 ff ff ff e9 39 ff ff ff e8 da e1 90 fc 45 31 ff e8 d2 e1 90 fc 90 <0f> 0b 90 48 85 ed 74 8c e8 c4 e1 90 fc 4c 8d a5 08 01 00 00 4c 89
RSP: 0018:ffffc90003137bd8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff88801f908be8 RCX: ffffffff816c49ad
RDX: ffff88802a360000 RSI: ffffffff84fd0abe RDI: ffff88801f908f48
RBP: ffffffff94de6f20 R08: 0000000000000001 R09: fffff52000626f69
R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000001 R14: ffff888024980f01 R15: 0000000000000293
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x93b/0xb30 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open+0x9c/0x120 drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x318/0x720 drivers/tty/tty_ldisc.c:563
 tiocsetd drivers/tty/tty_io.c:2439 [inline]
 tty_ioctl+0xbdc/0x15f0 drivers/tty/tty_io.c:2739
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f956812d2e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeea498a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffeea498c18 RCX: 00007f956812d2e9
RDX: 0000000020000080 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007f95681a0610 R08: 0000000000000000 R09: 00007ffeea498c18
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffeea498c08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
WARNING: CPU: 2 PID: 5188 at drivers/tty/serial/serial_core.c:625 uart_write+0x2bf/0x3e0 drivers/tty/serial/serial_core.c:625
Modules linked in:
CPU: 2 PID: 5188 Comm: syz-executor379 Not tainted 6.9.0-syzkaller-11924-gde7e71ef8bed #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:uart_write+0x2bf/0x3e0 drivers/tty/serial/serial_core.c:625
Code: 6b fc e9 4e ff ff ff e8 ef e1 90 fc 90 0f 0b 90 49 c7 c4 d2 ff ff ff e9 39 ff ff ff e8 da e1 90 fc 45 31 ff e8 d2 e1 90 fc 90 <0f> 0b 90 48 85 ed 74 8c e8 c4 e1 90 fc 4c 8d a5 08 01 00 00 4c 89
RSP: 0018:ffffc90003137bd8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff88801f908be8 RCX: ffffffff816c49ad
RDX: ffff88802a360000 RSI: ffffffff84fd0abe RDI: ffff88801f908f48
RBP: ffffffff94de6f20 R08: 0000000000000001 R09: fffff52000626f69
R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000001 R14: ffff888024980f01 R15: 0000000000000293
FS:  0000555560c5f380(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000001e942000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x93b/0xb30 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open+0x9c/0x120 drivers/tty/tty_ldisc.c:432
 tty_set_ldisc+0x318/0x720 drivers/tty/tty_ldisc.c:563
 tiocsetd drivers/tty/tty_io.c:2439 [inline]
 tty_ioctl+0xbdc/0x15f0 drivers/tty/tty_io.c:2739
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f956812d2e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeea498a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffeea498c18 RCX: 00007f956812d2e9
RDX: 0000000020000080 RSI: 0000000000005423 RDI: 0000000000000003
RBP: 00007f95681a0610 R08: 0000000000000000 R09: 00007ffeea498c18
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffeea498c08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
