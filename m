Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E03146A83;
	Tue, 30 Jul 2024 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299373; cv=none; b=GHZzQWgajYjUTvxRiB/SKjBWeYyhHBO7db0K+Y9WaDRe7DLjzfzLv7kIIZTPJ6ZTvUfjzoOsLPWIV/qvkVqZuFkr73hu4jNC9begSMH0G3b/zrBHHe6U1rxIFWnInBOGJcXaCK+LoO4gG/IQ1K3o+t2cRWcfuZDNrWbV4eAn17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299373; c=relaxed/simple;
	bh=OLDt7dRlbPKWhHGfKxLBHLD9o2bFrg9K7MPbZR7/DtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1bZX/1Reodtoen5IBV7ePL6N5UvLQKLoBpZQMKNEYXFEqN50bJASOP/yC/3UoaoFzQW2L/lUl4LDpr5PTUdRnKb482dv4KHRJAAPG6uzQjn+lGu2qQVtEZWoYazry+GeisP49bLCPAR7eeI//5yKD658h4iJk1rqPuD4U3kjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:12 +0000
Subject: [PATCH v5 09/10] riscv: dts: spacemit: add Banana Pi BPI-F3 board
 device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-9-98263aae83be@gentoo.org>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
In-Reply-To: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Yangyu Chen <cyy@cyyself.name>, Yixun Lan <dlan@gentoo.org>, 
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
 Meng Zhang <kevin.z.m@hotmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=mJc6hZeXKZcPaMSmqXhuz5fuxopioAcnLOzTKcNsQPA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDO4E6d3UZe/bVuVUZSjoK3XM15I9PwC3cJs7
 CKafXBjhxmJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzuF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277RTzEACXo4PuyGGsPgWFQb
 +ypG7l1MUq8ZaLsBJcjgBmuCk8I5kuuAOk08+tf2UaUXepmHSkMLOBm3lk3mTum/WZrnJoxBgWU
 G3JtHp1MXt4Ubhhk7bJaqAdz+jHPbFsNQVzRsjnCOx6bq791hJCIj55uzr3bUnvzWk+r4JKnKt0
 sMo2oNGnPo8HvzNethk0K6yOe5oJRJ9p/GwFoAQfYTFlOpWSvCOjTDgcg1zJPXMHcbMOfb3ypND
 7nfk3MM0bTZm37anplTUOGdV6daFGvLfCtgxUhqjFyE4+AUpKFpiumTwdn7KH9/aCMqZm7ysWgh
 czAIrJhyDRUsS8UydZAxc8+rbJvNe1CezdGXL2yWojMZEskzg/2XWQPUCbhXA+tNcm9xtm9hZvU
 G98Xy9eFkmtulElli3DsIrgVEvozn4Vl4Sxx2Rlwa0Kxi7VyULK8eYmJTioVZO4QFpZDwNcnKHr
 KZA+fMot+ieLJCf3UEwQX1D0hzTDPaEWaIpjZjHTzUdSMRbFU8M20S8zYHF4t4XnD7VMF0rBbLS
 TTKHQn6KqvmENFt2JJpGRQwyyTiKZbrrB+d3o4JLwEjZgCb+QAw6gaTOI2oVKapcplpVot8WT8B
 Fs+cQfVtKhHLJZy9jWU9vLXDcKOutKgPs15EultBf1inzx1V1xJAS19xk7/weH05af1g==
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

