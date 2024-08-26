Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C1579CF;
	Mon, 26 Aug 2024 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640435; cv=none; b=k4gO9zysQyEmNatEkc3xDXn3b0PXEBlhCOaV05oSMqqqa3yopEt9TfEoD0Qmwb+gLUPwfr4ML6GwXKkP+l6O/2r9NaIDrHXstlpYCS2NtmUhqXAzRyOjbqspzk9CP4zxgG60a3SLwnA4sF4PykD3fmq6ONJHU4XVvjYOdbXHh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640435; c=relaxed/simple;
	bh=ZsxxPaAL19teG19fNhATIXuviD8uVvWOYXCbhkHX08c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwV8ZDeKcqWvJKDgc/+I/xqSUFl7sLdHVoAsOcRHaUr3EK+YXQB4GcFuPVnTbM98piPrt8SZmRizGrBv15q415n30S9CGnr5c6V+tnSzb/1PuIlbSEZjBxMnqtXAFRDITJAJdJnroFZnaMWEz7dNEl3ba6n//qPEHjWYIUMCHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8DxCeqv7Mtm3PofAA--.712S3;
	Mon, 26 Aug 2024 10:47:11 +0800 (CST)
Received: from haword-linux.loongson.cn (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMCxC2er7MtmDH4iAA--.51899S3;
	Mon, 26 Aug 2024 10:47:08 +0800 (CST)
From: zhenghaowei@loongson.cn
To: zhenghaowei@loongson.cn,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v3 1/3] dt-bindings: serial: Add Loongson UART controller
Date: Mon, 26 Aug 2024 10:47:03 +0800
Message-ID: <20240826024705.55474-2-zhenghaowei@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826024705.55474-1-zhenghaowei@loongson.cn>
References: <20240826024705.55474-1-zhenghaowei@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxC2er7MtmDH4iAA--.51899S3
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAQEBBGbLHfYEKwABst
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1UZF1ftF13ArW7Xw4kKrX_yoW5GFy8pF
	sxCa9rGr40gF17ua98XFy8Ga1rZr95AanrXF47Jw17Kas8Kas0vr15KF1jqw47Cr1UXryU
	uFy0gF42ga48urcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4PfQUUUUU=

From: Haowei Zheng <zhenghaowei@loongson.cn>

Add Loongson UART controller binding with DT schema format using
json-schema.

Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
---
 .../bindings/serial/loongson,uart.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/loongson,uart.yaml

Changes in V2:

- Correct the schema formatting errors.

- file name changed from 'loongson-uart.yaml' to 'loongson,ls7a-uart.yaml'

- Replace 'loongson,loongson-uart' with 'loongson,ls7a-uart'.

Changes in V3:

- Change the filename from 'loongson,ls7a-uart.yaml' to 'loongson,uart.yaml'.

- Drop newly defined features: fractional-division, rts-invert, dtr-invert,
  cts-invert and dsr-invert.

- Add three specific SoC: 'loongson,ls7a-uart', 'loongson,ls3a5000-uart' and 
  'loongson,ls2k2000-uart'.

- Drop 'LOONGSON UART DRIVER' description in MAINTAINERS.

diff --git a/Documentation/devicetree/bindings/serial/loongson,uart.yaml b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
new file mode 100644
index 000000000000..19a65dd5be9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/loongson,uart.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/loongson,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson UART
+
+maintainers:
+  - Haowei Zheng <zhenghaowei@loongson.cn>
+
+allOf:
+  - $ref: serial.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - loongson,ls7a-uart
+          - loongson,ls3a5000-uart
+          - loongson,ls2k2000-uart
+      - items:
+          - enum:
+              - loongson,ls2k1000-uart
+              - loongson,ls2k0500-uart
+          - const: loongson,ls7a-uart
+      - items:
+          - enum:
+              - loongson,ls2k1500-uart
+          - const: loongson,ls2k2000-uart
+      - items:
+          - enum:
+              - loongson,ls3a6000-uart
+          - const: loongson,ls3a5000-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+
+    serial@1fe20000 {
+        compatible = "loongson,ls2k1000-uart", "loongson,ls7a-uart";
+        reg = <0x1fe20000 0x10>;
+        clock-frequency = <125000000>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <0x0 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.43.0

