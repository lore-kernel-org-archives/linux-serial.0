Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C1B5579F;
	Mon, 26 Aug 2024 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640439; cv=none; b=JLP6x5f3G9EIXumYOQGem45wUMvot3iB8b+YPPQFEiNA+sAffvRejQU1BwXntz0TZ/zWAl/ZGsR8jMquyRcwpYUTiM/L6SydrQMjtJQWwlKxKouoCU3U40kjXYDlZroEe93UoXHKMAfSNLtqbR/WyReRlx0eLXiamy8B1Uv1s5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640439; c=relaxed/simple;
	bh=NTag6DfiSup4A8d5wT7W3XcBTqLLuhqAIuBc8GckCTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSeLvfZ/xlCl8d4T4duD+LMrcte+eDzwGM+B8+g6wdFOxaePJczwngzPGLt7h6YlPhZzMjFZxvucd94jgG9eX8r57QbMepHyXaMAfMkC2N1NsVOE0Lpc4WaKYxpHszXwPe0wTHc5hTeGX+R1EJlaPLh6lKPkNTJ4EXD9GtnDPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8CxKJqz7Mtm7vofAA--.28345S3;
	Mon, 26 Aug 2024 10:47:15 +0800 (CST)
Received: from haword-linux.loongson.cn (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMCxC2er7MtmDH4iAA--.51899S5;
	Mon, 26 Aug 2024 10:47:14 +0800 (CST)
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
Subject: [PATCH v3 3/3] LoongArch: Update dts to support Loongson UART driver.
Date: Mon, 26 Aug 2024 10:47:05 +0800
Message-ID: <20240826024705.55474-4-zhenghaowei@loongson.cn>
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
X-CM-TRANSID:qMiowMCxC2er7MtmDH4iAA--.51899S5
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAgEBBGbLHpsD+AACsX
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw1xKF13Xr4kXF4fKF13ZFc_yoW8Kr1Dp3
	9Iv39rGr4Igr1xCryDJFyUJr4DZF98GFnFga13C34UJwsIq3yjvr1rJF9IqF4rXw4rX3y0
	grnYgrW2gF4UZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jciSdUUUUU=

From: Haowei Zheng <zhenghaowei@loongson.cn>

Change to use the Loongson UART driver for Loongson-2K2000,
Loongson-2K1000 and Loongson-2K0500.

Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k0500.dtsi | 2 +-
 arch/loongarch/boot/dts/loongson-2k1000.dtsi | 2 +-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Changes in V2:

- The compatible property for the UART is changed from "ns16650,loongson"

    to "loongson,ls7a-uart".

Changes in V3:

- Compatible has been modified for a specific SoC.

diff --git a/arch/loongarch/boot/dts/loongson-2k0500.dtsi b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
index 3b38ff8853a7..63c77d70639c 100644
--- a/arch/loongarch/boot/dts/loongson-2k0500.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
@@ -220,7 +220,7 @@ tsensor: thermal-sensor@1fe11500 {
 		};
 
 		uart0: serial@1ff40800 {
-			compatible = "ns16550a";
+			compatible = "loongson,ls2k0500-uart", "loongson,ls7a-uart";
 			reg = <0x0 0x1ff40800 0x0 0x10>;
 			clock-frequency = <100000000>;
 			interrupt-parent = <&eiointc>;
diff --git a/arch/loongarch/boot/dts/loongson-2k1000.dtsi b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
index 92180140eb56..cafb8d13c065 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
@@ -297,7 +297,7 @@ dma-controller@1fe00c40 {
 		};
 
 		uart0: serial@1fe20000 {
-			compatible = "ns16550a";
+			compatible = "loongson,ls2k1000-uart", "loongson,ls7a-uart";
 			reg = <0x0 0x1fe20000 0x0 0x10>;
 			clock-frequency = <125000000>;
 			interrupt-parent = <&liointc0>;
diff --git a/arch/loongarch/boot/dts/loongson-2k2000.dtsi b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
index 0953c5707825..d4fe91af8c07 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -174,7 +174,7 @@ rtc0: rtc@100d0100 {
 		};
 
 		uart0: serial@1fe001e0 {
-			compatible = "ns16550a";
+			compatible = "loongson,ls2k2000-uart";
 			reg = <0x0 0x1fe001e0 0x0 0x10>;
 			clock-frequency = <100000000>;
 			interrupt-parent = <&liointc>;
-- 
2.43.0

