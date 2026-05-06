Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D333B6F8
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096063; cv=none; b=YvvIE8GwPiwVe2BefG8482HSGNLkH0jddUOd+i1lmEvKdoGbqlxRWN//Wco+g4I61YF9FV0lwPYzbVzim32c9drq9q8UqR4Vo6x8nYJCvEtsuH2i1wWHOAkhrDYQX97VyomLjJFclK5t4xMteUlBYg9NNy+T18nTbYrA0GuXADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096063; c=relaxed/simple;
	bh=ZEiGjns9U3m5yLy5ZGIrzh9lkgRuFhlASuJcbgwcHG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NygonyKFiS9dEoamXynAnrBb/cbH5ujlwkraHiBHSDcgqoAdjdl9fdCN/sMqxKX7Y82PWLLrMjx3Zjt66QzyLXMWPCCwjra6k1YxvEUpe7c/1QPxEYAPdQQqHHliPCfYLavjUyB4j9bOL1GFo69VjnTr7kNkba7d9ExXlAHRcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTnr9aZd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTnr9aZd"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe608cb92so42057f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096056; x=1778700856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TwfVpezC0RgzGnR+5kZnlGfJY7eOd+0GsSEocGvqOw=;
        b=KTnr9aZdzQ6tzwjC4nEYGx7/eCsDwnRgn1METmFUT8AIqn2bpeQJwN5Twlgs2DvZ5R
         WbPK1wnEhDPXkbtz8OaEK+77SV/f2cEU5NGP5TBlevKV0mSEj/ZnYtAPkzvBTeZvaDtL
         2x3ppd7+V1yJrBdRXx+Zwm2Hj5P1Wqq0wwFfGt40mhe4F3Srs545XNWeVn2RrHUvkLDx
         Nzn6qRGmlzWQvW8rR8Xk621fa9AdhAfFL/5EVPs+PARhOh8Cg7c8QhAHSQhHmpByHSUb
         g89gn3cjOnQrnoY9Mz51jyWCyk036Jli0loXLlePmtjkHrjJyN2lcIAD2WZoAj1+w73F
         eDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096056; x=1778700856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2TwfVpezC0RgzGnR+5kZnlGfJY7eOd+0GsSEocGvqOw=;
        b=dZ+QtXhgp22mEL29iDpTpB4zkOlblTQROBmSqUgXMkto/s7WlK9o7Q6DE2URMx0TRb
         SGlmJm1hQjAevcfm2XxRuVT4AlDksXS8U/JBVvlNqaEP8agFBS572VxLMsh0LInT0zwI
         LQbw7Yot45EuXGE7wqLL/508b+eI08zVvYO/8XBY7I0hBo/39SnStY+9522f6OtzJwgA
         R57DnwPdUsN7JZL2YI5yMVIlLYyfiOwz31AxHT6z0sbmNSoHI7dPMgjnCqWahAUlN5MF
         vsqovNxvGx4bQ5pvuCYcOt0NB4Yd8IJPL6ALuAiFchTfb1Y5+8bVBsBjnxd5ipp6xbqZ
         J7JA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZILl8Ik+YFKOdM+VD3GGMHijbjRDRuq+6Y+ohld9+U36BHBdtPROV3T9MAk6OFqVdDM2qGLhI3/6YpmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1qBnfUQGIs+bzsCI+svdW8qLKU2WLxhCM24JgqR19bc774me
	Ri6CPSZTe8XT75LI69/76EqTtjCqj5CrYVjBtW7OMYZwSrHeM9/fVJmP
