Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89895ECAAD1
	for <linux-serial@archiver.kernel.org>; Wed, 31 Aug 2022 07:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiHaHki (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Aug 2022 03:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiHaHkg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Aug 2022 03:40:36 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 00:40:30 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B0BB14D7
        for <linux-serial@vger.kernel.org>; Wed, 31 Aug 2022 00:40:27 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202208310739247ab39d2019a4e13dd9
        for <linux-serial@vger.kernel.org>;
        Wed, 31 Aug 2022 09:39:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nGvVUAIr6EVotI+lAvFGhAT1Y/xk9oR6QAFXkdDhLEw=;
 b=oZui0olsoyaKWY7sY/5bHi3zMsJicM6TzSPdIdIm3NgxLhoz8IU8gqcWDcHqtBzxpyKIQw
 ljw95J1G0F30ZF1feFaean/JYoLMtO3+D90EnCxSDV53kptic3fUOcb3DwpKyWynp9q6npC9
 u5FgaM+l7xBh+cqAva+9x280PeFYo=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 6/6] tty: n_gsm: add debug bit for user payload
Date:   Wed, 31 Aug 2022 09:38:00 +0200
Message-Id: <20220831073800.7459-6-daniel.starke@siemens.com>
In-Reply-To: <20220831073800.7459-1-daniel.starke@siemens.com>
References: <20220831073800.7459-1-daniel.starke@siemens.com>
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

Incorporated review comments from Jiri Slaby since v2:
- changed (1 << n) to BIT(n) in the debug macro definitions

Link: https://lore.kernel.org/all/1d8d0d72-a5b7-724e-a70a-71d9fd3330c4@kernel.org/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f8a8c4059907..6588b84eed96 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -69,6 +69,7 @@ module_param(debug, int, 0600);
 #define DBG_DATA	BIT(2) /* Data transmission details. */
 #define DBG_ERRORS	BIT(3) /* Details for fail conditions. */
 #define DBG_TTY		BIT(4) /* Transmission statistics for DLCI TTYs. */
+#define DBG_PAYLOAD	BIT(5) /* Limits DBG_DUMP to payload frames. */
 
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

