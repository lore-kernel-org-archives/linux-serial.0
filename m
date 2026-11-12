Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497645;
	b=FezrAe0G6GPu1ZIdoPeFxhigR17fg7fcOO0Jks6ceBODfU7Trneusew+e8Hvinfo4g7U
	 9F3NuJmYP9K1dkx5KHofOdQuvHMtUytL7PJP5fsw3D91ZHzcUF76WaMAeNauuUzGplsCN
	 IzGxAQgv0abmgA5ZXJ+ww6YdDD4GG4TVsTMMsJYAdpwQGWUFhi7uneRsHg6UfU2Tw9XJG
	 7z/09tz/rZBlGttRRvVxCXjfvqXIEjPlB1UeKWJ2WvUeGOTtek+fp3g6/W17nGDRxhN0B
	 CDpx49TcSfO61ww1E565yvvbgGWvF1AiVCDqbOIVNodRl/jzrmOXsRp43qyHb5NYhJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=cb9BEjmbKiC1e6Ns5PB9qNgJqLkx/tEuk0+MP84fm7I=;
	b=PUg/S7sjQowQOPEeVcEtzd8IYAjfKL4DOvWRiDGbACLpGt0Q8MWEIOw6MA/BNN2uOHXP
	 stEfRCZp1fMplGZuSj1T/50a6DUBCxYvwxNPRl2Dum0kmjNgWDleLIaP1IEmnza6u4yky
	 EqxdwA5tohqJNfvHBDZl9a6tIecy5wcl8dUhu4FO30azXJ42R6hyvPH4ygNQZ5LF761cq
	 ha9exsl4g/Egn2T+QiKggw3f+MJz1aPLGUHvFzcNM6XpAghScK1FVy9f1r17jyN3nAfdE
	 6LjBeJbeTLi9R/PCd6ZF94EPJUI6BXQmwxRJ4ZXmxiix+mCVvRCtHrvBrHpxcOZy71A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Alal/djO";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08765606A8B4
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 15:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08765606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Alal/djO
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d05d51553so31217915e9.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497643; x=1795102443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cb9BEjmbKiC1e6Ns5PB9qNgJqLkx/tEuk0+MP84fm7I=;
        b=Alal/djO9WabNo0xNCNMd/5TqLehZJIEUmXgnMBpeUIigivbAcrzLOWlqX6ieAvcbl
         gsODy5uhWGx70IaMWM9o3NcF/zyiQBJGYuIj8aPMlAN6LC57a/ORWpvIJjCGHgGggPgn
         4t8S6PTHSAirtwiQtvUTM61NnU3AaQXKpPMKHJzaLqvIn950y3GhcptqQgio4z/LU4gV
         hjT9FUJt2lqAhOcKKT43+o2WZyOAya4m4OzD6MH40yq2QGglv90WptSVYmTT5q4jU/3p
         tXqJZMeD6fA5vqP+ZfUjd9jMP9iG3rsZQ4EsGyfPCaW7EmgyXSZazY5nfGv0dpAWkAB7
         n/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497643; x=1795102443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cb9BEjmbKiC1e6Ns5PB9qNgJqLkx/tEuk0+MP84fm7I=;
        b=P6YjUX9nrQs6qZ6D1jAHupjpM6459GsLozrNy8zIyz0uQObyqCVYX9tR875T55Ixok
         z6gVUE6qa9AUv65K7mhUQwLlav/S0Qx9axXWCHf9LPKd1H7LUodrGJKw0So+hakCahmB
         fa1psgdMXvjqIjN3lyqhPPUKVXQd6mlq5T4djdCemThr8lMOMxh34cDhpL3On0xFTtzN
         aBX55ioBuERuOj1T/O5PBCWW7OACAsjdGWNZnnedZtiWxHOki/GreGWsKai189IjNdW8
         AFgHyEzNaEyN796bhcOBXq01tvXkdvGKloXzM8JlVwy3dP6RDV38IU0rK+wSjIE2KeYV
         C2/A==
