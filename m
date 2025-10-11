Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6F2222D1
	for <linux-serial@vger.kernel.org>; Sat, 11 Oct 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167042; cv=none; b=AzV+BH0bNTXW96v4kavklAFM/jtgYYxT8LtPXoFtsVT4GAwp9vU/C8sgDAEqiXzGYLUJzsg1yEEOJINqXXetZ+bq3C5G2rpe5RNoLg03nmwosep/NkcUcosE2RQJZKwFb2gdtZbkIsFxonEn0/Xc7n4qxvLlwQLfehkwJrOaXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167042; c=relaxed/simple;
	bh=qzboaWjQ9fakcaoo7RXt9Dp1iwJWnjFhrHhL4aO65jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l62FJidsW09k4dmgP5jgooZb28P4+GmAxTIqmpNzXks6mxIQ9txD5BNxZddhc8NdIrd4pW19EaCNTVWM+ITq3095mchybaDR5my85fIH9/YEzEGy0nnBS5qiBU8COS+C+J1Wxwd/yR46JGPNl0P39tllEqqYTJ+xpbl3OPGNXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8BxH9N3BOpoTfkUAA--.45136S3;
	Sat, 11 Oct 2025 15:17:11 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJDxaMBwBOpo1ebZAA--.1011S3;
	Sat, 11 Oct 2025 15:17:10 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	ilpo.jarvinen@linux.intel.com,
	linux-serial@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/3] dt-bindings: serial: 8250: Add Loongson uart compatible
Date: Sat, 11 Oct 2025 15:16:47 +0800
Message-ID: <2d858e9303d95a3e4909aa9c1379d4abbdc52cc2.1760166651.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1760166651.git.zhoubinbin@loongson.cn>
References: <cover.1760166651.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaMBwBOpo1ebZAA--.1011S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEMCGjp8Y8BCAAAsx
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1DCw13ZF47uF47KrWkKrX_yoW8Xr1rpF
	sakF9xKry0kr13ua95XFy8Ja1rurWkAa1ayFW7G3ZFgF95ta9aqr1fKw4jqF4rCF10qFyU
	ZFW0gF4rKa40yrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnZ2-UUUUU=

The Loongson family have a mostly NS16550A-compatible UART and
High-Speed UART hardware with the exception of custom frequency divider
latch settings register.

Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

