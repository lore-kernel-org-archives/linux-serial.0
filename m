Received: from ustc.edu.cn (smtp2.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A2634D38E
	for <linux-serial@vger.kernel.org>; Fri, 13 Feb 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975259; cv=none; b=HU7HLbNOv3vZITllybzQQZSWsigJwMj7FoAYUnenJHKrHNNC3IwHdeyaXETB91dE+VqsnWfli2GbtqYY9pcw/siGxh7isQf+OeNLfg4IpHTrN+8vauGH0R5QcAICeH7JkHruRGUWcpTI5f1c0dZIUn9p+Zo9bS956fRnb1rGnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975259; c=relaxed/simple;
	bh=rk0iHRV+CtJK3/6+pk+FaqSGPYpx31CbCkHK5yC3I0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IetencOootVjgiadTzLOMXkHiz8/mPNnSBiSJfaWCN1hSRB2hdn7S+IRcntGxRYU+T1IdDgF8lWk54UOtrYBtC/MNzTfXbB9FI8R393GUJ5EhHtX2vZ70uXIkr46ljAb9SCHW77kMKM+F/s8MnC01xVmtS5QE4FUlASI4RMUmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=cOOQjo99; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="cOOQjo99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=LPqruGiTtMX1OIcihKFHk0AzkBa9TnlJEv
	kdURUb418=; b=cOOQjo99QT+37StZdJKSFPkiNyvtohEQkF0J2R1NQZcxWKlZCV
	luaTPBI9E/r6tw5YAVak9U2WVOX6hhH6oN6QSyG6Qh68t+3IFTsvjaKVED3YpjZw
	db8ztr9Y5VydCXD7pbxnnt/Vpt17Mxx4dmvWV19xybxnXQs5bHHbI+yEw=
Received: from mail.ustc.edu.cn (unknown [116.130.208.26])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHssL2745p89E8AA--.917S3;
	Fri, 13 Feb 2026 17:33:52 +0800 (CST)
From: LiuQingtao <qtliu@mail.ustc.edu.cn>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	bjorn.andersson@oss.qualcomm.com,
	marex@nabladev.com,
	dev@kael-k.io,
	mani@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.wenhong35@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	hu.yuye@zte.com.cn,
	dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn,
	jia.yunxiang@zte.com.cn,
	bai.lu5@zte.com.cn,
	yang.susheng@zte.com.cn,
	shen.lin1@zte.com.cn,
	tan.hu@zte.com.cn,
	zuo.jiang@zte.com.cn
Subject: [PATCH v1 1/2] LRW UART: dt-bindings: Add binding for LRW UART
Date: Fri, 13 Feb 2026 17:33:33 +0800
Message-ID: <20260213093334.9217-2-qtliu@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213093334.9217-1-qtliu@mail.ustc.edu.cn>
References: <20260213093334.9217-1-qtliu@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCHssL2745p89E8AA--.917S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW5trWUtrWrWFWfXr4DCFg_yoW5Cry3pa
	ykCrn7tay0gF17W3yrKa409F1rXrn5AF47CFsrXwn2v3ZIyFsYqw1fKrn0v3Wq9r48JFW3
	XF4F9rW8Kay0vr7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I
	0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8uwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU-CJPDUUUU
X-CM-SenderInfo: 5twox3o6pdxzwoxv3uoohg3hdfq/1tbiARERAGmN67Eo2QAJsH

From: Wenhong Liu <liu.wenhong35@zte.com.cn>

Add documentation for LRW UART devicetree bindings.

Signed-off-by: Wenhong Liu <liu.wenhong35@zte.com.cn>
Signed-off-by: Qingtao Liu <liu.qingtao2@zte.com.cn>
---
 .../bindings/serial/lrw,lrw-uart.yaml         | 49 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  7 +++
 3 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml b/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
new file mode 100644
index 000000000000..a2d41c278c4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/lrw-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LRW serial UART
+
+maintainers:
+  - Wenhong Liu <liu.wenhong35@zte.com.cn>
+  - Qingtao Liu <liu.qingtao2@zte.com.cn>
+
+description: |
+  Should be something similar to "lrw,<chip>-uart"
+  for the UART as integrated on a particular chip, It supports
+  multiple CPU architectures, currently including e.g. RISC-V and ARM.
+
+properties:
+  compatible:
+    const: lrw,lrw-uart
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
+required:
+  - compatible
+  - reg
+  - current-speed
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    uart0: serial@e0001800 {
+      compatible = "lrw,lrw-uart";
+      interrupt-parent = <&aplic0>;
+      interrupts = <0x12 0x4>;
+      reg = <0xe0001800 0x100>;
+      clocks = <&bar_clk>;
+      current-speed = <115200>;
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..ec9bf262f466 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -961,6 +961,8 @@ patternProperties:
     description: Loongson Technology Corporation Limited
   "^loongmasses,.*":
     description: Nanjing Loongmasses Ltd.
+  "^lrw,.*":
+    description: LRW Corp.
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
   "^luckfox,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 26898ca27409..ad6acbe24544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15035,6 +15035,13 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/loongson_edac.c
 
+LRW SERIAL DRIVER
+M:	Wenhong Liu <liu.wenhong35@zte.com.cn>
+R:	Qingtao Liu <liu.qingtao2@zte.com.cn>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/lrw,lrw-uart.yaml
+
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
 M:	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
-- 
2.27.0

