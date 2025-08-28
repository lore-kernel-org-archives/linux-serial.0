Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015B31194F
	for <linux-serial@vger.kernel.org>; Thu, 28 Aug 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386935; cv=none; b=VfkU7EdzaVnHx0SQS5zpVPHylWMMVB7efAZ6aG9DpD+r43f2XLMHvqYIkB4djPoFR7RMMuOXJG2zyOF6omSdj07InFJaKadeWttTfi2J6dBipuuz8M9Z3joFrfuOjyNT8R2zwull+5nXYrJmEGNzFPHJa415kER2CYhXHWIDxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386935; c=relaxed/simple;
	bh=1keMc57+QR2CICrcPlWaiGj5bDJ4SG5s8RArDpJq+tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYvq3fs6Euz2tr2WVklKLxNFvsJXl0KksALnkXyULrSZyVhpko7d2XvZNErn0Ag+nLwsJUMKeG/0iMdiSap1lGhog/kyrrH2Tu0z/ezBSaV5Ul+6sGTFiWUmU26qUfNeeSF0LJ9Q6sH9D6k/748vQSaERUjfAp0QTCwbCbnprjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N80ITG+6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N80ITG+6"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae31caso163539666b.3
        for <linux-serial@vger.kernel.org>; Thu, 28 Aug 2025 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386930; x=1756991730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukdxjc5DrhlQ7eBdrlN9f+Y4/ViYX/zBdRo4k+wcLt4=;
        b=N80ITG+6x2Tn5bfvb81vUxELGuDHJx4Ucooqu8aTY6Fp4idr3Yifp7Fl+Tg2gPLWcV
         yu37Pf7EqDy3c6z1b07B3EgWf6ZCAO6JG8DtYTtK68SLVK14NlfrWwHrQ7+tYcbRP7oT
         6pPWhYNrDAh4Px9nbvn/rZDfR465Pzezpr/Td0O9Ipby+tP6r9ixNU8h7g+eLWjjxr+D
         rzCIifCF+WWRCZqkB7RE42cMGNGR5w+QOgykTL0txSFpIlnRkMJZu8qO0uINIg3p8vg/
         TecaQGRqE3efQ/jZ1/pqow/nkc+lpwwkgfENq7b4DEg+1ZmLMfnDYnR8Bs2h+0r1NfgE
         zt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386930; x=1756991730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukdxjc5DrhlQ7eBdrlN9f+Y4/ViYX/zBdRo4k+wcLt4=;
        b=dNoJ3BW+DHGRSFrBZSux03lRauOP5kL9uVaprRdMyv5i5j3H6ZcB7M1ujuTmZr1Ug/
         cabEyNe9Jgq0r761ntEHIaNDr3IY5VfG2PxoWI3vF7KAPakHGZ1kIX67tdxunU7MViyH
         +wmS2V0awHkzWQO9aGQnQ4/s1Sk7YjNBwkmSYJ2TyoOZ3M/vMi/B7aaRqmcQfp3NpSBg
         yzkqWDWlg2JoB1p1pHBaQ/14bG5WuGMHiNipx0pPDqqkKoDqcucIHdagliALiH88elFO
         XsJsIaf+C8FTvw985q8m//9xODB0AsR6BG2mdsGc52DdObK+P2o84llj5QrMT04YNsWE
         1K7A==
X-Forwarded-Encrypted: i=1; AJvYcCUhqcjqh3DJs4vWUREnk1Tvl3HymjIppH9NJbfjdTShviOi5qBDPdJAlL1c9nw/y16JEzfh6hR8hliUkvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcqbuo22ducpLchD7qDEsipC0AnaNpEnlKcRRIpTtDM5B0QU2
	j5/h4vrpOZfJXyn3K/q84orR/blO5EgFTHH7wVz9Fh5XTvUZUJzVpojiz3Ux1xP/5Io=
