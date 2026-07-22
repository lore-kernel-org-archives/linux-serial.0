Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613324963DA
	for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714183; cv=none; b=Vsyeg8lD+mAIyNIzAC4wKm7p03joIQXNcjOqFBmQ5oIY45/DL0mialPNJu+k1Dk0CgvjgjKDR2oQeVmsCRPNEWFAQqTGQ94ZkMBFssKD7SAbEnMtRRY3t6RN/GP/yKxsPNXlATtaNUbyc2SpP8QV4WQq/NypwlARgYFlKc0Mgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714183; c=relaxed/simple;
	bh=dSb98ELCIB36qabBr1H76sUOHD/+Jd+DcUtXHc7yw9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrHHG6eq0F5DnkyFw/ncrZ7zUeQ9rY+Vchy0g1MK6p8ZsqBeSx8Log0jbM/bAw9zvxxKzMFXVcM7HrWpm3SekVizDPS7FhZMIHL/C+4dpEY2ZjJ20fauWAQuX3b93E4o1PablhMgbIoDD+Id5TNAwygePY/N1fs3D1btUzsEzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GjcVAEzb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjcVAEzb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47df43bfb07so3380089f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 22 Jul 2026 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784714174; x=1785318974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAVjIpM48CSjn5KJZGLdGDi2nZNAtIPoigWTJh0sm6Y=;
        b=GjcVAEzbWyIqc0D7Ur3Xhm3324kmItk36Z5rNFp13NY3GTt5Z6e3Kx1uIbaTwIc3Xj
         srTjz8DDbkSqorxkSV7DX3QqH94RmrZYjsRn/Z0rVpb7jiE55fqQ7Zt03WlsemIeWAJS
         3Tk8CHlfZGBwIJVpfNGGJ4LFpE+jQjw80mp2eg6G6Cyd3vLO4rkIfLYebvyXtB3J8+l1
         PgwEoRfIXEFM8+tk7wS+xXUdLy8J8Zz+fh2OUu/ADpZdHuSx4Lc6P4zCljxXJEtL/0XW
         ++b2ys283ejunlPmD+0um3rs4ZLgSBLr1HVRHgNuA0maMoJsKnNB52yOpTWUE0L5IGid
         fzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714174; x=1785318974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AAVjIpM48CSjn5KJZGLdGDi2nZNAtIPoigWTJh0sm6Y=;
        b=N2uv6c7dTuCakGa2MRzb8E9NWrFHnzyPkQ9AUV9AFw5P87/WL4IsZD9GAeaSjfTZve
         3Q0IZLVxFBOa1MZJURZbpbW7gMuZFqE4gIBirggvhz3dHjCkU4n4uI27exU9q/lIglIO
         4M1fOGYGpoLPPB/p6cnCtLvq0FzPqyc2Dp5XVPhXJNGuAFgxB3MwhKHa8iGowFRP6OcH
         PQntNQsbLdDjJVgCouOLH7cl2jjqUQ/hues4u8UgeSuTdfSZh424sdf1ZbCMdXdLyjky
         huAE0LF6VE04QBxmIFRYwhUMxel7570sL7ZB2FBy4aSUk7ZhCA9lCsL62MiMRuzSShvT
         4f7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqI5fi+lvlozcezmibPYrj05xiLP0xNj8wueBicCnePlse3HHwPR+BnrNgMzgYOoh8CxSWbdGof+Y8aqPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKN+vAhx3Rgs/KCYJykDwwp5Ac/3WFd+ovaJp3kVCykNWZ0PJB
	dbrrO8fo7Q2aSDaVmUCroVLBVWJActxxpHpks92ZkAOxw6TgYjb6CsO29+zI2hoTQMI=
X-Gm-Gg: AR+sD11erKSZpuqBe7H5JtQnD6UILE9IcmACTFZemXPfle7gzKQszXCevHER+h4/yxg
	hEsJa3tGNuF+i2dqEv9mBPuHB21q0NyEXPeWUdelD0wJxeFwoAKk9NI1jy+CKBHM3u5YzGDkLPs
	GnjuHXFSq/6aJhDbYVpcB6bBkzHLTqP+K//ue7Sf355yxSaGZQq8aLVNmfCYOfs3UJcC4NQkKzW
	jjO76cdj5oKp1rBOMziSvrFhbXQoIEl2v86EwCt0YpKWW7tNbS61CXkwc+rPA9I9KTvBzF1lPmu
	fuCiQGflnTvxXegMHHJAhZhG1yldcqd1ktJIoFH7rxLfv1F8KS/8ZXcP3K0RJPqAqqEZZjeDe2u
	/oWuqSdWqzs3erycEpeKiGEZz9P8Wo6yXe+Ytou/+pOvohe3kfaFJJ/KSHoHQS0C7p0CfxOS65x
	OcpQCl6O9+26ilCkbbm+kccatRptjm7uASfQ==
