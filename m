Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D87C28B5B
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBF860F58
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhINJPn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhINJPi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F225220D3;
        Tue, 14 Sep 2021 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMC4EVcw/uF5QULJdQl6X+7D4+czqBFVcA6/z6KRT6U=;
        b=k3u9KliMlQ1JEcDJvVDy77s4yVKR33N/MOhZteBtose3V9JGHCU5xKsufTw/GNkxmTvPcq
        ceA7dHCV8Kc0Q9ps41X27qMDo+SS+cEu3ogV+qTVdoRAdiZr17UO1/0grQWpgxWvbIEeyn
        TeQqHhmfFsBo3/fjQkyDSKIlN6Gzo3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMC4EVcw/uF5QULJdQl6X+7D4+czqBFVcA6/z6KRT6U=;
        b=g7ekpIiGMxbDSdboue8huaHEfTONuSAE/MPja2vjTxyK9Qbst7oCMmpJPa/ZqdrGZgIFUn
        eAgjdQYKKMFrUZBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4DA9BA3B94;
        Tue, 14 Sep 2021 09:14:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 15/16] tty: the rest, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:14 +0200
Message-Id: <20210914091415.17918-8-jslaby@suse.cz>
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
going to remove the former, so call the latter directly in the couple of
remaining users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
---
 drivers/char/pcmcia/synclink_cs.c | 2 +-
 drivers/ipack/devices/ipoctal.c   | 2 +-
 drivers/misc/bcm-vk/bcm_vk_tty.c  | 2 +-
 drivers/mmc/core/sdio_uart.c      | 2 +-
 drivers/net/usb/hso.c             | 2 +-
 net/bluetooth/rfcomm/tty.c        | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 78baba55a8b5..29a7a89ee58d 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -952,7 +952,7 @@ static void rx_ready_async(MGSLPC_INFO *info, int tcd)
 	}
 
 	if (work)
-		tty_flip_buffer_push(port);
+		tty_schedule_flip(port);
 }
 
 
diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index c14e65a5d38f..714e2b8c551f 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -184,7 +184,7 @@ static void ipoctal_irq_rx(struct ipoctal_channel *channel, u8 sr)
 		sr = ioread8(&channel->regs->r.sr);
 	} while (isr & channel->isr_rx_rdy_mask);
 
-	tty_flip_buffer_push(port);
+	tty_schedule_flip(port);
 }
 
 static void ipoctal_irq_tx(struct ipoctal_channel *channel)
diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index 1b6076a89ca6..328109a719be 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -114,7 +114,7 @@ static void bcm_vk_tty_wq_handler(struct work_struct *work)
 		}
 
 		if (count) {
-			tty_flip_buffer_push(&vktty->port);
+			tty_schedule_flip(&vktty->port);
 
 			/* Update read offset from shadow register to card */
 			vkwrite32(vk, vktty->rd, BAR_1,
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 04c0823e0359..55fc67bd0937 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -418,7 +418,7 @@ static void sdio_uart_receive_chars(struct sdio_uart_port *port,
 		*status = sdio_in(port, UART_LSR);
 	} while ((*status & UART_LSR_DR) && (max_count-- > 0));
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void sdio_uart_transmit_chars(struct sdio_uart_port *port)
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 7dc1ef3f93c3..55ea64b162e1 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2018,7 +2018,7 @@ static int put_rxbuf_data(struct urb *urb, struct hso_serial *serial)
 	if (count >= urb->actual_length) {
 		tty_insert_flip_string(&serial->port, urb->transfer_buffer,
 				       urb->actual_length);
-		tty_flip_buffer_push(&serial->port);
+		tty_schedule_flip(&serial->port);
 	} else {
 		dev_warn(&serial->parent->usb->dev,
 			 "dropping data, %d bytes lost\n", urb->actual_length);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index ebd78fdbd6e8..2a09637bdb00 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -618,7 +618,7 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 	BT_DBG("dlc %p len %d", dlc, skb->len);
 
 	tty_insert_flip_string(&dev->port, skb->data, skb->len);
-	tty_flip_buffer_push(&dev->port);
+	tty_schedule_flip(&dev->port);
 
 	kfree_skb(skb);
 }
@@ -677,7 +677,7 @@ static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
 	rfcomm_dlc_unlock(dev->dlc);
 
 	if (inserted > 0)
-		tty_flip_buffer_push(&dev->port);
+		tty_schedule_flip(&dev->port);
 }
 
 /* do the reverse of install, clearing the tty fields and releasing the
-- 
2.33.0

