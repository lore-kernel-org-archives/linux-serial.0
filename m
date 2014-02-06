From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 2/2] serial: sh-sci: Fix compatible string in DT bindings example
Date: Thu,  6 Feb 2014 15:47:40 +0900
Message-ID: <1391669260-23970-3-git-send-email-horms+renesas@verge.net.au>
References: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58958 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbaBFGrt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Feb 2014 01:47:49 -0500
In-Reply-To: <1391669260-23970-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Remove the -generic suffix from the compatible string in the serial port
DT bindings example.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index f372cf2..53e6c17 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -37,7 +37,7 @@ Example:
 	};
 
 	scifa0: serial@e6c40000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.2

