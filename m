Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424777;
	b=WBMZLYeK45oRNkzYbbJ1ivj0+wVw3r5p9ZibzUhHYq1vwRS8YKv5hcdHluXhfJhAMbOd
	 r22oBSRcVvVLrVatx+CPql/c6sbpoys78GppZhzghYElFothseHgWL8uXh4K/RZDeMp4C
	 tcPpbilPTmgXHyke9lLZVcEk6nJgfrdJcoH3k8trWbsCR3n5Dx9UO4HBepze6re+hBpdP
	 uinwVUP7xfxooKhjCm5KuUAU8G/opBaCWX4JvbmyzGefVLYLdqLhQoRI8lbofXIlEJmY0
	 RBfKDJIXcBmJKyoEPJ7D9EtpUwD1UDPq6+PlwUkoJFQFgNBUls0L+igfDRr8e52PqZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=alD5BAXz/kS3KLnylbWLn4qtc5TJTMjnEsE7TW0FMm8=;
	b=fs8vo3QG5Mr1o8Oh4rdRd8I6cQrNUp7FLeJMGHT5m+yTbVhDHWtRwWZjoiUda5sQXhQg
	 8BYjZ5a1zF4jjdQqDo/Bm6tZlFYIceBC1ke1TrMVZi8Ob5irGVkMq+QNX77kNEwkdaEe/
	 Jon3Rvvi9pP/rvzzl9BEf41UIwu9zkHdQDRypokJW84Ny16vs4gKsMSLQS1ckrkjGf0JA
	 lERHG9HyVmz4dUMlpmAy/t0alr1gxLw+IG5rH+Xg+ORAHYs3WnrtphGRQodP3KnPOT3TS
	 9dYSIJbCqWF/3uiFxSoqIZTOeoRAu4ftdbgrxcE/Jn0CuETqT/ct2irGxBke4gPlVNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rhkk0r71;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EE606A89C
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E09EE606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rhkk0r71
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4910b863b84so115445f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794424775; x=1795029575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alD5BAXz/kS3KLnylbWLn4qtc5TJTMjnEsE7TW0FMm8=;
        b=Rhkk0r7187NiBG3iZmLJ82ucpVZb6+skuiA3EJAtnZZGeYTtYaaGxbiFq+VIbjB17s
         oMV/vwOSB1pU5ZZJZKySNWqV0Id5puU4Mqn9fl7mf0tnKAGkybyHPvDAW/LmMXfG2nkx
         XMKhNX0ywPxHP5xaUYU8561c+sxMj/KK2CqDchCKr8ASD5rl/QpOfQO1qiOToYo4EhH+
         ZP7bdQURYXXbGjrp8H7y+6IGEggyhYKz/VupokHdWR0zmuNOQ6VRAvBf5zqKPS4ybYVc
         XQtQoYZ0s0p9TgLgjsvdBP8gbnu5FWeNq52eEgd2iWx/dYRIuiuP1cW0Z487lItMRI47
         sTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794424775; x=1795029575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alD5BAXz/kS3KLnylbWLn4qtc5TJTMjnEsE7TW0FMm8=;
        b=wf3gQm8OrTA41esqGRTLejHyQuamox0wXb1hmFsxO+WnGrfBevoWkp+8+P/kRk09bk
         c9SLvZFjF82l5dc1xHv59871uFmjND7lB2UFqy/yfcksN8KToBKB2rTlNlFjFirH9ZLf
         E6oiD9Sw9V7ikCShnBjuyO+zLHTgimyV5CcjTOwMl/H2JqTH5SK0kEA4HxQF2Kjq4yd4
         n/lbsGnsxb4mhjHjhCNcffwUay2zxCno3dxI9ieaBRnNSQgo1F6/lbEzvHxswMJyz6vA
         eY9VcW9LYT+LwtKPiLYBzsIVgcjS8J7dJEDx+zyzUtWdNoKDdgEezNbhTezLMw9hEUnn
         kD7Q==
X-Forwarded-Encrypted: i=1; AL+hErHSoB+PzCTYjvwed4MqIoOTHVxLU2U9Z6w2PBo9UchDahwgbn5WVg9gL5Gk33/1N6hb3YvRNNwWBIsvpKU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p+WpAGfFsFO02EE7D7aupaHXot+zHvP92N9nTFt0qYilgsw2i
	LL7wvdbvcgV7awUx3oWr8thrWzVze94j4R4gbMYh6ZbWEtMuhDP/ISw3
