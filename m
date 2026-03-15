Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0461DFFB
	for <linux-serial@vger.kernel.org>; Sun, 15 Mar 2026 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600250; cv=none; b=DhWAAqZY4ftQCGrxPo+zT7lusEN70rzfaZEofBd9JaEobL6wFSkzbeNFf6LkkZ/MGakbr1hfl23UO132d03QtB1/1w77BjFYEJ6C16GslTZxGxJZMH/GoUVuf9gGm8l4jZdAluLjpj+D2Z+R1whLNghArbOOnN3wrw3zdK+qzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600250; c=relaxed/simple;
	bh=hz6dQF2Kpbpn00C6ZOhV4gVA7hGQeJC2YTLY2wPmq0I=;
	h=Message-Id:Cc:From:Subject:Date:Mime-Version:To:Content-Type; b=Kg8g+PYEN1aYPX1NebequSQ4Ftobfj1RBgAeBGtSJM/W1iKRJFFR+/UKoIY5DA0D+kW21/VuORyoKUsMQ4SYQOU5N+f9OttdKepYZJVtnp6juSGfD/C9cgcNsBjEEOmzp+iYbk+hVIx8uF1/8uskaAIgyMaVbS6BDl6YTIWGUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=Mdfa6fFk; arc=none smtp.client-ip=209.127.231.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="Mdfa6fFk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1773600244;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=5f4JTrntWszcb2qdYmfCdX/l5DWGUDZ7ka+GLUYI+uI=;
 b=Mdfa6fFk+rcE2UG5X89KtuZ3WzXy+fOtDCpDp9dncDOU/dVdvxF/uNDq4NJK1fyL/geGMj
 9NNS5fEwT4R/J3T6jGbOwcU3X5hcy2p+UaNrCU41O7awU42pZEqi4+C4jBhstVccI6vb5D
 F2PjHbXAiAMCuI4CXc3FzzClW0qW1+m/hxs2bGjO0Mk2xLBU/9h+rcFnxuQnB5Ftjzims3
 71lGn2QWiNn4l+J/FmgOY3GzwLw4hxV6NyuLjj0jDfK1SKfSRMEEOhZ0bXoI4Etvs/H/kw
 oXVr8sBYIj8o9h7TrhzHaVYvrQYIP7ZTSkzXBWuvzCMbvibT8MXihinfZHnsUw==
Message-Id: <20260315184401.413975-1-rongrong@oss.cipunited.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+269b6fdf3+b248f4+vger.kernel.org+rongrong@oss.cipunited.com>
Cc: "Rong Zhang" <rongrong@oss.cipunited.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, 
	<linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	"Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Rong Zhang" <i@rong.moe>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH v2] MIPS: dts: loongson64g-package: Switch to Loongson UART driver
Date: Mon, 16 Mar 2026 02:44:00 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"Huacai Chen" <chenhuacai@loongson.cn>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>
Received: from tb ([223.88.91.90]) by smtp.feishu.cn with ESMTPS; Mon, 16 Mar 2026 02:44:02 +0800
Content-Type: text/plain; charset=UTF-8

Loongson64g is Loongson 3A4000, whose UART controller is compatible with
Loongson 2K1500, which is NS16550A-compatible with an additional
fractional frequency divisor register.

Update the compatible strings to reflect this, so that 3A4000 can
benefit from the fractional frequency divisor provided by loongson-uart.
This is required on some devices, otherwise their UART can't work at
some high baud rates, e.g., 115200.

Tested on Loongson-LS3A4000-7A1000-NUC-SE with a 25MHz UART clock.
Without fractional frequency divisor, the actual baud rate was 111607
(25MHz / 16 / 14, measured value: 111545) and some USB-to-UART
converters couldn't work with it at all. With fractional frequency
divisor, the measured baud rate becomes 115207, which is quite accurate.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
This patch targets the MIPS tree.

The series for the serial tree to update dt-bindings and enable building
8250_loongson (loongson-uart) on MIPS Loongson64 is sent separately, as
it's independant of this patch and can be applied in any order (the
compatible strings here still contain "ns16550a", so no regression will
be introduced).

Changes in v2:
- Separated from v1 (patch 3): https://lore.kernel.org/r/20260314234143.651298-1-rongrong@oss.cipunited.com/
(thanks Krzysztof Kozlowski)
---
 arch/mips/boot/dts/loongson/loongson64g-package.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson64g-package.dtsi b/arch/mips/boot/dts/loongson/loongson64g-package.dtsi
index d4314f62ccc2..029daeedd0ab 100644
--- a/arch/mips/boot/dts/loongson/loongson64g-package.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64g-package.dtsi
@@ -40,7 +40,7 @@ liointc: interrupt-controller@3ff01400 {
 		};
 
 		cpu_uart0: serial@1fe00100 {
-			compatible = "ns16550a";
+			compatible = "loongson,ls3a4000-uart", "loongson,ls2k1500-uart", "ns16550a";
 			reg = <0 0x1fe00100 0x10>;
 			clock-frequency = <100000000>;
 			interrupt-parent = <&liointc>;
@@ -50,7 +50,7 @@ cpu_uart0: serial@1fe00100 {
 
 		cpu_uart1: serial@1fe00110 {
 			status = "disabled";
-			compatible = "ns16550a";
+			compatible = "loongson,ls3a4000-uart", "loongson,ls2k1500-uart", "ns16550a";
 			reg = <0 0x1fe00110 0x10>;
 			clock-frequency = <100000000>;
 			interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;

base-commit: 267594792a71018788af69e836c52e34bb8054af
-- 
2.53.0
