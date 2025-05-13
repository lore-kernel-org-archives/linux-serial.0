Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282062770B;
	Tue, 13 May 2025 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747173587; cv=none; b=higyN6/1TDYkDSE3SyRtMTCdFposuwTfsL84t1+8qa6lAH27K0Y44O6EapJX+YlU4+imELJGILpxHhsseUWlgvT0089e/zAyiei8nl/wK79MjWAjPw7ZzXOgQPnaKFKPvDLbvx5zN2T1PtKU54j5Kad776vh4HNdh1Vq8uCBxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747173587; c=relaxed/simple;
	bh=ntDm6nMYwj9nso877Gv0Ll0lYiGUYVC4kTqiZ2cOGrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhrYqJPLIDt+zCLV7PLrNmm4drkHQkQRFNvRdlZKH69ka3Gfl0vWF11gIandEnv5t9vFcLZoJldH2owBwuiMh9ouE5Lab0u9eYMZZum9q338oZOXDBxY+3Fa2u+DnkY/YZV6wmfL36rlJNvA+yQW/nUosT0w4EJR4DYgRYd5Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VYO8tJDf; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VYO8tJDf"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxa7l2425893;
	Tue, 13 May 2025 16:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1747173576;
	bh=qmQfcLpiSyLwy3Zc5zbrGssZMtkDmMAcUwLjz7QJh1g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VYO8tJDfkIroqj/Xvx4yPWEaQDxkcQSISNZS4QLwOtrV7lPkoxtGea5Lc8+WeNbov
	 ZuZbj0hZA8xyXfAuSXGX+EytnYg9dnLaqXDVb3hwpRsuM+27CSb4IETYJDFITFs53t
	 xYyW1bqhZGTvTxxFRX13wy1+wHJP5KtFsJCcO3kI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54DLxZ021005887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 13 May 2025 16:59:35 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 May 2025 16:59:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 May 2025 16:59:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54DLxYdC111031;
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
Subject: [PATCH 1/7] dt-bindings: serial: add binding documentation for TI PRUSS UART
Date: Tue, 13 May 2025 16:59:28 -0500
Message-ID: <20250513215934.933807-2-jm@ti.com>
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

From: Bin Liu <b-liu@ti.com>

This adds the YAML DT binding for PRUSS UART on TI SoCs.

Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 .../bindings/serial/ti,pruss-uart.yaml        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ti,pruss-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/ti,pruss-uart.yaml b/Documentation/devicetree/bindings/serial/ti,pruss-uart.yaml
new file mode 100644
index 000000000000..34a03d572333
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ti,pruss-uart.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/ti,pruss-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI PRUSS serial UART
+
+maintainers:
+  - Bin Liu <b-liu@ti.com>
+
+description: |
+  The PRU subsystem has a serial UART peripheral based on the industry
+  standard TL16C550, with 16-byte TX/RX FIFOs.
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: ti,pruss-uart
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: |
+      PRU UART interrupt mappings, containing an entry of 3 cell-values.
+      The first is the PRU System Event ID for PRU UART Interrupt Request.
+      The second is the PRU interrupt channel ID.
+      The third is the PRU host interrupt ID.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    pruss_uart: serial@28000 {
+        compatible = "ti,pruss-uart";
+        reg = <0x28000 0x40>;
+        clocks = <&k3_clks 81 13>;
+        interrupt-parent = <&pruss_intc>;
+        interrupts = <6 4 4>;
+    };
-- 
2.49.0

