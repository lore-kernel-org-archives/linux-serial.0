Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFB2C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  6 May 2022 14:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiEFOwb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 May 2022 10:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442451AbiEFOwa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 May 2022 10:52:30 -0400
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B5C6AA64
        for <linux-serial@vger.kernel.org>; Fri,  6 May 2022 07:48:44 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20220506144841ee6703b991f9cee356
        for <linux-serial@vger.kernel.org>;
        Fri, 06 May 2022 16:48:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gg6FsUa8s9qhXdZ4iteEnt+803VsSNCtcKDz28ld6eQ=;
 b=HjA3OwOpyRxnICLTMvZGqvDmTnmxxW4uoUELNa7uf5qiTf2vYYLupqVRD1nv12dWtraoCd
 7Gg1B7Ch/0jqrF9pkLsjoQzTX0AHIpycnF0fmRwl/ZxUZWccPzML8o4af/J2JqmwHK9eLYr/
 AMQns9wGHGvkTtzbw11/1+eCadtEw=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/2] tty: n_gsm: fix user open not possible at responder until initiator open
Date:   Fri,  6 May 2022 16:47:24 +0200
Message-Id: <20220506144725.1946-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

After setting up the control channel on both sides the responder side may
want to open a virtual tty to listen on until the initiator starts an
application on a user channels. The current implementation allows the
open() but no other operation, like termios. These fail with EINVAL.
The responder sided application has no means to detect an open by the
initiator sided application this way. And the initiator sided applications
usually expect the responder sided application to listen on the user
channel upon open.
Set the user channel into half-open state on responder side once a user
application opens the virtual tty to allow IO operations on it.
Furthermore, keep the user channel constipated until the initiator side
opens it to give the responder sided application the chance to detect the
new connection and to avoid data loss if the responder sided application
starts sending before the user channel is open.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fd8b86dde525..08fea3e7674d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1493,6 +1493,8 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 	if (debug & 8)
 		pr_debug("DLCI %d goes closed.\n", dlci->addr);
 	dlci->state = DLCI_CLOSED;
+	/* Prevent us from sending data before the link is up again */
+	dlci->constipated = true;
 	if (dlci->addr != 0) {
 		tty_port_tty_hangup(&dlci->port, false);
 		spin_lock_irqsave(&dlci->lock, flags);
@@ -1522,6 +1524,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	del_timer(&dlci->t1);
 	/* This will let a tty open continue */
 	dlci->state = DLCI_OPEN;
+	dlci->constipated = false;
 	if (debug & 8)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
@@ -1602,6 +1605,25 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 	mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 }
 
+/**
+ *	gsm_dlci_wait_open	-	wait for channel open procedure
+ *	@dlci: DLCI to open
+ *
+ *	Wait for a DLCI opening from the other side. Asynchronously wait until
+ *	we get a SABM and set off timers and the responses.
+ */
+static void gsm_dlci_wait_open(struct gsm_dlci *dlci)
+{
+	switch (dlci->state) {
+	case DLCI_CLOSED:
+	case DLCI_CLOSING:
+		dlci->state = DLCI_OPENING;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  *	gsm_dlci_begin_close	-	start channel open procedure
  *	@dlci: DLCI to open
@@ -1745,10 +1767,13 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 	dlci->addr = addr;
 	dlci->adaption = gsm->adaption;
 	dlci->state = DLCI_CLOSED;
-	if (addr)
+	if (addr) {
 		dlci->data = gsm_dlci_data;
-	else
+		/* Prevent us from sending data before the link is up */
+		dlci->constipated = true;
+	} else {
 		dlci->data = gsm_dlci_command;
+	}
 	gsm->dlci[addr] = dlci;
 	return dlci;
 }
@@ -3163,6 +3188,8 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	/* Start sending off SABM messages */
 	if (gsm->initiator)
 		gsm_dlci_begin_open(dlci);
+	else
+		gsm_dlci_wait_open(dlci);
 	/* And wait for virtual carrier */
 	return tty_port_block_til_ready(port, tty, filp);
 }
-- 
2.34.1