X-Gm-Gg: ASbGncse3G/rfadiKikytaDIIql/03O/OkLr66MiOm/hYYolKiOdolyWv5eKTdUjAyT
	dWKBebpl6okfvA9Em34YN91ke4K4dxch65mrZAgsgpB7DftRFt3GexCwRt86rzXhv6oKQ5UIU6D
	xpDJHePWfkourQghHOPJGMCrTyuoQLa9wbkY1wP4GrE3M2/b3WzxuxnFn/cWAdX+rwK8ELsA0G3
	/sMd/S3CzxUXqN4dc8SHbpnnR+jBS3q6338plj5ennOYATBwgVs3wA5/rHKB9H7DG5nzTB3eRkf
	ZcJjo+zf9dESfPsKpkNaffl9rN5v2F0eu27viTn51SWPPFSSlpGzfg4Rtu2cWD4aicnxfAhnWiN
	Zmj/wKFai5alG2BYkpFwIxc+8mBRWp6SuUiQrRmu2rxUPcQh8uRHUd3w/u9znv5qLwaHx/50SAo
	dICyE+zeReNETPso8Smb0FjlJk0+M=
X-Google-Smtp-Source: AGHT+IFH1vLiPwLLOjWdncMu9CzzMSagWLiPnUFX55dhZYQCF06QAZ/tGnpnN+tm8vZ99g4CY7S5og==
X-Received: by 2002:a17:907:a47:b0:afe:ec74:2e2a with SMTP id a640c23a62f3a-afeec747f62mr156302566b.5.1756386930209;
        Thu, 28 Aug 2025 06:15:30 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fae316sm1222206166b.28.2025.08.28.06.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:15:28 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 4/5] arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
Date: Thu, 28 Aug 2025 15:17:13 +0200
Message-ID: <4ff3a58e98d90a43deb2448b23754808afc7153b.1756386531.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756386531.git.andrea.porta@suse.com>
References: <cover.1756386531.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ivan T. Ivanov" <iivanov@suse.de>

Add SDIO2 node. On RPi5 it is connected to WiFi chip.
Add related pin, gpio and regulator definitions and
add WiFi node. With this and firmware already provided by
distributions, at least on openSUSE Tumbleweed, this is
sufficient to make WiFi operational on RPi5 \o/.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 52 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 15 ++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index f0883c903527..411b58c1dddf 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -66,6 +66,18 @@ sd_vcc_reg: sd-vcc-reg {
 		enable-active-high;
 		gpios = <&gio_aon 4 GPIO_ACTIVE_HIGH>;
 	};
+
+	wl_on_reg: wl-on-reg {
+		compatible = "regulator-fixed";
+		regulator-name = "wl-on-regulator";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-0 = <&wl_on_default>;
+		pinctrl-names = "default";
+		gpio = <&gio 28 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <150000>;
+		enable-active-high;
+	};
 };
 
 &pinctrl {
@@ -79,6 +91,29 @@ pwr_button_default: pwr-button-default-state {
 		pins = "gpio20";
 		bias-pull-up;
 	};
+
+	sdio2_30_default: sdio2-30-default-state {
+		clk-pins {
+			function = "sd2";
+			pins = "gpio30";
+			bias-disable;
+		};
+		cmd-pins {
+			function = "sd2";
+			pins = "gpio31";
+			bias-pull-up;
+		};
+		dat-pins {
+			function = "sd2";
+			pins = "gpio32", "gpio33", "gpio34", "gpio35";
+			bias-pull-up;
+		};
+	};
+
+	wl_on_default: wl-on-default-state {
+		function = "gpio";
+		pins = "gpio28";
+	};
 };
 
 &pinctrl_aon {
@@ -109,6 +144,23 @@ &sdio1 {
 	cd-gpios = <&gio_aon 5 GPIO_ACTIVE_LOW>;
 };
 
+&sdio2 {
+	pinctrl-0 = <&sdio2_30_default>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	vmmc-supply = <&wl_on_reg>;
+	sd-uhs-ddr50;
+	non-removable;
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	wifi: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
 &soc {
 	firmware: firmware {
 		compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index f70ec8d3dc4d..871537366e96 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -285,6 +285,21 @@ gio_aon: gpio@7d517c00 {
 			 */
 		};
 
+		sdio2: mmc@1100000 {
+			compatible = "brcm,bcm2712-sdhci",
+				     "brcm,sdhci-brcmstb";
+			reg = <0x01100000  0x260>,
+			      <0x01100400  0x200>;
+			reg-names = "host", "cfg";
+			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_emmc2>;
+			clock-names = "sw_sdio";
+			sdhci-caps-mask = <0x0000C000 0x0>;
+			sdhci-caps = <0x0 0x0>;
+			mmc-ddr-3_3v;
+			status = "disabled";
+		};
+
 		gicv2: interrupt-controller@7fff9000 {
 			compatible = "arm,gic-400";
 			reg = <0x7fff9000 0x1000>,
-- 
2.35.3

