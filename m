Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31431C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180E260FDC
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhFRGSi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhFRGRt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02A2E21B67;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGMD3H2lAY5hTmQAamXpl3LCnLNkoyWme0TfBd7R0J8=;
        b=FXnIuhCMO9YC1uFqGae2hetjH0P1x8WFAbj9OgrYUw/9w4Sk1eXBx09EwxrmvQs9/6lLEL
        vnsZ1FapK/Vc4j2c23IAIK7Iyqus+n0W1vCeue/k+xOt/I2mELxAKKbU95PehxRbCtJPWE
        wU6hvtw2tyjCkdh/ZvTF5XtuJWZoyzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGMD3H2lAY5hTmQAamXpl3LCnLNkoyWme0TfBd7R0J8=;
        b=FgfLzAnPMFLkx70Uu3gGPCPmjmSb4klQGyrbea6apUQerXKwHk1dkAVMeH7/ZQ0l7p9hJ0
        YbpI9Ig2RXJAGAAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CFB3EA3B9D;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 46/70] mxser: move request irq to probe and switch to managed
Date:   Fri, 18 Jun 2021 08:14:52 +0200
Message-Id: <20210618061516.662-47-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Move request_irq from mxser_initbrd to mxser_probe so that we can switch
it to managed request. It simplifies the cleanup code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index be58ee025180..83c795acdb19 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1883,11 +1883,10 @@ static const struct tty_port_operations mxser_port_ops = {
  * The MOXA Smartio/Industio serial driver boot-time initialization code!
  */
 
-static int mxser_initbrd(struct mxser_board *brd)
+static void mxser_initbrd(struct mxser_board *brd)
 {
 	struct mxser_port *info;
 	unsigned int i;
-	int retval;
 	bool is_mu860;
 
 	brd->must_hwid = mxser_must_get_hwid(brd->ports[0].ioaddr);
@@ -1939,18 +1938,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 		outb(inb(info->ioaddr + UART_IER) & 0xf0,
 			info->ioaddr + UART_IER);
 	}
-
-	retval = request_irq(brd->irq, mxser_interrupt, IRQF_SHARED, "mxser",
-			brd);
-	if (retval) {
-		for (i = 0; i < brd->info->nports; i++)
-			tty_port_destroy(&brd->ports[i].port);
-		printk(KERN_ERR "Board %s: Request irq failed, IRQ (%d) may "
-			"conflict with another device.\n",
-			brd->info->name, brd->irq);
-	}
-
-	return retval;
 }
 
 static int mxser_probe(struct pci_dev *pdev,
@@ -2004,10 +1991,14 @@ static int mxser_probe(struct pci_dev *pdev,
 	/* irq */
 	brd->irq = pdev->irq;
 
-	/* mxser_initbrd will hook ISR. */
-	retval = mxser_initbrd(brd);
-	if (retval)
-		goto err_zero;
+	mxser_initbrd(brd);
+
+	retval = devm_request_irq(&pdev->dev, brd->irq, mxser_interrupt,
+			IRQF_SHARED, "mxser", brd);
+	if (retval) {
+		dev_err(&pdev->dev, "request irq failed");
+		goto err_relbrd;
+	}
 
 	for (i = 0; i < brd->info->nports; i++) {
 		tty_dev = tty_port_register_device(&brd->ports[i].port,
@@ -2027,7 +2018,6 @@ static int mxser_probe(struct pci_dev *pdev,
 err_relbrd:
 	for (i = 0; i < brd->info->nports; i++)
 		tty_port_destroy(&brd->ports[i].port);
-	free_irq(brd->irq, brd);
 err_zero:
 	brd->info = NULL;
 err:
@@ -2044,8 +2034,6 @@ static void mxser_remove(struct pci_dev *pdev)
 		tty_port_destroy(&brd->ports[i].port);
 	}
 
-	free_irq(brd->irq, brd);
-
 	brd->info = NULL;
 }
 
-- 
2.32.0

