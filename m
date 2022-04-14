Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41666C43219
	for <linux-serial@archiver.kernel.org>; Thu, 14 Apr 2022 09:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241918AbiDNJqT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241905AbiDNJqQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:16 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:52 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C570CFB
        for <linux-serial@vger.kernel.org>; Thu, 14 Apr 2022 02:43:52 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20220414094243549efb0002931582d8
        for <linux-serial@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PmuuDV740uCNQukuMAoWBIjNjCFKB+C5JJGKlHYkuWI=;
 b=ljb49c20slK5M+E8mf7EeMG+UZBGcYNoKwNrByEPkkME7XwkZ0b/+9TXbawyLyOyoD5rdE
 C34Oraz8BLNgwrY8aqb6W2axn5vshAFGFA1d6z9vplxQFUnBeVgZyKUUGY8OYD7KYMW6BI9F
 2+1rGcjHzJbr8eiCRFVYx9HMpgLG8=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 07/20] tty: n_gsm: fix malformed counter for out of frame data
Date:   Thu, 14 Apr 2022 02:42:12 -0700
Message-Id: <20220414094225.4527-7-daniel.starke@siemens.com>
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

The gsm_mux field 'malformed' represents the number of malformed frames
received. However, gsm1_receive() also increases this counter for any out
of frame byte.
Fix this by ignoring out of frame data for the malformed counter.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4ce18b42c37a..2e3da8a4697e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2044,7 +2044,8 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		}
 		/* Any partial frame was a runt so go back to start */
 		if (gsm->state != GSM_START) {
-			gsm->malformed++;
+			if (gsm->state != GSM_SEARCH)
+				gsm->malformed++;
 			gsm->state = GSM_START;
 		}
 		/* A SOF in GSM_START means we are still reading idling or
-- 
2.25.1

