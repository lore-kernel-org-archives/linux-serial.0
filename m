Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC523C4FA
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370791; cv=none; b=POz8HqrX2TG+Wds2KYOFobwjUVQgE+pBQ/w72JiycpPzBEPp653DwyUKovHcI8nmA+98jdGtgPSRe9Xuc8FoViDnP/FcpyHxgfsMvf045kgDIxC5eIdqD9h+z6ogmW4Y+ivwyxZ1RM7Y9l5VsFQBIi8LZKEvKfDScZJBeSozGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370791; c=relaxed/simple;
	bh=DfFTCD7dR9UzG1/YZiQHT6WP9Ms5CofApjF0auiCUpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/F/8vXn3hoZL728sF+64rEJMWmu6nbpMeqOk3q4QppydoNZiDh4tjwMh2985/14PDWMG4ILEq2h8cOd1divIpnYI9hMnqb2D0/QJ1kHh7h5sXpUU+FcsRLAHahmIMMuUyXOZLC7/Er2mGsieqW43qzXo9ATVdaouCmAB361BwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbn3OBLw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbn3OBLw"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488c2690057so85467575e9.0
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776370783; x=1776975583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKL1UApwli0vBwJCTHGaBiJ+JuL3QPXRKM4vGc8erbQ=;
        b=Fbn3OBLwsvH2XuUDyxkh3cXKfKOB2T9HGOuuldcUd76ok/KsuVFPLln+VeU1mbKdqy
         muuhn3kU1rQIATsRtmNXlYAbH5q7oPZ/L/dUlsYhTfu5Pxa3gfWf8DYWL9fmlixoc3B+
         ikZdeWK0iwbds+Uczoy81/FgsX0CRoOpoZSx6kZIJNSyOf2/fWqmR3LbFZgeUSY673nF
         8juruDh9Zm5yEF1+/SXH3WiWKlc2mEtC04AVsEcKEbvwW/0zLgNkUr5RUHfrnnVSnNGg
         NVF1oxnwQtKez9DYxXphDsYrjTRlfTOxXgWkfQ3udp6BvHir3YgYIAYMnT2mH67W+1KH
         VbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370783; x=1776975583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rKL1UApwli0vBwJCTHGaBiJ+JuL3QPXRKM4vGc8erbQ=;
        b=pa3XvdkF6HmUtSvJN02am7zbQtttvdlEuR3IvNo0C7ebcl1ABEvYjvJtmL6oUXZbKx
         kJTwmxY4dCw7RoBTcQKAKiBJ430+Gnh5n69RnpaSZ17QhDSp07K/+glGM4/6chD/kKZO
         dtF6rwXpOihlbURL9E6JaAlA356Oiqu5cjXyx5/8Vz82hFHByrEzo2JykIy9WaRck+Zf
         L9ZdwCO5IG9l5JQOWQ3gcu0IhP3eOW8VWP7mvlyZ3P/4CPoXQ30ivTRAvutHjORxM1m/
         IaWAJJ0vuRx6k2wOLDMN4Xn6etJLSsG9O8MiDGfCMAp6jD3YTR0U3JqtSyVnxGWOFY3F
         gPDg==
X-Forwarded-Encrypted: i=1; AFNElJ91X3M+Afy03vB2vDo3K6lwbzw5mxboVoIbvuVTs6bPGtrTMnVtZ5ZS63USS+E9B8AK1rXsbCAExiY97Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfP3CTzw5VW/MvYkEn+TzlQO0SoOLeN+QboTH2Aqro+E1SSriA
	YfQaQoFBKKlBr4OOygUouhgEwwQ9i7Vbz7TRom4UN8EeAe6oSerqVnAy
X-Gm-Gg: AeBDievHFYpzry5h/07o+WJ3m18VudKjT4fhh9Bwv1rLoTTq11mfjNhBzXqxHBywCQW
	Fx6aNV+TNzi0JRUTJt30/nIPYK9VhcIDZHVb+E4OFYvfzkBNclB2cqF6oXqgxwoCl+nBvlSVINV
	2uQyfLoQWiVc2E3gyBrPtNTY1FA0eWbbluKLoFH/vwNSoJIAAXjCcoRoTk3+9UwGSi2Sp4nbMuZ
	KM7Kkr07rLUFSsgUPniL0E0yAot4s4li9N3eIJGsvYwkZlIES62aUadEu9qFVymM3ltrTolDXYB
	tP/e3obLG9/sPp/q4JSF1wq+i670Hz599e4sx9+hEV/UtZE3c1yV8OWPo4ZcNRXd36Z5bnmm241
	H/nt3Ly3MB0Uq3uHbAFxn4rM0lN2c/zPjhEcZljMozHiypquwG9JFXa5jvLMKXbjiEF59oCaS/4
	spLyC6Uz2RZj7jPg9Z/v7gOD9kmEEkgZ40pP1tAw/7o54JKQ==
