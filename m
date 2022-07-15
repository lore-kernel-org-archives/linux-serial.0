Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8970DCCA47C
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jul 2022 06:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiGOGX2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiGOGX1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jul 2022 02:23:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093FA753A2
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 23:23:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u18-20020a5ec012000000b0067bd7f5e02aso1504216iol.21
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 23:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ECHvv+m4NKRuX14ubQJPUDLv1bbnfJjE0NSa75hnsh8=;
        b=LYewLxSnsti5ogVZvGe5++PoJmTAC3jYsWL29bQixEbDmc/D65UNWDI/6s5iFT/xv2
         hhuxwLwiAw5sFOR8FeLYmAq+pCJ0FxpmCoKfPr1+cARB5NpxP/LaLYzNOmVqdMKHKq50
         a98YARqIHCKjsdFrEAP/iKubYnECI3JVfqYrDgESti8sBkCryHBqPfE0YM4kN0WHW697
         LsgwVb7P2omPh5M/0vAO3Hs6kUYk6tyBgBeApT3JSGolNOg0nZqr2LzMH9qQ8eOp1cFb
         Xx3EqGI8CeIpgcvH7HBkoH97ybL3+z4Kt6BTx192DxR5SsM7dBtxe8d6oRhz97lwC+5x
         0qvA==
X-Gm-Message-State: AJIora8kG9k5EExMkvz0uhWXfFs8MLpYtCBX3iQAYvNEOQcqSGa9icOW
        9o8EXNVjB3cXDEnKPRXuNnyc+FJ4c3peaOsdBMT/IY2AJRQW
X-Google-Smtp-Source: AGRyM1vrMr+R9Bj3ssAKdUq2JrpTgJTGb1q3MgxULXiwN02ckj3l0hMSZ0Yh7sMGTSiSL2DFBNaAUvzjUMzQ1wxrTaibUZ5DqDzo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1448:b0:33f:7a74:5f2c with SMTP id
 l8-20020a056638144800b0033f7a745f2cmr6830715jad.179.1657866205379; Thu, 14
 Jul 2022 23:23:25 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:23:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041c2d305e3d20e6d@google.com>
Subject: [syzbot] Internal error in io_serial_out (2)
From:   syzbot <syzbot+26e067dfa81f748d3210@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, etremblay@distech-controls.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, u.kleine-koenig@pengutronix.de,
        wander@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4a57a8400075 vf/remap: return the amount of bytes actually..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1168fa9a080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7d589e916fa3bbe
dashboard link: https://syzkaller.appspot.com/bug?extid=26e067dfa81f748d3210
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26e067dfa81f748d3210@syzkaller.appspotmail.com

Internal error: synchronous external abort: 97140050 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 29340 Comm: syz-executor.1 Not tainted 5.19.0-rc6-syzkaller-00115-g4a57a8400075 #0
Hardware name: linux,dummy-virt (DT)
pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __raw_writeb arch/arm64/include/asm/io.h:27 [inline]
pc : _outb include/asm-generic/io.h:501 [inline]
pc : logic_outb+0x3c/0xa4 lib/logic_pio.c:302
lr : io_serial_out+0x2c/0x3c drivers/tty/serial/8250/8250_port.c:466
sp : ffff80000c263b40
x29: ffff80000c263b40 x28: f3ff0000265dd000 x27: 0000000000000000
x26: fbff000003d00528 x25: fdff000005bd3000 x24: f8ff000028c17000
x23: fbff000003d00528 x22: 0000000000000000 x21: ffff80000a6380e0
x20: 0000000000000008 x19: fffffbfffe800001 x18: 00000000fffffffb
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000020
x14: 0000000000000000 x13: ffff80000c263d78 x12: ffff80000c263d3a
x11: 0000000000000000 x10: 0000000000000066 x9 : 000000000000005c
x8 : 0000000000000000 x7 : 0000000000000001 x6 : ffff80000a2e0000
x5 : 0000000000005452 x4 : 0000000000000000 x3 : ffff80000a6380e0
x2 : 0000000000000000 x1 : fffffbfffe800000 x0 : 0000000000ffbffe
Call trace:
 _outb include/asm-generic/io.h:501 [inline]
 logic_outb+0x3c/0xa4 lib/logic_pio.c:302
 io_serial_out+0x2c/0x3c drivers/tty/serial/8250/8250_port.c:466
 serial_port_out include/linux/serial_core.h:270 [inline]
 serial8250_enable_ms drivers/tty/serial/8250/8250_port.c:1728 [inline]
 serial8250_enable_ms+0x68/0xa0 drivers/tty/serial/8250/8250_port.c:1715
 uart_enable_ms drivers/tty/serial/serial_core.c:1179 [inline]
 uart_wait_modem_status+0xcc/0x2a0 drivers/tty/serial/serial_core.c:1207
 uart_ioctl+0x1ec/0x894 drivers/tty/serial/serial_core.c:1437
 tty_ioctl+0x1f4/0xd44 drivers/tty/tty_io.c:2778
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xa8/0xf0 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0xa0/0xc0 arch/arm64/kernel/syscall.c:206
 el0_svc+0x44/0xb0 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x1ac/0x1b0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
Code: d2bfd001 f2df7fe1 f2ffffe1 8b010273 (39000274) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d2bfd001 	mov	x1, #0xfe800000            	// #4269801472
   4:	f2df7fe1 	movk	x1, #0xfbff, lsl #32
   8:	f2ffffe1 	movk	x1, #0xffff, lsl #48
   c:	8b010273 	add	x19, x19, x1
* 10:	39000274 	strb	w20, [x19] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
