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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B5C07E99
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2367E613F7
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 12:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhGEM4Q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGEM4Q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jul 2021 08:56:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB5C061574;
        Mon,  5 Jul 2021 05:53:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s18so3123128pgg.8;
        Mon, 05 Jul 2021 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YvloyU3dqwOUs5y7A1Fzgw1XqwjguqvjnyoAp8xlINA=;
        b=d4nDtfOqVJ9Jib2TBxpZkALCXojmUSv9vmzfJcWTPlYIQLpk0SGpFTd6JMuJNA1zpQ
         vsDzZORTk6moJSXyWsaU8NtIoW3tceCh6xpFHowjDoDNmZ2CSjMNoETCJjqJ6ZGssmfS
         V74pLUGJZZxTJYViyTL8YpzzEiF40lB2+fUqLcc1hlAKF1lgfolbYWXRDhf14qxr70Ml
         xP+iOn4+DZPg4pS163JAJ9e3RG2pEUjJdmn6K2WN7orrKACjTOjVWwRuq5lxYMb8kW4G
         ULgQY3v0cxiHrPZdWDAmxNMON/5jfH6YISeKLTwEnnmvJL3drC1zDPFwzQuDPHTNNg+W
         J2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YvloyU3dqwOUs5y7A1Fzgw1XqwjguqvjnyoAp8xlINA=;
        b=Lmb6MDgWVxVPlnLbrXBZi0bolNF0elhS2HNfWSCgdIco6PzIfZFEa3SYXtq1PaBSmp
         2RNtMqMWkeWMSseg/+AvInn54PMEmcTZVjZB53KwMYMr6FcZbBFN5saXu4MbEB1QPa1M
         gb0m9QyuuLbWL+1hMQMQVhJ54ZT9jkvFW9clzdTgULO9NJIhOMlnemsj0bOkO52EWmaJ
         HMZ6cEhee03GSUFOWn3EReaaP5X4qthnCGjW4ejOvvr0qOhncKr8TkVpUVm5O8flB+KO
         eW/OVwyPXqAKs4kotoIcih75uek1nIUZKS8dVYiriXnGvaP+dTV0n9lCSpzHLmn4ozpB
         +i7g==
X-Gm-Message-State: AOAM533DWTGWv8va2DrO8qMzaNJ0SnPMXyIyAtpG0wS4VUAMbHqmt5Q8
        Du+gW9VDq95amr9VMto7zw==
X-Google-Smtp-Source: ABdhPJyYO/JtcweQYIJQn37jszP+hOMUb8/LEmxuGGtKQ1J4NbWG4zhj2bvUrKjCB7OiMytI22wqpQ==
X-Received: by 2002:a62:3244:0:b029:308:22b0:52ff with SMTP id y65-20020a6232440000b029030822b052ffmr14792836pfy.68.1625489619461;
        Mon, 05 Jul 2021 05:53:39 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id w15sm21133430pjg.32.2021.07.05.05.53.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 05:53:38 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     zheyuma97@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] tty: serial: jsm: allocate queue buffer at probe time
Date:   Mon,  5 Jul 2021 12:53:08 +0000
Message-Id: <1625489588-26079-1-git-send-email-zheyuma97@gmail.com>
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

Fix this by allocating the memory at probe time and not at open time.

This log reveals it:

