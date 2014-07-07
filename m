From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2] serial: sh-sci: Add device tree support for r8a7{778,740,3a4} and sh73a0
Date: Mon,  7 Jul 2014 08:40:17 +0200
Message-ID: <1404715217-30632-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58722 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaGGGkg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jul 2014 02:40:36 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

--
v2
* Added r8a73a4, r8a7740 and sh73a0 support
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 64fd7de..b355660 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -4,6 +4,13 @@ Required properties:
 
   - compatible: Must contain one of the following:
 
+    - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
+    - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
+    - "renesas,scifa-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFA compatible UART.
+    - "renesas,scifb-r8a73a4" for R8A73A4 (R-Mobile APE6) SCIFB compatible UART.
+    - "renesas,scifa-r8a7740" for R8A7740 (R-Mobile A1) SCIFA compatible UART.
+    - "renesas,scifb-r8a7740" for R8A7740 (R-Mobile A1) SCIFB compatible UART.
+    - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
-- 
2.0.0.rc2

