Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212051C049
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752873; cv=none; b=rLihCK2xmZ2VRS2eZgvtC1G0zhRBzpu3MTadoche28W+CtR2oOJbHm/CQpUGYoPDNwoSdsKpzJrHqNh3NM1kn5V7Z4odDeVm12zLV5/Q2LHBDH66pgiax0qHiGYU7b7YMkymVnu01BjSfPmXIrc9HI5BGsixgFl1xgOWjNmC5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752873; c=relaxed/simple;
	bh=rjEp4+86TjcrXz9iI7uk3ebYL3hKRpjlWwHyS65EaE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nx5WNUjn9DvEoGMpB9wNy3gL8GHOneKvdv7dkykABcs1Gt7RI5oWRBQIhgenCnOVDwSXvrM/wQ1sJVBJxFu9Bowh+rBpVRePsm3zo67Saza321JNnqUQRmJJHKN8Z9Hb9GszPIQ+Cd6CxXzJm9gCV3HxzQ5amcyCEVRCtaKEW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yondX7rE; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yondX7rE"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1b846so1304007e87.0
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789752862; x=1790357662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECBJL6z7YLJzZeRvsQ6L27GjBzhnows769pVMAMfbMo=;
        b=yondX7rEHNK2UZihXNg5phIQElrD74vPd5jyjCLZJU/DSbrS91icALPV3ARu4YsHy0
         sp9vBp3z43j/GW3JqbgBU0I/g1aTkHvbV0mm+NGg8u3gQObDMFoop4aafKBfVrpIXAxg
         j1gf2fu1XfivpXm1fOBYKqQoQvDQ3TZlEbjgeAMODL15/achWqEfCMdAeprLmMDpAMCM
         aXnvo3tUgK4HOBTZ9mtUgNRJx4At7leaVGk9XngeG/Q2kErX25kFh6EBmANHxxVhcvo+
         ZR4E/r2twoslWF5lSBFFbVumAa3fXv0VnWbDM8VMF7PWNNxUv+ycZsaa+eDvTKyErghi
         31KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752862; x=1790357662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECBJL6z7YLJzZeRvsQ6L27GjBzhnows769pVMAMfbMo=;
        b=drx6De5BKSwh+lb8v2JVHLamYlEhs8+9uUyenQ2/8ybRBYcc/XDIpcawZa/G6LvMls
         bGdwK1ph/zfdpjNHa4tYD6x+fBb+Cx08pHUUi8e6LDvb7bNz63+2dmTAzXf8xCTtDuh+
         5LbULfLnmTX8uCci105xNGxzPKyCDwAD/G5e8v6M5+tt09a8R6KUxtkEHBDxYKts1uLs
         yL2hmTubMnTycdwtNqAyKbf76QlQO4jp+ynzAi+k3oaBgvgf/DKiIRzg6NebJiwFzLrd
         cgzzq5KCkpuMMJT2lGVcJk7HT3nySnK/HtxV8SdlKe1uvrTKC1n4L5CRSBwquNfGJqec
         yrJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRwoTo5KMhPB+CVbiNYFnn+0gzXBO/VlhE8lE8F2eGEe0d0gYBOIswML/nbI+m63jZTeWc2bGu0u6qVBc=@vger.kernel.org
X-Gm-Message-State: AFuF++nG6lmAAfuxeIP4QYpd8891G54CjCh08Nt/AacThF7Y0pssC6uz
	NdQswZPGfnmm5Kcp4BfpEiMMv2TEvImz/a+yxDiFcrJozTNw1egbyoNkjmQMiR/qvwqfUF5vOXb
	NxCvnqdU=
