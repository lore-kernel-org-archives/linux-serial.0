From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v4 1/3] ARM: dts: vf610: lpuart: Add eDMA support
Date: Wed, 22 Jan 2014 12:09:31 +0800
Message-ID: <1390363773-24108-2-git-send-email-yao.yuan@freescale.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:32376 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbaAVFIa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Jan 2014 00:08:30 -0500
In-Reply-To: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Add lpuart dts node properties for eDMA support, them depend on the eDMA driver.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 80db14e..4149ed6 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -101,5 +101,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	dmas = <&edma0 0 4>,
+		<&edma0 0 5>;
+	dma-names = "rx","tx";
 	status = "okay";
 };
-- 
1.8.4


