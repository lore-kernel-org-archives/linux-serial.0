Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3541199EAF;
	Thu,  1 May 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746059483; cv=none; b=Mml+nmJ7uWO+roN/evlURRZ2QtZ9CM/PJZmeDj4sMlM6VzEGYBQiX/NusOir9KrpSpWr8zQhO9yS0R2P1t1Y+pd16gGrtGh74o7i+Cgqp8C/1gb9/YxzvQ0xX6cgpgK5gbNEr/bnyDZhRs2CK4mIWhpw3Pi80kz2iWWo+eWLaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746059483; c=relaxed/simple;
	bh=34tWn2fnWQVW+u3/H+rD1hAFH3MnwAeyqVy2WNeuCyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odnhBDS4AVyWY5lOy0H2ftvMBLy9TIeeVbzjNvBxrMr9ilqwx+rfjSL1lIsuKhPQ25oDcdu2FYtJ+wrgPReIKVlWnvi9in/2tuaRhUgWMhLgHqiJd0GwcJIyilfbC21eYilziioy79v5SN0dAlZlTUvcLpFnTfIqoDfzIQlhCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rRH+UBow; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rRH+UBow"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5410VDMU069843
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746059473;
	bh=kY/9R+L8zSSys4zmzN9dEqA7Bm0697cnMG4P4z2aMLw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rRH+UBowI4mq/iQMVM3+OUOfTzUQEejwxJVBOkq49fex7HhWnpYCVx3Dw8SJAfEUD
	 gcGhPR48hGgE6a15witemwyrrzU3t92TD3mksX8md8t1feWSNpcHSJsSgpt/lnp+5s
	 Kz0ReeYlr2IrFBZ8DnoQhczBg7ZjrGTUF/CCoZ5Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5410VDdu018783
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Apr 2025 19:31:13 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 19:31:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 19:31:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5410VDaD044266;
	Wed, 30 Apr 2025 19:31:13 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>
CC: Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH RFC 1/2] dt-bindings: serial: add binding documentation for TI PRUSS UART
Date: Wed, 30 Apr 2025 19:31:12 -0500
Message-ID: <20250501003113.1609342-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501003113.1609342-1-jm@ti.com>
References: <20250501003113.1609342-1-jm@ti.com>
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
index 000000000000..f7f660688f7e
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
+  The PRU-ICSS module has a serial UART peripheral, which is based on
+  industry standard TL16C550, with 16-bytes TX/RX FIFOs.
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
+additionalProperties: true
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

