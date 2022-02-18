Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46881C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Feb 2022 07:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiBRHdB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Feb 2022 02:33:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiBRHdA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Feb 2022 02:33:00 -0500
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 23:32:39 PST
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0547297210
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 23:32:38 -0800 (PST)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20220218073129bf784fd41632b312de
        for <linux-serial@vger.kernel.org>;
        Fri, 18 Feb 2022 08:31:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JtVIeHCB9L76k6Yw2M8lDa9b0zL37qXi5FJsmRZz2WU=;
 b=Ae/DZ3+UHcKVxrmVq1qvNV8D+x0fgpLMcm+JgnLDH54btnf8vLWHoh6JFSLZL0VNzpSdfE
 9GRk4tuZRfpnjB33+zTDS5iazKPly9SOE2xHJ90wKAp+tcKDpdgOiOJX6uws4Uv3hhyQCIVy
 OGUtFV7998khpjYBL8mhtGpJHszbA=;
From:   daniel.starke@siemens.com
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 5/7] tty: n_gsm: fix wrong tty control line for flow control
Date:   Thu, 17 Feb 2022 23:31:21 -0800
Message-Id: <20220218073123.2121-5-daniel.starke@siemens.com>
In-Reply-To: <20220218073123.2121-1-daniel.starke@siemens.com>
References: <20220218073123.2121-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-7517:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty flow control is handled via gsmtty_throttle() and gsmtty_unthrottle().
Both functions propagate the outgoing hardware flow control state to the
remote side via MSC (modem status command) frames. The local state is taken
from the RTS (ready to send) flag of the tty. However, RTS gets mapped to
DTR (data terminal ready), which is wrong.
This patch corrects this by mapping RTS to RTS.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b1808e3a912..d57fd055b489 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3234,9 +3234,9 @@ static void gsmtty_throttle(struct tty_struct *tty)
 	if (dlci->state == DLCI_CLOSED)
 		return;
 	if (C_CRTSCTS(tty))
-		dlci->modem_tx &= ~TIOCM_DTR;
+		dlci->modem_tx &= ~TIOCM_RTS;
 	dlci->throttled = true;
-	/* Send an MSC with DTR cleared */
+	/* Send an MSC with RTS cleared */
 	gsmtty_modem_update(dlci, 0);
 }
 
@@ -3246,9 +3246,9 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 	if (dlci->state == DLCI_CLOSED)
 		return;
 	if (C_CRTSCTS(tty))
-		dlci->modem_tx |= TIOCM_DTR;
+		dlci->modem_tx |= TIOCM_RTS;
 	dlci->throttled = false;
-	/* Send an MSC with DTR set */
+	/* Send an MSC with RTS set */
 	gsmtty_modem_update(dlci, 0);
 }
 
-- 
2.25.1

