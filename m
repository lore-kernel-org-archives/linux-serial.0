Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9519CC27
	for <linux-serial@vger.kernel.org>; Sat, 11 Oct 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167043; cv=none; b=PdXJ2CRQjNmRRc3sHOse/Y8gKCFR9Kk/H6PWYe6zkO+r6Ydirhi7/RaiJWlqD8SgezYGuti3iRBmu2fxmDO3F6D0gAzKEakj3+BD1qBssK2z/9sguT4x6wuVs7ccImC5X8I6oUreLucBa2Kb1fzkCfVz0d3+EYljBNpNeR8NlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167043; c=relaxed/simple;
	bh=Bqcfq/5hvvyukGL3kkXiQQnws5gX06F+lhFQbamJsBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwUNr3SB4eLP0ohfoF2J1MqMnAzyuCYTolgKD2RW9zsqKbDy74WBX7FMqEi/t7xJqZ9P+VhGcHIANDQVxu6XqU1uIp6nZ3cosR7vPk23qpwpvNYZTL2G1H00PcIKR9GLeEDRO8kle2Adf9oYCq7zBZKiUvhLVL3Fy8uPTji5wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8Dxb_B4BOpoWfkUAA--.45328S3;
	Sat, 11 Oct 2025 15:17:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJDxaMBwBOpo1ebZAA--.1011S5;
	Sat, 11 Oct 2025 15:17:12 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v6 3/3] LoongArch: dts: Add uart new compatible string
Date: Sat, 11 Oct 2025 15:16:49 +0800
Message-ID: <8e0c08459fa5bddefd898648fea28a9f2fde701a.1760166651.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxaMBwBOpo1ebZAA--.1011S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEMCGjp8Y8BCgAAsz
X-Coremail-Antispam: 1Uk129KBj93XoW7urW5KFWkZw4kKFy8ArW7ZFc_yoW8tr45p3
	sI939rKr4Igr1fCryDJFWUJr4kZF98GFnFga13CFyUGrsIqa4jvr1rJF9IqF1rXw4Fq3y0
	grnYgrWa9F4UZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r4j6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbCzuJUUUUU==

Add loongson,ls2k*-uart compatible string on uarts.

Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k0500.dtsi | 2 +-
 arch/loongarch/boot/dts/loongson-2k1000.dtsi | 2 +-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k0500.dtsi b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
index 588ebc3bded4..357de4ca7555 100644
--- a/arch/loongarch/boot/dts/loongson-2k0500.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
@@ -380,7 +380,7 @@ tsensor: thermal-sensor@1fe11500 {
 		};
 
 		uart0: serial@1ff40800 {
-			compatible = "ns16550a";
+			compatible = "loongson,ls2k0500-uart", "ns16550a";
 			reg = <0x0 0x1ff40800 0x0 0x10>;
 			clock-frequency = <100000000>;
 			interrupt-parent = <&eiointc>;
diff --git a/arch/loongarch/boot/dts/loongson-2k1000.dtsi b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
index d8e01e2534dd..60ab425f793f 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
@@ -297,7 +297,7 @@ dma-controller@1fe00c40 {
 		};
 
 		uart0: serial@1fe20000 {
-			compatible = "ns16550a";
+			compatible = "loongson,ls2k1000-uart", "loongson,ls2k0500-uart", "ns16550a";
 			reg = <0x0 0x1fe20000 0x0 0x10>;
 			clock-frequency = <125000000>;
 			interrupt-parent = <&liointc0>;
diff --git a/arch/loongarch/boot/dts/loongson-2k2000.dtsi b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
index 00cc485b753b..6c77b86ee06c 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -250,7 +250,7 @@ i2c@1fe00130 {
 		};
 
 		uart0: serial@1fe001e0 {
-			compatible = "ns16550a";
+			compatible = "loongson,ls2k2000-uart", "loongson,ls2k1500-uart", "ns16550a";
 			reg = <0x0 0x1fe001e0 0x0 0x10>;
 			clock-frequency = <100000000>;
 			interrupt-parent = <&liointc>;
-- 
2.47.3

