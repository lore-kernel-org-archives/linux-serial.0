Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D8378822
	for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803054; cv=none; b=jo+3+Zcx6ZBZkQTZnZVCuEtrgqGtq1ckbWhBkYv6PanXNzcDViI0l9RamZxL7X2vprcuWJRCetlVU1laG6VHSFtK1ixV2aMH0tVsWSc5lnYY1NEjlW/lC30v3MDze/XxQwfznZvr87IwShVad6EUjQTifJHw/lhpzkUZ90oAItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803054; c=relaxed/simple;
	bh=2yHUR7vf/4pTVAeDqwUY/lONvxGcKw5B3T7ZR8edG+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qPjPb8P6lsTHLUg25jRwbvr/LXH7cFvqulJWyJSEgSQU5R7MD+/05F9zrbbcOicBcWNMJtTBpnNlD4cltkAjcwZwmYx8KsXqsQCgMPX9FE+h2xXlPpsU77Ea4gPhnd1bS+D5XOTCDB4VLfawp6o7Gy/3PHVV0fEQCF6c6pxP+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGTGEbXL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGTGEbXL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so33942555e9.0
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2026 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803051; x=1777407851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WBbGaO308OrKoNoLYMLOL+P4wfBfZBUd8DmimKDQOY=;
        b=eGTGEbXLgTyfaVDd3yOq57X5YIIy9wJ6Pvw9ZR09qrfztp1rP03iD8EjKH/3C4CZP+
         Eq0Tqcu8ITjogCWjc5aHjqZOb2Q66XkJxpY1kmkSX6vjsgnzIF5ukMRTKG9AXjE5hKqc
         4mbxpkYveueF/Wzjkps+7vLaGA1ywEQ+KHPp3k4MPFQSNScd9fG2/KBsoPtX+aZ3jSbJ
         5o8nT5xQgnAyeSVC5ZRwlkrF4LZabzLQnx5GMgpe9BfHK/q/z7TDgH0zQH0FMsViuC4g
         cqZWwpa7R7DQ9w5DuvpkIJc1LbcBQcBfq8lJxnJevISxqWshRlcYsNmP9j6cjbRY0Fid
         0xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803051; x=1777407851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+WBbGaO308OrKoNoLYMLOL+P4wfBfZBUd8DmimKDQOY=;
        b=hKU2ouIITJMpEglnq7H8oEVffmipD6duqL8cM891CgVZF2F1pdXQz+kM1zxlHWt7gb
         T4mJEBzFFQP0ZdTjRpNTIZwtQ0uZVh1t221kwnK2ElD+MLvzlsv2IFGOcJKabOOoO8Ic
         9klDbVhpppOYIZL5rw8Mh7aISFEvQyceuwhj7yE3X2x6IiBFipZ19eR6TmTvkeVUgjcl
         c9gilQpTjYT0qKYbNqviC/4bFA5F3G8vNsqH8VU+yfY3KF8jnqQrBq9P6Uwr2LbjWvRF
         HBynClJgIWQFMEBmLj3MCFFwqeMGeE9ggP1d7kx0m8BQMGoWYgi9nIiap3cUjVm6l0tu
         C1cA==
X-Forwarded-Encrypted: i=1; AFNElJ9ofZITvftPnYJ9Tn7foffisbHu+kZsMfZ1Vp+GP7zOnt87Oi86Laxf2lnPN7KW/1xS9EH/UwPAJDXGgPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/0SnhuStAdQsCpVpjJDGGKdEn+NlSe6HCwit0mkjj67/E0OX
	ngNQkDHv6bv5HoJauKRCo8GvcZXudcEdhfnpa+ZjhUyzWVSNmLTbTlYC
X-Gm-Gg: AeBDieuaxMXJr8Yz8HLdBfrjsnm+VYwI6r6ooVFq4M/uyGvjsTPd+3rDwEEZADD7UEY
	kd7Hmb4cCjwvoxClTL6ElK4DTwdgytVv3mwHsqgI3/JI7ENzJLiJVzO6ARfN7dJX8mxXbEQaNSQ
	Ysyxb74jhxMH2dZ2wZ0yDKzP4o6V9ej8MAuhWF08nURblYT/BbVzrwL1QYDpOF/Tsi/uXmsJuFt
	b9rSIE22VW3GHPP/OMhB0B3e6Z/VTLkffP1funsg0PzX0HI1QH9PMiZCkHohn0Wqh9SiCJ9Fy2s
	6ChuZfND8Ul8nkAA2pz/pPgJQ4joIhAm1opUrUxunst0hva8umThQobBk9eMvWB4mQELui+XMeZ
	Jcy+Yfr39XuwDJt56BIk9qHHn8EPaiOH58g9lf1N63dljVSJ569egjeg+BaOA9MKtTmq2BrqxBW
	/MDgg3ch3LtJQqYbNGZE9D6OVQDCdA/+vXgVAmxN46JfOY
