Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110B436377
	for <linux-serial@vger.kernel.org>; Wed,  8 Jul 2026 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509488; cv=none; b=LwR8BAzR2+M0q4Ki/UjGf2Gyb7DYDLEJZb4QQGgsHGukal2SKknMcnoDt1/kbwOHk+u4kgwiSYcd6d8bC1XmRnV13+S94PlzUmBM1mgyj/EGozNppRCXyX2C3U8xYqT6zgyDZTUBMeWjf6/mpBlT1/gaOXdSzUlkaaVO57nncNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509488; c=relaxed/simple;
	bh=UUW8FDjbH++M+5cnKYL0HCr0Tn0/mkah5SLd+++eEF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bht+hXIUg4iWQZqMx5spafLMkH6vLxtL4kB6RgMMTKcKFeG04KjAGPHaj/iM1JJUZNEntZ80RpnusAIQ4PccxTia8qzf+Cgyva7uAIH+BIiXFGR1e9JQxdpBr/oDiJuJdt4fzF7ihFRtJXjSp/EOWO5yu7c3v+VV646INmRheQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NPk8KZAp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NPk8KZAp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so5834365e9.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783509481; x=1784114281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9h4E8fzpkUKefQYXbM+5aTJxB/wkrGJJdLAlPHgwa7A=;
        b=NPk8KZAp97H8/rl5880gWadTickFoCGeJgwHQmRpVwXb2XLv2k/EB6WsEXkVKR8lyO
         AyC1kjjBl3Hturd+YZ3WLSftR+3L0vuJJhy0xQfacg5nGk28+nXgdx9d9b2PDAVOrfFH
         wkfNAj/zi4T3jahS+bvuNF+LF1G/5rKVedijmXS52W1IYAzqQASY9/p3q5Jbm6nB/loN
         huRn4Y2iZPHgicSbVNB96dcJCicXv+Y3/3nP2I2m1cQx93aD1G0eg5PgrE42HpD88sQ4
         G2uyit/V2WIjfd4jboICHBeLj0dzryX8euXa4VHj9VSPUunkYoBtzjV7d986+fQwchYo
         y+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509481; x=1784114281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9h4E8fzpkUKefQYXbM+5aTJxB/wkrGJJdLAlPHgwa7A=;
        b=qPxWd++csJBTK1dzST+fh4UhEEk6IyqHsMZHtkKdMhjnTW4XXL1j3z1NujjTIPyS6g
         URnbWgnpTZ5+dOBKYVsQOZQFWJVu7JxZdiHlZ15aVmyHjF17pjSL2iWB4AcjsLjy8qzq
         +UZlSQ/r7EMzTCEyDtUR4BgzQwsDybGCEY/cSfXn6UVQ3MAFDuY37VvQQX2wajANniMQ
         BetwTMXHGMddpJkaWL0uVcWoKXhSiwH11EEEjUmD6RrnpLXrSHeUVHNGYiBDcxeb3Yop
         dU1IH9SwWkBycjzMmz/5gaW6F8p1ehr+a0+2js1DWrQkw/IOX7jpxq5LR+yXwRQhEK4M
         Jg0w==
X-Forwarded-Encrypted: i=1; AHgh+RotVqjOrCY6rM/V9B3akx8XSvrX6UNxwCEda4BZXIv/ffWMe3NBv0ZOiqTUEmXJe2oowECGjGcDDAmzgRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xkvF3xALpo7BjX/s5jzsdjP7fr8j1r7dt71aAiHMHQSxxgJE
	Eh95qG9PBbFHMSzRA00qzxzAH5N7nHBJ3Cd9r7aqhhDZFOqXtQ3JWVMoDVUMe0wGLF8=
X-Gm-Gg: AfdE7clFmcCSPStuLfBfASAFqgUowayGrPc4YC4b4t1tb8QlNm609vDzOFjlOGUZ3+4
	V8kqpTvmeQSbeXxTNVQ9o2on7kv4sQTI5WLo7kE6QDw1tc79nHHjOUwzPp3ghYG6orlIbKIISGe
	hf9yMUD7qjzgQD/iwNcKCpQ185GkCnNJ9lTPMS++rkLT+PxAzaluRA9Qd93rWzAmAvcQyjmv8+s
	okS7XZ0uLfPsBem74KNL2I0wRIJ/zyVngl1tZhPvpPh7iRGVJxokGpkGa+/lj/gXnA343GQ9Btb
	UOkan6gpy0Hhy9WXxNs6iIzpACcOQRd+OxPHV+KaThuf9pwZCl5o2sklApqb45Gw6fPffnzFoC2
	gKv/vq8HzCS6DUauvIYqQijU9XSq+S4ZlEV8QJ77LDfcXIDdo5C1w1JAMlW7r04cOfCm0osS2hz
	8tpRy7fS/96VmW8b2CCZukh5nVbbzewp6bnIgQ3jc7k068Xwz3yy1JIoR9URcF/2Tl8u+UX145r
	5ceKTWsPnkqsKHvvg==
X-Received: by 2002:a05:600c:a55:b0:490:469c:556b with SMTP id 5b1f17b1804b1-493e68bef13mr21155325e9.12.1783509481596;
        Wed, 08 Jul 2026 04:18:01 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (host-79-16-115-126.retail.telecomitalia.it. [79.16.115.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm37867694f8f.31.2026.07.08.04.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:18:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 08 Jul 2026 13:17:41 +0200
Subject: [PATCH 2/2] serial: 8250_mtk: honor DT serial aliases
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ccaione-genio-serial-aliases-v1-2-bf22229e9383@baylibre.com>
References: <20260708-ccaione-genio-serial-aliases-v1-0-bf22229e9383@baylibre.com>
In-Reply-To: <20260708-ccaione-genio-serial-aliases-v1-0-bf22229e9383@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2

The Genio board DTs provide serial aliases for all enabled UARTs, but
the MTK 8250 driver still registered every port with the default line
number. If uart0 deferred and another UART probed first, the 8250 core
could still assign ttyS0 to the wrong port despite the DT aliases.

Read the serial alias during OF probe and seed uart.port.line before
registering the port so the 8250 core reserves the requested ttyS slot.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index e6a56cf54ae0..841d64f6a707 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
@@ -521,7 +522,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 	struct uart_8250_port uart = {};
 	struct mtk8250_data *data;
 	struct resource *regs;
-	int irq, err;
+	int irq, err, line;
 	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
@@ -575,6 +576,10 @@ static int mtk8250_probe(struct platform_device *pdev)
 #endif
 
 	if (is_of_node(fwnode)) {
+		line = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (line >= 0)
+			uart.port.line = line;
+
 		/* Disable Rate Fix function */
 		writel(0x0, uart.port.membase +
 			(MTK_UART_RATE_FIX << uart.port.regshift));

-- 
2.55.0

