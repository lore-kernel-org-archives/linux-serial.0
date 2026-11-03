Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742028;
	b=XEoOYsHOY18U1hH0rH8f5oEz63UUUhdJkC/6NgyjPZ6PPvNqRoT8ytTir6hI7MBXIFm3
	 1RMqmCXw1wjAprPY3Y6Dos496UDgfwJQ0nw6nnZi4QK6XwC/ULlTlrrVoSmCzvqbdxoNB
	 GCLWlB0Ku+u6fHy5LadJiOX8aRzxxNH7rE8ItWCF0aDf3Z4dBowEIh+Wi0hfHvSZdPeTM
	 UvzLA+yTLLAtoRMKlv6oUDGIVY4LJy+Ediy2Rq2ffBO0mNIYS2+AkeO4+ybC5imqwXFKt
	 Mm2u6jGTU9bUhbE5zOchJmYM2YoRSa1IAqYMJZC+2zQxrpcEVz/vhnFrLMmaIk3EO1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=aRqQDgQhXtc2io8t2nwzRELQbWhBlZAnTMTGCqc8nfs=;
	b=FY6xP3QODuDFt4RyWNoHO81yO8nrVnXECjDEtkY4giNSmmPzQz4cxazaFntjC34MnWX7
	 Hhp4GMjR4xHxwjKNBT0tP65dZkF0q3wApkWUob9MZb5AdIfXo8yUkZ0HFfdjiFMgG4Npi
	 BQxDQ1M/FzDei12o8WMbHH/s08Rv9kqEh1Ehe8BubzciUMapxFguyOyqikzUcoX/ZR0rG
	 Xo0aZLGqKLrmhJX+COF6VaY81u0k5UOnfNYYtZpfBvcLNRuQy/FpY3dUl6b0frHbWU+OR
	 oswdpAVGaoMsJUBEhRPGzLKofVdjuC7ABPEnnYoe/8iCZ1cRnwYf9BoXcRdSJuogD1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=furl0n9h;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBD6082BFC
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23DBD6082BFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=furl0n9h
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8439fe796ebso21537a34.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742017; x=1794346817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRqQDgQhXtc2io8t2nwzRELQbWhBlZAnTMTGCqc8nfs=;
        b=furl0n9hv3AfBCJWZBPeQMseF/sjLJddQ/67YYA48n1IV+Qkk6TDED1J5ac5L+sWU6
         CHOlDo7v6NSLP5LWMIWBimRrEkQF/bs/Fx+GFiN2jzzpNZAhq+PY8cKbkNMt1xPNPkmY
         sAe0/PoLMwy+25KOqOGNcoZu9xnhOC6uM/o6/XYp0dijzFCr0bFs+293HK8KowZMTXxr
         09LHP+AMCkiwHwWAAoNjgvTDnpWfQJRzWtK+PfbknEq0uc9my/fZxYDTkzWTMxk2Wxq9
         HLczZoMwKvVBOU4MVMpui0Qomvggyi9hk+RceG3kG06Bx0/j+ObaL4W5LoBi6S63RsOU
         8UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742017; x=1794346817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRqQDgQhXtc2io8t2nwzRELQbWhBlZAnTMTGCqc8nfs=;
        b=Jx7HVdglhDILar1Xgk41m/2I5Gj0kfJO1JloER65JxngAJaZF4UMlNP/J+ylkbeQlj
         RUEpos5tPgDGrxECMgM2hAC9pBLIBFVkZ6lDZqkt/NMWTjIHd4uHAGbWY5BrjhB3dkId
         6azUR8Qvha7Qjv9U1SDUjrzcU62k2rwtFwgeMNkgRlzXgON3USQj5q/nDT4cXmYRm01i
         klcby7IWLRfmU9n378APRDmeqaZ2iGlnO2ZCCak/Qk++HfZ6Cs3tMN+5ikn7aHf7DCU+
         A/VgNz/p8Y8Pdw5kORAVTjM4BMswj77ZkGd367yIMwCMdXZ9WWafipHRijnQIKVBMfa8
         j+Dw==
X-Forwarded-Encrypted: i=1; AKwUvBxUYtqxWqXDkA6KSNbWgn1yinqUrZPeSfrZQVMquMdNoYJy2dfSgD92nZira4cB8iOiJx83g2h6ogLo9m0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UulIa9BvV+9WM4t8lCJksDwM9tkMojEYU1p6C79PwtZFznRMd
	uvcGFFUghZWDTeqBatwMY5BjTaeCZOQC2qKF5aNLHElHvRLic8QpfW7yL+4eC0OJ
X-Gm-Gg: AYBFou3s55iFJ40TnZ4wOzp1esML/NqKP6t4J8IBoYbI7gYM4tUTo+WWEw1uaCXWvBR
	eENq7YWg4+N1uMSiQ02Bj5UkSCUSTLDWpSHj0egDJK+QRKFZdf91KPacF52onMmWPjOgQRWFteW
	BTDzTiErX/nTgD7OzK/Rn3itCAIFe4YE2FJzINRkSqJRU2P1jEM1pdxzYyqLuuuW0ukVCv0I/Yf
	xvNLUskYs1o3k5DpXOdb1auFAfri/RQ9JIIYPdfInoxwH7I7Tla4aUG7Pksq52kbkG2dwO/wnt+
	GSCoM0+x8SO1gLBDd9C/4iVUuTHpS3j9X++fe/nwkF4f+0X8f0TGil2/zNgtlxyhYEceNoJ8Uo1
	qYRkIqncifSSTpuOHRv4cj6OyxwNuqJtHXLg0DmUUyALlyQ3lkqYs0TvPOTNh6a08beXvjuVtir
	DDy3pxmMqcmSC1qv1zuCFMNvXUYJR84it8J1WmhUvvehN9Iy7otPN06YhuTW3/R9dn6mePAb6MH
	5aRfvhtXR0x7J96frkJGTwqtqDRCxb85347khx4dLt2a6zfQsRTuj0wqhY7m5IFx3K6cEiNvfP/
	mdcJkxpTGd8yQaAl+tHN2kbsOmHU5VUSZqXiiU7KPxHUzuhYorxI2Gzr/2k2F1y9iRicz4q7WhR
	1xRD9LoOay3oMsih621UKjB+KqrQfQ4O7ai59a93uO91ITk8+kpa1VYsLEjVwms0Al4Kf+aLCCM
	d010UOn159Ln3O6TJ7J7KHPFBWHb+7nosnsJYodLQmX88ToQQgaPGF
X-Received: by 2002:a05:6808:66c5:b0:567:605a:b8a6 with SMTP id 5614622812f47-567605ac3f9mr743665b6e.41.1793742017040;
        Tue, 03 Nov 2026 13:40:17 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:16 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:40:04 -0700
Subject: [PATCH v7 11/12] arm64: dts: allwinner: a523: describe the UART
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-11-c9e248d685c1@gmail.com>
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
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Identify the Allwinner UART integration on all eight CPUX controllers.
The specific compatible selects FIFO-depth discovery through FCC,
allowing the driver to derive the shared DesignWare receive thresholds
from each controller's FIFO capacity.

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

