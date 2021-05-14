Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF22BC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A10613BC
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 11:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhENLS7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 May 2021 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhENLS6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 May 2021 07:18:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEBCC061574;
        Fri, 14 May 2021 04:17:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so191866plr.11;
        Fri, 14 May 2021 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XKcCS4s5C12mzZ7iKmgwJ8qzqkKrmAHk/I8vMw9Oki8=;
        b=k3T/8EFst3K4z5Zh/46JoQICHEZhYiu0pWLAACYbwF9AKbuToN0Dn/UasUHNCBWD60
         lQy6DI+X7jdpwUkskpbqe0asWiCFAg9ASo5JMGmbbbJkmGs8j2HezkHsBiBhKYQqcgLu
         lDLeBX/Lx3f+5IN9vP2N4ovaHw88d0pOLJ6Ct0qxHsWwfD89Z00VH4Y0jJprDeANK8CR
         sLI7zhdX9XHhSWiXEYhNapt0UqWWViw8HWPk0K8LRA0qJGMkKOo76wV798S7lCiWd1sx
         xd16EJLwmGPaMdvI9WqTdSFGZMx/HSRrUZpSDRX2H37r/OSNDCU5OoTUocN4Cs7JJL54
         fLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XKcCS4s5C12mzZ7iKmgwJ8qzqkKrmAHk/I8vMw9Oki8=;
        b=PPg7L7ZNEJTsuiDuY6oBslu+Lp1W9qKPvKDTFiQAwBgZB+GTo7sD8PkgMxJfQbcgcz
         E8+KPLGx7NVade/OaZNZ/i3nNoxrjGuwXBgc+QWSWgjyliB7CxccmCrO0YmL4bQ7KH2b
         crFkQ/zVtVUUaj0LwzcErRHrImJ0tRXGhu7WGegyWDnMOzf5ZObLZMFSgnbqDUIjYCNu
         OQ3EWGWJeFdlw7QykrJCxq5rdkkPZlJTJQM6jKgTpc3dhgb43dWHvzUgpKgv1EQVr82h
         qqtYHc1ZlU4pWjBRnGAW+M5Dryn2M48caT1gedi53bKKCxrNmCV9RgzNP1hSFAv9QT34
         rhGg==
X-Gm-Message-State: AOAM530Wi7T0bApAyFEktNLEmCoq4onP8XWZrc00ADdywarZ6FVimeAo
        6FmZGy/dbDWICUQKXXtZNA==
X-Google-Smtp-Source: ABdhPJyfNa7UIpTwCsxVuNUu6EZ52+eoWD0szowLt63C27eX4DFdqXsngFEhw1ivjIMLMeXkhNxmQQ==
X-Received: by 2002:a17:90b:1c10:: with SMTP id oc16mr18631648pjb.86.1620991067303;
        Fri, 14 May 2021 04:17:47 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id c6sm8973194pjs.11.2021.05.14.04.17.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 04:17:46 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     cernekee@gmail.com, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        zheyuma97@gmail.com
Subject: [PATCH] serial: rp2: disable interrupt in rp2_probe():
Date:   Fri, 14 May 2021 11:17:07 +0000
Message-Id: <1620991027-25856-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In 'rp2_probe', the driver registers 'rp2_uart_interrupt' then calls
'rp2_fw_cb' through 'request_firmware_nowait'. In 'rp2_fw_cb', if the
firmware don't exists, function just return without initializing ports
of 'rp2_card'. But now the interrupt handler function has been registered,
and when an interrupt comes('rp2' may shares an interrupt line with other
devices), 'rp2_uart_interrupt' may access those ports then causing NULL
pointer dereference or other bugs.

Fix this by disabling interrupt after registering 'rp2_uart_interrupt',
and enable it in 'rp2_uart_startup'.

The KASAN's report reveals it:

NFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.177-gdba4159c14ef-dirty #45
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-
gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xec/0x156 lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:727 [inline]
 register_lock_class+0x14e5/0x1ba0 kernel/locking/lockdep.c:753
 __lock_acquire+0x187/0x3750 kernel/locking/lockdep.c:3303
 lock_acquire+0x124/0x340 kernel/locking/lockdep.c:3907
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x32/0x50 kernel/locking/spinlock.c:144
 spin_lock include/linux/spinlock.h:329 [inline]
 rp2_ch_interrupt drivers/tty/serial/rp2.c:466 [inline]
 rp2_asic_interrupt.isra.9+0x15d/0x990 drivers/tty/serial/rp2.c:493
 rp2_uart_interrupt+0x49/0xe0 drivers/tty/serial/rp2.c:504
 __handle_irq_event_percpu+0xfb/0x770 kernel/irq/handle.c:149
 handle_irq_event_percpu+0x79/0x150 kernel/irq/handle.c:189
 handle_irq_event+0xac/0x140 kernel/irq/handle.c:206
 handle_fasteoi_irq+0x232/0x5c0 kernel/irq/chip.c:725
 generic_handle_irq_desc include/linux/irqdesc.h:155 [inline]
 handle_irq+0x230/0x3a0 arch/x86/kernel/irq_64.c:87
 do_IRQ+0xa7/0x1e0 arch/x86/kernel/irq.c:247
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:670
 </IRQ>
RIP: 0010:native_safe_halt+0x28/0x30 arch/x86/include/asm/irqflags.h:61
Code: 00 00 55 be 04 00 00 00 48 c7 c7 00 c2 2f 8c 48 89 e5 e8 fb 31 e7 f8
8b 05 75 af 8d 03 85 c0 7e 07 0f 00 2d 8a 61 65 00 fb f4 <5d> c3 90 90 90
90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41
RSP: 0018:ffff88806b71fcc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
RAX: 0000000000000000 RBX: ffffffff8bde7e48 RCX: ffffffff88a21285
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff8c2fc200
RBP: ffff88806b71fcc8 R08: fffffbfff185f840 R09: fffffbfff185f840
R10: 0000000000000001 R11: fffffbfff185f840 R12: 0000000000000002
R13: ffffffff8bea18a0 R14: 0000000000000000 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
 default_idle+0x6f/0x360 arch/x86/kernel/process.c:557
 arch_cpu_idle+0xf/0x20 arch/x86/kernel/process.c:548
 default_idle_call+0x3b/0x60 kernel/sched/idle.c:93
 cpuidle_idle_call kernel/sched/idle.c:153 [inline]
 do_idle+0x2ab/0x3c0 kernel/sched/idle.c:263
 cpu_startup_entry+0xcb/0xe0 kernel/sched/idle.c:369
 start_secondary+0x3b8/0x4e0 arch/x86/kernel/smpboot.c:271
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
PGD 8000000056d27067 P4D 8000000056d27067 PUD 56d28067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.177-gdba4159c14ef-dirty #45
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-
gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:rp2_ch_interrupt drivers/tty/serial/rp2.c:472 [inline]
RIP: 0010:rp2_asic_interrupt.isra.9+0x181/0x990 drivers/tty/serial/rp2.c:
493
Code: df e8 43 5d c2 05 48 8d 83 e8 01 00 00 48 89 85 60 ff ff ff 48 c1 e8
03 42 80 3c 30 00 0f 85 aa 07 00 00 48 8b 83 e8 01 00 00 <8b> 40 10 89 c1
89 85 68 ff ff ff 48 8b 83 e8 01 00 00 89 48 10 83
RSP: 0018:ffff88806c287cd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88806ade6820 RCX: ffffffff814300b1
RDX: 1ffff1100d5bcd06 RSI: 0000000000000004 RDI: ffff88806ade6820
RBP: ffff88806c287db8 R08: ffffed100d5bcd05 R09: ffffed100d5bcd05
R10: 0000000000000001 R11: ffffed100d5bcd04 R12: ffffc90001e00000
R13: ffff888069654e10 R14: dffffc0000000000 R15: ffff888069654df0
FS:  0000000000000000(0000) GS:ffff88806c280000(0000) knlGS:
0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000006892c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rp2_uart_interrupt+0x49/0xe0 drivers/tty/serial/rp2.c:504
 __handle_irq_event_percpu+0xfb/0x770 kernel/irq/handle.c:149
 handle_irq_event_percpu+0x79/0x150 kernel/irq/handle.c:189
 handle_irq_event+0xac/0x140 kernel/irq/handle.c:206
 handle_fasteoi_irq+0x232/0x5c0 kernel/irq/chip.c:725
 generic_handle_irq_desc include/linux/irqdesc.h:155 [inline]
 handle_irq+0x230/0x3a0 arch/x86/kernel/irq_64.c:87
 do_IRQ+0xa7/0x1e0 arch/x86/kernel/irq.c:247
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:670
 </IRQ>
