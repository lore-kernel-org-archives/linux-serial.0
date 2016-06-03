From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 02/11] serial: sh-sci: Update DT binding documentation for dedicated RTS/CTS
Date: Fri,  3 Jun 2016 12:00:02 +0200
Message-ID: <1464948011-377-3-git-send-email-geert+renesas@glider.be>
References: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1464948011-377-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Some Renesas SCIF UARTs have dedicated lines for RTS/CTS hardware flow
control.  Whether these lines exist depends on SoC and UART instance
inside the SoC.  Whether these lines can be used for hardware flow
control depends on board wiring.

Amend the DT bindings with an optional property to indicate that RTS/CTS
hardware flow control lines exist, and can be used as such, according to
the Generic Serial DT Bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
---
v3:
  - Add Acked-by,

v2:
  - Drop RFC status,
  - Use "uart-has-rtscts" instead of "renesas,uart-has-rtscts",
  - Refer to the Generic Serial DT Bindings.
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 997baeaa869baa6f..7a0e15053db97481 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -78,6 +78,8 @@ Optional properties:
   - dma-names: Must contain a list of two DMA names, "tx" and "rx".
   - {cts,dsr,dcd,rng,rts,dtr}-gpios: Specify GPIOs for modem lines, cfr. the
     generic serial DT bindings in serial.txt.
+  - uart-has-rtscts: Indicates dedicated lines for RTS/CTS hardware flow
+    control, cfr. the generic serial DT bindings in serial.txt.
 
 Example:
 	aliases {
-- 
1.9.1

