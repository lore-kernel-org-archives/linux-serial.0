Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6421F76CA;
	Tue, 13 May 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173596; cv=none; b=r3V5ZXEwxBRAHPpxvmGgmYgfeyJbRZc/h7LfVK5CbSb8nPnXISoYiqLwUInoJTxXvf4FkcCEOQ1U5YKVZjMRKc8Q2lbvzaEebGKSLpOjIRdKOiF/tkHOzLKITu/cKZ7poGdgqhQbxyxKoU3HvUfzP3lclOsq8w9jxSWpc6cgmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173596; c=relaxed/simple;
	bh=cXfb+cih4U/jRRz4hX6Tka2QfCFNSWJDDIrmRG8jo14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqbsx2+exDCuKSJli+01N0tf3/4jL+KL5O+OfL+fqZ0ziGfyljcUb70g8M9v/hwpM5XfCE84KMtLe3n20zoanlfbAZdSrhtLKyTV5agdsk7j03Z49qBZH4YLy4QucwdfD29G7wEfWFwZmQgfD/RdJBdsePWvgaeuHZ55+xp1Zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nYtAph87; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nYtAph87"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxa6P2965927;
	Tue, 13 May 2025 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747173576;
	bh=39lmcsKNJPXEA7+bGUZpLxZ0LoiPG+o0H7csu9OoDfk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nYtAph87BWKzTCTR45M7HmYjRXK7Fcu4RzAjf/3lYKHEPvrTZTFhb4U+8ti+WhEmx
	 vNKKbdRgSEohZoQBYBIrQXzwTEXI4DBv4N+UvP7hHWn94aP/THV8eMIrdXA+tdWL7q
	 elw22JHpp8SkcpbopVbtJr2DiOeOg4AqnBGKi9qw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54DLxZhQ1005886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 13 May 2025 16:59:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 16:59:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 16:59:35 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxYdF111031;
	Tue, 13 May 2025 16:59:34 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Bin Liu <b-liu@ti.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/7] DONOTMERGE: arm64: dts: ti: k3-am64-main: Add PRU UART nodes
Date: Tue, 13 May 2025 16:59:31 -0500
Message-ID: <20250513215934.933807-5-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513215934.933807-1-jm@ti.com>
References: <20250513215934.933807-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There is one PRU UART module in each PRU_ICSSG for am64 SoC.

Add a PRU UART child node in each ICSSG node in am64 main voltage
domain .dtsi file for am64x device.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index c7e5da37486a..5ba7b8a8dbcf 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1280,6 +1280,15 @@ icssg0_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg0_uart: serial@28000 {
+			compatible = "ti,pruss-uart";
+			reg = <0x28000 0x40>;
+			clocks = <&k3_clks 81 19>;
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <6 7 7>;
+			status = "disabled";
+		};
+
 		icssg0_iep0: iep@2e000 {
 			compatible = "ti,am654-icss-iep";
 			reg = <0x2e000 0x1000>;
@@ -1459,6 +1468,15 @@ icssg1_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg1_uart: serial@28000 {
+			compatible = "ti,pruss-uart";
+			reg = <0x28000 0x40>;
+			clocks = <&k3_clks 82 19>;
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <6 7 7>;
+			status = "disabled";
+		};
+
 		icssg1_iep0: iep@2e000 {
 			compatible = "ti,am654-icss-iep";
 			reg = <0x2e000 0x1000>;
-- 
2.49.0