RIP: 0010:native_safe_halt+0x28/0x30 arch/x86/include/asm/irqflags.h:61
Code: 00 00 55 be 04 00 00 00 48 c7 c7 00 c2 2f 8c 48 89 e5 e8 fb 31 e7
f8 8b 05 75 af 8d 03 85 c0 7e 07 0f 00 2d 8a 61 65 00 fb f4 <5d> c3 90
90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41
RSP: 0018:ffff88806b71fcc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
RAX: 0000000000000000 RBX: ffffffff8bde7e48 RCX: ffffffff88a21285
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff8c2fc200
RBP: ffff88806b71fcc8 R08: fffffbfff185f840 R09: fffffbfff185f840
R10: 0000000000000001 R11: fffffbfff185f840 R12: 0000000000000002
R13: ffffffff8bea18a0 R14: 0000000000000000 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
 default_idle+0x6f/0x360 arch/x86/kernel/process.c:557
 arch_cpu_idle+0xf/0x20 arch/x86/kernel/process.c:548
 default_idle_call+0x3b/0x60 kernel/sched/idle.c:93
 cpuidle_idle_call kernel/sched/idle.c:153 [inline]
 do_idle+0x2ab/0x3c0 kernel/sched/idle.c:263
 cpu_startup_entry+0xcb/0xe0 kernel/sched/idle.c:369
 start_secondary+0x3b8/0x4e0 arch/x86/kernel/smpboot.c:271
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000010
---[ end trace 11804dbb55cb1a64 ]---
RIP: 0010:readl arch/x86/include/asm/io.h:59 [inline]
RIP: 0010:rp2_ch_interrupt drivers/tty/serial/rp2.c:472 [inline]
RIP: 0010:rp2_asic_interrupt.isra.9+0x181/0x990 drivers/tty/serial/rp2.c:
493
Code: df e8 43 5d c2 05 48 8d 83 e8 01 00 00 48 89 85 60 ff ff ff 48 c1
e8 03 42 80 3c 30 00 0f 85 aa 07 00 00 48 8b 83 e8 01 00 00 <8b> 40 10 89
c1 89 85 68 ff ff ff 48 8b 83 e8 01 00 00 89 48 10 83
RSP: 0018:ffff88806c287cd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff88806ade6820 RCX: ffffffff814300b1
RDX: 1ffff1100d5bcd06 RSI: 0000000000000004 RDI: ffff88806ade6820
RBP: ffff88806c287db8 R08: ffffed100d5bcd05 R09: ffffed100d5bcd05
R10: 0000000000000001 R11: ffffed100d5bcd04 R12: ffffc90001e00000
R13: ffff888069654e10 R14: dffffc0000000000 R15: ffff888069654df0
FS:  0000000000000000(0000) GS:ffff88806c280000(0000) knlGS:
0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000006892c000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/tty/serial/rp2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index d60abffab70e..88b95d19266a 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -526,6 +526,7 @@ static int rp2_uart_startup(struct uart_port *port)
 		RP2_TXRX_CTL_RX_TRIG_1);
 	rp2_rmw(up, RP2_CHAN_STAT, 0, 0);
 	rp2_mask_ch_irq(up, up->idx, 1);
+	enable_irq(port->irq);
 
 	return 0;
 }
@@ -782,6 +783,7 @@ static int rp2_probe(struct pci_dev *pdev,
 			      IRQF_SHARED, DRV_NAME, card);
 	if (rc)
 		return rc;
+	disable_irq(pdev->irq);
 
 	/*
 	 * Only catastrophic errors (e.g. ENOMEM) are reported here.
-- 
2.17.1

