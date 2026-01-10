Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE931280D
	for <linux-serial@vger.kernel.org>; Sat, 10 Jan 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022451; cv=none; b=fPSue7G25pvyvEqx/8jNzf9aMWK//d5AoEriNPUMFuweppH74y52DhhHmF/7oZsdOgTGrsjqbbpOLFtELtTHnMwc98zJS5DXtHUPX+Ng+kLII50di3aa5QGaAUWtqyBmTM++aoF0N4uQs5VObRT57gu1WXrJVF6DnN+8tzz10JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022451; c=relaxed/simple;
	bh=RpX/YUsP57yYRCsMuPjhWD/AM3yMIl5MNE+TunhwMLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2XquA3btus1Asx0BX2rAMuEamF9uGcUQ4s7Rc9U4nEi2keDepK4wMqDCeQlzM2sKrejn+g7BB/rlbyEyAO2wp1gC+9Sq69I+jLaVXN/G/VlyGsDwtl6FKaqpIf4iJPF3HG31tMK99YbF700dM2UxV6iih0GbCQEd8EXcWu/nOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UhD4eBUG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UhD4eBUG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1955608a12.0
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 21:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768022449; x=1768627249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31DgMKkz4Cjgbg70+PADLl7ySardk8pduReCpk77D9U=;
        b=UhD4eBUGyV4AmGNXtMuKur1e5RuF/HR3mndgtmG/WfLKNWwx/HhD25W6izaUJdgk32
         Y1AYGKeiLwib5hDBR36H7C6aB0tH7D3KXNR38CKgBqI62a/0AQ3ptQkmzKZnB7Ej+v2w
         gAfbg5jQRrzEqKnPTVxHx8xYZN9si4l1R4yNzhQXtSEhjAdkkwHPWx6eWumZMsn+oA1w
         DK3xjT8Euv36a+w8vuXAjRXb/KuCOX2EHoCDA+oddTBoUCMhStqknWHw++ka75LbSur9
         0vEAxrLGrujVKU+h7oCe1UK0jEjDjWj2RlK2Z+zNjXAy4kf31zxbugftD1QfP9uo5Lnr
         ZEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022449; x=1768627249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=31DgMKkz4Cjgbg70+PADLl7ySardk8pduReCpk77D9U=;
        b=TwjQDhcRdRH53V9+glqW5J5P6mskF9n1YGUkfTJtcZ8KJqGOtLw8wOAZaggjkozVKn
         io/Ryixnx8wDpPOOT5/WIC3cEMJ9DFw1qLZUKouREKjb9oF9gJhMbbX2732Ar5qyAkZv
         yvx170LP46c4iLYmPfX/nAsQ0aWI3e3AKKsd+S0bmNQyDRNoy12PVxBK2JCtZep++I6R
         8/V677vbIH130iXABDej461A2O3nLkqDIPiv2hb+vj4L/W42co01wMz9RHVxaT8/Wnf8
         PTDaIXQIDS48vbyN6rVq5P+VUTMpFUPhDzLf6InON9PrKOHq+eV1ljqXIEV+/hVf7Hux
         SxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1gvK8u5c0LQlKw0QymI/RHGT/D+wfHvWv1UfDn8AcAH9/h04rKJCZ8TMCqlgMcj0jdFAOmo05lrCbEXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17V3+WEJOJyFYLLJ6XWOPrGlCCmkDWqiiinLco2eBszA3HDUU
	nnhGGFcH0mFhx5oxnAR1NGL7MwH0Ad2rPq5BFPghcY1r0/15KkOdgC7lo0oio+nlvl4=
X-Gm-Gg: AY/fxX4R3oE2hMJ6QVDeCgurJG0ihGu6zLOhuEwvb9TRSZqzU+h4QlX6D8Za929gpUV
	/oDhPUkGZiXrVKiOWzvSLaz8x4j7q4zuztbyzfXZeBADi6KpyaR5kl8yKgGh6Kdo2041Yc7EvuT
	ts+TuckP2cIu6lKxkvCV0ZFfVpITSEDqNe6TtqN6y/Np76Y0/zig2iFJjmLCSZ3iH9/kPJW/XBi
	c8P+yg53v1AagnGpX3FJTSssz9K08KSLXWOM88ybKT7cxPm5qhIOYWz7TQhJokhy6tM1rdrh+eJ
	5g+GZxD8GpLfyg2YptU1c8GMvsfgnFvWNh3HBCchwK/THGJT9TgBVqNLAtSaS194Xemlk6UhRvc
	TmhCLcy3TfYRN5y63rJ+WIsS6sulxhoQxrsftgmyikuNAhMSgA3BGKxYuz5/K64MnJW8qpUpO/T
	IogCD0FooPa2XqGOmtoko1iHjLpCZ7eZyNUiV/hAw3XmBcZRO1eQwRYw==
X-Google-Smtp-Source: AGHT+IHYGojnyw/X9+Sa4CxlCr/3Vn3pURVbolq+Xy03kMkgcsYibAap3C0WizH8w95DkH1bsHgxGQ==
X-Received: by 2002:a17:903:2309:b0:2a0:d46d:f990 with SMTP id d9443c01a7336-2a3ee4e81c6mr120164655ad.31.1768022448640;
        Fri, 09 Jan 2026 21:20:48 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm118208265ad.73.2026.01.09.21.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:20:48 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Sat, 10 Jan 2026 13:18:23 +0800
Subject: [PATCH v4 11/11] riscv: dts: spacemit: add SpacemiT K3 Pico-ITX
 board device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-k3-basic-dt-v4-11-d492f3a30ffa@riscstar.com>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
In-Reply-To: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
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
X-Mailer: b4 0.14.3

K3 Pico-ITX is a 2.5-inch single-board computer equipted with a SpacemiT
K3 SoC.

This minimal device tree enables booting into a serial console with UART
output.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: No change.
v3: No change.
v2: Add aliases node in this board DT.
    Update the memory node to reflect the hardware truth. Address
     starts at 0x100000000 (4G) boundary.
---
 arch/riscv/boot/dts/spacemit/Makefile        |  1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 38 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index 95889e7269d1..7e2b87702571 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k3-pico-itx.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
new file mode 100644
index 000000000000..037ce757e5bc
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