[   12.771912] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   12.774932] #PF: supervisor write access in kernel mode
[   12.775314] #PF: error_code(0x0002) - not-present page
[   12.775689] PGD 0 P4D 0
[   12.775881] Oops: 0002 [#1] PREEMPT SMP PTI
[   12.776212] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.12.4-g70e7f0549188-dirty #106
[   12.776803] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   12.777627] RIP: 0010:memcpy_fromio+0x75/0xa0
[   12.777983] Code: e9 02 f3 a5 41 f6 c5 02 74 02 66 a5 41 f6 c5 01 74 01 a4 e8 5d 4e 6b ff 5b 41 5c 41 5d 5d c3 e8 51 4e 6b ff 4c 89 e7 48 89 de <a4> 49 89 fc 48 89 f3 49 83 ed 01 eb a4 e8 39 4e 6b ff 4c 89 e7 48
[   12.779377] RSP: 0018:ffffc90000118db0 EFLAGS: 00010046
[   12.779771] RAX: ffff888100258000 RBX: ffffc90007d0010f RCX: 0000000000000000
[   12.780298] RDX: 0000000000000000 RSI: ffffc90007d0010f RDI: 0000000000000000
[   12.780820] RBP: ffffc90000118dc8 R08: 0000000000000000 R09: 0000000000000000
[   12.781359] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[   12.781928] R13: 0000000000000001 R14: 0000000007d0009e R15: 0000000000000000
[   12.782453] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000) knlGS:0000000000000000
[   12.783067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.783499] CR2: 0000000000000000 CR3: 0000000005e2e000 CR4: 00000000000006e0
[   12.784051] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   12.784579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   12.785105] Call Trace:
[   12.785295]  <IRQ>
[   12.785457]  neo_copy_data_from_uart_to_queue+0x2f7/0x4e0
[   12.785871]  neo_parse_isr.part.4+0x175/0x4d0
[   12.786217]  neo_intr+0x188/0x7a0
[   12.786478]  __handle_irq_event_percpu+0x53/0x3e0
[   12.786831]  handle_irq_event_percpu+0x35/0x90
[   12.787157]  handle_irq_event+0x39/0x60
[   12.787458]  handle_fasteoi_irq+0xc2/0x1d0
[   12.787763]  __common_interrupt+0x7f/0x150
[   12.788071]  common_interrupt+0xb4/0xd0
[   12.788358]  </IRQ>
[   12.788532]  asm_common_interrupt+0x1e/0x40
[   12.788853] RIP: 0010:native_safe_halt+0x17/0x20
[   12.789199] Code: 07 0f 00 2d 0b ab 50 00 f4 5d c3 0f 1f 84 00 00 00 00 00 8b 05 f2 11 f7 01 55 48 89 e5 85 c0 7e 07 0f 00 2d eb aa 50 00 fb f4 <5d> c3 cc cc cc cc cc cc cc 55 48 89 e5 e8 67 53 ff ff 8b 0d e9 dc
[   12.790581] RSP: 0018:ffffc9000008fe90 EFLAGS: 00000246
[   12.790975] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
[   12.791502] RDX: 0000000000000000 RSI: ffffffff859d2c94 RDI: ffffffff8589953e
[   12.792031] RBP: ffffc9000008fe90 R08: 0000000000000001 R09: 0000000000000001
[   12.792573] R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff86434488
[   12.793095] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888100258000
[   12.793625]  default_idle+0x9/0x10
[   12.793898]  arch_cpu_idle+0xa/0x10
[   12.794159]  default_idle_call+0x6e/0x250
[   12.794462]  do_idle+0x1f0/0x2d0
[   12.794708]  cpu_startup_entry+0x18/0x20
[   12.795008]  start_secondary+0x11f/0x160
[   12.795314]  secondary_startup_64_no_verify+0xb0/0xbb
[   12.795701] Modules linked in:
[   12.795931] Dumping ftrace buffer:
[   12.796206]    (ftrace buffer empty)
[   12.796481] CR2: 0000000000000000
[   12.796741] ---[ end trace 5535b8755359e59f ]---
[   12.797089] RIP: 0010:memcpy_fromio+0x75/0xa0
[   12.797417] Code: e9 02 f3 a5 41 f6 c5 02 74 02 66 a5 41 f6 c5 01 74 01 a4 e8 5d 4e 6b ff 5b 41 5c 41 5d 5d c3 e8 51 4e 6b ff 4c 89 e7 48 89 de <a4> 49 89 fc 48 89 f3 49 83 ed 01 eb a4 e8 39 4e 6b ff 4c 89 e7 48
[   12.798787] RSP: 0018:ffffc90000118db0 EFLAGS: 00010046
[   12.799175] RAX: ffff888100258000 RBX: ffffc90007d0010f RCX: 0000000000000000
[   12.799702] RDX: 0000000000000000 RSI: ffffc90007d0010f RDI: 0000000000000000
[   12.800226] RBP: ffffc90000118dc8 R08: 0000000000000000 R09: 0000000000000000
[   12.800753] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[   12.801287] R13: 0000000000000001 R14: 0000000007d0009e R15: 0000000000000000
[   12.801809] FS:  0000000000000000(0000) GS:ffff88817bc80000(0000) knlGS:0000000000000000
[   12.802431] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.802862] CR2: 0000000000000000 CR3: 0000000005e2e000 CR4: 00000000000006e0
[   12.803412] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   12.803932] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   12.804447] Kernel panic - not syncing: Fatal exception in interrupt
[   12.805067] Dumping ftrace buffer:
[   12.805315]    (ftrace buffer empty)
[   12.805584] Kernel Offset: disabled
[   12.805850] Rebooting in 1 seconds..

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v4:
    - Add error handling when allocating memory fails

