Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046A0C38142
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 08:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBAIDP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 03:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBAIDM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 03:03:12 -0500
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BD93C3F
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 00:03:05 -0800 (PST)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230201080302f9f89d52adc701334e
        for <linux-serial@vger.kernel.org>;
        Wed, 01 Feb 2023 09:03:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=cIy7cLtY1cHgn+gV5HomsZ9rqRnyEdD4Bro76hK5UPk=;
 b=Uz05oBpxbitSj3UUJdh6LKGxLPbwT+z2bxZu/GMfEDtDKKGGqjIkHXq6/XyTa7WOYK3vHB
 VXM5Hx3ZneHlZjjuSawMysj9wallxohe7gDyAL/szxTaWg8GdrZ01GJjd977q7UoP73vkT+I
 hDGF4V0zr0b+lk9akD9+OFBDcQFRA=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/3] tty: n_gsm: add keep alive support
Date:   Wed,  1 Feb 2023 09:01:49 +0100
Message-Id: <20230201080151.2068-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapters 5.4.6.3.4 and 5.1.8.1.3 describe the test
command which can be used to test the mux connection between both sides.

Currently, no algorithm is implemented to make use of this command. This
requires that each multiplexed upper layer protocol supervises the
underlying muxer connection to handle possible connection losses.

Introduce an ioctl parameter and functions to optionally enable keep alive
handling via the test command as described in chapter 5.4.6.3.4. A single
incrementing octet is being used to distinguish between multiple retries.
Retry count and interval are taken from the general parameters N2 and T2.

Note that support for the test command is mandatory and already present in
the muxer implementation since the very first version.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         | 89 +++++++++++++++++++++++++++++++++----
 include/uapi/linux/gsmmux.h |  3 +-
 2 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5783801d6524..98577b54f1fd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -318,13 +318,19 @@ struct gsm_mux {
 	struct gsm_control *pending_cmd;/* Our current pending command */
 	spinlock_t control_lock;	/* Protects the pending command */
 
+	/* Keep-alive */
+	struct timer_list ka_timer;	/* Keep-alive response timer */
+	u8 ka_num;			/* Keep-alive match pattern */
+	int ka_retries;			/* Keep-alive retry counter */
+
 	/* Configuration */
-	int adaption;		/* 1 or 2 supported */
-	u8 ftype;		/* UI or UIH */
-	int t1, t2;		/* Timers in 1/100th of a sec */
-	unsigned int t3;	/* Power wake-up timer in seconds. */
-	int n2;			/* Retry count */
-	u8 k;			/* Window size */
+	int adaption;			/* 1 or 2 supported */
+	u8 ftype;			/* UI or UIH */
+	int t1, t2;			/* Timers in 1/100th of a sec */
+	unsigned int t3;		/* Power wake-up timer in seconds. */
+	int n2;				/* Retry count */
+	u8 k;				/* Window size */
+	unsigned int keep_alive;	/* Control channel keep-alive in ms */
 
 	/* Statistics (not currently exposed) */
 	unsigned long bad_fcs;
@@ -1897,11 +1903,13 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 						const u8 *data, int clen)
 {
 	struct gsm_control *ctrl;
+	struct gsm_dlci *dlci;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gsm->control_lock, flags);
 
 	ctrl = gsm->pending_cmd;
+	dlci = gsm->dlci[0];
 	command |= 1;
 	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
@@ -1916,10 +1924,57 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 	/* Or did we receive the PN response to our PN command */
 	} else if (command == CMD_PN) {
 		gsm_control_negotiation(gsm, 0, data, clen);
+	/* Or did we receive the TEST response to our TEST command */
+	} else if (command == CMD_TEST && clen == 1 && *data == gsm->ka_num) {
+		gsm->ka_retries = -1; /* trigger new keep-alive message */
+		if (dlci && !dlci->dead)
+			mod_timer(&gsm->ka_timer,
+				  jiffies + gsm->keep_alive * HZ / 100);
 	}
 	spin_unlock_irqrestore(&gsm->control_lock, flags);
 }
 
