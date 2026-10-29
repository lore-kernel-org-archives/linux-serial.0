Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299662;
	b=vW6P5YLl6nujJmFeyvQtU6QqZyqZdIKfJZoJmUTVAxeJplfVwaYnMXCPwOlK+PGPpAla
	 fWESxMEjT1CtxY/JVt0M5mK6MKv+vvJwGDo+1C0VHQq3lNViJJ9DZAjhrpuuT4e2WwjXc
	 Tj0u/dNV+SpGYm8H/YGXCNNkIMIR3alhXrQtQX/ZWW0w6512Eg3xsursPOd1ul8clwwlJ
	 XV7IWZdHEs78eknNX5a5X708zHxoBDOmMlGrn2r+pLbNSK2iuw4VO5msmN0yGoB2HwFja
	 JuHAtX2b5hYcUWgXvK3gjT3/M52WdbK9Cca9+bgZ6jCXr4xmAg0KDBveDp2cBwV+aMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NCqbgiCveDVRhli2P2PmmtvKmmMz/nrumey9OJpxfP4=;
	b=0jCg57hNkLymvFHISVROcyCtd5wpavaA9kbZqt1MQ6k20k/y9G+s2YFcxHppw5aglxRx
	 gBOq1Wb1caEO+CGgK1AddoRw7zNk63ZSr5s786C5LbqGwK2r9kQ/WuQBvRmk5tuTe/QLb
	 zUPTHnI83vGbeh3vt6dGhV8zElZs0K0v9nFlhCdsOuXVR2DZRUnvSfa3VRasaHSV5pYgA
	 aBUbq/LlNVGF1efFMqrYd96Sg/rWfn+0Ahb817807NTIAOPkZrJ+ixaElqctHbo7xVk35
	 Mbul7HqW1hREfpVCYuGeGP23wC+iKsVv/x32TEJQkQSEbi148pofhyiFgNERj/QX4CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mgEfCHc9;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1E60A3821
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E1E60A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mgEfCHc9
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8451a619da7so1738299a34.1
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299661; x=1793904461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCqbgiCveDVRhli2P2PmmtvKmmMz/nrumey9OJpxfP4=;
        b=mgEfCHc9QsNK6XJOqY/q5OKZuaLnKglqbASo7K+bPQqZoyQcG6lWwdIFZf/XSYB9j4
         cwOZaDj53UstQv4V2RAD3ngIfPQJ/F6nSJcBfUh399Skq2gmSaH89w7H/FvE0L3L/1wR
         5YB01KQs+CQJ+BxLiQ1vdkIQFzJLwllQc+3fa/P8yJNUEGwoNeoGis8mlwKY0zoU4dBA
         bQAWa3oaWYS5shZpNDT7ZDn6fZ8SVVYc+z7ZMYN43ala+9W94C++qbPUM2Q4TiOTgr3W
         aSkbvaVUBlS51Onu+WdJ97L9UbvICJ881cNT1HYpnpkCKVsMBOsnoo+X5FHwp8ittDiA
         iXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299661; x=1793904461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCqbgiCveDVRhli2P2PmmtvKmmMz/nrumey9OJpxfP4=;
        b=SjcC7GizjUm/jEobv2h8K2WnwWukU0IRlJiYkmbq06QmPpdwuk8Zy+X+MD4dIZ1H73
         m5y/WugqNqmh/Ec3jf2AGdZZDvQo0zzZb95i93S78oq6726Eo8BT5RHvSnds2/y5vhmg
         MO4ChI37NuoPO1qvyGlgybJ+O+NEHwgPTJVhedlrDAe4WciBAT0rCTKcB6qq7PjirXkm
         OFwZ7j05FoXply2qzPAkm5u9R5ufVBdAojkLWFPxxfRqVtsghigg7dFX8x5WkuklQPKh
         vKg38twrQ1EuaaH60lAlPme4uBqJ2s8A+NVe9/eFBTR3rWbvkokpgFMjyYDVz+IK5mOn
         Dtkg==
