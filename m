Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1036DC433FE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Feb 2022 07:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiBRHdD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Feb 2022 02:33:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiBRHdA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Feb 2022 02:33:00 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 23:32:39 PST
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8106299259
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 23:32:39 -0800 (PST)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202202180731327d5020d2919e19d9e4
        for <linux-serial@vger.kernel.org>;
        Fri, 18 Feb 2022 08:31:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=b4XQwcsAcfoBdhr0FTblO5I+qrC5OxsrZ4b1kwFO1ds=;
 b=fkq5D1vJPkd1ubQGmu1oLGiWupCi97eeA4mr7CCWtXO/BKDj8dXd+rp9Je33yKswia7nlE
 VnPGIVTvxGjm2XH/4yrUzE7xO0B4piS8gDi5Mc740CipaFXMnt/Onp7aelILH+1Bb4rOtsnK
 iALymK33Tp2Buev0Dt8pJH8F4jxE0=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 7/7] tty: n_gsm: fix deadlock in gsmtty_open()
Date:   Thu, 17 Feb 2022 23:31:23 -0800
Message-Id: <20220218073123.2121-7-daniel.starke@siemens.com>
In-Reply-To: <20220218073123.2121-1-daniel.starke@siemens.com>
References: <20220218073123.2121-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In the current implementation the user may open a virtual tty which then
could fail to establish the underlying DLCI. The function gsmtty_open()
gets stuck in tty_port_block_til_ready() while waiting for a carrier rise.
This happens if the remote side fails to acknowledge the link establishment
request in time or completely. At some point gsm_dlci_close() is called
to abort the link establishment attempt. The function tries to inform the
associated virtual tty by performing a hangup. But the blocking loop within
tty_port_block_til_ready() is not informed about this event.
The patch proposed here fixes this by resetting the initialization state of
the virtual tty to ensure the loop exits and triggering it to make
tty_port_block_til_ready() return.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..e61a47c349e3 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1451,6 +1451,9 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 	if (dlci->addr != 0) {
 		tty_port_tty_hangup(&dlci->port, false);
 		kfifo_reset(&dlci->fifo);
+		/* Ensure that gsmtty_open() can return. */
+		tty_port_set_initialized(&dlci->port, 0);
+		wake_up_interruptible(&dlci->port.open_wait);
 	} else
 		dlci->gsm->dead = true;
 	/* Unregister gsmtty driver,report gsmtty dev remove uevent for user */
-- 
2.25.1