X-Received: by 2002:a5d:6f16:0:b0:47d:efd0:c026 with SMTP id ffacd0b85a97d-47f622feedfmr28217072f8f.11.1784714173601;
        Wed, 22 Jul 2026 02:56:13 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([2a00:23c7:314c:4601:ea7:d5d4:79db:6d52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm4414533f8f.22.2026.07.22.02.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:56:13 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 22 Jul 2026 10:55:55 +0100
Subject: [PATCH v2 4/5] arm64: dts: google: Add initial dts for
 frankel/blazer/mustang
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org>
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
In-Reply-To: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-serial@vger.kernel.org, soc@lists.linux.dev, 
 Douglas Anderson <dianders@chromium.org>, Juan Yescas <jyescas@google.com>, 
 RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>, 
 William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15623;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=5/Ox4AZKrNAcywtIaf5yMYb3vmYg681flxnKWa9di6A=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqYJO2fFUcCXu+bVxz459upIHNZtKZFVSG+ErdL
 B4iFy2rQAeJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCamCTtgAKCRDO6LjWAjRy
 ur3sD/9Jd1XShReo+e5Ajhg4g/nxciPr20Cjv1UNFdwzM7ASCpJeJIzcx7vruKPhkUSjntNbYmx
 LDzRG4gME4eHlGJqo8KV++Cr1Fd7OIbYt/MNCeJdkVzM4M0Qdh8ZqQvvU8ZS4bKZ5gu2Uewr1zG
 LfCzvXAAJPZmHRjFccGwuQJVmu7s8E2CSvII+1L8c9FdYHiuD+7l7OpKrIFAOBO/aSrucKl43ps
 xjDvKRM0msu3NDuoXB3BgtmGfTSpuMWPNVc1BtZFVYj3lcTlKycjCaCVcp8pH9mfn5ZojLc3JxR
 a0cRl0f6ikec5dx6z64Y1ovrFjiTr8Wdq5z9U9o24bzzKbWGa2yv1eTTv0tjO3ZdvGVWTNw/UT1
 QGe/ab0Rqy0lTND4j3f32er6hVPDPgsbKk74rTW2PR5ueqbwTb7i6VTE6A0zwcbXp6lXeO86d0W
 qLlX6FBqfXsv+8mzooRUOWXYv76XB9TnCay/rlv52dq+FecKVHYAcJsf/WQY5EfxvEcR22sUtxh
 41ECOXfoluLvb6uuXmn/oE4GBQ/EouxV9EXs7VQevSqiBppSEuKeOQo0uyL36D4rB2ScYrGh45k
 EehFlIrHfyHeL3hDEPSQfmqC8piZIu8ys+RwlFd8TuX270eCNcrX4+vOVec27AwQlaoriH6zAIK
 DpBBXXx8wj/b8WQ==
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

Many things can be noted about these device trees:

1. Even newer versions of the bootloader will still error out if they
   don't find a UFS node to add calibration data to. Until UFS is
   supported, we provide a bogus UFS node for the bootloader. While
   the bootloader could be changed, there is no long-term benefit
   since eventually the device tree will have a UFS node.
2. They purposely choose to use the full 64-bit address and size cells
   for the root node and the `soc@0` node. Although I haven't tested
   the need for this, I presume the arguments made in
   commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase address
   and size cells for soc") would apply here.
3. Though it looks as if the UART is never enabled, the bootloader
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
---
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
 arch/arm64/boot/dts/google/lga-pixel-common.dtsi |  23 ++
 arch/arm64/boot/dts/google/lga.dtsi              | 423 +++++++++++++++++++++++
 6 files changed, 497 insertions(+)

diff --git a/arch/arm64/boot/dts/google/Makefile b/arch/arm64/boot/dts/google/Makefile
index a6b187e2d631..4e833b2561e0 100644
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
index 000000000000..0894606624f8
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
index 000000000000..57df197a544f
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
index 000000000000..6ac0b5ef22ff
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
index 000000000000..57c318ab44c9
--- /dev/null
+++ b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Google Pixel 10 family common dtsi.
+ *
+ * Copyright 2024-2025 Google LLC.
+ */
+
+#include "lga.dtsi"
+
+&{/} {
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	aliases {
+		serial0 = "/soc@0/serial@db62000";	/* &lsion_cli16_uart */
+		ufs0 = "/ufs-placeholder";		/* &ufs - TODO "/soc@0/ufs@3c400000" */
+	};
+};
+
+&osc {
+	clock-frequency = <38400000>;
+};
diff --git a/arch/arm64/boot/dts/google/lga.dtsi b/arch/arm64/boot/dts/google/lga.dtsi
new file mode 100644
index 000000000000..343156a8c039
--- /dev/null
+++ b/arch/arm64/boot/dts/google/lga.dtsi
@@ -0,0 +1,423 @@
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
+			compatible = "arm,cortex-a520";
+			reg = <0x000>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <258>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd0>;
+		};
+
+		hayes_1: cpu@100 {
+			compatible = "arm,cortex-a520";
+			reg = <0x100>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <258>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd1>;
+		};
+
+		hunter_0: cpu@200 {
+			compatible = "arm,cortex-a725";
+			reg = <0x200>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd2>;
+		};
+
+		hunter_1: cpu@300 {
+			compatible = "arm,cortex-a725";
+			reg = <0x300>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd3>;
+		};
+
+		hunter_2: cpu@400 {
+			compatible = "arm,cortex-a725";
+			reg = <0x400>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd4>;
+		};
+
+		hunter_3: cpu@500 {
+			compatible = "arm,cortex-a725";
+			reg = <0x500>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd5>;
+		};
+
+		hunter_4: cpu@600 {
+			compatible = "arm,cortex-a725";
+			reg = <0x600>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <891>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd6>;
+		};
+
+		hunterelp_0: cpu@700 {
+			compatible = "arm,cortex-x4";
+			reg = <0x700>;
+
+			#cooling-cells = <2>;
+			capacity-dmips-mhz = <1024>;
+			device_type = "cpu";
+			enable-method = "psci";
+			power-domain-names = "psci";
+			power-domains = <&cpu_pd7>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&hayes_0>;
+				};
+				core1 {
+					cpu = <&hayes_1>;
+				};
+				core2 {
+					cpu = <&hunter_0>;
+				};
+				core3 {
+					cpu = <&hunter_1>;
+				};
+				core4 {
+					cpu = <&hunter_2>;
+				};
+				core5 {
+					cpu = <&hunter_3>;
+				};
+				core6 {
+					cpu = <&hunter_4>;
+				};
+				core7 {
+					cpu = <&hunterelp_0>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
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
+	};
+
+	memory: memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		cpu_pd0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cpu_lit_c2>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&cpu_lit_c2>;
+			power-domains = <&cpu_top_cl>;
+		};
+
+		cpu_pd2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd4: power-domain-cpu4 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&cpu_mid1_c2>;
+			power-domains = <&cpucl1>;
+		};
+
+		cpu_pd5: power-domain-cpu5 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&cpu_mid2_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_pd6: power-domain-cpu6 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&cpu_mid2_c2>;
+			power-domains = <&cpucl2>;
+		};
+
+		cpu_pd7: power-domain-cpu7 {
+			#power-domain-cells = <0>;
+			domain-idle-states =  <&cpu_big_c2>;
+			power-domains = <&cpucl2>;
+		};
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
+		cpu_top_cl: power-domain-top-cluster {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&cluster_c4_deep>;
+		};
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * Store ramoops at a known location in DRAM, for access by the ABL
+		 * following a crash-reset.
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
+		ranges = <0 0 0 0 0x10 0>;
+
+		dma-ranges = <0 0 0 0 0x10 0>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@5880000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0x05880000 0 0x10000>,
+			      <0 0x05900000 0 0x200000>;
+			ranges;
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
+			reg = <0 0x0db62000 0 0x100>;
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
+		interrupts =
+			<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>;
+	};
+
+	/*
+	 * The Pixel bootloader considers it a fatal error if it doesn't find
+	 * a `ufs0` alias so it can add calibration data to the node. Until
+	 * the proper UFS controller node is added under the SoC, create a
+	 * temporary node to make the bootloader happy.
+	 */
+	ufs: ufs-placeholder {
+	};
+};

-- 
2.55.0.229.g6434b31f56-goog

