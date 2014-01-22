From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v4 3/3] serial: fsl_lpuart: documented the clock requirement.
Date: Wed, 22 Jan 2014 12:09:33 +0800
Message-ID: <1390363773-24108-4-git-send-email-yao.yuan@freescale.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:51363
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750778AbaAVFI2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Jan 2014 00:08:28 -0500
In-Reply-To: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, shawn.guo@linaro.org
Cc: linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

It was previously required but not documented.
Add the text to the binding along with the new "dmas" addition.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
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
 - dmas: Generic dma devicetree binding as described
@@ -19,6 +21,8 @@ uart0: serial@40027000 {
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


