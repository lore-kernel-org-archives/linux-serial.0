Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082928B4FA
	for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064736; cv=none; b=ZjX/37+MhpBebt82DDB3ITKgpSfnjr6s2/KNWjkh5Sa70cyU3/86T+53otyiTgMtYIuId6sXM+RGM3FAFbNWB1p9FNA2kxUiZjFls8Rc91DM9Yr5+IlLu6JbVUeyOYsJJiZLptKCkCS4HG2/J0Pqk/w/AW3McL7mgo0Z38CHPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064736; c=relaxed/simple;
	bh=YlBcOTGkdAEX8Hb8Nsp6yCVp/3IlH3e/AnJneSIAzT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gPXgxfglDTUhifI49hgcTjtl/ePZd4wkj3jJ588p7xdgCNNpiwG+yKxPC97fimek6m1dJAWYdMro+bRUjMqLTStkMvfaNMs9X5Ih1UqDHiDGLyU0U9aNu0X6BGk4p1bJ6LGdqn8WlnFS5h6e/qra8IK7Y1h46ONm4v7vrBVqmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6s1bwa7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6s1bwa7"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a10d130b37so8248674e87.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Apr 2026 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777064733; x=1777669533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCYOgbfLBl2ffEEwC7jRGzDfvZV5p4y0B5VEInrpIEk=;
        b=I6s1bwa7a4WjiHjC2Rr4W6q09ubWwcfMv8sNdF9DW9nHjauggn+WeXaaIjLgZh6wGz
         himlNIuyy93gRW8RRxqmK+w16UnivKDr0G5dzfYm2/yeU+3wIydutzgXf8/MiGNuNWz1
         3MLXtF3Zo2H6TPjxY+aKC9aLAi9vs6Ga4Xh1s7M99PrcPd4cSGBrRhV/ktskE7PHkOJI
         2Z3EE0V8XXw1nqyTNlv0WXihvjiH6d92eDv7/lI7vWqsfbWcKRlWVkcy8kd+zDTs5qWr
         D2Nzq1EsBLPxCFLSfy6JJ0FOc9p3F33Tv/ag8+9og/hBSENQM4C5JOhFX0/aLzW0G4Wi
         FJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064733; x=1777669533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCYOgbfLBl2ffEEwC7jRGzDfvZV5p4y0B5VEInrpIEk=;
        b=IoMng9WYNK7fducsWbqMvaOYjjIAtV+O/dJkt0sKbtS+NAxhqfw/Y3JdGwBnC5f5MZ
         c6HQppJvZuENE0lVt6lw4Z+/yyS8lwoXxaQC9ozsFboQ5p88nodj6PNbnD45YlPnaha3
         DAYOUhLqpO1bEb5BvT88SpIgHUScx0GgquaBbMRGGI8L7JFGI9z8MSPbP4xOp9OPyBxL
         kKm0D6Yc2MDLiU+PgeG5ZCLnHVmhCzlLERd9Two3OCo/KkKRjRFK988Q9L2CsMdmImqf
         9Zmbfme2H1hvKhpxdaJhTK+WqGPB6wxLCtnQJ9XWH3La6gb0chL2ZmW4ufpHfmuWym+V
         Zwlg==
X-Forwarded-Encrypted: i=1; AFNElJ9beKR0RDyVgTU0Rpc5lOVdmcTGRiAYSY4XdiA1YjjS82jimn1zJsP6Wz1yETkupwDbbkubj9A0omruSm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzta5EymuHBfHxba3YwjvnAR9/eWiBrhiwst1k/Tzb7rP1LHtfk
	W1CctaL/iSQZbOOlO4/dBDoFBWyswUWvcSqZNC0fsuCsZmKJ3fbi9ERLmEQ5Ow==
X-Gm-Gg: AeBDiet3PW9tSNS7P8D2WMQ2r/rqItkHVwS0xLt6rdKd6DMJwII3yJhb4zdDN6u7HbB
	EHp6uD9uU/bJHGZmsprVsCpF4fGEBHUYu+367Qh7ZdM4jv8cfCK2hwP1ju/CkeIJv6L+l2agaok
	b/YNJXeySWAhaB/HLops7K8C5gSJSNM/TevIY/LPZ9gBdLqDiMpez0xPWlFnMuHXy3HhPL987Yq
	eVdQtUqKlSNsgmh4b2RcxaYc06QKzw45dPTHKmoTY1JdsffMNR0Zjaf42JXuxH08kICK3ppioei
	qQGdDluDnyCOmAubnTAQ7tI5VaTdHn8Vf4dwowhwokaz5qAIqD7nV8+NRXx8pRnS6iL8rIzAXWj
	d4g/MBrmbn7VVy7NZ3hSpl0MQOx2hHTFBAtbnKVcyuyOuO/+dsyfT/UatXqQKiNa8y2r8fBF+Pn
	s7AnLBJ26EHty0Ye+fwQbwrKmBA51vdCC2Q9V6+mzAbLl72Hha04E=