X-Forwarded-Encrypted: i=1; AKwUvBwcTDQBYqMUmqS8vEpf4mOisD7kZmx4DaDitlAinmhLmPQc0MQCUJwa55o6dA3XXcVP2kn/7cpwaeDnVGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6VrDtk1QAVWGqDxGKvTRAWkB6Cg3Pbze6PB/icHnqD5l7T4bp
	ZwQHWvh54/iKK+jBj5CYNYmzUtjzaNTDu7EXRtn4Qt6NeVh2vVuv71GX
X-Gm-Gg: AYBFou0W4sCUb7YnJ9m3uvH2mPl5Zv0KbEDEoLMqPneDu422ZBZYPUynZESuPx7Dh3v
	JPxX5shx07wk5H8FoyEAFeYuh89xeLLeQZheRlXdGLyFfClgypQkUOB8h3uD+P7SQwNL7PvlqVo
	Wyio9/exE6SaZ7mj0hM57+44y0DlZmuHpU0gaNqsHkj1lh/In6Aq9N6fkdvqA2BMtll2geBNsOJ
	qTIs5lHN1M0zLJe81X7Udr0SYugQgkBWKkLzNR5kJKqAMTVbXvCyTneGEoqFmZkE16vvofmBKQ8
	05LMwnzWhGXbBbQUyL/pRPAOrTrAxuQPvYDxjC8AE0yHUggftWAuqIAja6FjfRsgBPOQQsXXyGg
	eCo/kvHz0CcUXqP/Lb1H/Cfy4ft5TJbkYIcAh390aO2ssiFhxewj4zCLQZl86JKG3/1iXvlxLQZ
	iyUkbPV77V9FYeZ3jXQFWMi9ha5q0I+TEM047Bd5RFkyNweGt/jw8VuoQkmYdYgNcEuUlux4hVs
	d8aWpm7vvbB3KrAisOsNQ96Td2JJV8XJ5cUIvAvFFwKIZDuliVdvUOPB8lXVn6iknKV/NXdB7HK
	rimrKuJBYLr3Qde3Rwajgfb71hvikfopS8AtrVjLY8DcPmk2AZamGfhyGLG9PT3YmNFI8C/L1LL
	rqLfKAMsJtoRTYVbKZYi3BuPO20sHSRnKJDICKnJ2MJjW4Dd2cygas9rZBBF3m5Uo/QXTId4kIo
	clajn7PQCn5xX/ClMAZ+XNkP8I7Nds0dkk0e2PgKxvOuzEYKqYoFc=
X-Received: by 2002:a05:6830:438b:b0:822:a76e:95c9 with SMTP id 46e09a7af769-85d364642f9mr40665a34.14.1793299661366;
        Thu, 29 Oct 2026 11:47:41 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 12:47:29 -0600
Subject: [PATCH v5 8/8] arm64: dts: allwinner: a523: describe the UART
 integration
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
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-8-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
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
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Identify the Allwinner UART integration on all eight CPUX controllers.
The specific compatible selects FIFO-depth discovery through FCC and the
Allwinner receive-trigger mapping. Each controller supplies its own depth,
so the same compatible covers the different FIFO capacities.

Retain snps,dw-apb-uart as a fallback. The common SoC description supplies
these UART nodes to the A527 and T527 boards as well.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 85ef492ffeae..23340b9f58cb 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -390,7 +390,7 @@ wdt: watchdog@2050000 {
 		};
 
 		uart0: serial@2500000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500000 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -403,7 +403,7 @@ uart0: serial@2500000 {
 		};
 
 		uart1: serial@2500400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500400 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -416,7 +416,7 @@ uart1: serial@2500400 {
 		};
 
 		uart2: serial@2500800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500800 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -429,7 +429,7 @@ uart2: serial@2500800 {
 		};
 
 		uart3: serial@2500c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500c00 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -442,7 +442,7 @@ uart3: serial@2500c00 {
 		};
 
 		uart4: serial@2501000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501000 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -455,7 +455,7 @@ uart4: serial@2501000 {
 		};
 
 		uart5: serial@2501400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501400 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -468,7 +468,7 @@ uart5: serial@2501400 {
 		};
 
 		uart6: serial@2501800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501800 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -481,7 +481,7 @@ uart6: serial@2501800 {
 		};
 
 		uart7: serial@2501c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501c00 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;

-- 
2.53.0

