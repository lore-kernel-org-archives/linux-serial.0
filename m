Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58E38C2D4
	for <linux-serial@vger.kernel.org>; Sat, 14 Mar 2026 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531719; cv=none; b=DrLw92SdYeioQNrRS/gCCYozBUfa4pTsaWSGlqhH8DogT//Rh9Zqqm1/PUPBnKlEJEeUrQIHSPQwcw3wOPg0qcAQ3ctlq6RkfufY/FlJQxtFLNFTIjpBkoRluWvs05/T+jdZHk9331ynGQsRWCzbXtAKHi0bkN3N8OadE6GqzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531719; c=relaxed/simple;
	bh=wv6HpXrIlfr6EXsqbV6jc8CuC8VrTOicp6tv1wBw7BY=;
	h=Date:Mime-Version:In-Reply-To:To:Cc:From:Content-Type:Subject:
	 Message-Id:References; b=KVR52kK0xkKavv6CbK1PDTKNvz6Jg8nMNKAlKpc/rzC7K+PsgFb5Zp4KhrC6PIJPQTiTvCWvfVeVGBZSB1j8HyO7IrgcTLQQVHF38RehB6yQdTI/GqxNSwGJ3DlTl9u8Jwu5OkWbLDCyRCrwrzFtekSKShJ3qKx4hdvKHdT3neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=WFCXGrKW; arc=none smtp.client-ip=209.127.231.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="WFCXGrKW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1773531712;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=BZW8ZqsLZjXZI6wPg1zAMlBbDDZ7mr231EF1XozrvFk=;
 b=WFCXGrKWmmRok8znSvaJPV797atmUDGLEEJlJLw3A0Sdx8EeI0Ljc3rwzNF8gjkK8I98mN
 pfbPhgNp0sRcnWxP9E7L+TNDko/UQf3j1NwMf3OSmgDqcdnFvCBqcUKo6/s/187uawiR+0
 m2bG3aOhYy6OS2Yp36INx13lxdnHry9RU6CkTE8rnVQqSQWlT+9pSzTLrSlBPJPAExHQK+
 1euDrE9Z5z7Yso8w/4R/1PiqiB+QeiHx+SHH43HkuQe+W+tRyMn+blofvbDiqILjUh+Ti9
 iDHtxe/awCBPVZFpXc8q/R1ZyvBhCYWD/TiUB3Lvbo33EC/zQC+Sq8W7IT1g+Q==
Date: Sun, 15 Mar 2026 07:41:43 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260314234143.651298-1-rongrong@oss.cipunited.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"Huacai Chen" <chenhuacai@loongson.cn>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>
Cc: "Rong Zhang" <rongrong@oss.cipunited.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, 
	<linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	"Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Rong Zhang" <i@rong.moe>
X-Lms-Return-Path: <lba+269b5f23e+a7f42a+vger.kernel.org+rongrong@oss.cipunited.com>
X-Mailer: git-send-email 2.53.0
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Received: from tb ([223.88.91.90]) by smtp.feishu.cn with ESMTPS; Sun, 15 Mar 2026 07:41:49 +0800
Content-Transfer-Encoding: 7bit
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 3/3] MIPS: dts: loongson64g-package: Switch to Loongson UART driver
Message-Id: <20260314234143.651298-4-rongrong@oss.cipunited.com>
References: <20260314234143.651298-1-rongrong@oss.cipunited.com>

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
-- 
2.53.0
