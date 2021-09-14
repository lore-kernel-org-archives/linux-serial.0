Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F622C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07ABA60F58
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhINJPg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhINJPf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 984F5220D1;
        Tue, 14 Sep 2021 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCkWvpYv5VVJ3UHRUdrtSKabTeRWI4CYH9eGul69DPw=;
        b=wYr26iLwq3CCN1jNcH9/umi3Fm4ThlblNdds+a9xeA3u8GvXXit5rVQXiD4XJmPjQKJtrN
        X9WEdbUWFx5rn+Ig2DeTqQuvNI6eabAowZMZi6pXd4bOw3BmldzLVHyZHv8bA7SJBYhSjZ
        nR/xR2wzpSsp/xhrm2xEaU5ZO5MLN68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCkWvpYv5VVJ3UHRUdrtSKabTeRWI4CYH9eGul69DPw=;
        b=POCzVnMTscraT5PXR4Xdi/5RnY7+Y0adev1a10dHcjCZM77VPlSDaZr74yTf6VjFtU0L/H
        JBSnGVApOyz7eUDw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 47B55A3B8E;
        Tue, 14 Sep 2021 09:14:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 09/16] tty: drivers/tty/, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:08 +0200
Message-Id: <20210914091415.17918-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the former, so call the latter directly in the rest of
drivers/tty/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/tty/amiserial.c           | 2 +-
 drivers/tty/ehv_bytechan.c        | 2 +-
 drivers/tty/hvc/hvc_console.c     | 2 +-
 drivers/tty/hvc/hvcs.c            | 2 +-
 drivers/tty/hvc/hvsi.c            | 6 +++---
 drivers/tty/ipwireless/hardware.c | 2 +-
 drivers/tty/ipwireless/tty.c      | 2 +-
 drivers/tty/mips_ejtag_fdc.c      | 2 +-
 drivers/tty/mxser.c               | 2 +-
 drivers/tty/n_gsm.c               | 4 ++--
 drivers/tty/nozomi.c              | 2 +-
 drivers/tty/pty.c                 | 2 +-
 drivers/tty/synclink_gt.c         | 2 +-
 drivers/tty/vcc.c                 | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 1e60dbef676c..47daa64e2a65 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -256,7 +256,7 @@ static void receive_chars(struct serial_state *info)
 	tty_insert_flip_char(&info->tport, ch, flag);
 	if (oe == 1)
 		tty_insert_flip_char(&info->tport, 0, TTY_OVERRUN);
-	tty_flip_buffer_push(&info->tport);
+	tty_schedule_flip(&info->tport);
 out:
 	return;
 }
diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 19d32cb6af84..971f7c557e29 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -393,7 +393,7 @@ static irqreturn_t ehv_bc_tty_rx_isr(int irq, void *data)
 	}
 
 	/* Tell the tty layer that we're done. */
-	tty_flip_buffer_push(&bc->port);
+	tty_schedule_flip(&bc->port);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 7b30d5a05e2f..dc8db977bec7 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -752,7 +752,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 		   a minimum for performance. */
 		timeout = MIN_TIMEOUT;
 
-		tty_flip_buffer_push(&hp->port);
+		tty_schedule_flip(&hp->port);
 	}
 	tty_kref_put(tty);
 
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 245da1dfd818..51e8478d55c0 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -582,7 +582,7 @@ static int hvcs_io(struct hvcs_struct *hvcsd)
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	/* This is synch -- FIXME :js: it is not! */
 	if(got)
-		tty_flip_buffer_push(&hvcsd->port);
+		tty_schedule_flip(&hvcsd->port);
 
 	if (!got) {
 		/* Do this _after_ the flip_buffer_push */
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index aa81f4835fef..8e4ad5cb2387 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -454,7 +454,7 @@ static int hvsi_load_chunk(struct hvsi_struct *hp, struct tty_struct *tty,
 	compact_inbuf(hp, packet);
 
 	if (flip)
-		tty_flip_buffer_push(&hp->port);
+		tty_schedule_flip(&hp->port);
 
 	return 1;
 }
@@ -500,7 +500,7 @@ static irqreturn_t hvsi_interrupt(int irq, void *arg)
 		/* we weren't hung up and we weren't throttled, so we can
 		 * deliver the rest now */
 		hvsi_send_overflow(hp);
-		tty_flip_buffer_push(&hp->port);
+		tty_schedule_flip(&hp->port);
 	}
 	spin_unlock_irqrestore(&hp->lock, flags);
 
