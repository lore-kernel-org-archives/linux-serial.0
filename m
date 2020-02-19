Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B2FC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1813A222D9
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgBSIub (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:50:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:49712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgBSItw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 886EAAC69;
        Wed, 19 Feb 2020 08:49:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/10] n_gsm: drop unneeded gsm_dlci->fifo field
Date:   Wed, 19 Feb 2020 09:49:40 +0100
Message-Id: <20200219084949.28074-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

gsm_dlci->fifo always points to gsm_dlci->_fifo. So drop the pointer and
rename _fifo to fifo. And update all the users (add & to them).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5f8c30f0538e..828c0c7babdd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -129,8 +129,7 @@ struct gsm_dlci {
 	int retries;
 	/* Uplink tty if active */
 	struct tty_port port;	/* The tty bound to this DLCI if there is one */
-	struct kfifo *fifo;	/* Queue fifo for the DLCI */
-	struct kfifo _fifo;	/* For new fifo API porting only */
+	struct kfifo fifo;	/* Queue fifo for the DLCI */
 	int adaption;		/* Adaption layer in use */
 	int prev_adaption;
 	u32 modem_rx;		/* Our incoming virtual modem lines */
@@ -796,7 +795,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 
 	total_size = 0;
 	while (1) {
-		len = kfifo_len(dlci->fifo);
+		len = kfifo_len(&dlci->fifo);
 		if (len == 0)
 			return total_size;
 
@@ -820,7 +819,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 			*dp++ = gsm_encode_modem(dlci);
 			break;
 		}
-		WARN_ON(kfifo_out_locked(dlci->fifo, dp , len, &dlci->lock) != len);
+		WARN_ON(kfifo_out_locked(&dlci->fifo, dp , len, &dlci->lock) != len);
 		__gsm_data_queue(dlci, msg);
 		total_size += size;
 	}
@@ -1424,7 +1423,7 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 	dlci->state = DLCI_CLOSED;
 	if (dlci->addr != 0) {
 		tty_port_tty_hangup(&dlci->port, false);
-		kfifo_reset(dlci->fifo);
+		kfifo_reset(&dlci->fifo);
 	} else
 		dlci->gsm->dead = 1;
 	wake_up(&dlci->gsm->event);
@@ -1645,8 +1644,7 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 		return NULL;
 	spin_lock_init(&dlci->lock);
 	mutex_init(&dlci->mutex);
-	dlci->fifo = &dlci->_fifo;
-	if (kfifo_alloc(&dlci->_fifo, 4096, GFP_KERNEL) < 0) {
+	if (kfifo_alloc(&dlci->fifo, 4096, GFP_KERNEL) < 0) {
 		kfree(dlci);
 		return NULL;
 	}
@@ -1681,7 +1679,7 @@ static void gsm_dlci_free(struct tty_port *port)
 
 	del_timer_sync(&dlci->t1);
 	dlci->gsm->dlci[dlci->addr] = NULL;
-	kfifo_free(dlci->fifo);
+	kfifo_free(&dlci->fifo);
 	while ((dlci->skb = skb_dequeue(&dlci->skb_list)))
 		dev_kfree_skb(dlci->skb);
 	kfree(dlci);
@@ -3030,7 +3028,7 @@ static int gsmtty_write(struct tty_struct *tty, const unsigned char *buf,
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
 	/* Stuff the bytes into the fifo queue */
-	sent = kfifo_in_locked(dlci->fifo, buf, len, &dlci->lock);
+	sent = kfifo_in_locked(&dlci->fifo, buf, len, &dlci->lock);
 	/* Need to kick the channel */
 	gsm_dlci_data_kick(dlci);
 	return sent;
@@ -3041,7 +3039,7 @@ static int gsmtty_write_room(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
-	return TX_SIZE - kfifo_len(dlci->fifo);
+	return TX_SIZE - kfifo_len(&dlci->fifo);
 }
 
 static int gsmtty_chars_in_buffer(struct tty_struct *tty)
@@ -3049,7 +3047,7 @@ static int gsmtty_chars_in_buffer(struct tty_struct *tty)
 	struct gsm_dlci *dlci = tty->driver_data;
 	if (dlci->state == DLCI_CLOSED)
 		return -EINVAL;
-	return kfifo_len(dlci->fifo);
+	return kfifo_len(&dlci->fifo);
 }
 
 static void gsmtty_flush_buffer(struct tty_struct *tty)
@@ -3061,7 +3059,7 @@ static void gsmtty_flush_buffer(struct tty_struct *tty)
 	   then the data being transmitted can't simply be junked once
 	   it has first hit the stack. Until then we can just blow it
 	   away */
-	kfifo_reset(dlci->fifo);
+	kfifo_reset(&dlci->fifo);
 	/* Need to unhook this DLCI from the transmit queue logic */
 }
 
-- 
2.25.0

