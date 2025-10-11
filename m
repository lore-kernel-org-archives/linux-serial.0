Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098C20C037
	for <linux-serial@vger.kernel.org>; Sat, 11 Oct 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167043; cv=none; b=VmLybCMn5K0LzaoNbrjxisEteA4L6YnNkpkkiTY4iJDIuBcoF/l+Y0iVZnYQ129MKY1RTXgDO9zgpFXrdwa35tLttpI4tJULDXUg/sJeMEc6gNGfuXFNWXdvitbxdXXzHtHztQZdB0cQdP+gRDw5JEWN6O5UJP6dg4ArDbq3nWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167043; c=relaxed/simple;
	bh=+Mj4pLHcm8CzEjjf9CVygVK6WkVlpnUMtolb4803yOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIMnWUMGY1F3k7Yi8I2FCVqeCVZGNBqHyDsA5kStv5ZtK9JGp8SOtSiM05Ue4FSoSuisE/EYecdDT2p7ZXM4b/GFOugP40Xuqv/JwajGMD8e/wm7zrjH83qFdhGI2kSmVkm1M1JuOEOPElEQiyNGEyVOupLM1rwiSrKRfB+D43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8Bx3795BOpoXfkUAA--.43205S3;
	Sat, 11 Oct 2025 15:17:13 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJDxaMBwBOpo1ebZAA--.1011S2;
	Sat, 11 Oct 2025 15:17:06 +0800 (CST)
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
Subject: [PATCH v6 0/3] uart: Introduce uart driver for the Loongson family
Date: Sat, 11 Oct 2025 15:16:46 +0800
Message-ID: <cover.1760166651.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaMBwBOpo1ebZAA--.1011S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEMCGjp8Y8BBgAAs-
X-Coremail-Antispam: 1Uk129KBj93XoWxWw4xGr4fAw4kXw15KFyxCrX_yoW5XFWfpF
	sI9ayqkrs5tF1xAws3JFWruF45Zry5JF9FgFsrGw1UW39Yvw1UXr4ft3ZIyF13ArZYqr42
	qF48CrWUGFyUZ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1q6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UN6p9UUUUU=

Hi all:

For various reasons, I will be taking over from Haowei and continuing to
push forward with this patch set. Thanks to Haowei for his efforts so
far.

This patchset introduce a generic UART framework driver for Loongson family.
It can be found on Loongson3 series cpus, Loongson-2K series cpus and Loongson 
LS7A bridge chips.

Thanks.

------
V6:
Patch-1:
 - Add Conor's Acked-by tag, thanks.

Patch-2:
 - Add more missing #include;
 - Convert mcr_invert/msr_invert from int to u8;
 - Split serial_fixup() on a preceding line;
 - Add macro definition to avoid magic numbers, such as
   LOONGSON_QUOT_FRAC_MASK;
 - Rework the relevant data structures, where `loongson_uart_ddata`
   represents the Soc's driver_data;
 - Drop `PORT_LOONGSON` and use PORT_16550A instead.
 - devm_platform_get_and_ioremap_resource() instead of platform_get_resource();
 - Use uart_read_port_properties() and parse the clock attributes;
 - Use switch-case instead of if-else in serial_fixup().

Link to V5:
https://lore.kernel.org/all/cover.1758676290.git.zhoubinbin@loongson.cn/

V5:
Patch-1:
 - Since the Loongson UART is NS8250A-compatible, simply add ls2k* compatible to 8250.yaml.

DTS{i} tested by `make dtbs_check W=1`

Link to V4:
https://lore.kernel.org/all/cover.1757318368.git.zhoubinbin@loongson.cn/

V4:
Patch-1:
  - Rename binding name from loongson,uart.yaml to
    loongson,ls2k0500-uart.yaml;
  - Drop ls7a compatible;
  - According to the manual, ls3a and ls2k uart are the same, so merge their
    compatible.

Patch-2:
  - Format code;
  - Add the LOONGSON_UART_DLF macro definition to avoid magic numbers;
  - Simplify the code, merge flags and quirks, and remove struct
    loongson_uart_config;
  - Use DEFINE_SIMPLE_DEV_PM_OPS;
  - Drop loongson,ls7a-uart compatible.

Patch-3:
  - Add ls2k* compatible string, and ns16550a as the fallback
    compatible.

Link to V3:
https://lore.kernel.org/all/20240826024705.55474-1-zhenghaowei@loongson.cn/

Binbin Zhou (3):
  dt-bindings: serial: 8250: Add Loongson uart compatible
  serial: 8250: Add Loongson uart driver support
  LoongArch: dts: Add uart new compatible string

 .../devicetree/bindings/serial/8250.yaml      |  14 ++
 arch/loongarch/boot/dts/loongson-2k0500.dtsi  |   2 +-
 arch/loongarch/boot/dts/loongson-2k1000.dtsi  |   2 +-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi  |   2 +-
 drivers/tty/serial/8250/8250_loongson.c       | 238 ++++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |  10 +
 drivers/tty/serial/8250/Makefile              |   1 +
 7 files changed, 266 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_loongson.c


base-commit: 0d97f2067c166eb495771fede9f7b73999c67f66
-- 
2.47.3

