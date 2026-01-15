Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954937BE78
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477296; cv=none; b=ONOGkNBrDFKff3oBit8nVnHJYyciFO2Dzko+zUXQRPZfgsM2WHvv4YmDx4VGlrjuTjUmbkxR4g3QuUP+SM1BBYHl3nl5zsyjydOazuYTJdj04DCS3p/JbrouFGYhVORl+dqk5B+1YOaAXPIlYO+FVzA9YFWE1g8j6GSoErs28xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477296; c=relaxed/simple;
	bh=kGLAInhaNaEk5rc2QTU8x+5FcCE5pgYroSfVZcUveHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4qsNE2kevDfjdQsFbcNCnHHi+BuvCqT/LzlecS9zeEOfQr5lI0f6bZzZHuHY9TPxRUGUWJCQ0mgEbn+eq2tkuM7jP2K4MCDpVsqtaTZm4wRmSz36NJO8BSK2yCY/embHS7stvFEeRfp3JWjQHl7fprxdXumTWlbAIex66qSMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=bgojcElQ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="bgojcElQ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233b172f02so964727c88.0
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477294; x=1769082094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6Hh4x4yU6+a4AjWH4xSBmP3UWp5wIhlMj96VEo5V8g=;
        b=bgojcElQFKHWk8J2QDM7bzI7VeTyPtMU5yByyGLHBGEn0Yzh6BeApsylOLgTpadW4C
         KTO1oV5OARVmQgoUL2M7aMX8JxJbTyaGXnuY1QlkT9ZTwtT4DFVNXsbB7oM/L3ESDuh+
         IVs1btTKYgCKpoOZMrBCkWDrae+Qk25O2wHtNBudsylq5Gdj9fYDS2GIRpqIIdBYA2jF
         hsfBZOtSrnv2D+T1AfKZxKG/klbK0DitTvy5qNG9gy1RmjLb/J+wl2WooBVlzq4LRMJP
         vwoW4R36Rj15ZIavj6NtwxzN41g92CfBvH2dEcieMaVZeOXyIIIJw137E7xK7o4Zmtrc
         sZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477294; x=1769082094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A6Hh4x4yU6+a4AjWH4xSBmP3UWp5wIhlMj96VEo5V8g=;
        b=UfpjNFg7X1mWY/+dyPd88nF/3MhAGtQlLZkCk4tOGgZhTq73tgRJfrnPa8bP6/ReU4
         Wm4t2uwJkyqJr1uosXGosQwXJN/UYg63cgTWslXUhghvYG7s1kl7575qoWjv89lmYcsl
         FKlEomoSl1tN0ty89ev7U9upoNP2SWW7gbgEd5L0rEwTomptr+M+LhgTjqoeKSc1Nr0Z
         2xSr007jXsjoCxD3ck3YRFmtQ7mYR9v0XO6mpGQ4tZb9eaimjYj/V5jpQT6oVon9SWIl
         ZTfKsu5P0lb7qNhY5U5m4Y4RAgnhwbjQunpSIAOyccR2LbHqfQcSALvZxjr1NONJ0c0O
         bZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHqvaL5T6gBP1SLc77jt/M3lhrTDJ6J8AQb8HovrNFBRqANPVwtfUgEYtpgaTYQi/cT1w94MfFoDsq/to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBrVlrPzrPBRNB69Pomzcw+SAAHrC0379HMqcA6agSnDkMBbB
	VZo1LUGE+RjHyv2YOnDh8nUo0fbn3gP8g2GTXxdQE/OMwhlmJ9nwSRFMZierNDf+G9M=
X-Gm-Gg: AY/fxX7SynnA32u3Latt6c2ceR1zntiudbb4QONUxrPvkoBUCPYXHnpcBj21ADTGtM6
	2t3u8C4439U/yrksFcIFsyvMjaqO50YuOcWIboIxC7vjph26gVf8HiGuENE6vVlyWmsImMWeFQB
	7hvUaNn3+BctY2lL8ffXjkJsZjmpgQID8Z+TdpN5pkOaAVnAU2NL7D8cEFaNAIBqYZskk/Fy7Ax
	BrD3QHLi/8TsCc6jB/Xnb7Xj63X4UXZYKUM1RjL5+hwhP0Xb+VVfkCibsvdfI1/715rA0uVvj4B
	ZnYsHKfEh6Z2O9h61dDPtXhbhu4BpEbQrt07sGJ9GBRCmBKXygRR5gU3cNV4c1RtfAgoISy43bc
	2Chh4B+AN0XftSpJ8oeXTu1QVozqLP4TYABanINUW0Rvhn0h0EKFeOrlh1kbw/Rqq/fdXuhQZX5
	GzUm1xgpjXxWa8JsDCCJadJzc08lSlKKjWl+8Q/97HbWRcBFl6Uio6i9QdomDkQ/BWHO7Zb+by/
	HhO6lR/
X-Received: by 2002:a05:701b:220b:b0:119:e56b:98bf with SMTP id a92af1059eb24-12336a82526mr5837069c88.38.1768477294058;
        Thu, 15 Jan 2026 03:41:34 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:33 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 07/11] arm64: dts: microchip: add LAN969x clock header file
Date: Thu, 15 Jan 2026 12:37:32 +0100
Message-ID: <20260115114021.111324-8-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses hardware clock indexes, so document theses in a header to make
them humanly readable.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v5:
* Relicense to GPL-2.0-or-later OR MIT to match DTSI

 arch/arm64/boot/dts/microchip/clk-lan9691.h | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm64/boot/dts/microchip/clk-lan9691.h

diff --git a/arch/arm64/boot/dts/microchip/clk-lan9691.h b/arch/arm64/boot/dts/microchip/clk-lan9691.h
new file mode 100644
index 000000000000..0f2d7a0f881e
--- /dev/null
+++ b/arch/arm64/boot/dts/microchip/clk-lan9691.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
+
+#ifndef _DTS_CLK_LAN9691_H
+#define _DTS_CLK_LAN9691_H
+
+#define GCK_ID_QSPI0		0
+#define GCK_ID_QSPI2		1
+#define GCK_ID_SDMMC0		2
+#define GCK_ID_SDMMC1		3
+#define GCK_ID_MCAN0		4
+#define GCK_ID_MCAN1		5
+#define GCK_ID_FLEXCOM0		6
+#define GCK_ID_FLEXCOM1		7
+#define GCK_ID_FLEXCOM2		8
+#define GCK_ID_FLEXCOM3		9
+#define GCK_ID_TIMER		10
+#define GCK_ID_USB_REFCLK	11
+
+/* Gate clocks */
+#define GCK_GATE_USB_DRD	12
+#define GCK_GATE_MCRAMC		13
+#define GCK_GATE_HMATRIX	14
+
+#endif
-- 
2.52.0