X-Forwarded-Encrypted: i=1; AL+hErGp1qoA/rQATSHhL6RiGejbrBIRCv5qsLz+OeXuVgq7u55HUMiIxXct4NfYHCEhwm5Lsw0gg346ATRp1xE=@vger.kernel.org
X-Gm-Message-State: APuU4Z87Wo1jFpc7F1w7FOJrFbnDt58+gnmKVXVkCys9wZ0PUdaIOip9
	QM0NeJHhV/RwhofrDK25VAsI9BBQzAJU1tnfWRSYvBTy2Z+lAsJ1Y8SO
X-Gm-Gg: AYBFou38SoOOjSQTyzXswDVhfVcYhyAsCpxYbHsib6ULmJKYIy0glXbUqsSBJOJuQGC
	goPFYLfeqjtCyy6ef42ovz6uAbjjwiiwtE+8h5t87gxy85YyJyacIPL//ZBti7/7gENJpBerRo4
	F4K5Aj7A+y/5gUE0u9yol888MXAUrRxuVPsesfhjnrAFuGKw3uCqdXvaphF8658oL53zor3zxHQ
	dzZIebjgfNHOOK3RRnZLMyu6OP2J+8e2lClCWTEvSnwxCHhZsI2fa9Xf/QDD+lX6XnxrehCFXHT
	yaSYeKKzX0+NgakfY/oftmLPjhzTJMf91dk72Rvz/F5wDOL4bs0pWVtR0DgpcbL+cqaQkjaRBmL
	9jVL2Jth4dBP2QvJRLNAo3WKter12WdR/maEZyWlTsk5QZ3HcL1a5zzdw9bJzrgKBbkh8uyxZSw
	gseAc+N/09+j7Lf6MjIWByKidKMOnMjsnWQ1Bv/TC3MwMaUXD0pAC3DwDGxNWCUZGWzkGWu28lG
	1cggIR0z4azXT+mI0JZl3InbE5u9bAzoV9Ds7HM3SILQymT4QBhCQA5IliYGuUxME7AHZ7QtTYh
	awPFYPB3q631BeCBHdCl0SM452Rid6eNXWEWWGwVBGV2VdhpyLFVj5ApwoDE2XWOtOo4ulL6Sgf
	WWAQM7m4=
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ba093a3cf9mr133072185e9.28.1794497643353;
        Thu, 12 Nov 2026 07:34:03 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm87105855e9.5.2026.11.12.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:34:02 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 19:33:13 +0400
Subject: [PATCH v2 5/6] serial: vt8500: Use devm_clk_get_enabled()
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
Message-Id: <20261112-vt8500-serial-cleanup-v2-5-36b258e0c0dd@gmail.com>
References: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
In-Reply-To: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=alchark@gmail.com;
 h=from:subject:message-id; bh=aNl/b6SlgUpHOAaonf2+NOgTxzDT2w4YvE4m0DcTp5A=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9veNVq5GRPm8+5/97Vp57flnN8ok9osmhc4pnQyWb+
 aMLclUqHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1kQTD/xjOrdoB5jYTvIocngROMXJnStaND3j2f4be9NNnDzQUFTH84Xlde5U
 7PCF1/zJFi0kODQWJz9wmaGx9eWiFjNpzo++pTAA=
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
index 0c8ddd55f94d..cd5188282f64 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -586,7 +586,6 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	struct resource *mmres;
 	struct device_node *np = pdev->dev.of_node;
 	const unsigned int *flags;
-	int ret;
 	int port;
 	int irq;
 
@@ -606,18 +605,10 @@ static int vt8500_serial_probe(struct platform_device *pdev)
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
+				     "failed to get and enable clock\n");
 
 	vt8500_port->vt8500_uart_flags = *flags;
 	vt8500_port->clk_predivisor = DIV_ROUND_CLOSEST(

-- 
2.56.0

