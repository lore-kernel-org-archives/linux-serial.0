Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E64C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACA965014
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 11:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhA2L5L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jan 2021 06:57:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:39857 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbhA2L42 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jan 2021 06:56:28 -0500
Received: by mail-il1-f200.google.com with SMTP id e11so7348987ils.6
        for <linux-serial@vger.kernel.org>; Fri, 29 Jan 2021 03:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BtTuTJ7ZB/kcTHGKNTf155HKZJmQZxL5uqEKr7G5Xs8=;
        b=hjkf6ASqNKcoA34Wfwq4hcWXqyod2Lt5zFLkUW72qTqsBWtkKH4PBdLZCubORzMuy4
         JQO+uOjXGmIn1r2+i/E2G2DIFgXfb+G+K+BUn+KEz0uWtzQL8BFVvcUmD6pqI2HD+y6B
         soWDFB0Tn3JhVui6gTtzpY3Z1WAuTiPhd9cCoHen4RZYTN+3lOPefN1dL/uvezO2NLS/
         IcdyKUscKFniZWh9u3AhWkxWC8iqBLrmzCsgvqPtFOCQvVN94YFN+HHZxhokX2USM0NF
         EJayxVmb1mGdya5CcWCxYWZ2UAGyLH8M1xh6m/5kfylt1cMoqmFxIio5n39nxSKmR0Xa
         bONA==
X-Gm-Message-State: AOAM530u4V+9h+6wWsQwzAk6JSa6+Cn8CyCM6/DK+1ORtxQyP25VZKia
        8JiozuVgqYgfeBT6DzJtBzORErjOX+vdp0BhVsp2u1Z3kuCp
X-Google-Smtp-Source: ABdhPJyFERWg+PtCF0VyWKhyl1k9LjAFTV8rHz8J2er7TViP/bVO2aDyEGXxHehBiVYu8N/OKdbFh/7NQPyi9WGMxG1dAzlrxMfC
MIME-Version: 1.0
X-Received: by 2002:a02:9666:: with SMTP id c93mr2703734jai.44.1611909251908;
 Fri, 29 Jan 2021 00:34:11 -0800 (PST)
Date:   Fri, 29 Jan 2021 00:34:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ec92c05ba05de1b@google.com>
Subject: Internal error in io_serial_out
From:   syzbot <syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com>
To:     Sergey.Semin@baikalelectronics.ru,
        andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lukas@wunner.de,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    76c057c8 Merge branch 'parisc-5.11-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13728c5f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f75d66d6d359ef2f
dashboard link: https://syzkaller.appspot.com/bug?extid=51bed6fc20ecc6362058
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com

Internal error: synchronous external abort: 97140050 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 21580 Comm: syz-executor.0 Not tainted 5.11.0-rc5-syzkaller-00040-g76c057c84d28 #0
Hardware name: linux,dummy-virt (DT)
pstate: 80400089 (Nzcv daIf +PAN -UAO -TCO BTYPE=--)
pc : __raw_writeb arch/arm64/include/asm/io.h:27 [inline]
pc : _outb include/asm-generic/io.h:501 [inline]
pc : logic_outb+0x40/0xb0 lib/logic_pio.c:299
lr : io_serial_out+0x2c/0x40 drivers/tty/serial/8250/8250_port.c:453
sp : ffff80001767bbd0
x29: ffff80001767bbd0 x28: f1ff000004267000 
x27: ffff800014281000 x26: 0000000000000001 
x25: ffff8000142832a0 x24: ffff800014281000 
x23: ffff800014281000 x22: 0000000000000fff 
x21: 0000000000000001 x20: 0000000000000002 
x19: fffffbfffe800001 x18: 00000000fffffffb 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000020 x14: ffffffffffffffff 
x13: 0000000000000000 x12: ffff80001767bd9f 
x11: 0000000000000000 x10: 7f7f7f7f7f7f7f7f 
x9 : fefefefefeff3252 x8 : ffff80001767b924 
x7 : 0000000000000003 x6 : 0000000000000001 
x5 : f1ff000005d7c4e0 x4 : 0000000000000000 
x3 : ffff800013c02808 x2 : 0000000000000000 
x1 : fffffbfffe800000 x0 : 0000000000ffbffe 
Call trace:
 _outb include/asm-generic/io.h:501 [inline]
 logic_outb+0x40/0xb0 lib/logic_pio.c:299
 io_serial_out+0x2c/0x40 drivers/tty/serial/8250/8250_port.c:453
 serial_out drivers/tty/serial/8250/8250.h:118 [inline]
 serial8250_set_THRI drivers/tty/serial/8250/8250.h:138 [inline]
 __start_tx drivers/tty/serial/8250/8250_port.c:1566 [inline]
 serial8250_start_tx+0x98/0x1c4 drivers/tty/serial/8250/8250_port.c:1666
 __uart_start.isra.0+0x3c/0x4c drivers/tty/serial/serial_core.c:127
 uart_start+0x70/0x110 drivers/tty/serial/serial_core.c:137
 uart_flush_chars+0x14/0x20 drivers/tty/serial/serial_core.c:573
 __receive_buf drivers/tty/n_tty.c:1651 [inline]
 n_tty_receive_buf_common+0x2a0/0xb30 drivers/tty/n_tty.c:1744
 n_tty_receive_buf+0x18/0x2c drivers/tty/n_tty.c:1773
 tiocsti drivers/tty/tty_io.c:2203 [inline]
 tty_ioctl+0x5b8/0xe5c drivers/tty/tty_io.c:2577
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:739
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
 do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
 el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
Code: d2bfd001 f2df7fe1 f2ffffe1 8b010273 (39000274) 
---[ end trace 00ba385f910422db ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