X-Received: by 2002:a05:600c:859a:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48a53ea15bdmr65740525e9.5.1776803051393;
        Tue, 21 Apr 2026 13:24:11 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm655989805e9.3.2026.04.21.13.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:24:10 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Tue, 21 Apr 2026 23:23:11 +0300
Subject: [PATCH v5 3/8] ARM: dts: Add D-Link DWR-932M support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-send-v5-3-ace038e63515@gmail.com>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
In-Reply-To: <20260421-send-v5-0-ace038e63515@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=2yHUR7vf/4pTVAeDqwUY/lONvxGcKw5B3T7ZR8edG+4=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp59zXRVl1Sw1Ld+3Q+2fSkkr6eCrCMpkH3vrj5
 iws4Vy7k4SJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaefc1xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiIVcRAAqBZ6FU4uNLKpJxvNRTWai38+QRve6ja
 /MNGEnjPG52ccLMGiQ88XJrzrJYJtoXoXgSOK77PjcMnqB/KnoWmUjg3Gp38WcUJk2JeRzPoBrU
 Dll9uopylKWmzlgFOOpZ6OPaCyvUgVDUNIhpUM3/LMvaPaLgd5qGbwy0SEweSVDg4jv/IT7cfJE
 slHiX3IVB5ieysWX/ifNF2WJ9LaxOXA6/x6naitX85TDKvQ/sLn6R5Cux5PZU2tWWl9+cwoFRdr
 BtnjYpvG1mUpMNjX2aqZQvYpwh/VT2iSC5vdBdl9EG53KXjqA9vQhIqFO++IGcXTKo/CkjdfyV1
 GDotOQzrl+hZCVFQ16BLpIkNWPQ2aDnvfQd/iJtoEUnAS7UpPvOwBJy1qmkhdCndgXQcRlE3tEg
 2KRjKoI9OMrx/pQrqYAF4m+1GXena6atYZtd5ri+8CKMOFfzb9Gw/WyzEAaCOobzbnLdrYuCZ6P
 iO1eV9RvN1DhQdG4DVOPv+ttkx9WEjdEGQsB34vmLIKmhlvz/xO5SLUl1wgzgHvSpMdaCWUrIEY
 zb5LNNZMzqw5stF/rEHGBxWlUBCSzP5qtIf+ZN4JU3md9M1uAawrjLbH1jRi+/wD6CROuwGY8nJ
 buhQyLgbBJ8oUpFSrmLqlr+Usakph9Q79+TZ15Cn/B/6/mWjjcVY=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This adds base DT definition for zx297520v3 and one board that consumes it.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

Changes in v5:
Prepend the SoC name in the device specific DTS filename.
---
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/zte/Makefile                     |  3 ++
 arch/arm/boot/dts/zte/zx297520v3-dlink-dwr932m.dts | 18 ++++++++++
 arch/arm/boot/dts/zte/zx297520v3.dtsi              | 40 ++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcade90ca14e..f7ca0d478e81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29203,6 +29203,7 @@ F:	tools/testing/selftests/cgroup/test_zswap.c
 ZX29
 M:	Stefan Dösinger <stefandoesinger@gmail.com>
 F:	Documentation/devicetree/bindings/arm/zte.yaml
+F:	arch/arm/boot/dts/zte
 F:	arch/arm/mach-zte/
 
 SENARYTECH AUDIO CODEC DRIVER
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
index 000000000000..ac20215fddef
--- /dev/null
+++ b/arch/arm/boot/dts/zte/zx297520v3-dlink-dwr932m.dts
@@ -0,0 +1,18 @@
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
diff --git a/arch/arm/boot/dts/zte/zx297520v3.dtsi b/arch/arm/boot/dts/zte/zx297520v3.dtsi
new file mode 100644
index 000000000000..0fff00f910d6
--- /dev/null
+++ b/arch/arm/boot/dts/zte/zx297520v3.dtsi
@@ -0,0 +1,40 @@
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
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		gic: interrupt-controller@f2000000 {
+			compatible = "arm,gic-v3";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xf2000000 0x10000>,
+			      <0xf2040000 0x20000>;
+		};
+	};
+};

-- 
2.53.0

