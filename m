From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v5 3/3] serial: fsl_lpuart: documented the clock requirement.
Date: Fri, 14 Feb 2014 15:27:19 +0800
Message-ID: <1392362839-8004-4-git-send-email-yao.yuan@freescale.com>
References: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [213.199.154.204] ([213.199.154.204]:40081 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752216AbaBNIbf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Feb 2014 03:31:35 -0500
In-Reply-To: <1392362839-8004-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org, mark.rutland@arm.com
Cc: linux@arm.linux.org.uk, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

This is a correction to the documentation. It was previously required but not documented.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 6e1cbbf..9666f97 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -4,6 +4,8 @@ Required properties:
 - compatible : Should be "fsl,<soc>-lpuart"
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
+- clocks : phandle + clock specifier pairs, one for each entry in clock-names
+- clock-names : should contain: "ipg" - the uart clock
 
 Optional properties:
 - dmas: List of two DMA specifiers, using a three-cell specifier for each channel.
@@ -22,6 +24,8 @@ uart0: serial@40027000 {
 		compatible = "fsl,vf610-lpuart";
 		reg = <0x40027000 0x1000>;
 		interrupts = <0 61 0x00>;
+		clocks = <&clks VF610_CLK_UART0>;
+		clock-names = "ipg";
 		dmas = <&edma0 0 2>,
 			<&edma0 0 3>;
 		dma-names = "rx","tx";
-- 
1.8.4


