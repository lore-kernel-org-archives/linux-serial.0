From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 01/11] serial: sh-sci: Update DT binding documentation for GPIO modem lines
Date: Fri,  3 Jun 2016 12:00:01 +0200
Message-ID: <1464948011-377-2-git-send-email-geert+renesas@glider.be>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Amend the DT bindings for the Renesas SCI driver to allow describing
optional GPIO-controlled modem lines, which can be used where dedicated
modem lines are not available.

The property naming is dictated by the Generic Serial DT Bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
v3:
  - No changes,

v2:
  - Add Acked-by,
  - Drop RFC status,
  - Refer to the Generic Serial DT Bindings,
  - Drop out[12]-gpios.
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 528c3b90f23cb04b..997baeaa869baa6f 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -76,6 +76,8 @@ Optional properties:
   - dmas: Must contain a list of two references to DMA specifiers, one for
 	  transmission, and one for reception.
   - dma-names: Must contain a list of two DMA names, "tx" and "rx".
+  - {cts,dsr,dcd,rng,rts,dtr}-gpios: Specify GPIOs for modem lines, cfr. the
+    generic serial DT bindings in serial.txt.
 
 Example:
 	aliases {
-- 
1.9.1

