Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742013;
	b=PJeaac3yTvFi+sTp621G3kdom3hLr55am7CARF4vARcN61W0O+zbf50MD40GW0SdDwZN
	 sOuR2055C37mM3jP0oJ/gLqi6DytdlX6MN/1AlQb3ZFFKDHfE4zmyu5u5Iu/aEkM1It6w
	 ueJV8ikEaYobqPDt5l54Z6Wn88Y3zDke8Z4XzBpdvTqmLg7gEczCKcIhS1SFPxzkw2gzl
	 knkfwf2dmPtqoNvEkuN5zlH/zlonijUyEReEWbea9CZHUtpLCMIw4cxbRX2Aypy9Nbmtw
	 E0hra9EOz3jDsGc2VSe4h2yBWaCmo5fva8K1RioClDPcHKFISKsngeO4qLPQE8QOLrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
	b=ZeM92AmOeJZWBr/8fZcv34DJfibJpuJc91cID9PXc3X6XJfAdDny1LMmdmyASpPKRzeq
	 bimq8bV6d3o9eqGIFuTS8/+La9hJyhD3yGo66Hz7zRKRfqSG0WMljAm+mXhDlZrhsgH0+
	 HdSnDwA10f8Nw4L4+T1b3b03wLZI9HRysDTftj71xyLlQ/odrqSCQDbyBoBRlLcrwlndD
	 tOcrHsUUFNAQvfNuo7B3UzWwZLq+m1sOn7TmMGpWjk24jpHCOjs/8osU4kb9PjxhHqKFx
	 IYmFcj//U9FK/B1asiuz5QjZ5DKTOmhfWSnssJCDsKg6OnJWdfhc0MNy82uB54WAJig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n7mZ+KIh;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A2606D81C
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 582A2606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n7mZ+KIh
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-825b40f8a26so21050a34.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742011; x=1794346811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=n7mZ+KIhd+iy36BqqT4I/trh5SfXup7BgaSb8QuJIUIPwWf7lxWDj4Z+WbNHY78DQc
         irK3EeE7y6ZgGlOtHE3LcU4gj/hKxxZAOU9jgYSgCDlZGqVhIDDHrj285wEHJX2uiyOW
         RSZR7A02MEvSdHpGz33tXN8I0BxQ3EpcMfvy1FgS3Yi8LL9mtaA7RWE41s/s869lxHNA
         ZE3B1fmfQ+8a5UnNBfSbIrO4KBFCIBpYdll+fObbs5nval6qmwji91gAt7ZLQTqLQjit
         5CoXmefAcBkTHFz9iXjjSHfAiRvvqLzZpC1nCDvkpfneg3HweCDM3Z+JQSdZIcJg3gpw
         pRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742011; x=1794346811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=MWjv/14cKrXKsDjI8m+uzM8V0ls8YfZRm/QhdkIkvsqjIRbpEORzgutavjueu+dPPy
         phtDIlYJWNt8l/zoFxJFaJ0J/3LSTsiWPEj3jUSoQG23Qycpt81eLQY4A/P0GnbgeJ52
         hhDtqwsvZO7D77cZfDchr9EVHU0TZSb1s7cIQvWeX6Ak0GoZkSmt7PLQSD+YA/lbeW1F
         h7XhLSm6JfWmd8g6fdZZyeFBn6OScT8wuNcWuCtSddOq7Me87eQFrUAqIosMvFts97kr
         Ag4ZwQoTLvGGCnJfSSRj+E05NSGqFfQZMcjbDz1WO1oDoDHd67A5tofj2D46USpRST30
         4KTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSLSQwF6xWhGQH14qa4twFkKgM6AdkwZrYreqhD4ul/XQnCqg3rZiMrJKZHGsG/QEhhEYeDGx1uINmJCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4tTOY2jVtJO1n3e7pPTT+UaW3RngbFkfyfLNj0cQF41MvA5+X
	r1eYjEFKQSHrTUr4hvnxNOyjOlm7Lq08kYIFo5y9vajop9CyApjOYMyilalYRK3C
X-Gm-Gg: AYBFou1mK75Rw5Zybekxy65QiLHzwfL+2rVdadQG1EtIsv1imdOnTSAZqE/Ao0RD8HZ
	EZBkT1GpgB80bGraLURfOkkVEX4rEPdkNg5GSvatNaZjVWZyHw5JPu0nWMHbNl94fWP2gSsNNyU
	/v6V7hf5xF0WW+oUyjNc98y48Id9uWv2sd94w2iXTuVuepTFg9bjee7neD1TY0Z2W1FBIkR6BuB
	h7/zClHlwPfKE83zTII0zLfxKy9BlHZ8lPwq9j9IZxZdWdfhJ8D05rdwrzY03v86ME/WdF6qiLF
	napDppIQK/ETOo+AEwN1KudREi6SCSeZ+A2OlZ8PNEg2s2FMqE4wT2SRSfjmtDP3MO/lCaGXUmx
	dwykujp3ZV2a7iBAhgXweQtyo0Ue55ZQIxxw1Br0t6aFE5Tj4IQP22DDXVPVjEeVz/gLx5bdxwf
	NhMlWFQLctn298NlRG/uSCfZs2Kd+ZNcy+2zCaxdVQqpnaHZw/iCjrTzUOaB2w5+Xxjuc1DBm/P
	QPgOmTyrwYUaGsn351LL0ceJbQmnYMW7wjv95PdlqvGdf4DTAT7MmLxjVRFwa+5UcUFPMexp+tw
	2ldxGGIi4XdkBGzBYj9lkxoyt1be+CKZoxmj5u0oiWBaW30gFTLR+Ew9VXuWj0Bd7e19zpA+9NK
	H3pY2RsEi0LXRmh73JZuDUuVVW+uLccZqT283hIjC9+WpVEZquimisIpfVj8lH3L1JfZyOD1Ccz
	jwbSQ556QO0+ZEnQzmeUWOoiyfNE2AyeCNV2ApjFuDjUeAgmjpazYU
X-Received: by 2002:a05:6808:2507:b0:4d6:90d4:6bb with SMTP id 5614622812f47-5640dd9d63emr10403938b6e.45.1793742011356;
        Tue, 03 Nov 2026 13:40:11 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:39:59 -0700
Subject: [PATCH v7 06/12] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-6-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
component parameter register does not report the FIFO depth. Its optional
register layout also differs from the generic DesignWare integration.

Add a specific compatible to identify this fixed configuration, retaining
snps,dw-apb-uart as a fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..fc1289073241 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -60,6 +60,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun50i-h616-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

