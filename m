Return-Path: <SRS0=lGjV=7D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8292C433E7
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7562070A
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgEUJMI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 May 2020 05:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgEUJMH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 05:12:07 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9DE3C061A0E;
        Thu, 21 May 2020 02:12:06 -0700 (PDT)
Received: from zenbar.fritz.box (pd95ef28a.dip0.t-ipconnect.de [217.94.242.138])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 47E7B40BCCC;
        Thu, 21 May 2020 09:09:05 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 5/6] sc16is7xx: Allow sharing the IRQ line
Date:   Thu, 21 May 2020 11:11:51 +0200
Message-Id: <20200521091152.404404-6-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091152.404404-1-daniel@zonque.org>
References: <20200521091152.404404-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When the interrupt line is shared with other devices, the IRQ must be
level-triggered, as only one device can trigger a falling edge. To support
this, try to acquire the IRQ with IRQF_TRIGGER_LOW|IRQF_SHARED first.

Interrupt controllers that lack support for level-triggers will return an
error, in which case the driver will now retry the acqusition with
IRQF_TRIGGER_FALLING, which was also the default before.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index cebc0cf9c30e..7e2360f8e393 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1313,7 +1313,19 @@ static int sc16is7xx_probe(struct device *dev,
 				s->p[u].irda_mode = true;
 	}
 
-	/* Setup interrupt */
+	/*
+	 * Setup interrupt. We first try to acquire the IRQ line as level IRQ.
+	 * If that succeeds, we can allow sharing the interrupt as well.
+	 * In case the interrupt controller doesn't support that, we fall
+	 * back to a non-shared falling-edge trigger.
+	 */
+	ret = devm_request_threaded_irq(dev, irq, NULL, sc16is7xx_irq,
+					IRQF_TRIGGER_LOW | IRQF_SHARED |
+					IRQF_ONESHOT,
+					dev_name(dev), s);
+	if (!ret)
+		return 0;
+
 	ret = devm_request_threaded_irq(dev, irq, NULL, sc16is7xx_irq,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					dev_name(dev), s);
-- 
2.26.2