X-Gm-Gg: AYBFou3tFStuOsLqKv6/UAC05GY19rAgXB272F/IK7e/7u57FuKJZq5tdaRmnguDKyT
	9H/2j6wZlM+3PBp1iJfcQgetx8wVyqvRouHaNbaVCIDTevUBcMIc4iSqKm05Yzc7gw7JdsnJ0g2
	xg2l0uFIz3FO9JfQQZqF+JiBDFQjfFsFZQZbXOgTienP5yfaYXXxnkcuHK3X2jO+YJ4Z/HE503k
	CTec1242bVQC4TK+tF1Gc6c1VdZb4BvflUy3h7Wkg2AOwOs85C/ChivQN39vgkC7ui4uoGELaV3
	QIRvsFLls/+AIA1GZ4UnK8t4fO6H5VH76xmSNkSlYUZpxeP8NVGzWh1CAvWkblBPI8TPBXL8e5y
	UbHSnO/O/tODXQSXLitTprf2HRa8INPhG7lExYjHXRggsU035OR1NWPPvYbWcW6y/53gkiq4f9K
	XJMNbslTNL7yxU83QTWWdKHt1QEIBgOQg9mc7F7QfuqlO3kiOoq6G3h1QNuckuYEm2Zx1EQblxT
	4l3CRlrR50L3d7UBH7yjmi27aSher7KaNC2adaSxsVFZWRuAlRybzlVBuoZPTrvYw==
X-Received: by 2002:a17:906:f58a:b0:c25:9102:ed with SMTP id a640c23a62f3a-c2a1564869bmr334769766b.5.1789752410961;
        Fri, 18 Sep 2026 10:26:50 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35701d8bsm902966b.27.2026.09.18.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:26:50 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 18 Sep 2026 17:26:36 +0000
Subject: [PATCH v3 3/4] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-contrib-pg-pixel10-initial-dts-v3-3-c94e51140509@linaro.org>
References: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
In-Reply-To: <20260918-contrib-pg-pixel10-initial-dts-v3-0-c94e51140509@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
 Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
 Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-serial@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, 
 Brian Norris <briannorris@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15306;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=lcFwjQmOWlIcJGB25aCSCMYe86ZTVVkq6y+rYEhX3Yk=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqrXRXD4ckyAVvu1qjkD9tlbhI2NBhj0u65Qmfi
 EbqRQB6W/qJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaq10VwAKCRDO6LjWAjRy
 ukKtD/4kgjLYzFR53/sN8hBBlLfL+tbCDnUnZOUKh5klYZW8swG4UNP1+qIOfcowj8lPXy0p5Bu
 4SGwpoB+Esak+6h/Uh4BDqvTiTT7066WvLt8cBaDNc8MPruXU8W8fHTeoyxC+/SvFhRRi/w+S+0
 /Y/CuAgxRMhKjGXiapT6KEsQatJFlVnfLgEtODOhsQS7VEMs9EhOC+O4fDrhLc+cKf3vyCj+44f
 1NrIRO7TKxwTldDw+VTL1WRDnF3mVCthqDC/9OXwGiroOAG129b8pqv/usK26h8CnPHqYxxYkkH
 nB8pyWhG07Z7nFbDYkOKHCVpCuYsTXQqZMrk1Rm6GNov+EWLbZqFsIGgEWv4AuVDtzyYSZav8do
 Z1taN/wG8rc+0AMQAv9GbMPPXMCKsRcJisiaAFSHpnUPwfMCv0vfvT+OZ1uYrcqgeHY/BYxMlqp
 4VzrQ9D/UkRWrjvFnINbeO6BD79t+TPXhZspnWb+vhaehu6z7/qU84ni7UL7HLDL+UOV1bukcSf
 ihBzR6nBUro6oDScf33WMK0qnq6458AR/A+NDW0jTEMagJurb4yItGGNejv+tTsnkmPkaTMoxUn
 TRyjch/M3Kyjj7bl25bZks70TYSEl7Qbuf3oZI+nwBJyaIAOQ9A/GTe8PvioVvJcSci6F6JKZS2
 VKXmytaT/dxmVug==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

From: Douglas Anderson <dianders@chromium.org>

