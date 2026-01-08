Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710644A2E30
	for <linux-serial@vger.kernel.org>; Thu,  8 Jan 2026 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875298; cv=none; b=odGvHi39iiffu6T+ElZvV/3NNkdW44LkV92mm64oOmCQyQr+TGWyvAqKzt//yAATojAjJaWpWP/1QMgd8qZAFutW3WGV449ry3ikXO6KntdpEZAOOWVdZLFikkB9DnFCbWYWOu8tz1LnDtY0mEaHCa0NM5TrVAghIx8yjBBGx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875298; c=relaxed/simple;
	bh=B/xJC06ouJTSzqoVe1zpf/ArcrN3kkBBh4pRafmC2q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3+2OCDQBVgW7BAebyEUBtWEQEssVMK8naJDeCN/nNBo6rB04GM6wvTQbWuuoxtH805rms3w3KxNy4fznFhTv/JUFOokyshcP1fyfDz4vmsd45mxzMUJt647MuJPzu2AT7eYd6VsQ4WpE4x5a1UKRd0aYxgs5NwNRnoicXn0Atk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=LGFo2/fR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="LGFo2/fR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7e2762ad850so2671478b3a.3
        for <linux-serial@vger.kernel.org>; Thu, 08 Jan 2026 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767875296; x=1768480096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vr6lqGLFQ3xLUl/SLHoUY02BcAcuWIW3ayvn+T++ix8=;
        b=LGFo2/fRBmL5A6dlnvfDDmng5HIJHiDGpUisu28uSY07QrHT/tocdpGwS94Gk3FWZp
         +1CWEu4nNaa+p1Y9l0Usu98yca9nkL3q3QFWsXiuPz164+l+AHVKzmMgTWc13oPu75Gy
         2XqiMMxgwpLYDw7bQchMh+Is4EhJ3P1Mu5N4MVDhP7GuihEkf2D6waVxCoS/+s/hTSL0
         LxIFeQsQg/eo+1hRBhVBXDJZB9GfGzr5WI/ZvcXGpAzHm8rVxpg1RfBw6lAKYTAUr/h9
         QuxCxiZ542+CYXt6RBCAXlKAicmUHEfYS523iZGYonGgaXDVcpYW5Q9HPxeljqhuQ+Nw
         SBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875296; x=1768480096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vr6lqGLFQ3xLUl/SLHoUY02BcAcuWIW3ayvn+T++ix8=;
        b=O47RNSoCuTVbwd4dZU8bS4li6M+oVcV0AQhSVni/M1V7biZPvG8fTsPkk0IxAbp7d8
         AAxoioqRJ8lw/rUQPDLCYBJcSUANzVeaG4whbN2WOy3Nzi07y7ZRiir2kzuRt5haVK2g
         zAxpB+FN/GOink2TsFODC7yJ0dbkXOUUnHb0LxhRo0d6+GpQ8r3OtlSTsh2YJVetC6Ah
         T4op5LEU0XI2iPsdtPkcD0L9QWwPHcZP65803wkS3WgOYkR9aa6lbWXk1B9mfrZDxZMl
         gtHqbbE1I2xb3gNI/Z95rJ5h1SQGAt4f2bivUUiLuvrh4KXzQxF+O07lHcxIkvAaRogj
         zoog==
X-Forwarded-Encrypted: i=1; AJvYcCVUtatP1GQP42wLQXwjKEmpIng46IL7RZv4DgfdHHoT9qQhtP0s0Ur8SMc77Zq5Jq4WK9tKn8XtpjOUQWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFqr16BYlLZ6ZH5t5vzvsASNGzz1gYmt7JCOv4t1LOSMwcK2Y
	+jWSiDxZ+K7EkyN6PXKr5HH1PEhbHGjx/sa/DCqH6k2Qwsrfm+C5YWAPEljscmjRaXohP0fnIDo
	e9aavQa6WMxqj
X-Gm-Gg: AY/fxX7ePHRj/9GeKG3o1vatJCJJH5r8Pn0C1knZbBKtdobIzRuw1GRuGHP/L75wMDh
	g63fsyLDxl2grEA1k9j1N2yAZHGYCTljKb3jNomv3mzjY9aZmHLGeP/THjP8NhbfZT9+0KF2BR1
	x4CrPKxY3tDZRqcIsWxZ6Xv68eUF6w7eyY8ksIAY9SvoUkIXAcwY6hfDg9zAu8y9QH2DxoU0YS2
	wAsvK8UcCbiEdKe8YXRnja0v9x55qC5blp1K8CmPO+uwfebj8R65lPYMJimVKjUaRojfP+goqZY
	5a+QOAncLNLHBza0czixIG7jKz0IAGjtE3W+7d1Ah4SRRSfmBTOfTEPW4mInlbEteoZMGGDkli6
	gT8oncvcu4EBH00ePFuQZoFnJtwUEyneMMsRmOKZwLGdnXDhPD3Duph0WI1PE9F6gqsWPRUJ3o4
	qQQQjVdg/WcEPicKAr7t47sl6dVQZ1uAE=
X-Google-Smtp-Source: AGHT+IEp3lIqQRQ8F/+xV31qGFYy3RxmeX8QufC32EgJpFKkC8v8rt/OnKylZz/xtgAcQ5aWbSQxCQ==
X-Received: by 2002:a05:6a00:3688:b0:819:bad0:1002 with SMTP id d2e1a72fcca58-81b801ce2e1mr5550278b3a.66.1767875295662;
        Thu, 08 Jan 2026 04:28:15 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::40df])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm7656401b3a.16.2026.01.08.04.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:28:15 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 08 Jan 2026 20:26:02 +0800
Subject: [PATCH v3 11/11] riscv: dts: spacemit: add SpacemiT K3 Pico-ITX
 board device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-k3-basic-dt-v3-11-ed99eb4c3ad3@riscstar.com>
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
In-Reply-To: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

K3 Pico-ITX is a 2.5-inch single-board computer equipted with a SpacemiT
K3 SoC.

This minimal device tree enables booting into a serial console with UART
output.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: Add aliases node in this board DT.
    Update the memory node to reflect the hardware truth. Address
     starts at 0x100000000 (4G) boundary.
---
 arch/riscv/boot/dts/spacemit/Makefile        |  1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 38 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index 95889e7269d1bae679b28cd053e1b0a23ae6de68..7e2b877025718113a0e31917eadf7562f488d825 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k3-pico-itx.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
new file mode 100644
index 0000000000000000000000000000000000000000..037ce757e5bcae0258a326ea6265185d761f2b52
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
+ */
+
+#include "k3.dtsi"
+
+/ {
+	model = "SpacemiT K3 Pico-ITX";
+	compatible = "spacemit,k3-pico-itx", "spacemit,k3";
+
+	aliases {
+		serial0 = &uart0;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		serial10 = &uart10;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	memory@100000000 {
+		device_type = "memory";
+		reg = <0x1 0x00000000 0x4 0x00000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.43.0

