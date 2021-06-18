Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB21C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E1A611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhFRGSx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46728 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5DDDD1FE07;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3y0/IFp2CiRPkh2A4x+A3iEwUH8AU+BFHPdO+95c54=;
        b=PVWIk455NY9c8iMLWnVA0om8MhYw7UnmLxRDW2uLpL26KNAR3QvEL40htnn29IOedQvWYy
        ADJ+0Tn/7PjVrY/Gu4ucUNqQZqMUdBrK0QUPLgSRP1l+ZPYLBOO0jGl1prXgM37gePFMvt
        e1I/osQpnsBUKs2K2w1eWRVDrBnq+2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3y0/IFp2CiRPkh2A4x+A3iEwUH8AU+BFHPdO+95c54=;
        b=bnLUN/ON+agpnPyYnvwpzXbn2G+mCWVcQECbUyZ4fjOmAC/+T5RkgeIRkUJWScvEeCDSS/
        h7neUHA1KxRvZDBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 41013A3B9D;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 48/70] mxser: remove mxser_cardinfo
Date:   Fri, 18 Jun 2021 08:14:54 +0200
Message-Id: <20210618061516.662-49-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that mxser_cards array (of struct mxser_cardinfo) contains only port
count and a quirk, we can encode these two directly into
pci_device_id::driver_data. And we can remove this struct completely.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 113 ++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 72 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 04a39c1f13bb..bb4110d466cb 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -168,7 +168,8 @@
 #define PCI_DEVICE_ID_CB134I	0x1341
 #define PCI_DEVICE_ID_CP138U	0x1380
 
