Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3F32CF96;
	Tue,  9 Sep 2025 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419911; cv=none; b=ltV4RYmiazBYK180bJOnTT7WYwGLtM1RPamvpuRaKxsbkwM2mFdmol7t+hLRLKuAyXKsM9v+YY9H2SpZRbOFVQFuirRFJJLprszPuaDhe2kw0g0KhOCP/Kw9RO+ysghSZwqNeZ9tRua5+aUExwvGK/iIvYH0Sf6RJE26NmSKRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419911; c=relaxed/simple;
	bh=npjwhY8azA5d0Qu4slZE93s4EQMQveymohXQJ2V6DEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRgTMxhxomdUSdBm7R1XpEzWgfCt/jBkrB5cp8gRceLXbnpkEEfdb+8mDeBKWC0wH9meAHubJmKMGUSCx1M7kbq7EJ8Z7JSdLDJ4f7NZa0iuaD2Hh+6vjxC4Ai4B6NiogMH9IHWVI6enBF9oklG9z132shnBSpUYCPcS7NK0BnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8Dxb_B9GcBodV0IAA--.17969S3;
	Tue, 09 Sep 2025 20:11:41 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJCxH8JzGcBoOzSKAA--.57626S3;
	Tue, 09 Sep 2025 20:11:37 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 1/3] dt-bindings: serial: Add Loongson UART controller
Date: Tue,  9 Sep 2025 20:11:18 +0800
Message-ID: <8575ff2d46b701950b1b0da3d3c181db331f79db.1757318368.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1757318368.git.zhoubinbin@loongson.cn>
References: <cover.1757318368.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxH8JzGcBoOzSKAA--.57626S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4kGFyrZr15tFWftFyrAFc_yoW5Wr18pF
	sIk3srGr40gF17u398WFy8C3WrZr95CFnIgF47A3ZrKF90qasIvr13KF1jqa13Cr4UXFWU
	uFyI9r4jka48ZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Add Loongson UART controller binding with DT schema format using
json-schema.

Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../serial/loongson,ls2k0500-uart.yaml        | 60 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/loongson,ls2k0500-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/loongson,ls2k0500-uart.yaml b/Documentation/devicetree/bindings/serial/loongson,ls2k0500-uart.yaml
new file mode 100644
index 000000000000..69f6df6cd9fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/loongson,ls2k0500-uart.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/loongson,ls2k0500-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson UART controller
+
+maintainers:
+  - Haowei Zheng <zhenghaowei@loongson.cn>
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+allOf:
+  - $ref: serial.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - loongson,ls2k0500-uart
+          - loongson,ls2k1500-uart
+      - items:
+          - enum:
+              - loongson,ls2k1000-uart
+          - const: loongson,ls2k0500-uart
+      - items:
+          - enum:
+              - loongson,ls3a5000-uart
+              - loongson,ls3a6000-uart
+              - loongson,ls2k2000-uart
+          - const: loongson,ls2k1500-uart
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
+        compatible = "loongson,ls2k1000-uart", "loongson,ls2k0500-uart";
+        reg = <0x1fe20000 0x10>;
+        clock-frequency = <125000000>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <0x0 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..ed016f251cf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14353,6 +14353,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
 F:	drivers/pwm/pwm-loongson.c
 
+LOONGSON UART DRIVER
+M:	Haowei Zheng <zhenghaowei@loongson.cn>
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/loongson,uart.yaml
+
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
-- 
2.47.3