+/**
+ * gsm_control_keep_alive	-	check timeout or start keep-alive
+ * @t: timer contained in our gsm object
+ *
+ * Called off the keep-alive timer expiry signaling that our link
+ * partner is not responding anymore. Link will be closed.
+ * This is also called to startup our timer.
+ */
+
+static void gsm_control_keep_alive(struct timer_list *t)
+{
+	struct gsm_mux *gsm = from_timer(gsm, t, ka_timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsm->control_lock, flags);
+	if (gsm->ka_num && gsm->ka_retries == 0) {
+		/* Keep-alive expired -> close the link */
+		if (debug & DBG_ERRORS)
+			pr_info("%s keep-alive timed out\n", __func__);
+		spin_unlock_irqrestore(&gsm->control_lock, flags);
+		if (gsm->dlci[0])
+			gsm_dlci_begin_close(gsm->dlci[0]);
+	} else if (gsm->keep_alive && gsm->dlci[0] && !gsm->dlci[0]->dead) {
+		if (gsm->ka_retries > 0) {
+			/* T2 expired for keep-alive -> resend */
+			gsm->ka_retries--;
+		} else {
+			/* Start keep-alive timer */
+			gsm->ka_num++;
+			if (!gsm->ka_num)
+				gsm->ka_num++;
+			gsm->ka_retries = gsm->n2;
+		}
+		gsm_control_command(gsm, CMD_TEST, &gsm->ka_num,
+				    sizeof(gsm->ka_num));
+		mod_timer(&gsm->ka_timer,
+			  jiffies + gsm->t2 * HZ / 100);
+		spin_unlock_irqrestore(&gsm->control_lock, flags);
+	}
+}
+
 /**
  *	gsm_control_transmit	-	send control packet
  *	@gsm: gsm mux
@@ -2061,8 +2116,10 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 		/* Ensure that gsmtty_open() can return. */
 		tty_port_set_initialized(&dlci->port, false);
 		wake_up_interruptible(&dlci->port.open_wait);
-	} else
+	} else {
+		del_timer(&dlci->gsm->ka_timer);
 		dlci->gsm->dead = true;
+	}
 	/* A DLCI 0 close is a MUX termination so we need to kick that
 	   back to userspace somehow */
 	gsm_dlci_data_kick(dlci);
@@ -2078,6 +2135,8 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 
 static void gsm_dlci_open(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
+
 	/* Note that SABM UA .. SABM UA first UA lost can mean that we go
 	   open -> open */
 	del_timer(&dlci->t1);
@@ -2087,8 +2146,15 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	if (debug & DBG_ERRORS)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
-	if (dlci->addr)
+	if (dlci->addr) {
 		gsm_modem_update(dlci, 0);
+	} else {
+		/* Start keep-alive control */
+		gsm->ka_num = 0;
+		gsm->ka_retries = -1;
+		mod_timer(&gsm->ka_timer,
+			  jiffies + gsm->keep_alive * HZ / 100);
+	}
 	gsm_dlci_data_kick(dlci);
 	wake_up(&dlci->gsm->event);
 }
@@ -2840,6 +2906,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	/* Finish outstanding timers, making sure they are done */
 	del_timer_sync(&gsm->kick_timer);
 	del_timer_sync(&gsm->t2_timer);
+	del_timer_sync(&gsm->ka_timer);
 
 	/* Finish writing to ldisc */
 	flush_work(&gsm->tx_work);
@@ -2987,6 +3054,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	INIT_LIST_HEAD(&gsm->tx_data_list);
 	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+	timer_setup(&gsm->ka_timer, gsm_control_keep_alive, 0);
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
 	init_waitqueue_head(&gsm->event);
 	spin_lock_init(&gsm->control_lock);
@@ -3003,6 +3071,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
 	gsm->mtu = 64;
 	gsm->dead = true;	/* Avoid early tty opens */
+	gsm->keep_alive = 0;	/* Disabled */
 
 	/* Store the instance to the mux array or abort if no space is
 	 * available.
@@ -3046,6 +3115,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 	c->mru = gsm->mru;
 	c->mtu = gsm->mtu;
 	c->k = gsm->k;
+	c->keep_alive = gsm->keep_alive;
 }
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
@@ -3094,6 +3164,8 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 		need_restart = 1;
 	if (c->mtu != gsm->mtu)
 		need_restart = 1;
+	if (c->keep_alive != gsm->keep_alive)
+		need_restart = true;
 
 	/*
 	 * Close down what is needed, restart and initiate the new
@@ -3109,6 +3181,7 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	gsm->encoding = c->encapsulation ? GSM_ADV_OPT : GSM_BASIC_OPT;
 	gsm->adaption = c->adaption;
 	gsm->n2 = c->n2;
+	gsm->keep_alive = c->keep_alive;
 
 	if (c->i == 1)
 		gsm->ftype = UIH;
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index cb8693b39cb7..b64360aca1f9 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -19,7 +19,8 @@ struct gsm_config
 	unsigned int mtu;
 	unsigned int k;
 	unsigned int i;
-	unsigned int unused[8];		/* Padding for expansion without
+	unsigned int keep_alive;
+	unsigned int unused[7];		/* Padding for expansion without
 					   breaking stuff */
 };
 
-- 
2.34.1

