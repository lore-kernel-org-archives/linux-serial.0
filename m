Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E303D0A4
	for <linux-serial@vger.kernel.org>; Tue,  9 Jan 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bb6983237fso381563139f.2
        for <linux-serial@vger.kernel.org>; Tue, 09 Jan 2024 10:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824543; x=1705429343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQshBh/fxjyTmdN95UWGzvUhlNjt9J+r51+Ot2uzyGw=;
        b=DoPLW5Yz2PYHwMxx5y67ujOn+10dwIAjDjs6ovWYBLLL9u1sn/D1NRHLMjXSmxrB9/
         SgMvgJGe90pWNGA4rvoAHbWQgvtUtveO2scL+kXC8SY3YU5zdo1jDq3o+HEmRFaJkp/x
         BiOoaT9x6Vfr8/M9P0mIC7PgYY4adxH0NNCkh20SWzQFC8T5Wnh6DAVhgCDFnOzcrqMh
         sDKtAZUsnk0xN29T8OOHfGYODOlt2kAfKtd5TNljTl2WDpNO+B37ZmOrxj8+O70PNxkU
         p6SyWnx4adZX5YS1vKBwL4MwX3hKIbn0t/nOYjOqLkq8/ULYBpZDiWOe5cWAPC+7V1f4
         vtkA==
X-Gm-Message-State: AOJu0YxaLudEEyQN9eJv6fRTROjcHCwVvmfSIks3dbGzE0vwAZougedV
	l79WeJI0H9XFF5cxe2wyyq0Q/WJIYi3a5qBIHkYjeZUB1BhD
X-Google-Smtp-Source: AGHT+IEulx7Mb3nQDilqzzO14+gAdrRfPzc72xrvsDqtZ5RxaFg2yVYxRJBz4uYkZHyHKPfibrkZmMB9ASCxzgtVoTxO79zwKhIm
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c9:b0:46b:719a:62d0 with SMTP id
 g9-20020a05663816c900b0046b719a62d0mr693290jat.5.1704824543307; Tue, 09 Jan
 2024 10:22:23 -0800 (PST)
Date: Tue, 09 Jan 2024 10:22:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004efc03060e8765fc@google.com>
Subject: [syzbot] [serial?] KMSAN: uninit-value in n_tty_receive_buf_closing (2)
From: syzbot <syzbot+bb79c2d300f0f7a021f8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130f5a99e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e51fe20c3e51ba7f
dashboard link: https://syzkaller.appspot.com/bug?extid=bb79c2d300f0f7a021f8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/baec1b9d2a54/disk-ac865f00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/162f156f01a7/vmlinux-ac865f00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14fcf2ebed42/bzImage-ac865f00.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb79c2d300f0f7a021f8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in n_tty_receive_char_closing drivers/tty/n_tty.c:1454 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_closing+0x539/0xb40 drivers/tty/n_tty.c:1567
 n_tty_receive_char_closing drivers/tty/n_tty.c:1454 [inline]
 n_tty_receive_buf_closing+0x539/0xb40 drivers/tty/n_tty.c:1567
 __receive_buf drivers/tty/n_tty.c:1625 [inline]
 n_tty_receive_buf_common+0x183e/0x2310 drivers/tty/n_tty.c:1729
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1775
 tty_ldisc_receive_buf+0xce/0x270 drivers/tty/tty_buffer.c:386
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:444 [inline]
 flush_to_ldisc+0x4b7/0xdc0 drivers/tty/tty_buffer.c:494
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:179 [inline]
 __tty_buffer_request_room+0x36e/0x6c0 drivers/tty/tty_buffer.c:272
 __tty_insert_flip_string_flags+0x140/0x560 drivers/tty/tty_buffer.c:308
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa00 drivers/tty/serial/serial_core.c:3494
 serial8250_read_char+0x1a2/0x5d0 drivers/tty/serial/8250/8250_port.c:1760
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1777 [inline]
 serial8250_handle_irq+0x77b/0xb30 drivers/tty/serial/8250/8250_port.c:1937
 serial8250_default_handle_irq+0x11a/0x2a0 drivers/tty/serial/8250/8250_port.c:1962
 serial8250_interrupt+0xc0/0x350 drivers/tty/serial/8250/8250_core.c:127
 __handle_irq_event_percpu+0x113/0xc90 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xef/0x2c0 kernel/irq/handle.c:210
 handle_edge_irq+0x341/0xf90 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq arch/x86/kernel/irq.c:238 [inline]
 __common_interrupt+0x94/0x1f0 arch/x86/kernel/irq.c:257
 common_interrupt+0x89/0xa0 arch/x86/kernel/irq.c:247
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:640

CPU: 1 PID: 6205 Comm: kworker/u4:2 Not tainted 6.7.0-rc8-syzkaller-00024-gac865f00af29 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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
