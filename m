Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792873361;
	b=KXnVPJAkxTDuPBspaorCctWgZUxEPegT96KFsXF1/1Uo/MBl7BwxRIvU53PVppSIKsQl
	 I+9MkeO0ISAyx8PuoULARtrMwX96ZTPu7UZOlRYNckXUiAXvDt699KwHsuAfjFz7VLvwn
	 6twpTJ+XnWTFh97KO0sFpQraIlZajk2Ta05xfwmKhtCQah67Q2a+d8iWFksvim4TN1cS8
	 uxLdfPhbHkrxngY1bx6QG16VD+tytf8Z5sHJJUhM+hhvDuUA3fxflDLOISZ4tTYYjQQiE
	 ABbAqn4TdM1eG9/yAdhJkts2MZaQqlBvQ1Xf7co9XdD+Kkbd5V9jH9oWqSkMQK1liIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792873361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=t3d25DrrE5qm1Af0idWzUzDlmbOi3iKehZeUeGURamQ=;
	b=rCRF/YMTUS7z63medqX9XkkyhnmezejL5XSPTB9Y35XVR7uTKycxeBZnszu2mH2SXFS3
	 M4tOewSnswCXx99PmlCkiEwmVgbfbiooqd2/ph76vdIOF1Dq67JXMKAIOU32RGFmyTcJm
	 tXzaAENB55BEzMZeK4/C7MVcyPbMpDbdQIzjbiW6TrgPWO+T5kAVtAUk5wnOdlF8HctD9
	 E13rHOBDMgSlGWzNVGOiOHPmyw7/iWMMuZTJpy7MlyW+SqQozqd2NGoyJiLFVfmgyIgk+
	 yuodiT1H3/y+G09ZbrM3LY41kv2oycLOMtzkbg3bUpNxJAs2NpKjgnbqrTUKHlc2xFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WqIcS2ud;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92C606A32A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 20:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E92C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WqIcS2ud
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8253bc5a613so1254645a34.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792873359; x=1793478159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3d25DrrE5qm1Af0idWzUzDlmbOi3iKehZeUeGURamQ=;
        b=WqIcS2udx/nWAIpBgI4vxk7+jeyYJyEKEUUbPHZMbidORpLmfX20J8MT5vR9cEYmT4
         eYotdEVxMHfsys/m8CK42JgjE5ZWjOIsOAaPlUyF3I2oX886MgwO9gBIUo6bfkL8GU+Q
         OJtQOwReWnUrS8H1JAOn6P9Pi2KLROVObWXr4er0eZ63hJmEhTjnkR/0V9EDOXAChfJ9
         Akq2ncoTCcS34x4OYOQB8ram7ZRRBO6PhTB7x0jeGl2U/evir3RLVFr+ZnrZ75gzMmSr
         dflm3u/d5s2sNKmJwzIcY5mS4EHWb1XkGpPp5qKURt35r3ULutEwG1h3VpxyZsAqtepz
         d4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792873359; x=1793478159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t3d25DrrE5qm1Af0idWzUzDlmbOi3iKehZeUeGURamQ=;
        b=JQwaxjLAZCdpIoMHoNBZ+5Wa3ODdzs7/SO941dEwBdy5URZZeokHmbPr2eza0omLV5
         uOVIZMMTU99h1GBw3FbQYmut020Uzf3gMFz+dZoCjxmukY+N0UZGwDDfRXLwVHMUZdsc
         2hGxNTe1PIsBvHNMOUQMrvrMHWanhcJFtndslHdSTlkMnmY9X6dDpaYEC0rEXxevV6Ik
         fEepkpilMeNUcJjeWGNlrVIweicvVz5bnkFKuGKOKGFAU3dhoUQkCiKnB/2i+mAnRR7N
         6ZEJzc0BSc4HNsU6fkCb8ap1hA5k+MauumxlP9hYEjwQFOlp1xNAdyYWJIlfnx0rY2tN
         sJnA==
X-Forwarded-Encrypted: i=1; AKwUvBwR8Gxdd7styufPRGNXy5kv9IA/LoZY4E5HFJ2l6cFup+Yrv45dHzn2vCTiYGZDvdNlqL67s7M6nbQMTvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVNj6bstq5Eoq695Dse4NDDG3KmV7bNFz3JUFRcR7RE6Y3KDpX
	ncEHcbZpa4eXyy1RkrHWjUrz/pPjy4x2430JPQTUkL9hAOAyJaTmQPGN