X-Received: by 2002:a05:6512:3b0c:b0:5a3:e87a:3ea8 with SMTP id 2adb3069b0e04-5a41716da76mr10666181e87.2.1777064732678;
        Fri, 24 Apr 2026 14:05:32 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad12asm6379218e87.1.2026.04.24.14.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:05:32 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: sashal@kernel.org,
	miquel.raynal@bootlin.com,
	phil.edworthy@renesas.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: Clean up register macros and error handling
Date: Sat, 25 Apr 2026 00:05:24 +0300
Message-ID: <20260424210525.1574497-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Align register offset definitions for DW_UART_USR, DW_UART_DMASA,
OCTEON_UART_USR, RZN1_UART_TDMACR and RZN1_UART_RDMACR to improve
readability. Replace raw shift with FIELD_PREP() and GENMASK() for
RZN1_UART_xDMACR burst field definitions — this documents that the
field occupies bits [2:1] and prevents accidental overflow when new
burst values are added.

Simplify ENXIO handling in dw8250_probe(): instead of explicitly
zeroing 'err' and then checking it, use a single conditional that
allows -ENXIO (no interrupt, fall back to polling) while treating
any other error as fatal. No functional change intended.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hi,

This small cleanup patch addresses a few minor style and robustness
issues I noticed while working with the driver.

Thank you.

--
Regards,
Artem

 drivers/tty/serial/8250/8250_dw.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94beadb4024d..3e7b79154d9d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -35,13 +35,13 @@
 #include "8250_dwlib.h"
 
 /* Offsets for the DesignWare specific registers */
-#define DW_UART_USR	0x1f /* UART Status Register */
-#define DW_UART_DMASA	0xa8 /* DMA Software Ack */
+#define DW_UART_USR			0x1f /* UART Status Register */
+#define DW_UART_DMASA			0xa8 /* DMA Software Ack */
 
-#define OCTEON_UART_USR	0x27 /* UART Status Register */
+#define OCTEON_UART_USR			0x27 /* UART Status Register */
 
-#define RZN1_UART_TDMACR 0x10c /* DMA Control Register Transmit Mode */
-#define RZN1_UART_RDMACR 0x110 /* DMA Control Register Receive Mode */
+#define RZN1_UART_TDMACR		0x10c /* DMA Control Register Transmit Mode */
+#define RZN1_UART_RDMACR		0x110 /* DMA Control Register Receive Mode */
 
 /* DesignWare specific register fields */
 #define DW_UART_IIR_IID			GENMASK(3, 0)
@@ -52,9 +52,10 @@
 
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN		BIT(0)
-#define RZN1_UART_xDMACR_1_WORD_BURST	(0 << 1)
-#define RZN1_UART_xDMACR_4_WORD_BURST	(1 << 1)
-#define RZN1_UART_xDMACR_8_WORD_BURST	(2 << 1)
+#define RZN1_UART_xDMACR_BURST_MASK	GENMASK(2, 1)
+#define RZN1_UART_xDMACR_1_WORD_BURST	FIELD_PREP(RZN1_UART_xDMACR_BURST_MASK, 0)
+#define RZN1_UART_xDMACR_4_WORD_BURST	FIELD_PREP(RZN1_UART_xDMACR_BURST_MASK, 1)
+#define RZN1_UART_xDMACR_8_WORD_BURST	FIELD_PREP(RZN1_UART_xDMACR_BURST_MASK, 2)
 #define RZN1_UART_xDMACR_BLK_SZ(x)	((x) << 3)
 
 /* Quirks */
@@ -729,9 +730,7 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	err = uart_read_port_properties(p);
 	/* no interrupt -> fall back to polling */
-	if (err == -ENXIO)
-		err = 0;
-	if (err)
+	if (err && err != -ENXIO)
 		return err;
 
 	switch (p->iotype) {
-- 
2.43.0

