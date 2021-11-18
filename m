Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA92C43219
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5FB61A62
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbhKRHev (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46422 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbhKRHeb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 714B8218E0;
        Thu, 18 Nov 2021 07:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yu0y74oMtF+lJUlNGiYgI7tMeVKHm6ikxOnBczy+TBI=;
        b=cdidaUYUcos5XS+hXMBqr5Gp/qjFdtCs72oVUr/J3SKGmHlLSV4BV2I29cc+SDzNsukcrs
        Yi6JE7WwqMxP8MTlJrMnSJlnk2ly4WLg3DrFAPmalLJD0Zy480iNaE9owifl1B4Nt8vUTG
        EmjIgzk/vYmuNm+1ydcd+OzhyRs9DFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yu0y74oMtF+lJUlNGiYgI7tMeVKHm6ikxOnBczy+TBI=;
        b=7MwmCi+KrRmUhPrveuMefWK6Bbu45i+FCewzSfKFyVdFxmhnxRb2VcIaqHdCv+3AwwLRXn
        wz4aaCp6IIN0UyAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 49500A3B84;
        Thu, 18 Nov 2021 07:31:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/19] mxser: use PCI_DEVICE_DATA
Date:   Thu, 18 Nov 2021 08:31:25 +0100
Message-Id: <20211118073125.12283-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that we have all the PCI device IDs unified, we can use
PCI_DEVICE_DATA() macro to simplify mxser's pci_device_id list, i.e.
mxser_pcibrds.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ba96ffed193a..c858aff721c4 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -212,32 +212,32 @@ static const struct {
 /* driver_data correspond to the lines in the structure above
    see also ISA probe function before you change something */
 static const struct pci_device_id mxser_pcibrds[] = {
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132),	.driver_data = 2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CT114),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102),	.driver_data = 2 | MXSER_HIGHBAUD },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104U),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),	.driver_data = 2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU),.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_RC7000),	.driver_data = 8 }, /* RC7000 */
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),.driver_data = 2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),	.driver_data = 2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB108),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB114),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB134I),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138U),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_POS104UL),.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114UL),.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UF),.driver_data = 2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112UL),.driver_data = 2 },
+	{ PCI_DEVICE_DATA(MOXA, C168,		8) },
+	{ PCI_DEVICE_DATA(MOXA, C104,		4) },
+	{ PCI_DEVICE_DATA(MOXA, CP132,		2) },
+	{ PCI_DEVICE_DATA(MOXA, CP114,		4) },
+	{ PCI_DEVICE_DATA(MOXA, CT114,		4) },
+	{ PCI_DEVICE_DATA(MOXA, CP102,		2 | MXSER_HIGHBAUD) },
+	{ PCI_DEVICE_DATA(MOXA, CP104U,		4) },
+	{ PCI_DEVICE_DATA(MOXA, CP168U,		8) },
+	{ PCI_DEVICE_DATA(MOXA, CP132U,		2) },
+	{ PCI_DEVICE_DATA(MOXA, CP134U,		4) },
+	{ PCI_DEVICE_DATA(MOXA, CP104JU,	4) },
+	{ PCI_DEVICE_DATA(MOXA, RC7000,		8) }, /* RC7000 */
+	{ PCI_DEVICE_DATA(MOXA, CP118U,		8) },
+	{ PCI_DEVICE_DATA(MOXA, CP102UL,	2) },
+	{ PCI_DEVICE_DATA(MOXA, CP102U,		2) },
+	{ PCI_DEVICE_DATA(MOXA, CP118EL,	8) },
+	{ PCI_DEVICE_DATA(MOXA, CP168EL,	8) },
+	{ PCI_DEVICE_DATA(MOXA, CP104EL,	4) },
+	{ PCI_DEVICE_DATA(MOXA, CB108,		8) },
+	{ PCI_DEVICE_DATA(MOXA, CB114,		4) },
+	{ PCI_DEVICE_DATA(MOXA, CB134I,		4) },
+	{ PCI_DEVICE_DATA(MOXA, CP138U,		8) },
+	{ PCI_DEVICE_DATA(MOXA, POS104UL,	4) },
+	{ PCI_DEVICE_DATA(MOXA, CP114UL,	4) },
+	{ PCI_DEVICE_DATA(MOXA, CP102UF,	2) },
+	{ PCI_DEVICE_DATA(MOXA, CP112UL,	2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
-- 
2.33.1

