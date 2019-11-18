Return-Path: <SRS0=fJeH=ZK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D70C43215
	for <linux-serial@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81BA20878
	for <linux-serial@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QnjQ3VWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKRLYR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52325 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKRLYQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id l1so16932927wme.2
        for <linux-serial@vger.kernel.org>; Mon, 18 Nov 2019 03:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxOc+VLC43HvcGUQEhtnARm5XJC9SvDuTVy7GLZ6cO4=;
        b=QnjQ3VWOrv5PqpLTTONtUNJkMMdER+gYHmgfEkx7i09mBONlZmA/0Ghuyr0aUYP2aW
         U/YgU7RU58BAa2/IkpVvBi2Xo/SAIQz1EbXkWqySpqdTAvpMhouJioJsdRg9KS90UVZT
         r1jJf3H4VJblOarFcnmE8ZmwCSBWDu2Gj5Z+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxOc+VLC43HvcGUQEhtnARm5XJC9SvDuTVy7GLZ6cO4=;
        b=AIDtW9EONz7/1nS4PsFWrFUVx2zjEj0hn3JfgZ4F/klHIP1+6cyc70FFqocKVXAIzv
         D/4AI/lAftQLDhmKRidWfOhzO2X1YtG//TCF6iurTjibE2MU/HynsiSNOIzETkJZjUUM
         Gof5jap8xS7tngHVc5fDtcjjES2IKt45IjDXOMVjrzL1YAY9bErNE6l8xdExizb/sItc
         tquozwtFsgDE/QCh4uwfZhI7J/5dHfNlpCMzapxId8fZ7z+tV9NuEEjSBgb0fIRlLo49
         Qv60NUYEYZRdjBLZz6XdDTU227DdKsK1xhqDO10vRdzN8ERFUdyCLTJYgK3hBa+3snNi
         Mpbw==
X-Gm-Message-State: APjAAAWx+oA6mOx4I819Vz3mBtNLow57tOIsjqC3Xgo1PrOo6+EYEUAY
        SK3Ir/3lmhhXeh9FSj4t8qFyOQ==
X-Google-Smtp-Source: APXvYqx/ho3Ljxs26hkLbFmc2D6E11Ax3AsxH25Z1dc5EmTrLZlpwCsYbpXxWXFX6Gb+7ZDImZlg0A==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr28612250wmn.171.1574076254260;
        Mon, 18 Nov 2019 03:24:14 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:12 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 32/48] serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
Date:   Mon, 18 Nov 2019 12:23:08 +0100
Message-Id: <20191118112324.22725-33-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For this to work correctly on little-endian hosts, don't access the
device-tree properties directly in native endianness, but use the
of_property_read_u32() helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 36 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 313697842e24..c055abf4c919 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1256,10 +1256,10 @@ static int soft_uart_init(struct platform_device *ofdev)
 static int ucc_uart_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-	const unsigned int *iprop;      /* Integer OF properties */
 	const char *sprop;      /* String OF properties */
 	struct uart_qe_port *qe_port = NULL;
 	struct resource res;
+	u32 val;
 	int ret;
 
 	/*
@@ -1290,23 +1290,20 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 
 	/* Get the UCC number (device ID) */
 	/* UCCs are numbered 1-7 */
-	iprop = of_get_property(np, "cell-index", NULL);
-	if (!iprop) {
-		iprop = of_get_property(np, "device-id", NULL);
-		if (!iprop) {
-			dev_err(&ofdev->dev, "UCC is unspecified in "
-				"device tree\n");
+	if (of_property_read_u32(np, "cell-index", &val)) {
+		if (of_property_read_u32(np, "device-id", &val)) {
+			dev_err(&ofdev->dev, "UCC is unspecified in device tree\n");
 			ret = -EINVAL;
 			goto out_free;
 		}
 	}
 
-	if ((*iprop < 1) || (*iprop > UCC_MAX_NUM)) {
-		dev_err(&ofdev->dev, "no support for UCC%u\n", *iprop);
+	if (val < 1 || val > UCC_MAX_NUM) {
+		dev_err(&ofdev->dev, "no support for UCC%u\n", val);
 		ret = -ENODEV;
 		goto out_free;
 	}
-	qe_port->ucc_num = *iprop - 1;
+	qe_port->ucc_num = val - 1;
 
 	/*
 	 * In the future, we should not require the BRG to be specified in the
@@ -1350,13 +1347,12 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	}
 
 	/* Get the port number, numbered 0-3 */
-	iprop = of_get_property(np, "port-number", NULL);
-	if (!iprop) {
+	if (of_property_read_u32(np, "port-number", &val)) {
 		dev_err(&ofdev->dev, "missing port-number in device tree\n");
 		ret = -EINVAL;
 		goto out_free;
 	}
-	qe_port->port.line = *iprop;
+	qe_port->port.line = val;
 	if (qe_port->port.line >= UCC_MAX_UART) {
 		dev_err(&ofdev->dev, "port-number must be 0-%u\n",
 			UCC_MAX_UART - 1);
@@ -1386,31 +1382,29 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		}
 	}
 
-	iprop = of_get_property(np, "brg-frequency", NULL);
-	if (!iprop) {
+	if (of_property_read_u32(np, "brg-frequency", &val)) {
 		dev_err(&ofdev->dev,
 		       "missing brg-frequency in device tree\n");
 		ret = -EINVAL;
 		goto out_np;
 	}
 
-	if (*iprop)
-		qe_port->port.uartclk = *iprop;
+	if (val)
+		qe_port->port.uartclk = val;
 	else {
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
 		 * half the QE bus frequency.
 		 */
-		iprop = of_get_property(np, "bus-frequency", NULL);
-		if (!iprop) {
+		if (of_property_read_u32(np, "bus-frequency", &val)) {
 			dev_err(&ofdev->dev,
 				"missing QE bus-frequency in device tree\n");
 			ret = -EINVAL;
 			goto out_np;
 		}
-		if (*iprop)
-			qe_port->port.uartclk = *iprop / 2;
+		if (val)
+			qe_port->port.uartclk = val / 2;
 		else {
 			dev_err(&ofdev->dev,
 				"invalid QE bus-frequency in device tree\n");
-- 
2.23.0

