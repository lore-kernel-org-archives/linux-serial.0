Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8413AA2F
	for <linux-serial@vger.kernel.org>; Mon, 26 Jan 2026 05:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769405497; cv=none; b=s3JA0K/7wKdI0e/6GRJMSXN+wQNcDWvwze5e+0DElS7zZ6Dv7r/OtXBg+pYRRWvzbofH8YfrAYiwmdkAF9QqnXWjC/USI0VX64qB/kiIIdd+yfL5jYxSeO5lu9rAaql0KmasVpvNvW2oFvZ3ymtIGdEsc4Ddzw+TupaTIsJHBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769405497; c=relaxed/simple;
	bh=oQ0IgKnhwOHxp/pLc2fiaJzMamDyEOqVWH9YGlSNriA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jca1P+/NNPDcUDXCJcJqf+AmFow1qiZ6T9SCDFrkPl9YILomk8rCzvxGn5qlBbmO9FFeKBMgWrSs8cV143myAZnhlVVRZgQtZXIZ+FpbtSPdT7Jgz1Lrbui9jUS0zGzGk+g9ri/N9r/usPDirUyA3KHnovTmW4AI54WSnYr9GXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7cad3d056c1so12665993a34.1
        for <linux-serial@vger.kernel.org>; Sun, 25 Jan 2026 21:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769405494; x=1770010294;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqUZ3c9+ax5L+vGKSacQgC7V3LN4C9o9FlkF2Ug/AEg=;
        b=PbscGMLzaGD+MDr9DWJAsRAb2uOmmTjq9WCDFSjEsR8G057nGXZYHJgKHeUz1jHxlO
         ivmyDGEAZxO0lazDajtJPLJVLa6fehwmmIDjWnqrQliHoyn0m8qhXifPYuDxIegZoyAA
         a0K2cdeCGq6r31MDpvLs0cTKWCuOuZ6JeoxAV5If+wE0YB9XYukmKMldbvuY+xghc4QD
         8YoAzk5opj6weI68UE/3tV5rrAVFGB+kEF0J7N2sJ4/P1rJ+mS/slWesmXgLPQUj8aBG
         pII9SI5RQKzq7Or1WWxieeEampncL+Jt5EhwBSpB8D0Ab3+0FAcT2NmgVp4HJgKOw8+Z
         D/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Y1ketteLhED5F5oOWOCZ1RBr13reYbmSFXYjIgx2s2EX2DVxPRy4SIp5PSnl3F4yMCR7o15UF7OIYkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrO8LtOaG5857betsHcYt/tD0cgt7XbZxXwZWR+BN+mqo4gr1g
	qfB1cnwKhKb6Dv5WML9sHsiXSz3EqFpITYxW6GO4cGs2dNuQSPCKydIAmPc4fEHJHxqZ14OTpYb
	7v62X4yq3L9kwWcHqDFZgVzXKfiiz+vpE3vyhDwEEHRfiWIZEpA7vk7PIiOM=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2010:b0:65b:299f:8947 with SMTP id
 006d021491bc7-662e0a11e37mr1702345eaf.14.1769405494479; Sun, 25 Jan 2026
 21:31:34 -0800 (PST)
Date: Sun, 25 Jan 2026 21:31:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6976fc36.a00a0220.33ccc7.0031.GAE@google.com>
Subject: [syzbot] [serial?] KMSAN: uninit-value in gsmld_receive_buf (2)
From: syzbot <syzbot+60e074cc0d3b54a82cf1@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf38b2340c0e Merge tag 'soc-fixes-6.19-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e05d22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bf02b9e495b9fcd
dashboard link: https://syzkaller.appspot.com/bug?extid=60e074cc0d3b54a82cf1
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0bca22500a65/disk-cf38b234.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d7caf81eafb/vmlinux-cf38b234.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d9e3619531e9/bzImage-cf38b234.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60e074cc0d3b54a82cf1@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in gsmld_receive_buf+0x558/0x5d0 drivers/tty/n_gsm.c:3617
 gsmld_receive_buf+0x558/0x5d0 drivers/tty/n_gsm.c:3617
 tty_ldisc_receive_buf+0x1f7/0x2c0 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0xd7/0x1a0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x43e/0xe40 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xb03/0x1da0 kernel/workqueue.c:3340
 worker_thread+0xede/0x1590 kernel/workqueue.c:3421
 kthread+0xd5a/0xf00 kernel/kthread.c:463
 ret_from_fork+0x207/0x6f0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4960 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_noprof+0xae9/0x1c00 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
 __tty_buffer_request_room+0x3d4/0x7a0 drivers/tty/tty_buffer.c:273
 __tty_insert_flip_string_flags+0x157/0x6f0 drivers/tty/tty_buffer.c:309
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x368/0x930 drivers/tty/serial/serial_core.c:3423
 serial8250_read_char+0x1ba/0x670 drivers/tty/serial/8250/8250_port.c:1641
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1658 [inline]
 serial8250_handle_irq+0x930/0x1110 drivers/tty/serial/8250/8250_port.c:1822
 serial8250_default_handle_irq+0x116/0x370 drivers/tty/serial/8250/8250_port.c:1846
 serial8250_interrupt+0xcb/0x420 drivers/tty/serial/8250/8250_core.c:86
 __handle_irq_event_percpu+0x118/0xec0 kernel/irq/handle.c:211
 handle_irq_event_percpu kernel/irq/handle.c:248 [inline]
 handle_irq_event+0xe0/0x2a0 kernel/irq/handle.c:265
 handle_edge_irq+0x2a9/0xb50 kernel/irq/chip.c:855
 generic_handle_irq_desc include/linux/irqdesc.h:172 [inline]
 handle_irq arch/x86/kernel/irq.c:255 [inline]
 call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
 __common_interrupt+0x9d/0x180 arch/x86/kernel/irq.c:326
 common_interrupt+0x94/0xb0 arch/x86/kernel/irq.c:319
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:688

CPU: 1 UID: 0 PID: 6065 Comm: kworker/u8:16 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events_unbound flush_to_ldisc
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
