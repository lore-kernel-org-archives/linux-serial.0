Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A93DD864;
	Wed, 13 May 2026 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662321; cv=none; b=UdBpxOiZcFMfLAkl+L5Al8m4Op98aK5Kp8TQ9k08KO2NHbZ53lO36fhnPUPaagR6pqZPXKHrm2TK2BaCX4mK0E+QnRg1PkYWTl0HkGC6vFp07naQimHUTQBPQI/FScZ7CZOp1qs3mLIb7S3OOXmzcf1083cyrVJIG4Clog2UmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662321; c=relaxed/simple;
	bh=Unxirq2/KQPybEPRUH+oaday2IrPrm36vKoKFhF5ko4=;
	h=Message-Id:References:Date:Mime-Version:From:To:Subject:
	 Content-Type; b=obyY0tA9VfRmneuX2tYw4SRFMYYYN+csXR73xNK7BNK8gcTwX0JRuLBLicqdRnIn7Emwut94jAUhEJsex0HyJmYzhmWJtYTPP6gG1Wo0uUBEmCdo9D14CXZG+w6T/UpDdzZ3IZqSIqlun1VBN0zQZ6ZoLaWouWh+nHZPFGpKbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gFnJX44xfz4xPYg;
	Wed, 13 May 2026 16:51:56 +0800 (CST)
Received: (from root@localhost)
	by mse-fl1.zte.com.cn id 64D8prqc083672;
	Wed, 13 May 2026 16:51:53 +0800 (+08)
	(envelope-from liu.qingtao2@zte.com.cn)
Message-Id: <202605130851.64D8prqc083672@mse-fl1.zte.com.cn>
Received: from njy2app03.zte.com.cn ([10.40.13.14])
	by mse-fl1.zte.com.cn with SMTP id 64D8kmvG074085;
	Wed, 13 May 2026 16:46:48 +0800 (+08)
	(envelope-from liu.qingtao2@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Wed, 13 May 2026 16:46:51 +0800 (CST)
X-Zmail-TransId: 2afe6a043a7be67-f3fcc
X-Mailer: Zmail v1.0
References: 20260512183012245tRba33vG69iPkP37ZE21R@zte.com.cn
Date: Wed, 13 May 2026 16:46:51 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <liu.qingtao2@zte.com.cn>
To: <krzk@kernel.org>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marex@nabladev.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <rdunlap@infradead.org>,
        <geert+renesas@glider.be>, <quic_zongjian@quicinc.com>,
        <arturs.artamonovs@analog.com>, <robert.marko@sartura.hr>,
        <hvilleneuve@dimonoff.com>, <thierry.bultel.yh@bp.renesas.com>,
        <julianbraha@gmail.com>, <flavra@baylibre.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <liu.wenhong35@zte.com.cn>, <liu.fei16@zte.com.cn>,
        <dai.hualiang@zte.com.cn>, <deng.weixian@zte.com.cn>,
        <jia.yunxiang@zte.com.cn>, <he.yilin@zte.com.cn>, <bai.lu5@zte.com.cn>,
        <yang.susheng@zte.com.cn>, <shen.lin1@zte.com.cn>,
        <zuo.jiang@zte.com.cn>, <hu.shengming@zte.com.cn>,
        <gao.rui@zte.com.cn>, <tan.hu@zte.com.cn>, <liu.qingtao2@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvMl0gQWRkIFpURSBMUlggVUFSVCBkcml2ZXI=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64D8prqc083672
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.qingtao2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 13 May 2026 16:51:56 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A043BAC.000/4gFnJX44xfz4xPYg

From 08610be731b6fc3919d5eebfd2ff9d67f38a094c Mon Sep 17 00:00:00 2001
From: Wenhong Liu <liu.wenhong35@zte.com.cn>
Date: Tue, 28 Apr 2026 22:30:31 +0800
Subject: [PATCH v2 1/2] dt-bindings: serial: Add zte,lrx-uart

Add devicetree binding for ZTE LRX UART controller.

Co-developed-by: Qingtao Liu <liu.qingtao2@zte.com.cn>
Signed-off-by: Qingtao Liu <liu.qingtao2@zte.com.cn>
Signed-off-by: Wenhong Liu <liu.wenhong35@zte.com.cn>
---
../bindings/serial/zte,lrx-uart.yaml         | 51 +++++++++++++++++++
MAINTAINERS                                   |  8 +++
2 files changed, 59 insertions(+)
create mode 100644 Documentation/devicetree/bindings/serial/zte,lrx-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/zte,lrx-uart.yaml b/Documentation/devicetree/bindings/serial/zte,lrx-uart.yaml
new file mode 100644
index 000000000000..20f470f04257
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/zte,lrx-uart.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/zte,lrx-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ZTE LRX UART
+
+maintainers:
+  - Wenhong Liu <liu.wenhong35@zte.com.cn>
+  - Qingtao Liu <liu.qingtao2@zte.com.cn>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: zte,lrx-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  current-speed:
+    description:
+      Initial baud rate configuration for the UART. This is a required
+      property to configure the serial port baud rate at boot time.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - current-speed
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial@e0001800 {
+      compatible = "zte,lrx-uart";
+      reg = <0xe0001800 0x100>;
+      interrupts = <18>;
+      clocks = <&clk_uart0>;
+      current-speed = <115200>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0dfad67f66c0..79be2dde3b71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29494,6 +29494,14 @@ F: include/linux/zswap.h
F: mm/zswap.c
F: tools/testing/selftests/cgroup/test_zswap.c

+ZTE LRX SERIAL DRIVER
+M: Wenhong Liu <liu.wenhong35@zte.com.cn>
+R: Qingtao Liu <liu.qingtao2@zte.com.cn>
+L: linux-serial@vger.kernel.org
+S: Maintained
+F: Documentation/devicetree/bindings/serial/zte,lrx-uart.yaml
+F: drivers/tty/serial/lrx_uart.c
+
SENARYTECH AUDIO CODEC DRIVER
M: bo liu <bo.liu@senarytech.com>
S: Maintained
--
2.27.0
