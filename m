Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C583ECBC3
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370810; cv=none; b=foBXTral+TZZ1EeMnACF6GuxkKoEN23ZyXrsL8ixpUjPfpVKuHTC+XfLZEGJNXHT7tqltFTh6gTaNJ2PsagzVFTfQ6lW4RTVfjpmIQ/u0HGyBagm1U1WrOBay9esPytMbbYy1ZzpZVf3at2AVPXHpXfZ/q0LgjilJUOKS3fmxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370810; c=relaxed/simple;
	bh=OkP3mdKoK/wb2ZT5jYJ/ZVN3/jOhvWuJhUE9h0qF2VQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuujyYLZ2DJeAwfx00/3Y9kR5F1Tw/puJBkJjK/lY9PsPWikntP3tNZyvYulBjLVBgFG4kaNVmjGoJrK8aLBtWnDkXtU/NOourNl2XVWZzbNHA/eMmOxAdCMyDAk+b1TaMpGdg6RvMnjnSizclihXf1eAZVEK6QY3Bz+Jcwg8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezm15MJh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezm15MJh"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d7645adbdso3021011f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370801; x=1776975601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sy9TqEHIxN6NK0fYsnvnEQIWM0euuGHsvcvwSpdM1gA=;
        b=ezm15MJhGSjXPV1o2EJ/o/NL7xY5wwCbS6HSZMRr318vwDyg3jHvHSZh5TUff242y8
         PT01dYxAyohICJTA9xpvDFL5g5OW0j656zDkasHsxftRpDUerci1IRxmO3OBcgbHMU6b
         Ark/e+NJ9JfpKX3CK152P6iVkXLyTcsHAs/AspslTWOtQeapsQrhw7i7rfR5gT0jf3Nm
         lSLSlUDZ/DXmv1cQ7J++xT7jquYxJs/jIGMbrjoMBd8HwYEKx+ni/isvCCI3PupXyVHx
         92nAHwIcH4BFpJMzaN7lHWsP4FkVQNb+EqVunR4zMivpauXDRDsuInxQ7i9CwxOt7uhc
         IV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370801; x=1776975601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sy9TqEHIxN6NK0fYsnvnEQIWM0euuGHsvcvwSpdM1gA=;
        b=kHX5fulA8IKqHYeTI5+68eKGXURam/kGlNltWioO0TNSsbTzVe2n7pk5df3S8M+ip2
         cwTwxDFM/qwAnFIRVnbC3LHYLEbs534IDlPAzpuSnqq7O2Mf2qMXRacfX4nm+eg3atg6
         VUwqHVGty+E2X5ZzkqRL6J48ybQXXUqc7KIM6qNy6dwarcYDoNe8VoBhQlxkIDMDkgZ1
         g3neSI516uHKVCdi/wNsSNvdQSpZ86JY3r5AqNOkK7G2dMvEWbDKeFKFSOwFWU+TIa1D
         2cyuQ7q+wxWPnP+nFYzN9DV/trVT6tqTZPiHH5SffLv4qiHkrsBZxFjNuDFudr3TMuyu
         VPuw==
X-Forwarded-Encrypted: i=1; AFNElJ8bZkMnaFgBm/5UDZMWaB3LtjBNL3GyfxXqfgewI0F7ZADPnnkKp83UqxZIL7a1WkRzzYQtl8b+XSduw5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMKfa20/qPMm/EVczY2ys04YB8GgH8b+mYgPKjZ0OZIy3KRf1
	YpNcjx23hbEbHyLIMFmVYs2RJWre4UlUV0Y+wLQVWuX6EDHyGFzPKzvv
X-Gm-Gg: AeBDiesiCDqT74Xib0Xu+xB7czyQCUwzV2ooOdexZrR/f+e7/Q4XpfKFhapmwsdxqVY
	OpEXObNVXSDfZjoxEJHK6/7ewH2RKFaB1AHT/JdtZtZoUxhnWfZn+cWrrHE1WkJtEgZRjVWLRRW
	/ZGTQR0J8bpbDwmBemBvagwWKj3/4n6RqUFJrFoBe7YzOELvbyCGR0V36AMTP9Yda5nIlY33HVB
	OsKTP5chrLIRE04IHtrnOKcw0PdN0gVwD+Sv71Bfhx0Grj3+tGXg5ntRiPm0bYZK4zUGtfnZIxG
	Obl6wTk/Pa3TZAa7CngNowc4a6vbHiyPMmGsiZqCjeDoGxuaTCoXy5JwnDNN//WLcJYadEX1bRW
	XVVcib/MJ07PPm5DyvtzqQ+i52vIP8YliAXfCetSWSQQRk9FMs4lKHpPnSdJXeqrbpzOqj88G52
	Sg7ceUQILVbWR8A9KbdWwBixDKOEaT5fQe92j7CauBgfA1cw==
