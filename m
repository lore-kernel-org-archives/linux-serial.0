From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 03/27] serial: sh-sci: Update DT binding documentation for external clock input
Date: Mon, 14 Dec 2015 19:57:12 +0100
Message-ID: <1450119456-964-4-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Amend the DT bindings to include the optional external clock on
(H)SCI(F) and some SCIFA, where this pin can serve as a clock input,
depending on board wiring.

Clarify the use of the divided functional clock as a source for the
sampling clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org
---
v3:
  - Add Acked-by,
  - Clarify the use of the divided functional clock.
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 7091213f02513cda..31cc0631ef7ca22d 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -51,6 +51,11 @@ Required properties:
   - clocks: Must contain a phandle and clock-specifier pair for each entry
     in clock-names.
   - clock-names: Must contain "fck" for the SCIx UART functional clock.
+    Apart from the divided functional clock, there may be other possible
+    sources for the sampling clock, depending on SCIx variant.
+    On (H)SCI(F) and some SCIFA, an additional clock may be specified:
+      - "hsck" for the optional external clock input (on HSCIF),
+      - "sck" for the optional external clock input (on other variants).
 
 Note: Each enabled SCIx UART should have an alias correctly numbered in the
 "aliases" node.
-- 
1.9.1

