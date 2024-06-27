Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671C199233;
	Thu, 27 Jun 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502409; cv=none; b=Qkt1N593P7MP9+rA7Vf+pb5ecncwtE9HuttEoABXaka4vN2G5gP7Rd7eh5irdsUjer9zklgXpNlli0u0l97bog+TUg5JCh3xFhn+f63OS/r+chOiZUaUDdxMkbBsNi2lK3SbImpQP4Rb0zj8XFwQSN61Pe0eZt1b0Xd1si2tanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502409; c=relaxed/simple;
	bh=01mjDMhbjRjSEE5AA9vLXMq3HgswYmRlYpL7yJZwxco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oigLB4GrZelfwlqkcjvdZ5nWkMr5DWXBZdH3T0vowmi/8gYA2gAAhccpiktLbN3rCSehrxGImpHEPwHRZ8gukfZ7dkea93oieS3y98f+mzr/h4R6PsTPZgZF5mKxqOq+a9wdcdeTdArC1frdVpltyHGmCDHLT2XNryd67nAR1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:23 +0000
Subject: [PATCH v2 09/10] riscv: dts: spacemit: add Banana Pi BPI-F3 board
 device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-9-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
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
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=XJLCzjRr75gc7h7vfB2sTI/M5qxrnuiigx/hYD6tFcQ=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYX6rt2CZqbs2ZrI1XnrgAw8eQgOlBFn3veuy
 wxEByUttOyJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F+l8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277fq3EACS0Y4Z9v5pkgv6R0
 7/+nVsL1VELgHJIjkTzTAcDqJohWiTxGPEcNHA6Xaxz6p8AdpksBDPLFKS/GQIazltA3nV35GRz
 I9D9PmclgGdynhL6gQRpwqgwleEp6oa1x+bmf3+6eSR3NywdD2EOXHsM5MPVirdrKVLoXwND5Ks
 vCIkoOS1q5BegkuGgGTDHHfg535cCur9hR9lxCTXnZd+lsU4iDdzIR7qe9I4en2HWiCfQJbT+Qg
 sXjyXl0bh5BDzi5SNlYwkZPaDcSkgzwPztlWG/KfSe+uDRFBMHl6VO6REfl3EWHe+wRv1cEaHDl
 b9LZldNSZvrtQqN6TaKUAwPTDbUIILYF5siC1DUmtZ2JuOOV171SE7ZzqjyE+9JFfyVRYAtiGdP
 aSWU6u4BLIl4wdJRk3FQL7Ej2814CauoJQKvVG/vug8eVhpeltIq837wh3HkzE1KRr3Z1SwcX+B
 yzuGKfQ0SDxM57IeL+G75cvRS2V4+2ednw0N+tB3/9kxAAU1102xvafSz2IOUwfvDlzNpCO6zFS
 6FhQyKo+beAmn6XFTb5/qfVXzJOcofj2Vs9N49hKFPQEPV2a1O0tkrrIrDS1Sz71kA/Ufnf1hiZ
 Oy+najVK0JGHMZ5L9y1gkjj4HGbSWuHF3nIsD+Oo7YU0iptWvUB0qPerkVBKu7OkH16Q==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Banana Pi BPI-F3 [1] is a industrial grade RISC-V development board, it
design with SpacemiT K1 8 core RISC-V chip [2].

Currently only support booting into console with only uart enabled,
other features will be added soon later.

[1] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
[2] https://www.spacemit.com/en/spacemit-key-stone-2/

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

