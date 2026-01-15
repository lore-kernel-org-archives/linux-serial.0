Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374430214B
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768460000; cv=none; b=KSbdkb/jqiCeEy+DwfgdHgoCQzRgvSAzJ2oHMFaTFDozeew8i4Z8/tMWcw2vHyw5wINVQ2MKeQ8gkIV/81ew9tN5P/1z46UHSLfbzRYCe042lUFC0tHL/G84BKm5r3DFhNAxvNkCmjmfgHIX4kr9LbGXvXWsW5zMZXvqsvFiPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768460000; c=relaxed/simple;
	bh=QjJKkTUz/26FCCJorplE27fDB3J4K9QRmD2HajPhw84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KblrWYDokpyTZu5SZ7+nvKP99Vn16lo1uLiUasegOBarOSJb4FMNfYODtsWdj1gzGmyW3FDdk/mkAGQXBlwZpJFVOeWWEHX9fJdiR7aBx3p3K/bQWUgsbwjy6vqAzHyGb+m0P/zZ2EA71PswcqgDccFzjbMk7YAm9TSmy7KfQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pR/gJgZf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pR/gJgZf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a2ea96930cso3687905ad.2
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1768459995; x=1769064795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JN4w43030nBMnmCgDRIi09REyeuq/cQHIYBn+3h/zwU=;
        b=pR/gJgZf1JlBwf1zTjdLX4m9r5KoWEsfGcbEJ12GjIA2G9fhf4WRBJBQxmmiBLDJIm
         9Y3HH1c7oeIdtcX55CrFa4znvhmE/Lp3OCmflqu80anlKbHaifKjRpGQrFVCP24LdF8Q
         h5eUmEYsfZkDRF07NVi9ay9hm50tbXwXJi4jkk0AAoaDSxQSKrSpY8WoMHq1kw0xIL98
         i6morGR/JErc1kSqVyHk/LoqfFPIEG+4tEkItfdafeSQsea7+KKmjxQ2leUsZSPyHGAW
         8aRy1guERQQy/FMZ0WlI9pQX4e5ANANb36gqOvVfDZzHHXhuPemttn5ypajzpCbf4GdX
         Y9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768459995; x=1769064795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JN4w43030nBMnmCgDRIi09REyeuq/cQHIYBn+3h/zwU=;
        b=cLgK+A9ka5hCvykbvRCd9bCY0n6MErBlvFOPmkfWhoNrRiSq2EH2FNx10mBE4hEUhq
         xBhZamfH85weNITGrgJFaVF/auDVcQnRN7v5I0FGfrsIHKLG/DwFHx7hCMg9ft1VuYTD
         cSfTs5ytcsocxrVBLNZx8UKGhYnNyiVoZeypKMUKcuo1ceZ+13wTpJs8YsaRMdPKdOw/
         BhZsQjtkRyK917sOdNmyG3qC097eb4vtiBqKqXQ9Ms1f/2v1gFeqsO5bGzEno2U4NpAA
         76nN/0wiv6zl8RZnnL/brmDGuRfGuPuWa2xRazPM+w1X6I5m9ZBR4xxQv31MNa7ZxQuD
         0TGA==
X-Forwarded-Encrypted: i=1; AJvYcCV3rjCCApvEVjDYCIl9u1afedEXF0idJjuZeYvVb7u62jCu0ZIXyAwSV1Z9bGtJ208e8uzb2Cqr3SQWjHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcM7wZtBf45UiDXpwne+Bt7hMIonZ0eP1XKMFdEIxKn1/HL0f5
	oMojCN1sNfBqchzMiOw1bO+XuChmAMDIldA4rjPQqoQHbCXBcLMPmq4fIZb3iTtH9cM=
X-Gm-Gg: AY/fxX6iZ+GcHjf/buTLmVMueAz2OdMKJcVlnrcxwL0hLw7ryOeNzN59+0JvL4Wi17C
	8inwyj4EF7ctrKq346UGTflTFFlAnJE2hhxVloJZ7GjqbI7WMkQ5c5HQS4tIme22Esz0njDYdMH
	KFtifPptid/AMbTRBicsMbb+eMu70M2QPT0As984wqN+BZ/206plwGhEu5kuN7DggHqXL8am8sR
	kwVDqkekxgTgdpabuh27PJFEbNvH0JqPW6JhYQxRVXtItZsdylvYfIIg35phOK7A6BYatl+Hxy3
	PBg+phTJ/TCWE3mDGgB/6BbZDa3F47eDLmbX1WAdsPVficY4O4KqHib3szEmOGr5420c44OMk1l
	jeg/JDeUSqTNW/KtGIzlLlyI/p+Hm0mA+yMjgM3McFozYFT5qz18yLmPB7R8GkpJMZVZWkEU5Dc
	yf9dqOhFdQ24ZTx9X4iXPW45yVmGVDxuyHa/GknR0d8HWWeRJfYiR2eg==
X-Received: by 2002:a17:902:e94c:b0:2a0:c5b6:67de with SMTP id d9443c01a7336-2a59bc43586mr44946485ad.52.1768459994844;
        Wed, 14 Jan 2026 22:53:14 -0800 (PST)
Received: from [127.0.1.1] ([45.8.220.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e7a3c6fdsm235081015ad.15.2026.01.14.22.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 22:53:14 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Thu, 15 Jan 2026 14:51:46 +0800
Subject: [PATCH v5 7/7] riscv: dts: spacemit: add K3 Pico-ITX board support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-k3-basic-dt-v5-7-6990ac9f4308@riscstar.com>
References: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
In-Reply-To: <20260115-k3-basic-dt-v5-0-6990ac9f4308@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>, Thomas Gleixner <tglx@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
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
v5: Update the commit message subject per Yixun's suggestion.
    Remove the unused aliases.
    Update the copyright year to 2026.
v4: No change.
v3: No change.
v2: Add aliases node in this board DT.
    Update the memory node to reflect the hardware truth. Address
     starts at 0x100000000 (4G) boundary.
---
 arch/riscv/boot/dts/spacemit/Makefile        |  1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 29 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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
index 000000000000..b691304d4b74
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (c) 2026 Guodong Xu <guodong@riscstar.com>
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

