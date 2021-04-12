Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFABFC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 03:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8429161209
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 03:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhDLDrz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 11 Apr 2021 23:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbhDLDrx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 11 Apr 2021 23:47:53 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F85C061574;
        Sun, 11 Apr 2021 20:47:32 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 84736690;
        Sun, 11 Apr 2021 20:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1618199252;
        bh=fvG+KhGr56hUUimTU+sIx4n7YvDI7UPAddjCieqejpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njJTMX/KmoKkVAeUPHntoS+o7bdvrqN+M/JrYaMRLZvG0M4hhEJAyuQbDTdEm4/0x
         fkLEwDJYOgoGpO1PpR+BxaIyRV2k/GsbMpNl243A3KzZtngu2yRsgps9zT9gUF9tDP
         yP9ZNZyv0UWmKLq0No2pazYEkPVafxa4/DYazbmc=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH v6 2/4] serial: 8250_aspeed_vuart: refactor sirq and lpc address setting code
Date:   Sun, 11 Apr 2021 22:47:10 -0500
Message-Id: <20210412034712.16778-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412034712.16778-1-zev@bewilderbeest.net>
References: <20210412034712.16778-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
out of the sysfs store functions in preparation for adding DT
properties that will be poking the same registers.  While we're at it,
these functions now provide some basic bounds-checking on their
arguments.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 51 ++++++++++++++-------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index c33e02cbde93..8433f8dbb186 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -72,22 +72,31 @@ static ssize_t lpc_address_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
 }
 
+static int aspeed_vuart_set_lpc_address(struct aspeed_vuart *vuart, u32 addr)
+{
+	if (addr > U16_MAX)
+		return -EINVAL;
+
+	writeb(addr >> 8, vuart->regs + ASPEED_VUART_ADDRH);
+	writeb(addr >> 0, vuart->regs + ASPEED_VUART_ADDRL);
+
+	return 0;
+}
+
 static ssize_t lpc_address_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
 {
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
-	unsigned long val;
+	u32 val;
 	int err;
 
-	err = kstrtoul(buf, 0, &val);
+	err = kstrtou32(buf, 0, &val);
 	if (err)
 		return err;
 
-	writeb(val >> 8, vuart->regs + ASPEED_VUART_ADDRH);
-	writeb(val >> 0, vuart->regs + ASPEED_VUART_ADDRL);
-
-	return count;
+	err = aspeed_vuart_set_lpc_address(vuart, val);
+	return err ? : count;
 }
 
 static DEVICE_ATTR_RW(lpc_address);
@@ -105,27 +114,37 @@ static ssize_t sirq_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
 }
 
+static int aspeed_vuart_set_sirq(struct aspeed_vuart *vuart, u32 sirq)
+{
+	u8 reg;
+
+	if (sirq > (ASPEED_VUART_GCRB_HOST_SIRQ_MASK >> ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT))
+		return -EINVAL;
+
+	sirq <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
+	sirq &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
+
+	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
+	reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
+	reg |= sirq;
+	writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
+
+	return 0;
+}
+
 static ssize_t sirq_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct aspeed_vuart *vuart = dev_get_drvdata(dev);
 	unsigned long val;
 	int err;
-	u8 reg;
 
 	err = kstrtoul(buf, 0, &val);
 	if (err)
 		return err;
 
-	val <<= ASPEED_VUART_GCRB_HOST_SIRQ_SHIFT;
-	val &= ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
-
-	reg = readb(vuart->regs + ASPEED_VUART_GCRB);
-	reg &= ~ASPEED_VUART_GCRB_HOST_SIRQ_MASK;
-	reg |= val;
-	writeb(reg, vuart->regs + ASPEED_VUART_GCRB);
-
-	return count;
+	err = aspeed_vuart_set_sirq(vuart, val);
+	return err ? : count;
 }
 
 static DEVICE_ATTR_RW(sirq);
-- 
2.31.1