X-Received: by 2002:a05:600c:c0c8:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-488fb787ba3mr732015e9.27.1776370783286;
        Thu, 16 Apr 2026 13:19:43 -0700 (PDT)
Received: from [192.168.0.2] ([197.250.227.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35c026sm16180624f8f.15.2026.04.16.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:19:42 -0700 (PDT)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Thu, 16 Apr 2026 23:19:11 +0300
Subject: [PATCH v4 3/8] ARM: dts: Add D-Link DWR-932M support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-send-v4-3-e19d02b944ec@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=DfFTCD7dR9UzG1/YZiQHT6WP9Ms5CofApjF0auiCUpM=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBp4URKMjgP0rIgBZerMAS04qD7fxmmvb4Dtqzzl
 qq0lJcpsFeJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCaeFEShsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiKSgRAAhITFO+PosbwvE3BtTizQCM5HaxtoiNN
 PcknQEsqTA0dbu2+zLAYugjmebCwIo0Gd6QwM4l1TWj0iW9ti9QM9G+SQQBXFxrohZyh+U9ouIm
 gVclMgJnT86r4gWMVEf/f/VCzxERJsNXencypr3FPpTorY2YrTYv98MPNEHMAlEdmeCiLImCzqG
 LP+2Yf4fi8t3ki97W6CjCRgTbUL7vFRFhBn5IHugKznpqcXqnFsc0qqn+NIyaEzS7DGYgCjFz1a
 D9BujFr3Ghcugdx9NxwyQBFxKk3EtnYdakq8lYFVTRKRj/ux7Ga4R1WgybucAHe3a2lz3n9ZVUd
 kH7JDkBMMTCHQV0KNSQsg71IFEB2ERUsQhzrHMtqDTFc1D6bWOYYCO4+TtNBi0y7ysD1da4bR1S
 kPd+om15RV4vPr6mUec3rPMmOPE2fvcp58LRYTqgErhXquMJAWt0+vq9N2EIATPyH/4a+oAZsxJ
 XWi7/qA1mdWYbZ59qWN90uayMpSsOkB1xEPoCBo5N7zYwR0K7aHwqW6QyfTRuvrKumb/CRN3I5i
 xf1YgbgpQrElLCF8kX8qy+Np61GmIS2MelINW+r34WUPytspWVh//Z7/Y/zPEzNGLuFRLxuVD37
 5P2OFcYy1ygGF8H2pGUny4dT3RJT9+e+JDpnItIQnI3U28+fPFSg=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This adds DT bindings for zx297520v3 and one board that consumes it.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>
---
 MAINTAINERS                              |  1 +
 arch/arm/boot/dts/Makefile               |  1 +
 arch/arm/boot/dts/zte/Makefile           |  3 +++
 arch/arm/boot/dts/zte/dlink-dwr-932m.dts | 21 ++++++++++++++++++
 arch/arm/boot/dts/zte/zx297520v3.dtsi    | 37 ++++++++++++++++++++++++++++++++
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
index 000000000000..416c24a489cd
--- /dev/null
+++ b/arch/arm/boot/dts/zte/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_ZX297520V3) += \
+	dlink-dwr-932m.dtb
diff --git a/arch/arm/boot/dts/zte/dlink-dwr-932m.dts b/arch/arm/boot/dts/zte/dlink-dwr-932m.dts
new file mode 100644
index 000000000000..7b2a26aaaecb
--- /dev/null
+++ b/arch/arm/boot/dts/zte/dlink-dwr-932m.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * D-Link DWR-932M Board
+ *
+ * (C) Copyright 2026 Stefan Dösinger
+ *
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
index 000000000000..d6c71d52b26c
--- /dev/null
+++ b/arch/arm/boot/dts/zte/zx297520v3.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
2.52.0

