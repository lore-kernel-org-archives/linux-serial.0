From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 REPOST] serial: sh-sci: Add device tree support for r8a7779
Date: Mon, 26 May 2014 09:41:27 +0900
Message-ID: <20140526004127.GB31096@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40705 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbaEZAle (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 May 2014 20:41:34 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Simon Horman <horms+renesas@verge.net.au>

Simply document a new compat string.
There appears to be no need for a driver updates.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v3
* Keep lists sorted by SoC number
* Added Ack from Laurent Pinchart

v2
* Do not update the driver to set SCSCR_CKE1.
  Instead DT may provide the P clock as the clock for the SCIF devices.
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 53e6c17..64fd7de 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -4,6 +4,7 @@ Required properties:
 
   - compatible: Must contain one of the following:
 
+    - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
     - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
     - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
-- 
1.8.5.2

