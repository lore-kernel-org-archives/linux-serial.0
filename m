Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250DDC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 01:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B41613DE
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 01:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhEJBn5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 9 May 2021 21:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhEJBnw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 9 May 2021 21:43:52 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1DEC06138B;
        Sun,  9 May 2021 18:42:46 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B6D86500;
        Sun,  9 May 2021 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1620610966;
        bh=9BI4KzEc5P9h+jLSDHe3pKEvL0KLoXMseWebG6t328Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZVKVgOys2r+Jn2clKpXyO0wv7s5kFPPRMy+wbSr5U/ypvSfGb+Q2W4atukLWtL9w
         MCg3LTBnFnqrXeoFctt8Yh037/uFMhPwQj0L2aSwAMh078UFqcLtk6kgwOlvPC+KpD
         VIl2A0QiZhPEgQFDERIrp/Jb3XPYmBFhcdIObMhU=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openbmc@lists.ozlabs.org, Zev Weiss <zev@bewilderbeest.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] serial: 8250_aspeed_vuart: factor out aspeed_vuart_{read,write}b() helper functions
Date:   Sun,  9 May 2021 20:42:29 -0500
Message-Id: <20210510014231.647-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510014231.647-1-zev@bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a small prepatory step for changing the way this driver does
its I/O accesses.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 38 +++++++++++++--------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 61550f24a2d3..9e8b2e8e32b6 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -64,14 +64,24 @@ static const int unthrottle_timeout = HZ/10;
  * different system (though most of them use 3f8/4).
  */
 
+static inline u8 aspeed_vuart_readb(struct aspeed_vuart *vuart, u8 reg)
+{
+	return readb(vuart->regs + reg);
+}
+
+static inline void aspeed_vuart_writeb(struct aspeed_vuart *vuart, u8 val, u8 reg)
+{
+	writeb(val, vuart->regs + reg);
+}
+
 static ssize_t lpc_address_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
 	u16 addr;
 
-	addr = (readb(vuart->regs + ASPEED_VUART_ADDRH) << 8) |
-		(readb(vuart->regs + ASPEED_VUART_ADDRL));
+	addr = (aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRH) << 8) |
+		(aspeed_vuart_readb(vuart, ASPEED_VUART_ADDRL));
 
 	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
 }
@@ -81,8 +91,8 @@ static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
 	if (addr > U16_MAX)
 		return -EINVAL;
 
-	writeb(addr >> 8, vuart->regs + ASPEED_VUART_ADDRH);
-	writeb(addr >> 0, vuart->regs + ASPEED_VUART_ADDRL);
+	aspeed_vuart_writeb(vuart, addr >> 8, ASPEED_VUART_ADDRH);
+	aspeed_vuart_writeb(vuart, addr >> 0, ASPEED_VUART_ADDRL);
 
 	return 0;
 }
@@ -111,7 +121,7 @@ static ssize_t sirq_show(struct device *dev,
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
 	u8 reg;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRB);
 	reg &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg >>= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 
@@ -128,10 +138,10 @@ static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
 	sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
 	sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRB);
 	reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
 	reg |= sirq;
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRB);
 
 	return 0;
 }
@@ -159,7 +169,7 @@ static ssize_t sirq_polarity_show(struct device *dev,
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
 	u8 reg;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 	reg &= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
 	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg ? 1 : 0);
@@ -168,14 +178,14 @@ static ssize_t sirq_polarity_show(struct device *dev,
 static void aspeed_vuart_set_sirq_polarity(struct aspeed_vuart *vuart,
 					   bool polarity)
 {
-	u8 reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	u8 reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 
 	if (polarity)
 		reg |= ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 	else
 		reg &= ~ASPEED_VUART_GCRA_HOST_SIRQ_POLARITY;
 
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRA);
 }
 
 static ssize_t sirq_polarity_store(struct device *dev,
@@ -210,14 +220,14 @@ static const struct attribute_group aspeed_vuart_attr_group = {
 
 static void aspeed_vuart_set_enabled(struct aspeed_vuart *vuart, bool enabled)
 {
-	u8 reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	u8 reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 
 	if (enabled)
 		reg |= ASPEED_VUART_GCRA_VUART_EN;
 	else
 		reg &= ~ASPEED_VUART_GCRA_VUART_EN;
 
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRA);
 }
 
 static void aspeed_vuart_set_host_tx_discard(struct aspeed_vuart *vuart,
@@ -225,7 +235,7 @@ static void aspeed_vuart_set_host_tx_discard(struct aspeed_vuart *vuart,
 {
 	u8 reg;
 
-	reg = readb(vuart->regs + ASPEED_VUART_GCRA);
+	reg = aspeed_vuart_readb(vuart, ASPEED_VUART_GCRA);
 
 	/* If the DISABLE_HOST_TX_DISCARD bit is set, discard is disabled */
 	if (!discard)
@@ -233,7 +243,7 @@ static void aspeed_vuart_set_host_tx_discard(struct aspeed_vuart *vuart,
 	else
 		reg &= ~ASPEED_VUART_GCRA_DISABLE_HOST_TX_DISCARD;
 
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRA);
+	aspeed_vuart_writeb(vuart, reg, ASPEED_VUART_GCRA);
 }
 
 static int aspeed_vuart_startup(struct uart_port *uart_port)
-- 
2.31.1

