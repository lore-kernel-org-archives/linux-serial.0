Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE1BC2FC14
	for <linux-serial@archiver.kernel.org>; Thu, 17 Aug 2023 09:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349653AbjHQJd0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349713AbjHQJdC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:02 -0400
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677B72D5F
        for <linux-serial@vger.kernel.org>; Thu, 17 Aug 2023 02:33:00 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230817093258546425dc651938e25b
        for <linux-serial@vger.kernel.org>;
        Thu, 17 Aug 2023 11:32:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7p+KGwOw76EIRSY8uk6f1a9HP/ysAdoFopAyIj5i6LE=;
 b=Wt5z+fY/Y2C06ZNKf9fa+6ZywTH3z6a1dMHyKVsdmQrREyvHlQh/dkno09SJONSz4ssh9m
 bGJK7zoKhrYQLDOsBz7Hn+qNrt++X7XWtdaaxgMluccj+eL4ZD7fcJjTR/8C+6poXy7sWKrc
 u5N8tptpMqOfIoDQTJGsQAQSZVxcU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 5/9] tty: n_gsm: increase malformed counter for malformed control frames
Date:   Thu, 17 Aug 2023 11:32:27 +0200
Message-Id: <20230817093231.2317-5-daniel.starke@siemens.com>
In-Reply-To: <20230817093231.2317-1-daniel.starke@siemens.com>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The malformed counter in gsm_mux is already increased in case of errors
detected in gsm_queue() and gsm1_receive(). gsm_dlci_command() also
detects a case for a malformed frame but does not increase the malformed
counter yet.

Fix this by also increasing the gsm_mux malformed counter in case of a
malformed frame in gsm_dlci_command().
Note that the malformed counter is not yet exposed and only set internally.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v5 -> v6:
No changes.

Link: https://lore.kernel.org/all/20230517155704.5701-5-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d28465f142a8..18f022f75831 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2455,8 +2455,10 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 	data += dlen;
 
 	/* Malformed command? */
-	if (clen > len)
+	if (clen > len) {
+		dlci->gsm->malformed++;
 		return;
+	}
 
 	if (command & 1)
 		gsm_control_message(dlci->gsm, command, data, clen);
-- 
2.34.1

