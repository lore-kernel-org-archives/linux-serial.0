Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7114CDED
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661139; cv=none; b=ghIqmWmXL24M+qEaDC0hGxmQwTeV/jeVunBMDF22aUhy7si6NaTczfbk4MNPRguxiag03scVyvgrpGUJfN9mFpJqf1jOc0jq84eEXGkPapNq8rmFcFzcFdASegmVhV2KYBI24kPzCS15QlQcswY0x1iI9R1iSHQFb0KX6TNekzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661139; c=relaxed/simple;
	bh=F0EgC+aY2d9D0s9EMXRvXW6DwtHatOTbMqQA3afuWrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCZzhYS6IFWFCtR/KpnWZgx/7sBlfRBe0Dko4NM2Ey8v4dTCT8sk4VS6t/dCIVKnL/R7rl+p/JN5OoV6mBDmBJ17T2SJkbYhCkkSt6flUt58f4BiljNiUEB1BaejFT/a5vaJGZWVUVuGoQqzGxzhQKlKCE3E3DpfxLCZ+hv0STc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oFC2hLrK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFC2hLrK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76626170so6697595e9.2
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661135; x=1706265935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLdYk7lMN8S67k1ZA1qBwWGzOiN17GG5/kldayDzF2I=;
        b=oFC2hLrK/NxbSrc4wCO2Ak0JzyrKW9plT1s9ND0tS45YUBraEYF3A56csBdyKlBsWG
         dNUwGx8PyrwbuhlFQjiUU3A9ClqqhaLMwu+uv8Ltk1dgVnLcHT0bGpmqqnTO0lnTziWI
         2yLQM7pn21V6lhx30efSPcIUwTktKo684h46WJmgrIvWpFXfRC2DZqFe53RSCJub2e3w
         pBlvz5QpK78c7WebgtlT3kXhRZA5puwyu8xGYhalRRdqZw313/NMYbX+pY8lv5kbdTJM
         xRBerLKZjWqi6W6J9X+7bK5uGkAV2ukaAAiLtgvminHSLEQai8R0Ydw/0z9pCIaaRET8
         Jgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661135; x=1706265935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLdYk7lMN8S67k1ZA1qBwWGzOiN17GG5/kldayDzF2I=;
        b=iq9xv5SbkJXDOC8Q2B4c1zxsIqWZtSDHhlI1IcVzSLIMV2TOTSkJtwubSWHvhLkKMz
         h/NOanDLga85ywsTBaL7aOgyEVh3LowexQ03eOL/1a+B84GgGos/9h33s4QyKDNNn8dp
         zcILVmVUHIlS3jGyQCA2LR5INrodz2eSUwBNWhSEtXxktVnHZqjwiruiHp+9Lf6/ZwTq
         dh7Fo2nSUNxzbG8OzTxfisHQNPHZGSdu8ME/b6vghrEBAsennz4tFcmiRTAhJSumOkPw
         tyWaEyQSn2hA9dAByDnfX1Te+MIVzKgVpi/YTyEHiwAcUIH721FByRW5hxjlzZAIJ2yI
         UdBA==
X-Gm-Message-State: AOJu0YxfRU+MnEiB8bwOQGKaHa5GZBz/n4TqhMuAi2VrfmWlB0/FgJ9z
	Viaahv2T1b/ouFsonlBxjde5PPNbQoyrZ7PMfZSsOnaNZuPdXAmpxYHIwMScaJc=
X-Google-Smtp-Source: AGHT+IHStpeaJg7czVAXhy1YLg3/cMnP60jBDv2J1qFM0FiGJKfMOtGOvAXTPzU6UR+GGpcxYZaeFg==
X-Received: by 2002:a05:600c:1d03:b0:40e:8a59:c3a9 with SMTP id l3-20020a05600c1d0300b0040e8a59c3a9mr1568710wms.2.1705661134824;
        Fri, 19 Jan 2024 02:45:34 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:33 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 06/19] tty: serial: samsung: sort headers alphabetically
Date: Fri, 19 Jan 2024 10:45:13 +0000
Message-ID: <20240119104526.1221243-7-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting headers alphabetically helps locating duplicates,
and makes it easier to figure out where to insert new headers.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 80b8fcf9e025..bd9064d4efe7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -21,26 +21,27 @@
  * BJD, 04-Nov-2004
  */
 
-#include <linux/dmaengine.h>
+#include <linux/console.h>
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/slab.h>
+#include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/math.h>
 #include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_s3c.h>
+#include <linux/slab.h>
 #include <linux/sysrq.h>
-#include <linux/console.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include <linux/serial_core.h>
-#include <linux/serial.h>
-#include <linux/serial_s3c.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/cpufreq.h>
-#include <linux/of.h>
+
 #include <asm/irq.h>
 
 /* UART name and device definitions */
-- 
2.43.0.429.g432eaa2c6b-goog

