Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A61C3F6B0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Aug 2022 07:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiHVHYP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Aug 2022 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiHVHYN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Aug 2022 03:24:13 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 00:24:09 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC629CAC
        for <linux-serial@vger.kernel.org>; Mon, 22 Aug 2022 00:24:09 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20220822072305a8348c1116ce4c6b65
        for <linux-serial@vger.kernel.org>;
        Mon, 22 Aug 2022 09:23:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kG+0qXXrDijXLAMNyyyKqvB26/6HqiXhBVma8IBGVuM=;
 b=RaoNLvrvpsgFs4obdqCMDL5oIMeVq7vmkAuILqAPSqKuHaAR4RHrXCH1+xhnKP2qZHxV5u
 GqNdbblhsfdvBuh9MhKIBYlPJqEsrDwqlwV0vhfwbV7xd4iw1iNWTuE3vJNN1sMb7rKhHGVw
 z0Xre7ZjrGS35t+m93dJynosanSdY=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 6/6] tty: n_gsm: add debug bit for user payload
Date:   Mon, 22 Aug 2022 09:21:38 +0200
Message-Id: <20220822072138.3123-6-daniel.starke@siemens.com>
In-Reply-To: <20220822072138.3123-1-daniel.starke@siemens.com>
References: <20220822072138.3123-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

A debug bit to output a complete transmission dump exists. Sometimes only
the user frames are relevant. Add an additional bit which limits the
transmission dump output to user data frames if set.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e8f10a5f0a8a..676034fb1190 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -69,6 +69,7 @@ module_param(debug, int, 0600);
 #define DBG_DATA	(1 << 2) /* Data transmission details. */
 #define DBG_ERRORS	(1 << 3) /* Details for fail conditions. */
 #define DBG_TTY		(1 << 4) /* Transmission statistics for DLCI TTYs. */
+#define DBG_PAYLOAD	(1 << 5) /* Limits DBG_DUMP to payload frames. */
 
 /* Defaults: these are from the specification */
 
@@ -598,6 +599,10 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 {
 	if (!(debug & DBG_DUMP))
 		return;
+	/* Only show user payload frames if debug & DBG_PAYLOAD */
+	if (!(debug & DBG_PAYLOAD) && addr != 0)
+		if ((control & ~PF) == UI || (control & ~PF) == UIH)
+			return;
 
 	pr_info("%s %d) %c: ", hdr, addr, "RC"[cr]);
 
-- 
2.34.1

