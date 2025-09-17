Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A832E22B4
	for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143070; cv=none; b=EUWQvClq9FtDhTmIurKvwGOLwejASHlxnyP+c5ZUUYU8Rw3XYVxLcSTLiNRGfcLD4sBQpbJ7oceLD3ZqrfBHgEggGN5/Rf5AWvXbKFT4+oW2pf/sQ41ZwInsREh7QxMT0rTSsyrSpq853AkVm0EcVm6r93uNQM2ggIQTrXSo9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143070; c=relaxed/simple;
	bh=dpzH3ZgZfhAHeookD5eV+FtY/q5RImJCHodew0fPSVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thpwOU64Nqa/9KxOs4z5EEoZA8V64mUG0a5Xs1ZAAR4C568NRe4ZvoaHr7HGDKQXAcGqVROnsbw9dH5sYMPffrwjQRtNp0w5DYdPSp8D3Me98B83lHZSDIp+Od2/pYsh4qAGHUtd3fpT/n0E5E4BNrizITHcUHU04PjKG24hw1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeGsShaT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeGsShaT"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78defc1a2afso2963166d6.2
        for <linux-serial@vger.kernel.org>; Wed, 17 Sep 2025 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758143067; x=1758747867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rScmOcK/Kz2XNUOFOt6dJ286EcKY4tMZMYUqUQHpaYg=;
        b=ZeGsShaTmxDAVtApix4bayEHtWhb8LsKK8t52Wsotfm/QnjEFrwwJIYmmoaB+JfVDw
         EI6q86F736YuN6txsW8OyfKt+vY+SKdumWlewpLMtukU3Iq8bSiHzyoHclWDdS145lfV
         TjxdUelO5wlHrm8N+qtKVnSxxnlsC3XE+QyYoroEDKBN8ex33g1ftuqHb7ZzGl+UdObD
         5O8H/ypU5momudp9okYcedtr35/pzR+NPmYaaJW5kSzikyZWFj06vaYWPHfSVbtbBiXa
         A04sWgyrnX7jrddHyNhb6fnBesj8dBiYdf5ZXQuUXxB1WpIQIHjbpR9X5ZM2uv4rbBCx
         lREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143067; x=1758747867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rScmOcK/Kz2XNUOFOt6dJ286EcKY4tMZMYUqUQHpaYg=;
        b=g8XOpnBrV4YKrtZKhjiy4BGPei+/HzmhwIc1XnJQRkKpKLD0PaSnZIz26upnvW0lwS
         dMQXCSsIkA90Jt82QDRskARYHLJqoejwGFVvxxy8ImoTed4LdoNE3BTolmImQzBXdhgn
         uDlSXhHuMmun2Z9bCicteKi9YdT+x2n8R+cJ8vkIod0/suMkiPLzU1gvcy0d/bdWAk0w
         vx+9PO6q+QSpP8sZtCpbHHqEVkPFqMIx9BgvskjEHsEs5DmpNPUw1ieS2EEaNgtPebfR
         f+Aj06+/VUMvX1u3sWOJL+TmmCawngNHjT5JC7vm2/CPydlU4S6zbo+Mhjm37RnN+5zt
         PMfg==
X-Forwarded-Encrypted: i=1; AJvYcCV+RVwgzsUid4eXacxW9d9H6TbJxZJRlMYlhDiCui61lEekhlxu0Vfn3FdzG7JXaJprWcqZiJmFdWqkOts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uDWbzqHyoMBhoLZ8lPLDIdlOoby06TrmOX3pqsGOZpYHJ7/E
	e5Lyq9KP/GRXAsNL+7cz5PEsSGMDf5t0wku/L1vdX2cuzshPH2rz7Vrq
X-Gm-Gg: ASbGncvUg95odgdfiPfSK2yjU5M/CCixHLq4vCcZP7RkxOrU3pSmeLBJHk5akkeSYRG
	C3zL1UcELYY7W+DDWtx+bxxf87UKXuf3gV4Rr8+39+QO4N5g1btsMTCf4LAgXGi6Ihkjni5OhMS
	337XjLZCKORs+LsMRtVnOS0iaN8K4Fb6s0DY2+qui8ONl6fjVd5DdChWuZI041uSI+dUDrXPfSy
	zFU8YurLmL749Fmgp2T3aDIaeDXzoW5+e7BahgmdywVOmqqr9EMViUIi2aKbIaYEtpM4sPr93h/
	a2OfMQr3g1KeRt2S6zAyKD0qVn7YpvqC24YcA1X8iU84aALJ2oEMr3bd77DQlaByhvgsyBZn3HV
	MJV6aWciJifOz3RId1QE+RCvcYjfVag5qQFH8trrItmNi
X-Google-Smtp-Source: AGHT+IExuzovxP8Zn5vlfq5BEJhcOcbH3jOSulS76F9O+uegFBEF1Mh7x8YWAUPDWU56s84wZ9djlw==
X-Received: by 2002:a05:6214:5183:b0:77a:29ba:1b68 with SMTP id 6a1803df08f44-78ecf309395mr40268536d6.63.1758143066759;
        Wed, 17 Sep 2025 14:04:26 -0700 (PDT)