X-Received: by 2002:a05:6000:26cf:b0:43d:4a43:53db with SMTP id ffacd0b85a97d-43fe1596617mr1025259f8f.26.1776370801383;
        Thu, 16 Apr 2026 13:20:01 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35c026sm16180624f8f.15.2026.04.16.13.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:20:00 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 16 Apr 2026 23:19:15 +0300
Subject: [PATCH v4 7/8] ARM: dts: Declare UART1 on zx297520v3 boards
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-send-v4-7-e19d02b944ec@gmail.com>
References: <20260416-send-v4-0-e19d02b944ec@gmail.com>
In-Reply-To: <20260416-send-v4-0-e19d02b944ec@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 soc@lists.linux.dev, linux-serial@vger.kernel.org, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=OkP3mdKoK/wb2ZT5jYJ/ZVN3/jOhvWuJhUE9h0qF2VQ=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp4URLcuxim/TQS8pbKO5tQensiaHCwPrFRWbsQ
 gPtxXIEKtaJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaeFESxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiI07g/+J3gFaCAibP2Uu0oP9XXc2ViXRxyXuQ6
 FAr5syZvJc3oJiuQ8lPxaVfhIeRQ/TzRFaWYm4TqFFcoF8CFQku3LTCQ6CC3inaT1TFnlUH7LDB
 DsBg/9ZCh836vnGTHhbrR4IiqackyVH2zvAqFSqk4mfvSASEuNdyOXELcC3/moctlguw8xpR/qk
 ienfNlJqmmmy50hafQi8gmr7xx9zwBLOV4aBbQfX+Zp6v1KZ7hxMaSknODVoa4AmVKIpSOzbulH
 NsGOCLhnJyeYwYU9Uu7CRZqf2cCVeLSJf7fWHvmVxa94/DoAHMl0O4d+EweIqKbH1zPxkQQJ0TF
 bi3cfdDQI3GNgboNRWpm1kyhyplaw/+CG0r8OaZbt9z7DVw3+bdKEVaKDkCl6Gfw3PcJjfYTjsj
 rC/vAByXUmH5gMnozEauB6uMQX1ZY/mcqfvfymRnOOu4CokkWbDMLvFnvj9XEmNjYI4Tc1qlhEH
 KgQKGHrK/pBDTb027GsLc9Gqcb00VrrniSvf3V/AjwlJ/yhMILQzBrgaSg5BJKxcL7EEUTU7vDO
 pqzhEYa/7l+q14+34gB9Pu9fangdFK4cB/jwYClSMrZNlZFnnmlYXtwGeIWRMrvkq2s3haie5dj
 uD7zjc/BZ/mFFBqWm9n9JhgrrQl25WEY1fsfP7pI8rXoDDu79KTc=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This is the UART that sends Uboot messages and is accessible via pins on
the boards I have seen so far. UART0 and UART2 exist as well in the SoC
and can be used with the right pinmux settings on some boards. They will
be added later.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

The reason why I add the serial1=uart1 alias is to keep console=ttyAMA1
stable regardless of the other enabled UARTs. UART0, as the name
implies, has a lower MMIO address, but uart1 is the one that usually has
the boot output and console.
---
 arch/arm/boot/dts/zte/zx297520v3.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/zte/zx297520v3.dtsi b/arch/arm/boot/dts/zte/zx297520v3.dtsi
index ecd07f3fb8b3..09fbb1d052e3 100644
--- a/arch/arm/boot/dts/zte/zx297520v3.dtsi
+++ b/arch/arm/boot/dts/zte/zx297520v3.dtsi
@@ -6,6 +6,10 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	aliases {
+		serial1 = &uart1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -57,5 +61,23 @@ timer {
 			 */
 			arm,cpu-registers-not-fw-configured;
 		};
+
+		/* The UART clock defaults to 26 mhz. It will be replaced when the zx29 clock
+		 * framework is added.
+		 */
+		uartclk: uartclk: clock-26000000 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <26000000>;
+		};
+
+		uart1: serial@1408000 {
+			compatible = "arm,pl011", "arm,primecell";
+			arm,primecell-periphid = <0x001feffe>;
+			reg = <0x01408000 0x1000>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>;
+			clock-names = "apb_pclk";
+		};
 	};
 };

-- 
2.52.0

