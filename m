Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC88C48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A8F61154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhFRGR1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58876 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhFRGR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 85EEE21B52;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxA0lKs8Z+czelyrY3foDizE8Kt9dob8xZvBzoIG1oo=;
        b=WV1G3B5L/WgL9mOzaIshkAgD7YHUAQCugiFvS/h+ta/BYIfQCQ9W9+SH3xkK+xRrSGUUAe
        SvoiWqDU9QLXm/SF5u4b6qcPT3aYqtB2dUH0IrdCtnxZl2eUxt20DJSISWMJdsgWW+LMw6
        QSkQrOp1KGNJIeiaWJeEp7I9UiU6ozA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxA0lKs8Z+czelyrY3foDizE8Kt9dob8xZvBzoIG1oo=;
        b=rf4tHmfxWuf5jtDdT8Hew80RPIiiugiBopEF1NXNWEB1rn6Ytg7wv3k1yDhKH+MnUPeqIs
        gqLJRmCvvaXTASAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6977BA3B99;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/70] mxser: renumber mxser_cards
Date:   Fri, 18 Jun 2021 08:14:08 +0200
Message-Id: <20210618061516.662-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the ISA cards removal in the previous patch, the mxser_cards array
has holes in it. So renumber the array while updating PCI device's
driver_data.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 80 +++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3a00f180f54a..ef539f084e55 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -95,69 +95,63 @@ struct mxser_cardinfo {
 };
 
 static const struct mxser_cardinfo mxser_cards[] = {
-/* 0*/	{ },
-	{ },
-	{ },
-	{ "C168H/PCI series",	8, },
+/* 0*/	{ "C168H/PCI series",	8, },
 	{ "C104H/PCI series",	4, },
-/* 5*/	{ },
-	{ },
-	{ },
 	{ "CP-132 series",	2, },
 	{ "CP-114 series",	4, },
-/*10*/	{ "CT-114 series",	4, },
-	{ "CP-102 series",	2, MXSER_HIGHBAUD },
+	{ "CT-114 series",	4, },
+/* 5*/	{ "CP-102 series",	2, MXSER_HIGHBAUD },
 	{ "CP-104U series",	4, },
 	{ "CP-168U series",	8, },
 	{ "CP-132U series",	2, },
-/*15*/	{ "CP-134U series",	4, },
-	{ "CP-104JU series",	4, },
+	{ "CP-134U series",	4, },
+/*10*/	{ "CP-104JU series",	4, },
 	{ "Moxa UC7000 Serial",	8, },		/* RC7000 */
 	{ "CP-118U series",	8, },
 	{ "CP-102UL series",	2, },
-/*20*/	{ "CP-102U series",	2, },
-	{ "CP-118EL series",	8, },
+	{ "CP-102U series",	2, },
+/*15*/	{ "CP-118EL series",	8, },
 	{ "CP-168EL series",	8, },
 	{ "CP-104EL series",	4, },
 	{ "CB-108 series",	8, },
-/*25*/	{ "CB-114 series",	4, },
-	{ "CB-134I series",	4, },
+	{ "CB-114 series",	4, },
+/*20*/	{ "CB-134I series",	4, },
 	{ "CP-138U series",	8, },
 	{ "POS-104UL series",	4, },
 	{ "CP-114UL series",	4, },
-/*30*/	{ "CP-102UF series",	2, },
-	{ "CP-112UL series",	2, },
+	{ "CP-102UF series",	2, },
+/*25*/	{ "CP-112UL series",	2, },
 };
 
 /* driver_data correspond to the lines in the structure above
    see also ISA probe function before you change something */
 static const struct pci_device_id mxser_pcibrds[] = {
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),	.driver_data = 3 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114),	.driver_data = 9 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CT114),	.driver_data = 10 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102),	.driver_data = 11 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104U),	.driver_data = 12 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),	.driver_data = 13 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),	.driver_data = 14 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),	.driver_data = 15 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU),.driver_data = 16 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_RC7000),	.driver_data = 17 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),	.driver_data = 18 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),.driver_data = 19 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),	.driver_data = 20 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),.driver_data = 21 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),.driver_data = 22 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),.driver_data = 23 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB108),	.driver_data = 24 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB114),	.driver_data = 25 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB134I),	.driver_data = 26 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP138U),	.driver_data = 27 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_POS104UL),	.driver_data = 28 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114UL),	.driver_data = 29 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP102UF),	.driver_data = 30 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP112UL),	.driver_data = 31 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),	.driver_data = 0 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),	.driver_data = 1 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132),	.driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114),	.driver_data = 3 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CT114),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102),	.driver_data = 5 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104U),	.driver_data = 6 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),	.driver_data = 7 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),	.driver_data = 9 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU),.driver_data = 10 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_RC7000),	.driver_data = 11 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),	.driver_data = 12 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),.driver_data = 13 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),	.driver_data = 14 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),.driver_data = 15 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),.driver_data = 16 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),.driver_data = 17 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB108),	.driver_data = 18 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB114),	.driver_data = 19 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB134I),	.driver_data = 20 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP138U),	.driver_data = 21 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_POS104UL),	.driver_data = 22 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114UL),	.driver_data = 23 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP102UF),	.driver_data = 24 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP112UL),	.driver_data = 25 },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
-- 
2.32.0