Add initial device trees for frankel (Pixel 10), blazer (Pixel 10
Pro) and mustang (Pixel 10 Pro XL). These device trees are enough to
boot to a serial prompt using an initramfs.

Currently only Laguna B0 silicon found in mass production phones is
officially supported. Further revisions such as A0 silicon and EVT
devices maybe added in the future if they are useful. As of today,
these device trees boot fine on EVT devices with A0 silicon.

A few things can be noted about these device trees:

1. They purposely choose to use the full 64-bit address and size cells
   for the root node and the `soc@0` node. Although I haven't tested
   the need for this, I presume the arguments made in
   commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase address
   and size cells for soc") would apply here.
2. Though it looks as if the UART is never enabled, the bootloader
   knows to enable the UART when the console is turned on. Baud rate
   is configurable in the bootloader so is never hardcoded in the
   device tree.

Changes by Peter Griffin:
 - Remove dtbo overlay approach and add individual board dts
 - Update to lga-pixel-common naming like gs101-pixel-common
 - Reorder nodes alpha-numerically by the node name
 - Add ramoops reserved-memory (tested with console=pstore)
 - Add reserved-memory for bootloader & gsa logs
 - Add reserved-memory for Android BootLoader ABL (used on Watchdog
   reset to extract boolotader logs / parse breadcrumbs / ramdump etc).
 - Add osc 38.4Mhz fixed-clock

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Co-developed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v3
 * Use 0x0 instead of 0 consistently for new code (Krysztof)
 * Remove 'ranges' from gic-v3 as no msi child node with unit address (Krysztof)
 * Remove ufs0 alias and ufs placeholder node (Krysztof)
 * Remove memory node from lga.dtsi (Krysztof)
   It turns out bootloader adds the node anyway
 * Use standard '/ {' not overlay style (Krysztof)
 * Update alias to point at label (Brian)
 * Drop GIC_CPU_MASK_SIMPLE for GICv3 interrupt controller (Shashiko)
 * Fix dt-check-style --mode=strict warnings (Peter)

Changes in v2 (by Peter Griffin):
 * Remove dtbo overlay approach and add individual board dts
 * Update to lga-pixel-common naming like gs101-pixel-common
 * Reorder nodes alpha-numerically by the node name
 * Add ramoops reserved-memory (tested with console=pstore)
 * Add reserved-memory for bootloader & gsa logs
 * Add reserved-memory for Android BootLoader ABL (used on Watchdog
 reset to extract boolotader logs / parse breadcrumbs / ramdump etc).
 * Add osc 38.4Mhz fixed-clock
---
 arch/arm64/boot/dts/google/Makefile              |   5 +
 arch/arm64/boot/dts/google/lga-blazer.dts        |  15 +
 arch/arm64/boot/dts/google/lga-frankel.dts       |  16 +
 arch/arm64/boot/dts/google/lga-mustang.dts       |  15 +
 arch/arm64/boot/dts/google/lga-pixel-common.dtsi |  22 ++
 arch/arm64/boot/dts/google/lga.dtsi              | 413 +++++++++++++++++++++++
 6 files changed, 486 insertions(+)

