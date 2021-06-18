Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C4C49EA5
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB48A611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhFRGRm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46158 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhFRGR2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6A83B1FDFE;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JapVV+Ep14EY9iMIxDFMI3xj74/EpUEBsvVrve3HFy0=;
        b=FHeNiwqAu2gO7W3qeDRdSdJyMsKbLzAwfaon6zi4vFfFTIUI07LQJaOhRdsoTHxqpLuc3X
        ziHdf7Z21vwJqbYPmu2Nw3kEjNYurR4mVWP857oK8WIuCp0UOmMSTcd/Ux4yueKDRG7JJY
        CmsyNNXKJpSvXt3iNknTHh5Bmcv+aaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JapVV+Ep14EY9iMIxDFMI3xj74/EpUEBsvVrve3HFy0=;
        b=bujUTYGMM5WhdDFFHlF0euSKe6rkfjhkDHV8TMKLeJxrTZZczda/98g26dImCnL5pIF8l4
        EtAI0HjfghCTU6BA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45566A3B99;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/70] mxser: rename CheckIsMoxaMust to mxser_get_must_hwid
Date:   Fri, 18 Jun 2021 08:14:12 +0200
Message-Id: <20210618061516.662-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

CheckIsMoxaMust actually finds out what the card is. So rename it to
mxser_must_get_hwid, so that the name conforms to the semantics of the
function.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 3b3f0da9ea64..72e1aeabdee7 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -583,7 +583,7 @@ static void mxser_disable_must_rx_software_flow_control(unsigned long baseio)
 	outb(oldlcr, baseio + UART_LCR);
 }
 
-static int CheckIsMoxaMust(unsigned long io)
+static int mxser_must_get_hwid(unsigned long io)
 {
 	u8 oldmcr, hwid;
 	int i;
@@ -2452,7 +2452,7 @@ static int mxser_probe(struct pci_dev *pdev,
 	/* irq */
 	brd->irq = pdev->irq;
 
-	brd->chip_flag = CheckIsMoxaMust(brd->ports[0].ioaddr);
+	brd->chip_flag = mxser_must_get_hwid(brd->ports[0].ioaddr);
 	brd->uart_type = PORT_16550A;
 	brd->vector_mask = 0;
 
-- 
2.32.0

