Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F51C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbiDNJqY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiDNJqT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:19 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:54 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928B6E54C
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:43:54 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202204140942453b89bb4f320f9cceae
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=BeY7tUTv0JkVwOPsalB6SRWsraBVI4DRmB8X+cQCD64=;
 b=RIqpALIXOaqm2jmA2yjsGYAjlJKVXKPN6qha01nU0Jq1C1Thbw2DmOY0DAQydb4izizcFz
 GHQhu20OHiPGmj2IK2W6QKrE6TKPol4uish36za4iqGEo0+MwDtj85bVQFsaNAgHxjWswMDM
 jGOD2pyROTbLjZ/0fO8vlnQedfJ10=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 09/20] tty: n_gsm: fix wrong DLCI release order
Date:   Thu, 14 Apr 2022 02:42:14 -0700
Message-Id: <20220414094225.4527-9-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The current DLCI release order starts with the control channel followed by
the user channels. Reverse this order to keep the control channel open
until all user channels have been released.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cc90b03ce005..6b953dfbb155 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2146,8 +2146,8 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	/* Finish outstanding timers, making sure they are done */
 	del_timer_sync(&gsm->t2_timer);
 
-	/* Free up any link layer users */
-	for (i = 0; i < NUM_DLCI; i++)
+	/* Free up any link layer users and finally the control channel */
+	for (i = NUM_DLCI - 1; i >= 0; i--)
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
 	mutex_unlock(&gsm->mutex);
-- 
2.25.1

