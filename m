Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87D18732B
	for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722915694; cv=none; b=l2mmqKrkv5VuVmsWjuDH/Bg8RPehjMV9k7nl4dAA1jQ48Aic31F2BPPrBfp9L6MQsHQHgyR0LVmNug7PY4Wur7pXhLNMjTRHv4gat3T6cG2vAfNBI3RaCcpM46713KmumEfDCVCBm9hc9j3VdQYVrF7GLvL52fUzMyn98uAecWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722915694; c=relaxed/simple;
	bh=cfJnQiGRiLNZZXQ0U5w+PwTLBxMbYLy4nYGq0lhTmtA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pkKyo+OWk3qsUCRPF3tOQWHK4lbmonBfQGVxLKhsnvCl/uTLcQ56Unp6ksLYJ6jRCsyaKppnXyAotdtin/ZKtOFxdO7Wf2Kt+TS33VpUCIIXYZvg5nDx8Qdc/UJ/4WtY6lRzWyqa4eYNPg0cwpDiE9aclkapecPwNoGNUyAGcVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fb21a0e41so10231039f.2
        for <linux-serial@vger.kernel.org>; Mon, 05 Aug 2024 20:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722915688; x=1723520488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+JgjY7BMDnfPKZwhOPFpQUnmBA2Ec1+1za4jsL4wAJQ=;
        b=aUflgFKdtOczQw0v9zZmRpZrGNBgI9zlQCS9ecvZdBHCqBDoVsu/xJQc9u6aU7dsx4
         WpfXELfpfqmNrFR0ABzxZgM3MDARwNQFuUUAkvfEdIQPpSz3ZIVIc11rJdcTyXtZs+5R
         qC9cs41FP0ijVMqLyTqhHRBB3UTYiFzoi/PlIgOPUdeuPSkwDVuwL4gXHD4xCJbASsB4
         tec+rvachlrNobjohWCP4BktdRLM9JO2vfaGv6V5DkZm21eeOwFaZG0PhTt+rj/Sty71
         u2BFZsQTzeuFSstoKENTEa+GN33JGojg7DQ4nHHDBP7BKtwvhCCDN1/eMy8+3MiovKU6
         80sw==
X-Forwarded-Encrypted: i=1; AJvYcCW6iEL9hf8VKN3Y7aGYIW0t1CxEEGGmo+UzPO1ftszrjlK+fj8LR8NcGhteSfX/5Joem9pvg3N/oNusQADYjm/5kWmyiA3zKeOmwo4w
X-Gm-Message-State: AOJu0YyszJLdtwnmFsbvtoB1ERH1YHA4jJhLyshQjU25CzsWnkXA5oIB
	Ysvy3/XelUCNileoXXFXdNGFdmBQhMbDGrPg6CcVFgh9gPm7OlV15wRxBontnnFf0Xv7ngjTA8d
	nKD/YAX+tCwcWacHf72G9W5jb/7xTWlu+dl9EOzWm03A0V3cVmoedifg=
X-Google-Smtp-Source: AGHT+IHVoYK2/OVOYfaCo3woMIImP2h9pp6CXglXCHeHvltXb/LLj4+pMMWRpDNkZbvLbobZk6o6fEUrr3wCaF6/0T5/FXmYvXI4
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8911:b0:4c2:7a26:278b with SMTP id
 8926c6da1cb9f-4c8d56af0b0mr362481173.5.1722915688467; Mon, 05 Aug 2024
 20:41:28 -0700 (PDT)
Date: Mon, 05 Aug 2024 20:41:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096e011061efb915b@google.com>
Subject: [syzbot] [serial?] KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
From: syzbot <syzbot+290abdcd4f509377a0eb@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17712b7ea075 Merge tag 'io_uring-6.11-20240802' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc6e75980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d6059ad10dde6fd
dashboard link: https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ab4fb08b298/disk-17712b7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22441c38ffc1/vmlinux-17712b7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/faf4575a6197/bzImage-17712b7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+290abdcd4f509377a0eb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in n_tty_lookahead_flow_ctrl+0x2cd/0x300 drivers/tty/n_tty.c:1516
 n_tty_lookahead_flow_ctrl+0x2cd/0x300 drivers/tty/n_tty.c:1516
 tty_port_default_lookahead_buf+0x144/0x210 drivers/tty/tty_port.c:59
 lookahead_bufs drivers/tty/tty_buffer.c:428 [inline]
 flush_to_ldisc+0x8ec/0xdb0 drivers/tty/tty_buffer.c:498
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
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa10 drivers/tty/serial/serial_core.c:3560
 serial8250_read_char+0x1a7/0x5d0 drivers/tty/serial/8250/8250_port.c:1743
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1760 [inline]
 serial8250_handle_irq+0x77a/0xb80 drivers/tty/serial/8250/8250_port.c:1924
 serial8250_default_handle_irq+0x120/0x2b0 drivers/tty/serial/8250/8250_port.c:1949
 serial8250_interrupt+0xc5/0x360 drivers/tty/serial/8250/8250_core.c:86
 __handle_irq_event_percpu+0x118/0xca0 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xef/0x2c0 kernel/irq/handle.c:210
 handle_edge_irq+0x340/0xfb0 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x97/0x1f0 arch/x86/kernel/irq.c:285
 common_interrupt+0x8f/0xa0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 0 UID: 0 PID: 3456 Comm: kworker/u8:20 Not tainted 6.11.0-rc1-syzkaller-00272-g17712b7ea075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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
