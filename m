Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0832E3AE2;
	Mon, 21 Jul 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113142; cv=pass; b=AWDU/U+7Q1vgEC3A2CVpqjGkvkP4/RyPQm+RcxeLrRSl1YRcx2KPI7MOogsSaygfeWsLqY1H0DWO9zcblOfiZQ3HX/Qxkbtf9W8ZTILk8Q7O5uXFFwnC095+nCEo67zOyYkOwrRzUBNYXh/v1BT7IhaSP0RiuQGYfRqRR2JdtKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113142; c=relaxed/simple;
	bh=dt4UgCfziITaZN8gOwGd/lnBPhcw0i3TYLGZmxXzCjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMaqjk4rXbXX6ciaOfUqCRMg7X/XUIczqaLgAW85GgiZTCgHS9cWCHQyj/UW3iheJ/kMg/NkaM8Exiz8l2ZHWGDjV97ecS1//PVtcyAEXxsX6FGvgtw7gGm5+wPT2iku2pKPahfPdA2Nj91pzQWCDhPlRj3smdBesibEGerJKfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=HKRN5n86; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="HKRN5n86"
ARC-Seal: i=1; a=rsa-sha256; t=1753113120; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UGS9PQRRqbDJm16TyefCwFDSAM0GHTpHrUucKfAfXVXdqCCIGlyn1l6+bXxl3wg7aoD+VYXWNR4OG2OF2x9i8FP+FUxS58dSwLhbMdQEQv+KMAb+DiKc/YD7zi3acHVgVFIXSNWjx8Z/2MIDAgT63eZi+QlRuJLj2TJ9vG2J00A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113120; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Dua8z3nV/2FEqKiQMdSSaJn0uYH4bX3mclgeln9et94=; 
	b=Vo7fP1491qzf9hccjxneaMBphr8JkPbMWE+JKp2ADW2+AZp9wPehcItfkOKDvALG8dr3pTd7m5VkWdwA3LX93Ur9HGfc5L9zJUUVcmgEGMEWgj0FxxV02HoOvTnoFkqS3WDHkMolJi8U2iR01KxAbqiUCevvPmcLDq2D/vtXH30=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113119;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Dua8z3nV/2FEqKiQMdSSaJn0uYH4bX3mclgeln9et94=;
	b=HKRN5n864HKbjslFdzWUyD5N2NsgV/Rr8v4hKms+pxvQDRqxKtUOvXhquOAVvUo8
	llznXOmQiiNABmqBQHlatEWYOb9f87ZRrjEi76nbG409M4Uv9toYt9wc0MjIrFVoLHN
	O9O13IjR1cHsb9+Jc/D6pWli6dAx7ndEN4AHrMvA=
Received: by mx.zohomail.com with SMTPS id 1753113117022688.9292154261038;
	Mon, 21 Jul 2025 08:51:57 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:15 +0800
Subject: [PATCH RFC 09/10] riscv: dts: anlogic: Add Milianke MLKPAI FS01
 board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-9-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=2221;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=dt4UgCfziITaZN8gOwGd/lnBPhcw0i3TYLGZmxXzCjw=;
 b=PFeQKGi8OpDfUWCZ23aqkiAxhGwQj3LwwaKmJyPclrDk76VqFNt/v0LbtY3wloDGCSxJ1yDu+
 VLk2K9cH0FjBMUjmFh1aro/22kG5mUBwVPgAnzvV/sutG2+t3ucStHC
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Add support for the Milianke MLKPAI FS01 board based on the Anlogic
DR1V90 SoC. The board features 512MB of onboard memory, with the region
after 0x1fe00000 reserved for OpenSBI.

Currently, the board can boot to a console via UART1, which is connected
to the onboard serial chip and routed to the Type-C interface.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/boot/dts/Makefile                       |  1 +
 arch/riscv/boot/dts/anlogic/Makefile               |  2 ++
 arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts | 28 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 64a898da9aee33f5c10cd332ad59b945615816bf..d423b825160c7cc0248b258126867531b9687e23 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += allwinner
+subdir-y += anlogic
 subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
diff --git a/arch/riscv/boot/dts/anlogic/Makefile b/arch/riscv/boot/dts/anlogic/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..87f3b2f418cfa32012df5ae82d17262a9610f90c
--- /dev/null
+++ b/arch/riscv/boot/dts/anlogic/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_ANLOGIC) += dr1v90-mlkpai-fs01.dtb
diff --git a/arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts b/arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts
new file mode 100644
index 0000000000000000000000000000000000000000..6a9dca4b6e39261bdef63df5f158c89a323f1732
--- /dev/null
+++ b/arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include "dr1v90.dtsi"
+
+/ {
+	model = "Milianke MLKPAI-FS01";
+	compatible = "milianke,mlkpai-fs01", "anlogic,dr1v90";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x1fe00000>;
+	};
+};
+
+&uart1 {
+	status = "okay";
+};

-- 
2.50.1

