Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299659;
	b=PXLCOxLSnQUCliqFcba7uU+gaCVaKBed1Xi9vc/JawyrTSQVAUrhDpK51P3JH4uEeCVj
	 WCaZk+6Cld3V3ihq2VCyYZoSM3DDRM0ld91ayoZYAxSxNo6tAuqBG/xgGZn5Usw5qgh4V
	 TdfKf2i9ZFkms1z83r9/L53hWjtI7b/nWKuCoTnK3nQtPwF9yPpH4Zf8ZmHEy2c9xlILB
	 F+VtsZ/lq9ya17Mqfo/RwkpKpArGzB03qiJaB2QdLMDsE6+O/HoaI8gtAmniUUtfbqE+e
	 x1S31orT0ndoZH+m9HFVeNLpsJq5XDV7AmPpwChN+0z9eQfaJDpQS7MFIPwXuRojY0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
	b=ObffZAradym+FtfMq3bxUVEsiP4t9n25mm9PmI2JSJ3whhADwK8kV0Iqbfic8q1qaJVs
	 1+65kaAHQDUwPQl7nYQ1+K75j8zeCTEe8aFbRRPir0fxCUgiEHZOpBbmh9T9BZX3HXAxU
	 5uIc8MU2kPje6AedbYeKoUN1sJTwpDxrGQIfFTbghKmbN6rSlcMfrOZbBjTKi8jMo6oDD
	 Q5zoGfMYPTpi92yXgbRQv24L+OsTdFRnyJyMelHs8y5kfLaN8iCedinG0pVkxKiOquZyp
	 iUf5+GFKspTyExwd7Kf0x+8xDfjHzLChavhAcTsf4aluZOvq7/weavswk5iTX66M9gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXQJRQj9;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E760A2636
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599E760A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hXQJRQj9
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6de1fd5f572so1224124eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299658; x=1793904458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
        b=hXQJRQj9rDCCM54LxLJ0O0GcaUqZZ1vbaf5ccd7XzTXCcm8o5nGy6Yj3i6MRM2zDbs
         Tt/NJX9+NBWqKZlukA/OBfyPR9mRBJOoBoljBFdXLsS9JPCZLf1a9mTy1FHcgcPrTbqa
         TQSEbJo3AD7U3WXbfzRQmvfJ0g5CSN2ixjJPG7nxPDJ7fhItwAHIZqA2ZQW1hKQ97XyJ
         PsQIKLyCbU85mm7xGRHOsZruQYUjZJk/rFe3agJ9uS3l+4VtC+BFK1RP1lx0KdiQGpR6
         SYDXeEH6YhKijleqGgsdlQs6Xh1Icotrg14Ukr6vyk33OZiok526+TaFA4MegRsvIjma
         +gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299658; x=1793904458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
        b=FKigIh5H9UUuN82aH+eTSLdQFeO6DJOig2VDJPuPxNtnG1s0Q3uUuTZzZEA+HvyXsk
         66tFuicbxTKut75LFQwa89CHNdWDiE7oxcH2OmHylXhRHQ+1DC6v0+C+Vu0ntjHLYWX8
         1TySj6n7Yq3PzCdj3qlQmiHwVM56Iud1pW9j+rxMmKZthwdeVsWbdWVf0aFRoTigC9Ga
         PzW+YsOs1AwCzgBMnSlSOreEcgFjhUkFvHWZOCDYbhDQnukRrfD65cvxrFLvxE+Cbnaf
         Il4iuGs0GQBh8sfi5let6Cs0nhspRYrplanWBO+CU6vIDLiOMIbioLySD1hhGMzLfXVp
         vBVQ==
X-Forwarded-Encrypted: i=1; AKwUvByck9wzlKsOK3iEy/pYs7sy5rkZPmjaoDujObjg8NFgvw0scdvnqFjfLd1xjNek/hBpyW7Us+lbXji2jMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxQJqUNrnnGfMpr15FyX3O/RmbqSfj1rJ9TsUicUNIZTKXfGUW
	HYCPoHQwZnFowN2kBuLp3j9Hu85s89wkHHHpuwb6GkkeLmqVQR8FvKNA
X-Gm-Gg: AYBFou3geCsCiMMRzxGSvQDzJYG/tSmKYBr9PXfUacm+R8EcEyY0pjyQSXI9sKZd2Nb
	jLvHVguQ5LNzf/YnciJ3iqZjmRf0FQisoC7A1O4fvXt8l6wQ9mOBcdHw0DRaVxWoIMGErQsEcGH
	YN0DY3rTywjBT3TgsPSn8D8tlARE3uiximtlAs9RHLE1OP98HUwa2Yw+OavHIu3nd+vSwxLuXY6
	yQBIVI30IOTnPYXPk2BYAQNpVVKRAyT1KPbLYGxRKNGeq69Td24dWZ8j2npxj1djTAYZiPZcpN1
	HAP5cvcKnSwOXH4jH34qnG8EOEU9aAsaVN6JscOdAylYKSFV1VhuPW3RigBMMo+sTGo6wdke8wz
	cdpPIVfDMvg6vcM9+kr8JcQKVhRI89H2wOT0uXmvMzLvlkIZwjcmZ6DyowBu0BA/2PpL9NPNUzH
	6V+lFib2WCkRgcW/TJbfCNIOvZ9PTaLNfzTQLBZKNkJH1LKZ0ZQ37p7V9tcofRnPag3NHnX/YSv
	pWqVwDbiG0vzjGa5qbsC/j2IAHgRMocL0aT6MnOd83bwiVxpgfSYuY8uX9LTcMqC32mcgqWicSw
	96Cse4Wj4sIhRp5QCikKwVyfVbuqEHTPpMrNprjqhQvido+f4RYig2VCsCBFQH8EC1ZbefZ0dHN
	YrtpBjb8t0SHgiAcv8IfvCZmaU/og8JX9Em9GVLE5pIB4dZ2oMCWytYcxODKy+3gKX5yRzhJh/n
	xBA7M+NL//rAbf7M81GQcD/xc8JOoIW107oDPLTNyan7f3WFAKj3rPRYsByhkfoWrzOw1xoQOG
X-Received: by 2002:a05:6820:c44b:10b0:70e:1dd8:6712 with SMTP id 006d021491bc7-714f29f3ee8mr66212eaf.72.1793299658351;
        Thu, 29 Oct 2026 11:47:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 12:47:26 -0600
Subject: [PATCH v5 5/8] arm64: dts: allwinner: h616: describe the UART
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
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-5-53b433aebbf8@gmail.com>
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

Identify the H616 UART integration on each of the six controllers. The
specific compatible describes the fixed FIFO capacity, register layout
and receive-trigger mapping.

Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
and uses the same UART integration.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index c6b3a3f8359a..b4b2f85726e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -550,7 +550,7 @@ mmc2: mmc@4022000 {
 		};
 
 		uart0: serial@5000000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -563,7 +563,7 @@ uart0: serial@5000000 {
 		};
 
 		uart1: serial@5000400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -576,7 +576,7 @@ uart1: serial@5000400 {
 		};
 
 		uart2: serial@5000800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -589,7 +589,7 @@ uart2: serial@5000800 {
 		};
 
 		uart3: serial@5000c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -602,7 +602,7 @@ uart3: serial@5000c00 {
 		};
 
 		uart4: serial@5001000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001000 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -615,7 +615,7 @@ uart4: serial@5001000 {
 		};
 
 		uart5: serial@5001400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001400 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;

-- 
2.53.0

