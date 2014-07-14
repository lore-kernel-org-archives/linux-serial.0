From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [RESEND 1/2] dt-binding: fsl-lpuart: use exact SoC revision to document binding
Date: Mon, 14 Jul 2014 17:41:10 +0800
Message-ID: <1405330871-9038-2-git-send-email-jingchang.lu@freescale.com>
References: <1405330871-9038-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2lp0238.outbound.protection.outlook.com ([207.46.163.238]:43183
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752879AbaGNK1b (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jul 2014 06:27:31 -0400
In-Reply-To: <1405330871-9038-1-git-send-email-jingchang.lu@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jingchang Lu <jingchang.lu@freescale.com>

use exact SoC revision instead of wildcard describing
to make the binding more clearer.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index a1d1205..c95005e 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -1,7 +1,11 @@
 * Freescale low power universal asynchronous receiver/transmitter (lpuart)
 
 Required properties:
-- compatible : Should be "fsl,<soc>-lpuart"
+- compatible :
+  - "fsl,vf610-lpuart" for lpuart compatible with the one integrated
+    on Vybrid vf610 SoC with 8-bit register organization
+  - "fsl,ls1021a-lpuart" for lpuart compatible with the one integrated
+    on LS1021A SoC with 32-bit big-endian register organization
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- 
1.8.0

