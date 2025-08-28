Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E92311975
	for <linux-serial@vger.kernel.org>; Thu, 28 Aug 2025 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386932; cv=none; b=ptx9Aft1pAqOv5vb9hm2oEyy+r1FNuGkEgCz+u8sU2m6MmDDMmy55K8XXFF7b7O4ygofRo0fWZOVTAGRGrzoXZ6qt9O3YPFS6Ps1J5gz+3TgOC/F6zAypA7y5s0tdpfNB96i3okOBMaNMHNqYl+B2sEyJuuXPauz7YIvWW7vUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386932; c=relaxed/simple;
	bh=7tzlDwbCU000uIS22b9GF1Z4Cn4FUZZpaRhqWJq/YAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXv+vedKUG7N20xAgvUpDFFN1o4NLMDuFHgR9j9H/BS5sAied3zw/nV5hDUx0zk1zvl/EmTZIQsMYpYeP+H0L05t0G//GdWFIy4TJj4eYegsHnNNE4a5zbCL8GIB7FJPFsmnhvPW/V+MSE908UJJVI6qHP5vnKXnkfUE6NfO7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mgyj2ff1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mgyj2ff1"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afe84202bc2so127140566b.2
        for <linux-serial@vger.kernel.org>; Thu, 28 Aug 2025 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386928; x=1756991728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuvwZFkQA9C7qsU3a5Mf07+vt99ZB7O1MdQDYloQZeU=;
        b=Mgyj2ff1AKN+CDHqNPTL+df30XR5P9+2RteyMpi0iT6Zdeut/hAMgvAso7Lg/FWW8A
         HMOeJi2rKd84PVBXAYFr4hI44eoG2lxmuXo/5TCqTzu3QwO7PzLGTpAULn5mNWTTQ+2g
         cZSW1W3tEy2doxIyVMWaEpIPHe14TvNgLDqcsJ+zsO6hskREGfLteVNbJE6IGQl90DIS
         Qk/yymMulf+Xck8oNiaj/RpvUKV7xXBFIqow9oF2SK0wYENtL8eNfvf1X+LVLysBTZeO
         MaW+S5TbN+83Ow6mlnPSAyE1uEmAHv9R1UgxJ2by1eFpOFfMDkh0J56EfGN5Wjn2QrgE
         Q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386928; x=1756991728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuvwZFkQA9C7qsU3a5Mf07+vt99ZB7O1MdQDYloQZeU=;
        b=gtLGHz2vzc+CwSxiaYyf+goTdz+bW+ZCAan0cgd+jSSIBgtYjASEQhgW9PQssFejAV
         tX184+bF7Yf89GN+DiTB0mO2eoNy+FpvJUYu+6QWlrOZ1K88CT+Vc0GGcCgUt9+ZMZLD
         y9LH6H+dIsqzIftikjY7YDmfkNhQ6jKMSH/35tH6HjBFn5Snle2eedAYNhjUnaFN2zIo
         eejR4kb5ymjxeokT/1QBAn8/9JPugqGsHlXY8o4HwSamGsKlmlBmGqiZgHn6QW5k1WB8
         FkG6Rdt68fvmO8OF+T46ylr7qK8gAfx512RYmXHDA+mn5Pv5Y+cRni6E+0irVaVThqX3
         SvBA==
X-Forwarded-Encrypted: i=1; AJvYcCUEeBV4bryT/onkSShWYpNoC0tLC0ZoZi0IBx7IPc2HBwmfJ90yRswqsdfi8+0Xd91fHVeEvQ7XI+s38c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz04Tm9UiumcL72myUIMeq+I/wF9/7uC1xiC7IfiYWNsde3sRX
	MG59FgaYkZmhcUMgzQtBmNyjePWh4HxEGEHc3lXqFfFAOfKLLgNGFwY8SjqKrktQ6x4=
X-Gm-Gg: ASbGncusxGaEeWvxIOUiXuSJRC+W3jmJUps2WL39dtSyFz6w5SMguqrFm14Gg9MsPNq
	zodmsdtktLhhNXQJdSpjYX3CfqB1XMprMiu7pO4fjIAylJl5xELvSsUdFkuj+I8LHi/uHV2jLms
	x7dbMqVNWgBB3H+EwmdIpAg/4V2BZT+bwHqbXHGu4Or67iHzsuXeY++ea6CErYenS30lxtj7BP6
	8dF3PCWbtvfsrhFSZMT65V7QLC2Stw7GPqH7J1OM/JkBxEpI7Q0ABuZ1rggoNAPEj6+B9T1eQGO
	l5f1Len3Bk7o8YlI45MPobmx6SZsQLZfJoq3EIByjZribOWwy/SWoMMAM+pLcn/4QEuhYogiOgw
	WawpStrgGv0hEc0GRkhldcPoCis3Uiki39SHqk57JThacyNW14K6Xgml1gTcUasI1ynFxkbB42u
	w6Qmg7iJ+Ko+kKRqAsS/rjQkBAixE=
X-Google-Smtp-Source: AGHT+IGSKrLVAbeLo7wxrnx0s+JZT41mA3nP6tlZKBKQmBHaVFPv7RQF2CH2aqOCAJNVh+pwQ/4NwA==
X-Received: by 2002:a17:907:7e8a:b0:afe:c459:e663 with SMTP id a640c23a62f3a-afec459f209mr508631966b.21.1756386928087;
        Thu, 28 Aug 2025 06:15:28 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe7e3f63e9sm885782266b.98.2025.08.28.06.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:15:27 -0700 (PDT)
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
Subject: [PATCH v2 3/5] arm64: dts: broadcom: bcm2712: Add one more GPIO node
Date: Thu, 28 Aug 2025 15:17:12 +0200
Message-ID: <6d311b2f629bbc0e1dd9821e4aa8e5af9f8e5362.1756386531.git.andrea.porta@suse.com>
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

Add GPIO and related interrupt controller nodes and wire one
of the lines to power button.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 21 +++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 12 +++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
index 6091a1ff365c..f0883c903527 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "bcm2712.dtsi"
 
 / {
@@ -29,6 +30,20 @@ memory@0 {
 		reg = <0 0 0 0x28000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_button_default>;
+		status = "okay";
+
+		power_button: power-button {
+			label = "pwr_button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gio 20 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+		};
+	};
+
 	sd_io_1v8_reg: sd-io-1v8-reg {
 		compatible = "regulator-gpio";
 		regulator-name = "vdd-sd-io";
@@ -58,6 +73,12 @@ emmc_sd_default: emmc-sd-default-state {
 		pins = "emmc_cmd", "emmc_dat0", "emmc_dat1", "emmc_dat2", "emmc_dat3";
 		bias-pull-up;
 	};
+
+	pwr_button_default: pwr-button-default-state {
+		function = "gpio";
+		pins = "gpio20";
+		bias-pull-up;
+	};
 };
 
 &pinctrl_aon {
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 8a517261841d..f70ec8d3dc4d 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -248,6 +248,18 @@ pinctrl: pinctrl@7d504100 {
 			reg = <0x7d504100 0x30>;
 		};
 
+		gio: gpio@7d508500 {
+			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
+			reg = <0x7d508500 0x40>;
+			interrupt-parent = <&main_irq>;
+			interrupts = <0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			brcm,gpio-bank-widths = <32 22>;
+		};
+
 		pinctrl_aon: pinctrl@7d510700 {
 			compatible = "brcm,bcm2712c0-aon-pinctrl";
 			reg = <0x7d510700 0x20>;
-- 
2.35.3