-#define MXSER_HIGHBAUD	1
+#define MXSER_NPORTS(ddata)		((ddata) & 0xffU)
+#define MXSER_HIGHBAUD			0x0100
 
 enum mxser_must_hwid {
 	MOXA_OTHER_UART		= 0x00,
@@ -189,69 +190,36 @@ static const struct {
 };
 #define UART_INFO_NUM	ARRAY_SIZE(Gpci_uart_info)
 
-struct mxser_cardinfo {
-	unsigned int nports;
-	unsigned int flags;
-};
-
-static const struct mxser_cardinfo mxser_cards[] = {
-/* 0*/	{ 8, },
-	{ 4, },
-	{ 2, },
-	{ 4, },
-	{ 4, },
-/* 5*/	{ 2, MXSER_HIGHBAUD },
-	{ 4, },
-	{ 8, },
-	{ 2, },
-	{ 4, },
-/*10*/	{ 4, },
-	{ 8, },		/* RC7000 */
-	{ 8, },
-	{ 2, },
-	{ 2, },
-/*15*/	{ 8, },
-	{ 8, },
-	{ 4, },
-	{ 8, },
-	{ 4, },
-/*20*/	{ 4, },
-	{ 8, },
-	{ 4, },
-	{ 4, },
-	{ 2, },
-/*25*/	{ 2, },
-};
 
 /* driver_data correspond to the lines in the structure above
    see also ISA probe function before you change something */
 static const struct pci_device_id mxser_pcibrds[] = {
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),	.driver_data = 0 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),	.driver_data = 1 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),	.driver_data = 4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132),	.driver_data = 2 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114),	.driver_data = 3 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114),	.driver_data = 4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CT114),	.driver_data = 4 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102),	.driver_data = 5 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104U),	.driver_data = 6 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),	.driver_data = 7 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),	.driver_data = 8 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),	.driver_data = 9 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU),.driver_data = 10 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_RC7000),	.driver_data = 11 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),	.driver_data = 12 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),.driver_data = 13 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),	.driver_data = 14 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),.driver_data = 15 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),.driver_data = 16 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),.driver_data = 17 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB108),	.driver_data = 18 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB114),	.driver_data = 19 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB134I),	.driver_data = 20 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP138U),	.driver_data = 21 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_POS104UL),	.driver_data = 22 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114UL),	.driver_data = 23 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP102UF),	.driver_data = 24 },
-	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP112UL),	.driver_data = 25 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102),	.driver_data = 2 | MXSER_HIGHBAUD },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104U),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),	.driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU),.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_RC7000),	.driver_data = 8 }, /* RC7000 */
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),.driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),	.driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB108),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB114),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CB134I),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP138U),	.driver_data = 8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_POS104UL),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP114UL),	.driver_data = 4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP102UF),	.driver_data = 2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_CP112UL),	.driver_data = 2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
@@ -300,8 +268,8 @@ struct mxser_port {
 
 struct mxser_board {
 	unsigned int idx;
+	unsigned short nports;
 	int irq;
-	const struct mxser_cardinfo *info;
 	unsigned long vector;
 
 	enum mxser_must_hwid must_hwid;
@@ -1816,7 +1784,7 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 	struct mxser_board *brd = dev_id;
 	struct mxser_port *port;
 	unsigned int int_cnt, pass_counter = 0;
-	unsigned int i, max = brd->info->nports;
+	unsigned int i, max = brd->nports;
 	int handled = IRQ_NONE;
 	u8 irqbits, bits, mask = BIT(max) - 1;
 
@@ -1882,7 +1850,7 @@ static const struct tty_port_operations mxser_port_ops = {
  * The MOXA Smartio/Industio serial driver boot-time initialization code!
  */
 
-static void mxser_initbrd(struct mxser_board *brd)
+static void mxser_initbrd(struct mxser_board *brd, bool high_baud)
 {
 	struct mxser_port *info;
 	unsigned int i;
@@ -1896,7 +1864,7 @@ static void mxser_initbrd(struct mxser_board *brd)
 			brd->max_baud = Gpci_uart_info[i].max_baud;
 
 			/* exception....CP-102 */
-			if (brd->info->flags & MXSER_HIGHBAUD)
+			if (high_baud)
 				brd->max_baud = 921600;
 			break;
 		}
@@ -1908,7 +1876,7 @@ static void mxser_initbrd(struct mxser_board *brd)
 		outb(0, brd->vector + 0x0c);
 	}
 
-	for (i = 0; i < brd->info->nports; i++) {
+	for (i = 0; i < brd->nports; i++) {
 		info = &brd->ports[i];
 		if (is_mu860) {
 			if (i < 4)
@@ -1945,11 +1913,12 @@ static int mxser_probe(struct pci_dev *pdev,
 	struct mxser_board *brd;
 	unsigned int i;
 	unsigned long ioaddress;
+	unsigned short nports = MXSER_NPORTS(ent->driver_data);
 	struct device *tty_dev;
 	int retval = -EINVAL;
 
 	for (i = 0; i < MXSER_BOARDS; i++)
-		if (mxser_boards[i].info == NULL)
+		if (mxser_boards[i].nports == 0)
 			break;
 
 	if (i >= MXSER_BOARDS) {
@@ -1973,8 +1942,8 @@ static int mxser_probe(struct pci_dev *pdev,
 	if (retval)
 		goto err;
 
-	brd->info = &mxser_cards[ent->driver_data];
-	for (i = 0; i < brd->info->nports; i++)
+	brd->nports = nports;
+	for (i = 0; i < nports; i++)
 		brd->ports[i].ioaddr = ioaddress + 8 * i;
 
 	/* vector */
@@ -1987,7 +1956,7 @@ static int mxser_probe(struct pci_dev *pdev,
 	/* irq */
 	brd->irq = pdev->irq;
 
-	mxser_initbrd(brd);
+	mxser_initbrd(brd, ent->driver_data & MXSER_HIGHBAUD);
 
 	retval = devm_request_irq(&pdev->dev, brd->irq, mxser_interrupt,
 			IRQF_SHARED, "mxser", brd);
@@ -1996,7 +1965,7 @@ static int mxser_probe(struct pci_dev *pdev,
 		goto err_relbrd;
 	}
 
-	for (i = 0; i < brd->info->nports; i++) {
+	for (i = 0; i < nports; i++) {
 		tty_dev = tty_port_register_device(&brd->ports[i].port,
 				mxvar_sdriver, brd->idx + i, &pdev->dev);
 		if (IS_ERR(tty_dev)) {
@@ -2012,10 +1981,10 @@ static int mxser_probe(struct pci_dev *pdev,
 
 	return 0;
 err_relbrd:
-	for (i = 0; i < brd->info->nports; i++)
+	for (i = 0; i < nports; i++)
 		tty_port_destroy(&brd->ports[i].port);
 err_zero:
-	brd->info = NULL;
+	brd->nports = 0;
 err:
 	return retval;
 }
@@ -2025,12 +1994,12 @@ static void mxser_remove(struct pci_dev *pdev)
 	struct mxser_board *brd = pci_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < brd->info->nports; i++) {
+	for (i = 0; i < brd->nports; i++) {
 		tty_unregister_device(mxvar_sdriver, brd->idx + i);
 		tty_port_destroy(&brd->ports[i].port);
 	}
 
-	brd->info = NULL;
+	brd->nports = 0;
 }
 
 static struct pci_driver mxser_driver = {
-- 
2.32.0