Changes in v3:
    - Remove useless comments
    - Remove uncessary flag changes
    - Keep flushing input quques in the open function

Changes in v2:
    - Allocate the memory at probe time, instead of simply checking
    whether it is a null pointer.
---
 drivers/tty/serial/jsm/jsm_tty.c | 59 ++++++++++++--------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 8e42a7682c63..4f17ad3ae0b0 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -195,38 +195,6 @@ static int jsm_tty_open(struct uart_port *port)
 	/* Get board pointer from our array of majors we have allocated */
 	brd = channel->ch_bd;
 
-	/*
-	 * Allocate channel buffers for read/write/error.
-	 * Set flag, so we don't get trounced on.
-	 */
-	channel->ch_flags |= (CH_OPENING);
-
-	/* Drop locks, as malloc with GFP_KERNEL can sleep */
-
-	if (!channel->ch_rqueue) {
-		channel->ch_rqueue = kzalloc(RQUEUESIZE, GFP_KERNEL);
-		if (!channel->ch_rqueue) {
-			jsm_dbg(INIT, &channel->ch_bd->pci_dev,
-				"unable to allocate read queue buf\n");
-			return -ENOMEM;
-		}
-	}
-	if (!channel->ch_equeue) {
-		channel->ch_equeue = kzalloc(EQUEUESIZE, GFP_KERNEL);
-		if (!channel->ch_equeue) {
-			jsm_dbg(INIT, &channel->ch_bd->pci_dev,
-				"unable to allocate error queue buf\n");
-			return -ENOMEM;
-		}
-	}
-
-	channel->ch_flags &= ~(CH_OPENING);
-	/*
-	 * Initialize if neither terminal is open.
-	 */
-	jsm_dbg(OPEN, &channel->ch_bd->pci_dev,
-		"jsm_open: initializing channel in open...\n");
-
 	/*
 	 * Flush input queues.
 	 */
@@ -389,11 +357,8 @@ int jsm_tty_init(struct jsm_board *brd)
 			 * interrupt context, and there are no locks held.
 			 */
 			brd->channels[i] = kzalloc(sizeof(struct jsm_channel), GFP_KERNEL);
-			if (!brd->channels[i]) {
-				jsm_dbg(CORE, &brd->pci_dev,
-					"%s:%d Unable to allocate memory for channel struct\n",
-					__FILE__, __LINE__);
-			}
+			if (!brd->channels[i])
+				goto err;
 		}
 	}
 
@@ -420,10 +385,30 @@ int jsm_tty_init(struct jsm_board *brd)
 		ch->ch_close_delay = 250;
 
 		init_waitqueue_head(&ch->ch_flags_wait);
+
+		if (!ch->ch_rqueue) {
+			ch->ch_rqueue = kzalloc(RQUEUESIZE, GFP_KERNEL);
+			if (!ch->ch_rqueue)
+				goto err;
+		}
+		if (!ch->ch_equeue) {
+			ch->ch_equeue = kzalloc(EQUEUESIZE, GFP_KERNEL);
+			if (!ch->ch_equeue)
+				goto err;
+		}
 	}
 
 	jsm_dbg(INIT, &brd->pci_dev, "finish\n");
 	return 0;
+err:
+	for (i = 0; i < brd->nasync; i++) {
+		if (brd->channels[i]) {
+			kfree(brd->channels[i]->ch_rqueue);
+			kfree(brd->channels[i]->ch_equeue);
+			kfree(brd->channels[i]);
+		}
+	}
+	return -ENOMEM;
 }
 
 int jsm_uart_port_init(struct jsm_board *brd)
-- 
2.17.6