@@ -982,7 +982,7 @@ static void hvsi_unthrottle(struct tty_struct *tty)
 	spin_lock_irqsave(&hp->lock, flags);
 	if (hp->n_throttle) {
 		hvsi_send_overflow(hp);
-		tty_flip_buffer_push(&hp->port);
+		tty_schedule_flip(&hp->port);
 	}
 	spin_unlock_irqrestore(&hp->lock, flags);
 
diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index f5d3e68f5750..605a99f18ee1 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -719,7 +719,7 @@ static void ipw_receive_data_work(struct work_struct *work_rx)
 		/*
 		 * Note: ipwireless_network_packet_received must be called in a
 		 * process context (i.e. via schedule_work) because the tty
-		 * output code can sleep in the tty_flip_buffer_push call.
+		 * output code can sleep in the tty_schedule_flip call.
 		 */
 		if (packet->protocol == TL_PROTOCOLID_COM_DATA) {
 			if (hw->network != NULL) {
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index 9edd5ae17580..694e62383479 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -171,7 +171,7 @@ void ipwireless_tty_received(struct ipw_tty *tty, unsigned char *data,
 				length - work);
 
 	if (work)
-		tty_flip_buffer_push(&tty->port);
+		tty_schedule_flip(&tty->port);
 }
 
 static void ipw_write_packet_sent_callback(void *callback_data,
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 02c10a968de1..b8675782cf28 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -613,7 +613,7 @@ static void mips_ejtag_fdc_handle(struct mips_ejtag_fdc_tty *priv)
 							TTY_NORMAL);
 		}
 		if (flipped)
-			tty_flip_buffer_push(&dport->port);
+			tty_schedule_flip(&dport->port);
 
 		raw_spin_unlock(&dport->rx_lock);
 	}
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1216f3985e18..e084e4803f9f 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1637,7 +1637,7 @@ static u8 mxser_receive_chars(struct tty_struct *tty,
 	if (!mxser_receive_chars_new(tty, port, status))
 		status = mxser_receive_chars_old(tty, port, status);
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 
 	return status;
 }
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 59bbd4f6a610..b734362cdbea 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1171,7 +1171,7 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 	if (bits & 8)
 		tty_insert_flip_char(port, 0, TTY_FRAME);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 
 	gsm_control_reply(gsm, CMD_RLS, data, clen);
 }
@@ -1589,7 +1589,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 	case 1:		/* Line state will go via DLCI 0 controls only */
 	default:
 		tty_insert_flip_string(port, data, len);
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 	}
 }
 
diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 0454c78deee6..a70512470799 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1222,7 +1222,7 @@ static irqreturn_t interrupt_handler(int irq, void *dev_id)
 
 	for (a = 0; a < NOZOMI_MAX_PORTS; a++)
 		if (test_and_clear_bit(a, &dc->flip))
-			tty_flip_buffer_push(&dc->port[a].port);
+			tty_schedule_flip(&dc->port[a].port);
 
 	return IRQ_HANDLED;
 none:
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 74bfabe5b453..95cb84319b7d 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -123,7 +123,7 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 		spin_unlock_irqrestore(&to->port->lock, flags);
 		/* And shovel */
 		if (c)
-			tty_flip_buffer_push(to->port);
+			tty_schedule_flip(to->port);
 	}
 	return c;
 }
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index a9acd93e85b7..beea9c6141a5 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1820,7 +1820,7 @@ static void rx_async(struct slgt_info *info)
 	}
 
 	if (chars)
-		tty_flip_buffer_push(&info->port);
+		tty_schedule_flip(&info->port);
 }
 
 /*
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e11383ae1e7e..0fa8539a0f6b 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -297,7 +297,7 @@ static int vcc_rx(struct tty_struct *tty, char *buf, int size)
 
 	len = tty_insert_flip_string(tty->port, buf, size);
 	if (len)
-		tty_flip_buffer_push(tty->port);
+		tty_schedule_flip(tty->port);
 
 	return len;
 }
-- 
2.33.0

