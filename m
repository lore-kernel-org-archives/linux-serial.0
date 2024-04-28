Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45E4A2C
	for <linux-serial@vger.kernel.org>; Sun, 28 Apr 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714339229; cv=none; b=pt60kz8Szrkp8flzOQnmNL5brMfUuI7g5LFuOZYKDVABOFFsaSdG35wWcgP26cJDI/mdqrAb+C/eTHVt88zscnkS3rGtC4nboLnySj/LNudXMSYVfcdaMAZCI53rHjlaqJcORCSuO91hqv0dGnR1+C99YLwdbvykePSSf7LAooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714339229; c=relaxed/simple;
	bh=GnlWP92xN+/GoYzVZ2T5ivzMzjHUPtUijrlLUsETFHI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hk5Bj3WnC9l9/M/s5cKbiydkyOX/5LFwJ7cAMR5Z4lxN4VT2z1snmNet5GOPGE/igbeRWulvY9d1pzNoYEMl8RZ9v45f73OkhH7AwPQv8s/I1KjoogfJYrbzj7PA2P9FaztYR8o/JsQhmLTAIJlPh1iW9PZKeIdXPKyFZdy0wGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dec58efbfaso110238539f.3
        for <linux-serial@vger.kernel.org>; Sun, 28 Apr 2024 14:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714339227; x=1714944027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6hVO5FhFpuKvFim9NSfwhPqv8ZEhAS9UENFDff7oD8=;
        b=JIlM3eAnp7w3q7kBjqqtC3fV2g4waUGk9x6ff51FPz2kWUn8eTHX6NDBeFMsnimPHE
         IxiLkQaIgFicTjKIErevpBIAHY7vy/ExYQx0txqKJu86UdZ5XvOAvrIYrMfWpyA68ZVL
         nFCSV+shCD5AjktxfpH4oddHamEBbH/hZbJSzydoxiJTj3Z987tE9TXy2Zn+qlGrLQjm
         o4bWssYYQ8e4aQ8yMlw+bBfGHoYMtKe9v+MPVhj8JrU/yoAFIVqQKiKlhVpUuT75FtaA
         nXPN0dGmHoURAhwtP1UBVOueRus4juzHYvAAJrampmiNM+TLKRaQWcCMLlmXcdCEe59e
         1Lyw==
X-Forwarded-Encrypted: i=1; AJvYcCUBVCWUMVngEb+PYy79xSlbGf4hqTihYhMJhdBCH7DtbVY+tpkwZWNfHaEXxltRac20s9DmXuBcZXkNU5rCYRaC39OEZhc0L7TQNtDd
X-Gm-Message-State: AOJu0YyKa2PBoK7U3BuZgwtY+m/xigiHZp32NmyKJoodc/xkfQwVE3vf
	4S/VOHnMYHrekTjDbVZEmcxl6IHCas0mXQ7Hj7jW6ZMFdndFW8Oku7Zxm+TkYRJJOoG3RVBM39y
	/Z4CZ5W4hvnGvassLN0FEZbkyqdnQSZ0g2gzDpUqlBUzrrGI4hoj+Qyk=
X-Google-Smtp-Source: AGHT+IELbccC2vM6+djVggTer7HtqXCmr5mQTsm5NCgG9wQxWdfsVdh/X+3Bcg8Eu52lmR2ZYcsFRGpOupUzPxGkcj3/5TPlyGVA
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d89:b0:487:c6e:1bf2 with SMTP id
 ci9-20020a0566383d8900b004870c6e1bf2mr706534jab.1.1714339226881; Sun, 28 Apr
 2024 14:20:26 -0700 (PDT)
Date: Sun, 28 Apr 2024 14:20:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4a64506172eb4ff@google.com>
Subject: [syzbot] [serial?] KMSAN: uninit-value in gsmld_receive_buf
From: syzbot <syzbot+2f64914d6a3a8ce91bdd@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1664a5e8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
dashboard link: https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76771e00ba79/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c957ed943a4f/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e719306ed8e3/bzImage-e88c4cfc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f64914d6a3a8ce91bdd@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in gsmld_receive_buf+0x5dc/0x640 drivers/tty/n_gsm.c:3555
 gsmld_receive_buf+0x5dc/0x640 drivers/tty/n_gsm.c:3555
 tty_ldisc_receive_buf+0x202/0x290 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x473/0xdb0 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x6e4/0x1000 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
 __tty_buffer_request_room+0x36e/0x6d0 drivers/tty/tty_buffer.c:273
 __tty_insert_flip_string_flags+0x140/0x570 drivers/tty/tty_buffer.c:309
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa10 drivers/tty/serial/serial_core.c:3558
 serial8250_read_char+0x1a7/0x5d0 drivers/tty/serial/8250/8250_port.c:1750
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1767 [inline]
 serial8250_handle_irq+0x77a/0xb80 drivers/tty/serial/8250/8250_port.c:1927
 serial8250_default_handle_irq+0x120/0x2b0 drivers/tty/serial/8250/8250_port.c:1952
 serial8250_interrupt+0xc5/0x360 drivers/tty/serial/8250/8250_core.c:127
 __handle_irq_event_percpu+0x118/0xca0 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xef/0x2c0 kernel/irq/handle.c:210
 handle_edge_irq+0x340/0xfb0 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq arch/x86/kernel/irq.c:238 [inline]
 __common_interrupt+0x97/0x1f0 arch/x86/kernel/irq.c:257
 common_interrupt+0x49/0xa0 arch/x86/kernel/irq.c:247
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 1 PID: 14392 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
