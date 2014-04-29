From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC v2] serial: sh-sci: Add device tree support for r8a7779
Date: Tue, 29 Apr 2014 16:20:11 +0900
Message-ID: <1398756011-4672-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42632 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaD2HUR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Apr 2014 03:20:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Simply document a new compat string.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v2
* Do not update the driver to set SCSCR_CKE1.
  Instead DT may provide the P clock as the clock for the SCIF devices.
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 53e6c17..bba86de 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -12,6 +12,7 @@ Required properties:
     - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
     - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
     - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
+    - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
-- 
1.8.5.2