X-Gm-Gg: AYBFou204QoaxmPz91kdu1WZHqhfi0UhqZGpjppiOj2MN3UWVTkjDnRJANa+cJpzIjN
	36xiyFYuQ7adX6fI2YYFAv1Ac/hfdVEHAHQ9YVdyIeCoowsrkk1yrWxuv/IpfYpspyLXlUM2GYg
	GjVaatDPqvW1/dPAUqEOf0gs95P2QjbRAE3RSxPuPWmf4jE7BHd4uCFZBVV1u8YPCrJ8v/h1zLv
	GC2YuZ80TJ5zoc3HQURSqbRfRVkBivk9NSwS5h+Q7rb/umkN3UkKSfb3e0o5Fz9Ab5j3X2r22XB
	7Z1Sr1SZS/BfCSCNFjZhq7N11giUhB8fgIfOMaE6IXQKMJdhKvJNK/SWrBBQq6y5e0Ph60TAmIO
	21+Qnq2AnlINAtSPmGCaOoUmONuktxujRDGQmPCLuPl2+ckWU3hTsiGZps3/0pOXNasKUBO9DhM
	8e54FLLiGGYdBf++M3x/B6IlvlhH4gYO9P9yp+jAuufURHDIvLwBjlyMxSAG13NkUcBIHe9U0EH
	DVIETWllaQoqVsMSW9rSo/z0iECCyGwbPZIU9jUudkwz2Zxe7qqI81zLNOE5tSC2iZ037f2oETc
	FhE9oRweUI0Mcfgs6dE99NfYaZoD+GslDaSekXfGjLlbAVP0rm5mniYl+NzKhzaHVB0kIrZ7JcD
	ZUHlqWGg=
X-Received: by 2002:a05:600c:154a:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4bb4e27a9afmr8939145e9.7.1794424775346;
        Wed, 11 Nov 2026 11:19:35 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e267dcdsm9345305e9.11.2026.11.11.11.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:19:35 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 11 Nov 2026 23:19:17 +0400
Subject: [PATCH 2/4] serial: vt8500: Use devm_clk_get_enabled()
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-vt8500-serial-cleanup-v1-2-b33594a25f87@gmail.com>
References: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
In-Reply-To: <20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=alchark@gmail.com;
 h=from:subject:message-id; bh=U3F4KrTDPJYSmcypcQ7vg8h5zcbvYzjMb3gEr3v3uis=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR92b//z5UWsc5NZVIb5DU+XLP1Sv+eZ9faXDk5bvnzT
 Ita76taHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz14deMDHcnrUhyk6h6x9Cyxq3d2PfwhqKr7VcyvvSe/Wt13DV5FRsjw6dfu4s
 /H+FgL5g14a/l6ziGiqL2FT0zV/7V0Wu6/7U+hBcA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Let devres own the UART clock, so that no probe error path, present or
future, has to remember to disable and put it.

Pass the clock lookup error up through dev_err_probe() instead of
replacing it with -EINVAL, so that a clock provider that is not ready
yet defers the probe rather than failing it for good.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 6c53e108756a..17f928a7073a 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -600,7 +600,6 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	struct resource *mmres;
 	struct device_node *np = pdev->dev.of_node;
 	const unsigned int *flags;
-	int ret;
 	int port;
 	int irq;
 
@@ -643,18 +642,10 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (IS_ERR(vt8500_port->uart.membase))
 		return PTR_ERR(vt8500_port->uart.membase);
 
-	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
-	if (IS_ERR(vt8500_port->clk)) {
-		dev_err(&pdev->dev, "failed to get clock\n");
-		return  -EINVAL;
-	}
-
-	ret = clk_prepare_enable(vt8500_port->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		clk_put(vt8500_port->clk);
-		return ret;
-	}
+	vt8500_port->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(vt8500_port->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(vt8500_port->clk),
+				     "failed to get clock\n");
 
 	vt8500_port->vt8500_uart_flags = *flags;
 	vt8500_port->clk_predivisor = DIV_ROUND_CLOSEST(

-- 
2.56.0

