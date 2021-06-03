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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306FC47082
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF88461246
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 06:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCGpH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Jun 2021 02:45:07 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:45841 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCGpH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Jun 2021 02:45:07 -0400
Received: by mail-pg1-f169.google.com with SMTP id q15so4357047pgg.12;
        Wed, 02 Jun 2021 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c2rilUK8tmRGpu8KOGzVrGpxkQd4MROcVu5LTI+Vh/U=;
        b=Oheh5kkZ5mPz4OvNPgqLXhSwNtbpiOZxE+qj4DAluUr6VQGk9rooyLVQq2IdTWTp/M
         hYL374HbpvnqAZ2g3DpUvEPNXg7YMJmpDv63l+vyHc6WyRsluTyYF4Tu5736tIa+3VW8
         ud+fm4HLX1QhmoDTa8P5C7YYdvqauxCsYkvf7jdJ//QmocfqF3nNZNC4oZB/Fvo2HpbB
         c3eXf9tw/vNMbiojkPfDqfMhKGv+faTMtHi0JpCwPAM4hGuwxMkp3qLbLGZNKyeWeBxy
         /bJZiQLHRMEvQA4wndv2pWKZZatyCVCMRttnQ+jVAOED+Gz3ZTw60xYFZCykO68Lk5Ol
         ydPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c2rilUK8tmRGpu8KOGzVrGpxkQd4MROcVu5LTI+Vh/U=;
        b=YXz0EIgJNqQezp+6KtwdfVImozWLn2xs6ZMWI4WT7wjIicwvP5Pe6bF8j2R1ICmKo1
         xeqGABqM2zVI4aj8auHg27qkOe0tPspMK7tKpq3kXK393GjGcFKHG5m1QQjPlYMYhRq+
         rb84cj6VlX/ic5QAuhNttYHoyqKKbZKxBjhh0oeKt6RVhEMWOnudjzSKdheuSBGUM8gr
         o1H6eiMPjh4kK36JnmWf/MXv+WnDI1TzHbYOrZHcLVK8Py9mAy8cAlqZnQRd8yXytc42
         rm+6qjRB+o6WgUwLO9yiQLN6Qny/iccM/l1Z4UhEUq8OCZogHEVaIHh4VOVb5kPNVXkZ
         KKYg==
X-Gm-Message-State: AOAM531TkmkMoc8Wn8Sp65cYnRPUUlpgsmn6ZDAhrP0VAuyh/TMvTli2
        hYYnHw+Ldx7hdYu3LHF6VI7A7/z+gsKR
X-Google-Smtp-Source: ABdhPJzBk6y0EyNBBqBLoGVD1S3gYdmnA5BMshklLixlGcX1pp9FUGnu45Xlfm5EC0YI+07AcIGrsA==
X-Received: by 2002:a05:6a00:158d:b029:2e0:6ae2:17b1 with SMTP id u13-20020a056a00158db02902e06ae217b1mr29833117pfk.76.1622702542787;
        Wed, 02 Jun 2021 23:42:22 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id n72sm1412458pfd.8.2021.06.02.23.42.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jun 2021 23:42:22 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     zheyuma97@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: jsm: add checks against NULL pointer dereference
Date:   Thu,  3 Jun 2021 06:41:20 +0000
Message-Id: <1622702480-32140-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In function 'neo_intr', the driver uses 'ch->ch_equeue' and
'ch->ch_reuque'. These two pointers are initialized in 'jsm_tty_open',
but the interrupt handler 'neo_intr' has been registered in the probe
progress. If 'jsm_tty_open' has not been called at this time, it will
cause null pointer dereference.

Once the driver registers the interrupt handler, the driver should be
ready to handle it.

Fix this by checking whether it is a null pointer.

This log reveals it:

[   50.934983] BUG: kernel NULL pointer dereference, address:
0000000000000000
[   50.938297] #PF: supervisor write access in kernel mode
[   50.940075] #PF: error_code(0x0002) - not-present page
[   50.940460] PGD 0 P4D 0
[   50.940654] Oops: 0002 [#1] PREEMPT SMP PTI
[   50.940967] CPU: 2 PID: 0 Comm: swapper/2 Not tainted
5.12.4-g70e7f0549188-dirty #97
[   50.941554] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   50.942419] RIP: 0010:memcpy_fromio+0x75/0xa0
[   50.942759] Code: e9 02 f3 a5 41 f6 c5 02 74 02 66 a5 41 f6 c5 01 74
01 a4 e8 5d 93 6b ff 5b 41 5c 41 5d 5d c3 e8 51 93 6b ff 4c 89 e7 48 89
de <a4> 49 89 fc 48 89 f3 49 83 ed 01 eb a4 e8 39 93 6b ff 4c 89 e7 48
[   50.944158] RSP: 0018:ffffc90000118df8 EFLAGS: 00010046
[   50.944559] RAX: ffff888100258000 RBX: ffffc90007f0030f
RCX: 0000000000000000
[   50.945114] RDX: 0000000000000000 RSI: ffffc90007f0030f
RDI: 0000000000000000
[   50.945652] RBP: ffffc90000118e10 R08: 0000000000000000
R09: 0000000000000000
[   50.946192] R10: 0000000000000000 R11: 0000000000000001
R12: 0000000000000000
[   50.946729] R13: 0000000000000001 R14: 0000000007f0021e
R15: 0000000000000000
[   50.947279] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000)
knlGS:0000000000000000
[   50.947912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.948346] CR2: 0000000000000000 CR3: 0000000107950000
CR4: 00000000000006e0
[   50.948892] DR0: 0000000000000000 DR1: 0000000000000000
DR2: 0000000000000000
[   50.949429] DR3: 0000000000000000 DR6: 00000000fffe0ff0
DR7: 0000000000000400
[   50.949950] Call Trace:
[   50.950138]  <IRQ>
[   50.950292]  neo_copy_data_from_uart_to_queue+0x2f7/0x4e0
[   50.950694]  neo_intr+0x253/0x7a0
[   50.950975]  __handle_irq_event_percpu+0x53/0x3e0
[   50.951352]  handle_irq_event_percpu+0x35/0x90
[   50.951706]  handle_irq_event+0x39/0x60
[   50.951999]  handle_fasteoi_irq+0xc2/0x1d0
[   50.952319]  __common_interrupt+0x7f/0x150
[   50.952638]  common_interrupt+0xb4/0xd0
[   50.952954]  </IRQ>
[   50.953136]  asm_common_interrupt+0x1e/0x40
[   50.969513] Kernel panic - not syncing: Fatal exception in interrupt
[   50.970151] Dumping ftrace buffer:
[   50.970420]    (ftrace buffer empty)
[   50.970693] Kernel Offset: disabled
[   50.970968] Rebooting in 1 seconds..

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index bf0e2a4cb0ce..46be0b53ab42 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -716,7 +716,7 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 		return;
 
 	ch = brd->channels[port];
-	if (!ch)
+	if (!ch || !ch->ch_equeue || !ch->ch_rqueue)
 		return;
 
 	/* Here we try to figure out what caused the interrupt to happen */
@@ -832,7 +832,7 @@ static inline void neo_parse_lsr(struct jsm_board *brd, u32 port)
 		return;
 
 	ch = brd->channels[port];
-	if (!ch)
+	if (!ch || !ch->ch_equeue || !ch->ch_rqueue)
 		return;
 
 	linestatus = readb(&ch->ch_neo_uart->lsr);
@@ -1172,7 +1172,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
 				continue;
 
 			ch = brd->channels[port];
-			if (!ch)
+			if (!ch || !ch->ch_equeue || !ch->ch_rqueue)
 				continue;
 
 			neo_copy_data_from_uart_to_queue(ch);
-- 
2.17.6