Received: from [127.0.0.1] ([51.8.152.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793543ffae5sm1897226d6.53.2025.09.17.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:04:26 -0700 (PDT)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
Date: Wed, 17 Sep 2025 21:04:24 +0000
Subject: [PATCH v3 4/7] arm64: dts: exynos990: Add USI nodes for PERIC0 and
 PERIC1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-perics-add-usinodes-v3-4-a3629e4666ef@gmail.com>
References: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
In-Reply-To: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Denzeel Oliva <wachiturroxd150@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758143062; l=9012;
 i=wachiturroxd150@gmail.com; s=20250831; h=from:subject:message-id;
 bh=dpzH3ZgZfhAHeookD5eV+FtY/q5RImJCHodew0fPSVw=;
 b=XR7xcpWVxcZIHpVBO57uE9viom3J0Pq6mzGf3veugSWl76SHxT7RB0V4yl4YmE5SRe8q1kGE8
 vZshDF7HGEtBhwL6CU9L1xjGXHc52dMs2A8r9fHgEqKkm8xFhECio9+
X-Developer-Key: i=wachiturroxd150@gmail.com; a=ed25519;
 pk=3fZmF8+BzoNPhZuzL19/BkBXzCDwLBPlLqQYILU0U5k=

Add USI nodes for PERIC0 and PERIC1 blocks.
These nodes provide the base for serial communication controllers like
I2C, SPI and UART.

Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos990.dtsi | 247 ++++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos990.dtsi b/arch/arm64/boot/dts/exynos/exynos990.dtsi
index f8e2a31b4b7519b83aa31deefbc40e5edbb8186a..1e09f3efe685748789ffd346cd914f9a8ba68f8b 100644
--- a/arch/arm64/boot/dts/exynos/exynos990.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos990.dtsi
@@ -272,6 +272,123 @@ pinctrl_peric0: pinctrl@10430000 {
 			interrupts = <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		usi0: usi@105500c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x105500c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_5>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_5>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1004>;
+			status = "disabled";
+		};
+
+		usi1: usi@105700c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x105700c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_7>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_7>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x100c>;
+			status = "disabled";
+		};
+
+		usi2: usi@105900c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x105900c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_9>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_9>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1014>;
+			status = "disabled";
+		};
+
+		usi3: usi@105b00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x105b00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_11>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_11>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x101c>;
+			status = "disabled";
+		};
+
+		usi4: usi@105d00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x105d00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_13>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_13>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1024>;
+			status = "disabled";
+		};
+
+		usi5: usi@105f00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x105f00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK_15>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_15>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x102c>;
+			status = "disabled";
+		};
+
+		usi13: usi@106300c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x106300c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP1_PCLK_3>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP1_IPCLK_3>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x103c>;
+			status = "disabled";
+		};
+
+		usi14: usi@106500c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x106500c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP1_PCLK_5>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP1_IPCLK_5>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x1044>;
+			status = "disabled";
+		};
+
+		usi15: usi@106700c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x106700c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric0 CLK_GOUT_PERIC0_TOP1_PCLK_7>,
+				 <&cmu_peric0 CLK_GOUT_PERIC0_TOP1_IPCLK_7>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric0 0x104c>;
+			status = "disabled";
+		};
+
 		cmu_peric1: clock-controller@10700000 {
 			compatible = "samsung,exynos990-cmu-peric1";
 			reg = <0x10700000 0x8000>;
@@ -295,6 +412,136 @@ pinctrl_peric1: pinctrl@10730000 {
 			interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		usi6: usi@108a00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x108a00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_PCLK_10>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_IPCLK_10>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1018>;
+			status = "disabled";
+		};
+
+		usi7: usi@108c00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x108c00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_PCLK_12>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_IPCLK_12>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1020>;
+			status = "disabled";
+		};
+
+		usi8: usi@108e00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x108e00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_PCLK_14>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP0_IPCLK_14>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1028>;
+			status = "disabled";
+		};
+
+		usi9: usi@109000c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x109000c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_PCLK_0>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_IPCLK_0>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1030>;
+			status = "disabled";
+		};
+
+		usi10: usi@109200c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x109200c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_PCLK_2>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_IPCLK_2>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1038>;
+			status = "disabled";
+		};
+
+		usi11: usi@109400c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x109400c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_PCLK_4>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_IPCLK_4>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1040>;
+			status = "disabled";
+		};
+
+		usi12: usi@109c00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x109c00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_PCLK_12>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_IPCLK_12>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x2000>;
+			status = "disabled";
+		};
+
+		usi16: usi@109600c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x109600c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_PCLK_6>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_IPCLK_6>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1048>;
+			status = "disabled";
+		};
+
+		usi17: usi@109900c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x109900c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_PCLK_9>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_IPCLK_9>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x1050>;
+			status = "disabled";
+		};
+
+		usi18: usi@109e00c0 {
+			compatible = "samsung,exynos990-usi", "samsung,exynos850-usi";
+			reg = <0x109e00c0 0x20>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_PCLK_14>,
+				 <&cmu_peric1 CLK_GOUT_PERIC1_TOP1_IPCLK_14>;
+			clock-names = "pclk", "ipclk";
+			samsung,sysreg = <&sysreg_peric1 0x2008>;
+			status = "disabled";
+		};
+
 		cmu_hsi0: clock-controller@10a00000 {
 			compatible = "samsung,exynos990-cmu-hsi0";
 			reg = <0x10a00000 0x8000>;

-- 
2.50.1

