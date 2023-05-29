Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5338BC7EE29
	for <linux-serial@archiver.kernel.org>; Mon, 29 May 2023 14:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjE2OHf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 May 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjE2OHe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 May 2023 10:07:34 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C20A8;
        Mon, 29 May 2023 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j06j0xxAnTBWbm+RR07Ahwjb4COk2ZLwxArCeTG3Zrw=; b=FK/zyz5jag1Oy1osJK5trnHLQv
        131njOxu9Pw+MPoeXBq0qYCpBW3PXRcd9e3Z7NCv0VsWNC9MrLGzudi2cHD7qRONDOyFDp2Lgahi+
        rP0ZOWekuepnjJtBIoqi+RyJczMdAHsE+EFprDPI1j0coDhQuM3JjfusJ/6WK/kzo8vI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:50024 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q3dWq-0004Ht-Gu; Mon, 29 May 2023 10:07:21 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Mon, 29 May 2023 10:07:04 -0400
Message-Id: <20230529140711.896830-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230529140711.896830-1-hugo@hugovil.com>
References: <20230529140711.896830-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH v4 2/9] serial: sc16is7xx: add post reset delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Make sure we wait at least 3us before initiating communication with
the device after reset.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index fbaadec557d8..24c9336f6ab2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1428,6 +1428,12 @@ static int sc16is7xx_probe(struct device *dev,
 	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
 
+	/*
+	 * After reset, the host must wait at least 3us before initializing a
+	 * communication with the device.
+	 */
+	usleep_range(5, 10);
+
 	for (i = 0; i < devtype->nr_uart; ++i) {
 		s->p[i].line		= i;
 		/* Initialize port data */
-- 
2.30.2