X-Gm-Gg: AeBDietqtpxRpib4RkdTwuEnvnlNQJ3gL/PJPz7a5gQ3z/LcqYrY94IbQfIRVwvBeoA
	I9cp4lf01RbTYr5EVQlBL/ZyGi0re77IL26X50ov3Z1QBmWIUHLQvs7o+7XweExCRFXCNZH+Bkb
	51edbN2t3nuNNg3CiANsZzuohNKW3tRYM7RbtYLiffmuhqtl2G1sBmw6xnwjPXOqioPq0GiiAhM
	gtU3gIuMHhRrusH+oHegE7DeAxB6Y+fDlv8CDNosRIpP206ach6YCRyGutJNtmru7tZ6IUO+Evc
	1IS99g0l4GXaN5IT367XkJnEa89ioLeh9gwh86GHTNkUasUnNv/cSmTSIcPg31UKID+lE43Nntd
	VLQyDpLCCyziFHl8lQPKUtDSkrNZSg6x2nWjI6xHEbnyDIy8dg5y6ee6jVjgqc5JhoHzVakKXQN
	smWSU7jm10qUCrLD3A20b3HQtV6uJX2+AlwEH5dOY7d5flWRIosbKcrA==
X-Received: by 2002:a5d:64c5:0:b0:44f:e969:7c15 with SMTP id ffacd0b85a97d-4515b057230mr7847306f8f.3.1778096055787;
        Wed, 06 May 2026 12:34:15 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.51.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960022sm14895673f8f.26.2026.05.06.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:34:14 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Wed, 06 May 2026 22:33:22 +0300
Subject: [PATCH v8 5/6] ARM: dts: zte: Add D-Link DWR-932M support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-send-v8-5-f1bdf3243b34@gmail.com>
References: <20260506-send-v8-0-f1bdf3243b34@gmail.com>
In-Reply-To: <20260506-send-v8-0-f1bdf3243b34@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6258;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=ZEiGjns9U3m5yLy5ZGIrzh9lkgRuFhlASuJcbgwcHG4=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp+5eW50hKxRO8dpnpiZhOIbme+bBLcMDB5Z4pD
 68aGL1N/RKJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCafuXlhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiKIRg//QILi13hbd/g+oKBM9CrIz48opa08edK
 eynSCWwkLGmgS0HgG6qHvJHqMAGYp3qgiBrR7Wb1K17qn8I1V7F4e3hl1BzJ7jQtLLa3PRIoTvd
 yWSoRrGB5QX/KQbgXKz3LjRHO30p322S8gcOGHS79wXkyFFBCgd9gr7yq1+gNoYglYFBVKqnTXJ
 XD2yydPl3CISqTCmUyb8Bt/79mnxTfkglyOTspUgtozjhv0x3lS66eWDjaoX9YLvjhfibt8SYi9
 N/fSYr+g5fcDBAxnXF6uBu2vW2UxJmW0QVfqXv3MJ6OBd/hsiNQMtdMioJbqVJbevov0FbAK7HS
 kVrVUhAdP/RPhnvFI55A3JaeB16WwJeEOAWQRouZSH3qJ0vD+g37bSEy1J67COB5Kof74fVlbyW
 ImeSc3RtCP9qoCfM3KAEjtjUoil35Fk0+YZosLVlSewLq8+qnZIcXJPo1JmAFs7AOq4vZbGnGvb
 gqHA2ICt53ecx1Y+5kcj0Ix688OBSKK87ubS/SZhT7ScpMOB6cBJ4Ki8mdS5qqpuC6AAHWdtbP8
 +CX2LqOLBFI9tYUM5/KMto2NldJJyJt3qQlmvbOpKQ6BnOr5uYEtQNP8uuW9cqwKbQ42WYAIrKf
 gjifXCvmPDvLmvGSNKUdoL8evzHo48fiC1xHdyZ9aoHfihznv82o=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This adds base DT definition for zx297520v3 and one board that consumes it.

The stock kernel does not use the armv7 timer, but it seems to work
fine. The board has other board-specific timers that would need a driver
and I see no reason to bother with them since the arm standard timer
works.

The caveat is the non-standard GIC setup needed to handle the timer's
level-low PPI. This is the responsibility of the boot loader and
documented in Documentation/arch/arm/zte/zx297520v3.rst.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---

Changes in
v8: Remove redundant label, use "arm,pl011" for uart0 and 2 too.
v6: Squash board + timer + uart patches into one
v5: Prepend the SoC name in the device specific DTS filename.
v4:
  Declare all uarts
  Remove the UART aliases for now. I can revisit this when I get my
  hands on a board that exposes two UARTs.
