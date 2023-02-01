Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68DEC38142
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 08:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBAIEe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Feb 2023 03:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBAIEd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Feb 2023 03:04:33 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 00:04:09 PST
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76505D12D
        for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2023 00:04:09 -0800 (PST)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230201080304a0e0ab59c905041cee
        for <linux-serial@vger.kernel.org>;
        Wed, 01 Feb 2023 09:03:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uIC7wmtM876zS1feMXVcrIfYaMgU0Q3UqvmHnO01y6Y=;
 b=O2u9ft1yxfdTxZQA9nNo0NnO3ioyzSgxYzVJls+h4GVMPuK6EJGWExnF+UlNBcEXPpcFUP
 HqaMr6UEtNq6QtP8mHhQyD/lU9AkGweDQVLM8F2qNmqTx6jV6dfGraONpwBsaxSzYAupChqj
 24rg5yORQen+qJd0p0M8R3OQ/2tXE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 3/3] tty: n_gsm: add TIOCMIWAIT support
Date:   Wed,  1 Feb 2023 09:01:51 +0100
Message-Id: <20230201080151.2068-3-daniel.starke@siemens.com>
In-Reply-To: <20230201080151.2068-1-daniel.starke@siemens.com>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Add support for the TIOCMIWAIT ioctl on the virtual ttys. This enables the
user to wait for virtual modem signals like RING.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 118511c1fa37..48fb7dad44cd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1542,6 +1542,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	if (brk & 0x01)
 		tty_insert_flip_char(&dlci->port, 0, TTY_BREAK);
 	dlci->modem_rx = mlines;
+	wake_up_interruptible(&dlci->gsm->event);
 }
 
 /**
@@ -3848,6 +3849,35 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 	return -EPROTONOSUPPORT;
 }
 
+/**
+ * gsm_wait_modem_change	-	wait for modem status line change
+ * @dlci: channel
+ * @mask: modem status line bits
+ */
+
+static int gsm_wait_modem_change(struct gsm_dlci *dlci, u32 mask)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	u32 old = dlci->modem_rx & mask;
+	int ret;
+
+	if (gsm->dead)
+		return -ENODEV;
+
+	do {
+		ret = wait_event_interruptible(gsm->event, gsm->dead
+					      || old ^ (dlci->modem_rx & mask));
+		if (ret)
+			return ret;
+		if (dlci->state != DLCI_OPEN)
+			return -EL2NSYNC;
+		if (gsm->dead)
+			return -ENODEV;
+	} while ((old ^ (dlci->modem_rx & mask)) == 0);
+
+	return 0;
+}
+
 static bool gsm_carrier_raised(struct tty_port *port)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
@@ -4107,6 +4137,8 @@ static int gsmtty_ioctl(struct tty_struct *tty,
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 		return 0;
+	case TIOCMIWAIT:
+		return gsm_wait_modem_change(dlci, arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.34.1

