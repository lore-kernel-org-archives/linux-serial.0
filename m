Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF99C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A8D61BA1
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbhKRHev (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46402 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbhKRHea (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0B99C218CE;
        Thu, 18 Nov 2021 07:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVrk6O9Jcq3nH4ZuEH1MzJsj1GaM9qKBB7854LV5xs8=;
        b=aqFmE0FPMjst4tATB2EhOc/TcJXUMZcfTbPBV/+OB/UdtccNplhcxxFGLKWeYSwduR+3MZ
        2XYMs+wDizDlxtkx/MXxkIljxS3wsdbW9NIQLGuF6ji0O9NRQN/NWw5YsKBi653Di2oADG
        cZKOqeQg7xvaO3WwT7Kufp0QXnY9J1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVrk6O9Jcq3nH4ZuEH1MzJsj1GaM9qKBB7854LV5xs8=;
        b=/8wy3pXsVg7qQwiVVo1p/5hwnUQKo9T7VOORVwiNyuq9SHHUpY6um34G7byhDgrKXMo5UZ
        GCM5vS2vGjc2VqDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D5DF0A3B84;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/19] mxser: add MOXA prefix to some PCI device IDs
Date:   Thu, 18 Nov 2021 08:31:23 +0100
Message-Id: <20211118073125.12283-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some of the MOXA PCI device IDs contain _MOXA_, some don't. Add it to
the latter, so that they are all unified.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 65ea4baee5eb..f6842089459a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -159,14 +159,14 @@
 #define MXSER_BAUD_BASE		921600
 #define MXSER_CUSTOM_DIVISOR	(MXSER_BAUD_BASE * 16)
 
-#define PCI_DEVICE_ID_POS104UL	0x1044
-#define PCI_DEVICE_ID_CB108	0x1080
-#define PCI_DEVICE_ID_CP102UF	0x1023
-#define PCI_DEVICE_ID_CP112UL	0x1120
-#define PCI_DEVICE_ID_CB114	0x1142
-#define PCI_DEVICE_ID_CP114UL	0x1143
-#define PCI_DEVICE_ID_CB134I	0x1341
-#define PCI_DEVICE_ID_CP138U	0x1380
+#define PCI_DEVICE_ID_MOXA_POS104UL	0x1044
+#define PCI_DEVICE_ID_MOXA_CB108	0x1080
+#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
+#define PCI_DEVICE_ID_MOXA_CP112UL	0x1120
+#define PCI_DEVICE_ID_MOXA_CB114	0x1142
+#define PCI_DEVICE_ID_MOXA_CP114UL	0x1143
+#define PCI_DEVICE_ID_MOXA_CB134I	0x1341
+#define PCI_DEVICE_ID_MOXA_CP138U	0x1380
 
 #define MXSER_NPORTS(ddata)		((ddata) & 0xffU)
 #define MXSER_HIGHBAUD			0x0100
@@ -212,14 +212,14 @@ static const struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),.driver_data = 8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),.driver_data = 8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB108),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB114),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB134I),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP138U),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_POS104UL),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114UL),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP102UF),	.driver_data = 2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP112UL),	.driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB108),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB114),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB134I),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138U),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_POS104UL),.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114UL),.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UF),.driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112UL),.driver_data = 2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
-- 
2.33.1

