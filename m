Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B710C32789
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 06:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbiHWGaS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiHWGaO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 02:30:14 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 23:30:12 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D9D5FF42
        for <linux-serial@vger.kernel.org>; Mon, 22 Aug 2022 23:30:12 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202208230624070742ebb610803435a2
        for <linux-serial@vger.kernel.org>;
        Tue, 23 Aug 2022 08:29:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yrhprMDTlGL4plZ3xVQSKewwsGW84oYrlZ/o+UkYd40=;
 b=T66vzWwTQYCS/dpWOxW1+UKUvi2PHm9vChyFSVHBhw8LKY76bcJ2zRaRSmLVQUGiiNFpVN
 xX0ipuwSOIhDZC2CjXRfVwhVzO33WOVlWlBKM+nt9+taN5K6vuzUBdPRiO/JCFlK0nwHCs5E
 iiBuWZ7CsaI6mt4zLIPg65OCWES0c=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 6/6] tty: n_gsm: add debug bit for user payload
Date:   Tue, 23 Aug 2022 08:22:59 +0200
Message-Id: <20220823062259.4754-6-daniel.starke@siemens.com>
In-Reply-To: <20220823062259.4754-1-daniel.starke@siemens.com>
References: <20220823062259.4754-1-daniel.starke@siemens.com>
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

No changes since v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fcf2d52d5095..f3f0668f0a73 100644
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

