Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6522D7A1
	for <linux-serial@vger.kernel.org>; Sun,  7 Jun 2026 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780798298; cv=none; b=lpVSzahnKw0dQBHMdB2xsrkeViB+Y62T44PIbA+Mtx5EAwDFH37oZZn+DU/9bMolAdLY5UpcMx3RIcK6wI17kFBcFH/441enIRqdgSDc+rFnDU3Dvpx8jtCcK7Rju/evC1e7SAmucGEW03IoU86BLgPDcQREs0oJ5+rgBCdees0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780798298; c=relaxed/simple;
	bh=VIaasXVbsQnWemPmpykUJc2HesoylgOrDrFNET+PsQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O38vBQVWbNSRpv1KKwLMrrr4ABz/Dr9F3KZE2oT9LYELjGJS3YZHXTyxslcB3Br4aibTdG4Au6DVdL8scdl6TdlVV+Wp1wGyUL9+FhV1N/111Xw1gY0hc4AqFFDv9MTpHKy4HyNHPZPDLcox4rLxpZ0FYpCexiL7sr5bDge4el8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZbjDMP7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZbjDMP7"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e6cfdc8382so2290004a34.2
        for <linux-serial@vger.kernel.org>; Sat, 06 Jun 2026 19:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780798296; x=1781403096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItaUq0JN+2Wn+Yhvg3+jrAUf1I9tnkzUbmAWbHNBH50=;
        b=mZbjDMP7aKyPuxZktAZD00CzlFZHXHDPE1U1UNEl7pljfN9W01IYpfDwrKDNqKnR7L
         lMU9CtcgAqyS+ESnWz/tzr4ThtpLtW+SarsaH+GPSSmpClRr4lkusjhpJkeB/QTlGTXp
         G8ZTs37JJMUAsTXwhW1cF0wwL+k3iBQdOrtvEjMoORrotblFcQDx/D/uSskHuTPS3B2V
         KJjCUIXa3Vpt6dMGH1crGaEuNoFNtRrB6OHKDwXx4kQqI1wC3lpCrCkam2VzVGGhkdX+
         HJsWXcGAshVsPmGCkQld65mcaZsICIGG142jjXS6Oii34oTj5xGYYYKUPgiUah/Ass9K
         ZlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780798296; x=1781403096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItaUq0JN+2Wn+Yhvg3+jrAUf1I9tnkzUbmAWbHNBH50=;
        b=WxNw7pZHdE98XxMkIk/k2yncyKnEB1fxaq+QRpA52nZVxuGryQUvvZgRhHuARD3GIs
         3zS+I6e8NGqsKD+bo+aXVZadp6MKIlyRbpZ/1ImNH1JJEUlQ+O4JyzjMOeBTRNALMi+b
         /bFnGqT7dnMYV+t+3ilokbbgTO74A5KSyjjMOzOATkcrhMUZnY5Pjy7BbtG7/0IrwkY6
         rWLC74AT/B/SJ5sq0p71UFhVdyMQX0kbK+GYAfWsWB6vub19tf6adyz/O0vhLcAQUBDm
         nVE4IFOUyzyUtvqXyypWKj9rBVw4ve1a+FLpodgoRvS3vjUWCB8OhFLr7S8YftD7bQpY
         B/9Q==
X-Gm-Message-State: AOJu0Yyn4aap4ddzWlJb/nUTops/RGBt0Ot5PMx5YdjPdgc6OJz+JSmv
	R1NZ1IYAERO0NkBRWV8XaAwaB7uq6Q5R6tMpi2un58raR0nZQrg6Mdr2vniz0A==
X-Gm-Gg: Acq92OFU6op1p0bLtbNfl6Cn6omPzm1amVbq2UU0rSGBNchJ5EnWTuh7FoepRX8c//b
	pgFxUDMSXEuXjHtOjFsiJAWSmDEy872E1Pz+CmIa4Uv0g/sFtNTSt4XHHokobyALeg+/0RjK/Ib
	ZQLax9RVjA8n1PSkUUOD8o4XM5c5/7YY1UHj1zb48y2S3UwrmGZApiIzfBtcCJ15NrSLzrX/+2r
	qcSigU8AulFiEoTb4fwAmh0uwqBQyYeZF08e5d3i9S8oAFuu6u4Mkx1ocDUvKppncL1z/gRW1xy
	TrCv8jVsnqPSlPg5Gx9w7RgJ0hPSiTfLw05b820aYLtiI9UDgKUa8Pa6JJziMjrPGWZ8XnUiXhu
	iGxFJWCuNPeRix311blQ4OA6Gx745352nXdeg4SvWUDGwruvbjdmrr5NC08YPoOKqRIfOjFazce
	ir+DkQEnZA1BEy+w9T8OkGSRP2XG1mnP6xB/4YzMZBqXSlmhQ7nJ6Do48zivTWSKfdr36h2NpeB
	D1MC4UnLmBpFo7f4NeFEzwwNZkIq51pHwAvTTr7MTzSTx3URTt+ttaU
X-Received: by 2002:a05:6820:6ac6:b0:69e:34d9:e7a1 with SMTP id 006d021491bc7-69e68b5e0f5mr6293706eaf.20.1780798296496;
        Sat, 06 Jun 2026 19:11:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46450223sm7854954eaf.14.2026.06.06.19.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 19:11:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] serial: cpm_uart: replace irq_of_parse_and_map with platform_get_irq
Date: Sat,  6 Jun 2026 19:11:17 -0700
Message-ID: <20260607021117.6325-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_get_irq is a newer API for this that does not require
irq_dispose_mapping().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/serial/cpm_uart.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index b778a20ec9b1..39f54bb7b485 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -27,7 +27,6 @@
 #include <linux/memblock.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/gpio/consumer.h>
 #include <linux/clk.h>
@@ -1530,16 +1529,14 @@ static int cpm_uart_probe(struct platform_device *ofdev)
 	/* initialize the device pointer for the port */
 	pinfo->port.dev = &ofdev->dev;

-	pinfo->port.irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	if (!pinfo->port.irq)
-		return -EINVAL;
+	pinfo->port.irq = platform_get_irq(ofdev, 0);
+	if (pinfo->port.irq < 0)
+		return pinfo->port.irq;

 	ret = cpm_uart_init_port(ofdev->dev.of_node, pinfo);
 	if (!ret)
 		return uart_add_one_port(&cpm_reg, &pinfo->port);

-	irq_dispose_mapping(pinfo->port.irq);
-
 	return ret;
 }

--
2.54.0