diff --git a/arch/arm64/boot/dts/google/Makefile b/arch/arm64/boot/dts/google/Makefile
index a6b187e2d6318..4e833b2561e08 100644
--- a/arch/arm64/boot/dts/google/Makefile
+++ b/arch/arm64/boot/dts/google/Makefile
@@ -1 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+
+dtb-$(CONFIG_ARCH_GOOGLE) += \
+	lga-blazer.dtb \
+	lga-frankel.dtb \
+	lga-mustang.dtb
diff --git a/arch/arm64/boot/dts/google/lga-blazer.dts b/arch/arm64/boot/dts/google/lga-blazer.dts
new file mode 100644
index 0000000000000..0894606624f8e
--- /dev/null
+++ b/arch/arm64/boot/dts/google/lga-blazer.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Blazer Device Tree (Pixel 10 Pro)
+ *
+ * Copyright 2021-2023 Google LLC
+ */
+
+/dts-v1/;
+
+#include "lga-pixel-common.dtsi"
+
+/ {
+	model = "Blazer";
+	compatible = "google,lga-blazer", "google,lga";
+};
diff --git a/arch/arm64/boot/dts/google/lga-frankel.dts b/arch/arm64/boot/dts/google/lga-frankel.dts
new file mode 100644
index 0000000000000..57df197a544fa
--- /dev/null
+++ b/arch/arm64/boot/dts/google/lga-frankel.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Frankel Device Tree (Pixel 10)
+ *
+ * Copyright 2021-2023 Google LLC
+ */
+
+/dts-v1/;
+
+#include "lga-pixel-common.dtsi"
+
+/ {
+	model = "Frankel";
+	compatible = "google,lga-frankel", "google,lga";
+};
+
diff --git a/arch/arm64/boot/dts/google/lga-mustang.dts b/arch/arm64/boot/dts/google/lga-mustang.dts
new file mode 100644
index 0000000000000..6ac0b5ef22ff2
--- /dev/null
+++ b/arch/arm64/boot/dts/google/lga-mustang.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Mustang Device Tree (Pixel 10 Pro XL)
+ *
+ * Copyright 2021-2023 Google LLC
+ */
+
+/dts-v1/;
+
+#include "lga-pixel-common.dtsi"
+
+/ {
+	model = "Mustang";
+	compatible = "google,lga-mustang", "google,lga";
+};
diff --git a/arch/arm64/boot/dts/google/lga-pixel-common.dtsi b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
new file mode 100644
index 0000000000000..218b55a5d00af
--- /dev/null
+++ b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Google Pixel 10 family common dtsi.
+ *
+ * Copyright 2024-2025 Google LLC.
+ */
+
+#include "lga.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	aliases {
+		serial0 = &lsion_cli16_uart;
+	};
+};
+
+&osc {
+	clock-frequency = <38400000>;
+};
diff --git a/arch/arm64/boot/dts/google/lga.dtsi b/arch/arm64/boot/dts/google/lga.dtsi
new file mode 100644
index 0000000000000..26a14b3a1b190
--- /dev/null
+++ b/arch/arm64/boot/dts/google/lga.dtsi
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Google Tensor G5 (laguna) SoC rev B0
+ *
+ * Copyright 2024-2025 Google LLC.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	osc: clock-38400000 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hayes_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x000>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <258>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd0>;
+			power-domain-names = "psci";
+		};
+
+		hayes_1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a520";
+			reg = <0x100>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <258>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd1>;
+			power-domain-names = "psci";
+		};
+
+		hunter_0: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x200>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd2>;
+			power-domain-names = "psci";
+		};
+
+		hunter_1: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x300>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd3>;
+			power-domain-names = "psci";
+		};
+
+		hunter_2: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x400>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd4>;
+			power-domain-names = "psci";
+		};
+
+		hunter_3: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x500>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd5>;
+			power-domain-names = "psci";
+		};
+
+		hunter_4: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a725";
+			reg = <0x600>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd6>;
+			power-domain-names = "psci";
+		};
+
+		hunterelp_0: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-x4";
+			reg = <0x700>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <1024>;
+			enable-method = "psci";
+			power-domains = <&cpu_pd7>;
+			power-domain-names = "psci";
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&hayes_0>;
+				};
+
+				core1 {
+					cpu = <&hayes_1>;
+				};
+
+				core2 {
+					cpu = <&hunter_0>;
+				};
+
+				core3 {
+					cpu = <&hunter_1>;
+				};
+
+				core4 {
+					cpu = <&hunter_2>;
+				};
+
+				core5 {
+					cpu = <&hunter_3>;
+				};
+
+				core6 {
+					cpu = <&hunter_4>;
+				};
+
+				core7 {
+					cpu = <&hunterelp_0>;
+				};
+			};
+		};
+
+		domain-idle-states {
+			cluster_1_c3: cluster-1-c3 {
+				compatible = "domain-idle-state";
+
+				entry-latency-us = <325>;
+				exit-latency-us = <553>;
+				min-residency-us = <10000>;
+
+				idle-state-name = "cluster-1-c3";
+
+				arm,psci-suspend-param = <0x40010033>;
+			};
+
+			cluster_2_c3: cluster-2-c3 {
+				compatible = "domain-idle-state";
+
+				entry-latency-us = <345>;
+				exit-latency-us = <673>;
+				min-residency-us = <10000>;
+
+				idle-state-name = "cluster-2-c3";
+
+				arm,psci-suspend-param = <0x40010033>;
+			};
+
+			cluster_c4_deep: cluster-c4-deep {
+				compatible = "domain-idle-state";
+
+				entry-latency-us = <510>;
+				exit-latency-us = <1027>;
+				min-residency-us = <10000>;
+
+				idle-state-name = "cluster-c4-deep";
+
+				arm,psci-suspend-param = <0x40020333>;
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_big_c2: cpu-big-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <110>;
+				exit-latency-us = <413>;
+				min-residency-us = <3950>;
+
+				idle-state-name = "cpu-big-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+
+			cpu_lit_c2: cpu-lit-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <132>;
+				exit-latency-us = <296>;
+				min-residency-us = <3610>;
+
+				idle-state-name = "cpu-lit-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+
+			cpu_mid1_c2: cpu-mid1-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <130>;
+				exit-latency-us = <274>;
+				min-residency-us = <2720>;
+
+				idle-state-name = "cpu-mid1-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+
+			cpu_mid2_c2: cpu-mid2-c2 {
+				compatible = "arm,idle-state";
+
+				entry-latency-us = <130>;
+				exit-latency-us = <274>;
+				min-residency-us = <2720>;
+
+				idle-state-name = "cpu-mid2-c2";
+				local-timer-stop;
+
+				arm,psci-suspend-param = <0x40000003>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		cpucl1: power-domain-cluster-1 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_1_c3>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpucl2: power-domain-cluster-2 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_2_c3>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_lit_c2>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_lit_c2>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid2_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_pd6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_mid2_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_pd7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_big_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_top_cl: power-domain-top-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_c4_deep>;
+		};
+	};
+
+	reserved_memory: reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/*
+		 * Store ramoops at a known location in DRAM, for access by the
+		 * ABL following a crash-reset.
+		 */
+		ramoops@95200000 {
+			compatible = "ramoops";
+			reg = <0x0 0x95200000 0x0 0x400000>;
+			console-size = <0x200000>;
+			pmsg-size = <0x200000>;
+		};
+
+		/* bootloader logs */
+		bldr_log_reserved: bldr-log-reserved@95600000 {
+			reg = <0x0 0x95600000 0x0 0x100000>;
+			no-map;
+		};
+
+		/* gsa logs */
+		gsa_reserved_log: gsa-reserved-log@a61b0000 {
+			reg = <0x0 0xa61b0000 0x0 0x00004000>;
+			no-map;
+		};
+
+		/* Android BootLoader (ABL) for ramdump/coredump processing */
+		abl@be000000 {
+			reg = <0x0 0xbe000000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+		ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@5880000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x05880000 0x0 0x10000>,
+			      <0x0 0x05900000 0x0 0x200000>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			#interrupt-cells = <4>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&hayes_0 &hayes_1
+						    &hunter_0 &hunter_1 &hunter_2
+						    &hunter_3 &hunter_4>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&hunterelp_0>;
+				};
+			};
+		};
+
+		lsion_cli16_uart: serial@db62000 {
+			compatible = "google,lga-uart", "snps,dw-apb-uart";
+			reg = <0x0 0x0db62000 0x0 0x100>;
+
+			clock-frequency = <200000000>;
+			interrupts = <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH 0>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};

-- 
2.55.0.1082.g2b9226bbc0-goog