X-Gm-Gg: AYBFou04TBUj4e1yoNirk/AKTaxbyHQOG/lBmfzVm0ZPDO+owwPS+6//dB0in8oRglJ
	O4xXC6XBCaUj7vmtei0THsDDudgJoe/9rq0AoNm4Oi5dETYm7coZJe0Lkwzo0aYN02QyS8JdlhM
	Ed9XwvqItEjxx4qhidcZEX0chAH8yfh5YMOaztP1Ox03lmp90joyZLOZeUHfOhhYz1yeLIV20l5
	5SzdRfcN0WcPT7fE0GGLnLYw1zjTfm+LpqaFKf4lMtDkEI3YFLDZApemie0kQrSIY8yH/amHql2
	2g6kwwlhb0Z6cv7Vnnf2v/8KSHo1Mqml7RC/44QDam+BhRWYGViKLyw2xl12VNUv3MjrjIw6ezC
	rNBfc3/+06OzUgC2rIPdbe3SZW+jsqYySKPgUBExBQpCGHWu8acMnj2TMIM6kurJPTQNpmtK9Cs
	XWSqw2JlmAPZ55CseOSffcpe9IKNHWrqfDT+3vEBCLBBgdVSFAmVRlHeqRB7kOR/BmnBklgSJ8U
	CnH8oUJIyQDzzYtKlaEmIukT+OeQ5f6O33mS2ELQWRUq7vZVX8FrfjJ6nAm/qdOHo2gyslvXSIJ
	BhastyYXp6Tw6esL3ZJXlbq47qA032UmRitQoAqGnkEWpWmzhr8BP31dxwrvik3PSk785M4oV0d
	1sV+0g1eg6yLG4zkd5vKq0ZeeEWnQGE6eiJ/i9SNaXseYKcqtSRrjggOzGH+8sizY0zXWU/ulOD
	wbuQm9LF2xGbPSIUEvF4iMBsed
X-Received: by 2002:a05:6808:3099:b0:4c4:8ace:cce8 with SMTP id 5614622812f47-55bfff7e006mr2363837b6e.8.1792873359652;
        Sat, 24 Oct 2026 13:22:39 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0424775dsm1815063b6e.5.2026.10.24.13.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:22:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 14:22:26 -0600
Subject: [PATCH v3 4/4] arm64: dts: allwinner: h616: describe the UART
 integration and FIFO size
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
Message-Id: <20261024-submit-h616-uart-fifo-v1-v3-4-286fc1b8c3c1@gmail.com>
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
In-Reply-To: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Identify the H616 UART integration and describe its 256-byte transmit and
receive FIFOs on each of the six controllers. The specific compatible
selects the register layout and receive-trigger mapping, while fifo-size
provides the capacity that the component parameter register cannot report.

Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
and uses the same UART integration.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 1598e86259ab..a80f26ee0970 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -538,11 +538,12 @@ mmc2: mmc@4022000 {
 		};
 
 		uart0: serial@5000000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			fifo-size = <256>;
 			clocks = <&ccu CLK_BUS_UART0>;
 			dmas = <&dma 14>, <&dma 14>;
 			dma-names = "tx", "rx";
@@ -551,11 +552,12 @@ uart0: serial@5000000 {
 		};
 
 		uart1: serial@5000400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			fifo-size = <256>;
 			clocks = <&ccu CLK_BUS_UART1>;
 			dmas = <&dma 15>, <&dma 15>;
 			dma-names = "tx", "rx";
@@ -564,11 +566,12 @@ uart1: serial@5000400 {
 		};
 
 		uart2: serial@5000800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			fifo-size = <256>;
 			clocks = <&ccu CLK_BUS_UART2>;
 			dmas = <&dma 16>, <&dma 16>;
 			dma-names = "tx", "rx";
@@ -577,11 +580,12 @@ uart2: serial@5000800 {
 		};
 
 		uart3: serial@5000c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			fifo-size = <256>;
 			clocks = <&ccu CLK_BUS_UART3>;
 			dmas = <&dma 17>, <&dma 17>;
 			dma-names = "tx", "rx";
@@ -590,11 +594,12 @@ uart3: serial@5000c00 {
 		};
 
 		uart4: serial@5001000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001000 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			fifo-size = <256>;
 			clocks = <&ccu CLK_BUS_UART4>;
 			dmas = <&dma 18>, <&dma 18>;
 			dma-names = "tx", "rx";
@@ -603,11 +608,12 @@ uart4: serial@5001000 {
 		};
 
 		uart5: serial@5001400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001400 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			fifo-size = <256>;
 			clocks = <&ccu CLK_BUS_UART5>;
 			dmas = <&dma 19>, <&dma 19>;
 			dma-names = "tx", "rx";

-- 
2.53.0

