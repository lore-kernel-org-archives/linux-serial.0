Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38881C04A6B
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 15:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjITPUd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjITPUa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 11:20:30 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E1A3;
        Wed, 20 Sep 2023 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=r8HOyZrFylpADN6kIAcsYM4Dj9Wj63S1uN+Rn+MZbHU=; b=qChrI1ssVNXGOANauihMgDmiJR
        40kdHfuVJaerR3Bj1PgbADwQXjm517yN/tQU7VyRf09dAwZ5i4FZqIonDgvKf8wjKw5KXMcKvP4E6
        4j/7HuqMMHD5jJq3RG1IeSVg54KXEb0EVlDmIqFG8SLfeXDJfZ9tOxGSrz+UJBwXfkoY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43190 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qiyzz-0008Co-Hk; Wed, 20 Sep 2023 11:20:20 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Wed, 20 Sep 2023 11:20:13 -0400
Message-Id: <20230920152015.1376838-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230920152015.1376838-1-hugo@hugovil.com>
References: <20230920152015.1376838-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 2/4] serial: sc16is7xx: recognize "nxp,irda-mode-ports" DT property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Vendor prefix "nxp," will be added in an upcoming commit to DT binding
property "irda-mode-ports".

Prepare to recognize this new property "nxp,irda-mode-ports" and
retain backward compatibility with old DTBs by falling back to
"irda-mode-ports" when needed.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index db2bb1c0d36c..b0154e901358 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1415,13 +1415,19 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 	int count;
 	u32 irda_port[2];
 	struct device *dev = s->p[0].port.dev;
+	const char *prop_name = "nxp,irda-mode-ports";
+
+	count = device_property_count_u32(dev, prop_name);
+	if (count < 0) {
+		/* For backward compatibility with old DTBs. */
+		prop_name = "irda-mode-ports";
+		count = device_property_count_u32(dev, prop_name);
+	}
 
-	count = device_property_count_u32(dev, "irda-mode-ports");
 	if (count < 0 || count > ARRAY_SIZE(irda_port))
 		return;
 
-	ret = device_property_read_u32_array(dev, "irda-mode-ports",
-					     irda_port, count);
+	ret = device_property_read_u32_array(dev, prop_name, irda_port, count);
 	if (ret)
 		return;
 
-- 
2.30.2

