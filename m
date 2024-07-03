Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B517E8FD;
	Wed,  3 Jul 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018665; cv=none; b=jKNOEf+/EgFE2g1e6qSVbP0arhBPiDc0R+lJNxHmTVPq8D4obYgWaxC+TJyTtA+kbHULBFvXulgla0kyHSEQm+lMyozKI/n5UCCqv970lIPgN7tl6zlcGF4in0PrnmH12q3E7Qs55byRKh6ttmK7mP85eYOmIBVhNFmcOmVClII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018665; c=relaxed/simple;
	bh=OLDt7dRlbPKWhHGfKxLBHLD9o2bFrg9K7MPbZR7/DtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8UY8oepF5IxSTdRxcyaaOQAvYdrESJKFi1EXSaiAGkPvggu8teJpOeWDgZUKfhJ9aZSnVwqW2g2HnJdNZZh/NtCpaz+VMPKSiakB/2OM2dg3oVS3/NhV5w5THjreiai225KfolfaLpUZtVoOhhtR9SCtBlTZ0ryhSgnWy+SJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:12 +0000
Subject: [PATCH v3 09/11] riscv: dts: spacemit: add Banana Pi BPI-F3 board
 device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-9-12f73b47461e@gentoo.org>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
In-Reply-To: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
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
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=mJc6hZeXKZcPaMSmqXhuz5fuxopioAcnLOzTKcNsQPA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWaRIpsRw14WoKXw9eE74y+KQf5DH09Q3P0am
 QCfV7BWTDaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmkV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TVoD/4vf6Yk5Lk+uyW7za
 V8Df4PQ/lMAr9J67c1TEzTrNfABCAoqxvidsfqlkYgS7kojHHIsbAFilbInxlfv2S7K5rgmelBZ
 yuAKPG2SlD3SIsva050rF3K0KPLuEvca5DWffKFp6C18YMIqTWxZ2NvNRjArRHhTgPKVkZVwRuS
 l7f7xjiH3eL7eBI8Z5MqjnGoZduLPowKT3srlMPNBpQuIK8rIhB6K/Ve95Q1BQ2JlWEo3cdo62z
 cuuTK8qj8umfgUuJ4TashRPAeqCYZUu4mAIeDaERmSDyxinHf/aqxk6fXEKXn41xLsWW0ntw/bc
 87LseuhVoC/Mu2EIUOq8s+KZRieWwuvE7JHY8XHvH2OIu1koqVWSNjq5UNnO6LcLtruNh/R7Lvf
 dFuR8CvsKuGQtlg9wlCvu8smJZ+IP3aPYrUknc5PSGEGYcvIJ4hdgrHr+kVFzpjqYH1ZxXJoVss
 qpX39QRtJ0CxgqCwnPUsmOsSSmaHzLH/rfwq90TzMxaYuckLdREr/LmIUBXei7zCFxs75y0VXzD
 Yvte0HW4Dpupw7iCsgFk8DUo8o+Ko2Fu9EmSlb0rSQM2WopS2ZhavOxUJMd5xlMb3GuPbbEQg1h
 5KcmkwB/NrhLXnxrtN5cYYRO0LdARz6esPQGfxsxTDIhIfKSD5yMl9TIWnhMLkkt9keg==
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

