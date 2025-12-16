Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37B3A4EA0
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892069; cv=none; b=axSTnFYKZh+/kI6+MaH6o8GaBtWBbTxnAilkmnY76+bQppxaEpvrSpaKU++iGF8fkUeZnB/7uTzZ316uGqwEZ87FP55iGAyjTB1Kk0OQNA5HSM6q2U++TFLlJD4cphUaq/+Lfxgw5IdAH5VO1P1Tstf7K8tWPHWmFRU+rANIxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892069; c=relaxed/simple;
	bh=KjhTJTkDXnNRFpIPUaoSGbev6YIGfYkMTsBBPhzGvcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6TcWz5eOP3iLINCzF2KumXLHskiafqkTbZ4DdxCy6zlZegr8667WbOu85toF2po0Cxvbmg9xNhk0vKA6mOTdqWkSzZtbiRCWGsM9faiSHhoghnly7CXBJJPtpluN87oneYQEQa5Z928em8b9cGw6z2g/jeC6n4HX1bMtJADAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=WcV1nUQR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="WcV1nUQR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f0f875bc5so60714615ad.3
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765892066; x=1766496866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjtsZDFBVTJEjQk/WUDeFopXVBua3qA0F4qJMc77ff0=;
        b=WcV1nUQRebnfRO4g3dAsas2NloUn5XuVDdVFazmX6tT7whCI1tEKcWJjAlMiDqtSbX
         Dh+g+eLg8nyoEc17FpmQH7JI7GgU8qZ/6lb4eJ8r/fKUIHepKG/XgUwkErfiGOpsNjO7
         QxmWWNaiUlUVq5pF6uO3o+u2LUuCYUH8uMy4Szi58nps9qFwGb8/4Ypnt3cGnNkBtyFn
         KOP2IQfuGS+AvWAIr9RjI98+MmJ2uNzHqT0g8C6XrMBfmD0pBPwqUZxJbpFgZDcBjHF/
         quaZNJ69Ke2iK4PmmNlbeDRodWd6aMtUtAlMeK0u+aNl3p6leSe0JDM+SGI3UWK7ZgFH
         0i9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892066; x=1766496866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IjtsZDFBVTJEjQk/WUDeFopXVBua3qA0F4qJMc77ff0=;
        b=oN0CIODljBELfmO5bP7KMC3lWt0In3hQ7HhIVHcLtIhwrm6gr3QShexkTO0xwc6eZZ
         GyoEbgrTPNnDpsNXPFuYxguYzl3WiYfCSefvg13nfvVEzuS9ZRkVsrpxnCD+cyT5jRwv
         xOb0vR/7Aj7VQqmbKjTbhVrDaFTfYdQyhxcT2qQWAaotWzflT42sPbGOkkI71sG65SqY
         sFj3htd8Z2+sV/64pY4OZTxeKrRpUQr4M+9uqXvRjnvNSGb8wYgEDcAZHbLKiAqutXky
         iCxaIVz5zxiMQhp7N5ujzF+UTr5Fjl9pD8DWeD3XNm8nB9/jKH5Gg0ktUWT2KKhLiAnH
         gX7w==
X-Forwarded-Encrypted: i=1; AJvYcCVa9+iBtH5QFlABovbtK1+S0VK8poNeOoeJfRff1vA4O68+BQ7jn1WK4ULky16a98jtD3zXd+Ajuc8AQBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUi0tHu3d5HKYjSA+vMZHKyvERih5SvN0JDTTuJhWUjjxRf8f
	pq5P+a3/4OwKftf59Ijm/YoLw3rCkzStMCaON0k0LUhIyuTE7EvcqMx7WqPIuJFHmSs=
X-Gm-Gg: AY/fxX6URVbsECaGPr/RlF6XlmbGri1MekwN8ymVd/r0dC3PMY4/V532CmY4ntLosOg
	qnQzZwlpZBwE1QIAnL/Cb3Hfh5EJEDlykQTtUKgUyaDQcqImUCu+R8aTutuUHhTC1bWciIEA/4a
	2D9hgcFV/ZyLuYr86LkCWQ0UYi63dAPTqcuIK9SqDKq0z1U0ZwNZEyhqhXfuu6mWy5ntvgVct3/
	AnWayP3QLG7/GBo1O+gCQN7BBhm5f9cIZ/LzLtNh+deKqyIhUZ2oOJy5VOp6Q+fzIwq3MzjtVO/
	DAVtCTLJ6bIdIVZlNoQRl/p3BTPljc6YD4fxE7DNDMJexukPff4/2Q5aqaW+0gnGV7H7M1SFNkC
	0vdWheX4hNzsYdMdZmqR6vyJ5151pQCav8VU8AxG4YKiq4QQAYZCnAyCptsgcmppZkTHIs75CQd
	eaQ398xv+Wf7nYXuui+VwMwFPyjLqpnqd3yKi6u3R5MA==
X-Google-Smtp-Source: AGHT+IGVOxm+/QKyxHcc5Grjn3kteFx1uRcmQu8o0lO93tndrJa8YJKE/y22hloJlPWLdYElnvZGNQ==
X-Received: by 2002:a17:902:ef44:b0:2a0:a9f8:48f7 with SMTP id d9443c01a7336-2a0a9f849f9mr99550055ad.55.1765892065830;
        Tue, 16 Dec 2025 05:34:25 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:34:25 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:32 +0800
Subject: [PATCH 8/8] riscv: dts: spacemit: add SpacemiT K3 Pico-ITX board
 device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-8-a0d256c9dc92@riscstar.com>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
In-Reply-To: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
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
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
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
 arch/riscv/boot/dts/spacemit/Makefile        |  1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 0000000000000000000000000000000000000000..0f9d04dd352f5331e82599285113b86af5b09ebe
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -0,0 +1,25 @@
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
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	memory@100200000 {
+		device_type = "memory";
+		reg = <0x1 0x00200000 0x3 0xffe00000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.43.0

