Return-Path: <SRS0=lGjV=7D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291EDC433E4
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E952070A
	for <linux-serial@archiver.kernel.org>; Thu, 21 May 2020 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgEUJMG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 May 2020 05:12:06 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:59214 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbgEUJMG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 May 2020 05:12:06 -0400
Received: from zenbar.fritz.box (pd95ef28a.dip0.t-ipconnect.de [217.94.242.138])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 5E93040BCCF;
        Thu, 21 May 2020 09:09:06 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        jringle@gridpoint.com, m.brock@vanmierlo.com,
        pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 6/6] sc16is7xx: Read the LSR register for basic device presence check
Date:   Thu, 21 May 2020 11:11:52 +0200
Message-Id: <20200521091152.404404-7-daniel@zonque.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091152.404404-1-daniel@zonque.org>
References: <20200521091152.404404-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently, the driver probes just fine and binds all its resources even
if the physical device is not present.

As the device lacks an identification register, let's at least read the
LSR register to check whether a device at the configured address responds
to the request at all.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/tty/serial/sc16is7xx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7e2360f8e393..5e84ed5938af 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1181,6 +1181,7 @@ static int sc16is7xx_probe(struct device *dev,
 {
 	struct sched_param sched_param = { .sched_priority = MAX_RT_PRIO / 2 };
 	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
+	unsigned int val;
 	u32 uartclk = 0;
 	int i, ret;
 	struct sc16is7xx_port *s;
@@ -1188,6 +1189,16 @@ static int sc16is7xx_probe(struct device *dev,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	/*
+	 * This device does not have an identification register that would
+	 * tell us if we are really connected to the correct device.
+	 * The best we can do is to check if communication is at all possible.
+	 */
+	ret = regmap_read(regmap,
+			  SC16IS7XX_LSR_REG << SC16IS7XX_REG_SHIFT, &val);
+	if (ret < 0)
+		return ret;
+
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
 	if (!s) {
-- 
2.26.2