---
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/zte/Makefile                     |   3 +
 arch/arm/boot/dts/zte/zx297520v3-dlink-dwr932m.dts |  22 +++++
 arch/arm/boot/dts/zte/zx297520v3.dtsi              | 103 +++++++++++++++++++++
 5 files changed, 130 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 697287d1b372..b0b774aace55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3776,6 +3776,7 @@ ARM/ZTE ZX29 SOC SUPPORT
 M:	Stefan Dösinger <stefandoesinger@gmail.com>
 F:	Documentation/arch/arm/zte/
 F:	Documentation/devicetree/bindings/arm/zte.yaml
+F:	arch/arm/boot/dts/zte/
 F:	arch/arm/mach-zte/
 
 ARM/ZYNQ ARCHITECTURE
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe38eb25301..28fba538d552 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -39,3 +39,4 @@ subdir-y += unisoc
 subdir-y += vt8500
 subdir-y += xen
 subdir-y += xilinx
+subdir-y += zte
diff --git a/arch/arm/boot/dts/zte/Makefile b/arch/arm/boot/dts/zte/Makefile
new file mode 100644
index 000000000000..f052cfbd636c
--- /dev/null
+++ b/arch/arm/boot/dts/zte/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dtb-$(CONFIG_SOC_ZX297520V3) += \
+	zx297520v3-dlink-dwr932m.dtb
diff --git a/arch/arm/boot/dts/zte/zx297520v3-dlink-dwr932m.dts b/arch/arm/boot/dts/zte/zx297520v3-dlink-dwr932m.dts
new file mode 100644
index 000000000000..1700f46aba86
--- /dev/null
+++ b/arch/arm/boot/dts/zte/zx297520v3-dlink-dwr932m.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Stefan Dösinger <stefandoesinger@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "zx297520v3.dtsi"
+
+/ {
+	model = "D-Link DWR-932M";
+	compatible = "dlink,dwr932m", "zte,zx297520v3";
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x04000000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/zte/zx297520v3.dtsi b/arch/arm/boot/dts/zte/zx297520v3.dtsi
new file mode 100644
index 000000000000..a16c30a164bb
--- /dev/null
+++ b/arch/arm/boot/dts/zte/zx297520v3.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Stefan Dösinger <stefandoesinger@gmail.com>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0>;
+		};
+	};
+
+	/* Base bus clock and default for the UART. It will be replaced once a clock driver has
+	 * been added.
+	 */
+	uartclk: uartclk-26000000 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <26000000>;
+		interrupt-parent = <&gic>;
+		/* I don't think uboot sets CNTVOFF and the stock kernel doesn't use the
+		 * arm timer at all. Since this is a single CPU system I don't think it
+		 * really matters that the offset is random though.
+		 */
+		arm,cpu-registers-not-fw-configured;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		/* The GIC has a non-standard way of configuring ints between level-low/level
+		 * high or rising edge/falling edge at 0xf2202070 and onwards. See AP_INT_MODE_BASE
+		 * and AP_PPI_MODE_REG in the ZTE kernel, although the offsets in the kernel source
+		 * seem wrong.
+		 *
+		 * Everything defaults to active-high/rising edge, but the timer is active-low. We
+		 * currently rely on the boot loader to change timer IRQs to active-low for us for
+		 * now.
+		 */
+		gic: interrupt-controller@f2000000 {
+			compatible = "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xf2000000 0x10000>,
+			      <0xf2040000 0x20000>;
+		};
+
+		uart0: serial@131000 {
+			compatible = "arm,pl011", "arm,primecell";
+			arm,primecell-periphid = <0x0018c011>;
+			reg = <0x00131000 0x1000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&uartclk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart1: serial@1408000 {
+			compatible = "arm,pl011", "arm,primecell";
+			arm,primecell-periphid = <0x0018c011>;
+			reg = <0x01408000 0x1000>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&uartclk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+
+		uart2: serial@140d000 {
+			compatible = "arm,pl011", "arm,primecell";
+			arm,primecell-periphid = <0x0018c011>;
+			reg = <0x0140d000 0x1000>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&uartclk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+	};
+};

-- 
2.53.0

