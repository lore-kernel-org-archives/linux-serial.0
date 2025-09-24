Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC80621D3F2;
	Wed, 24 Sep 2025 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695404; cv=none; b=VM8tKT+xGle00YXgNZ/7H2RXsmXMk8nJq5Eb/pFIYuaTmbluxnSwaSLXvKqGg4OuxuB6CJHsWpsslT9uzAxfVxSIMh2xBPnFUXRQxXtLbufT4BRfJMGF6AF3c0MuMzsWtDnuSbiurUEb/flGVzFF9e7T+cjiNpTE6j+z33WR2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695404; c=relaxed/simple;
	bh=5J6y1T7EH9lA3RNN2unyCdJ/XGeClsqn+bF4ezTpm6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQfv08aLv6PFhLxVPrUhA84BLrej9JZkjaPhlz8rD1zmR2H9InDIMXJFe+sSY0YmPMzuKigXxvhO2derW0PGSoZwpksic8qzCWLlFGHRmAGS4WhfXXiQjuY/BNuEuFFj/aIg25cJl8+eBXWS2pjaVJCnkmEtEKs8Onl+goqqJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8CxL9Phj9Nom_YNAA--.29531S3;
	Wed, 24 Sep 2025 14:29:53 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJAxVOTbj9NogKyqAA--.21497S3;
	Wed, 24 Sep 2025 14:29:52 +0800 (CST)
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
Subject: [PATCH v5 1/3] dt-bindings: serial: 8250: Add Loongson uart compatible
Date: Wed, 24 Sep 2025 14:29:36 +0800
Message-ID: <ade57dcdd021de6824a15d4aa11aa9cbeebce169.1758676290.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1758676290.git.zhoubinbin@loongson.cn>
References: <cover.1758676290.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxVOTbj9NogKyqAA--.21497S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEPCGjTiA0AnAAAsm
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1DCw13ZF47Kry5ur45Jwc_yoW8GF4xpF
	sIkF9xKryjkr17ua95XFy8JayrurWkAa1ayFW7G3ZFgF95ta9avr4fKw4jqF4rCF10qFyU
	ZFW0gF4rKa40yrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8qsjUUUUUU==

The Loongson family have a mostly NS16550A-compatible UART and
High-Speed UART hardware with the exception of custom frequency divider
latch settings register.

Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index b243afa69a1a..167ddcbd8800 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -125,6 +125,8 @@ properties:
               - nxp,lpc1850-uart
               - opencores,uart16550-rtlsvn105
               - ti,da830-uart
+              - loongson,ls2k0500-uart
+              - loongson,ls2k1500-uart
           - const: ns16550a
       - items:
           - enum:
@@ -169,6 +171,18 @@ properties:
               - nvidia,tegra194-uart
               - nvidia,tegra234-uart
           - const: nvidia,tegra20-uart
+      - items:
+          - enum:
+              - loongson,ls2k1000-uart
+          - const: loongson,ls2k0500-uart
+          - const: ns16550a
+      - items:
+          - enum:
+              - loongson,ls3a5000-uart
+              - loongson,ls3a6000-uart
+              - loongson,ls2k2000-uart
+          - const: loongson,ls2k1500-uart
+          - const: ns16550a
 
   reg:
     maxItems: 1
-- 
2.47.3

