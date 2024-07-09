Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5147F6B;
	Tue,  9 Jul 2024 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495262; cv=none; b=pPGaR9cxpwgBcBHwfRqtv1jueqW4PVwQi5sNDVx+y+RcOZ3FRXTeCzrfBHnKuaT/Jff5VMLYZfqr09IASXOWH8JUTXUr3dhVjKR8aZGPFp3L2YWurABmT7G7oP/aB87e1/f2rD50ZKxTqt8YWdQKR3zdwNOoT++P+P2tltofxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495262; c=relaxed/simple;
	bh=OLDt7dRlbPKWhHGfKxLBHLD9o2bFrg9K7MPbZR7/DtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOtgOTKqVvVrOExbJbjaROOCEs297u4rce7ofbsdwuSOiDgqjQcBoqruf1+dW0tlMmNio3bCRwaiBQQWkAVzW+io6+ZvNekPK9SGI/oypEUCCxcJ+cPvBBPgOAInNcDQ7CVhpK9x/y1bMm+i2ZsBJp4xE8J3zPVm67i2nNwoq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:52 +0000
Subject: [PATCH v4 09/10] riscv: dts: spacemit: add Banana Pi BPI-F3 board
 device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-9-ae5bb5e56aaf@gentoo.org>
References: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
In-Reply-To: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Jesse Taube <jesse@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=mJc6hZeXKZcPaMSmqXhuz5fuxopioAcnLOzTKcNsQPA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKw54FO/wGQQEetIDywkal1MPnSgjquHCTvUC
 2baklrbcrKJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysOV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277S9oD/0V6Q7ZRNo0qx87KI
 3EXKU34sr343u/RmJm+xgwRZcRUqQDgg0lBxVUiY5uIamSaQdJSE1oZtCH5LADUaowY7Fr6eoXo
 AyUmam25notxo2jNxwVmT758NtSTEcWHS9M6rjh9f5m9fwZhUZaGSJv8vLznMvcLrWRm3tAhOgm
 MHnYhDcikZcpVmJYY1mTzbz+5ggQBD4k+EeAp5Y1kS/thqP60giX11zg/tawRaN+5bG0UcQ6sAO
 KIPsPfnCHR/EMI8hBwTQ1wCwzL8UVzWEmP61X1Ohwg/Sd5Qh8tTT8frRcHjDDOMOdVY/n+lJI8p
 WFvC7MhUiNP2rWJYtfLyVJW+Kl+ZXYxt4YZqWD9BXUUAoZ85LWHXDE1fYxEnA38s6d8eTd9p3dg
 WnZzaCAyufPyl3AuMj9Ju0Kk70LOL5Z0VePu3BwZmyxpInWytJcE6tWM7Bvrf+zmSt3CF2X/eCt
 aNqFMwgURR1cEXSdMwsiZm9QhcLef6f5TVrNVr4oq/potrcH+s3/G3S3vbWdDZxDnL2Lc+F8/2v
 1na6H2dp/Nd2M6cS4bU3OPDFvFAFyQN8xfWJbV6/bu+xmiC1gJZW9JBgWaO8EVP33GV8x9OYM1p
 6nmPq0ElndWRqaPTa+A95c/q4JXcH3lPd3pmhtDmEAUHAFPArjFQJRByibbj2YR7ux2w==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Banana Pi BPI-F3 [1] is a industrial grade RISC-V development board, it
design with SpacemiT K1 8 core RISC-V chip [2].

Currently only support booting into console with only uart enabled,
other features will be added soon later.

Link: https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3 [1]
Link: https://www.spacemit.com/en/spacemit-key-stone-2/ [2]
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/Makefile                    |  1 +
 arch/riscv/boot/dts/spacemit/Makefile           |  2 ++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index fdae05bbf5563..bff887d38abe4 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -5,6 +5,7 @@ subdir-y += microchip
 subdir-y += renesas
 subdir-y += sifive
 subdir-y += sophgo
+subdir-y += spacemit
 subdir-y += starfive
 subdir-y += thead
 
diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
new file mode 100644
index 0000000000000..ac617319a5742
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
new file mode 100644
index 0000000000000..023274189b492
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
+#include "k1.dtsi"
+
+/ {
+	model = "Banana Pi BPI-F3";
+	compatible = "bananapi,bpi-f3", "spacemit,k1";
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.45.2

