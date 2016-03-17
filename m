From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/5] serial: sh-sci: Update DT binding documentation for dedicated RTS/CTS
Date: Thu, 17 Mar 2016 14:47:26 +0100
Message-ID: <1458222449-12324-3-git-send-email-geert+renesas@glider.be>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Some Renesas SCIF UARTs have dedicated lines for RTS/CTS hardware flow
control.  Whether these lines exist depends on SoC and UART instance
inside the SoC.  Whether these lines can be used for hardware flow
control depends on board wiring.

Amend the DT bindings with an optional property to indicate that RTS/CTS
hardware flow control lines exist, and can be used as such.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
This has been mimicked after the "fsl,uart-has-rtscts" and
"sirf,uart-has-rtscts" properties.

However, as this is fairly generic, perhaps it should just be named
"uart-has-rtscts" instead?
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index f8d7b36742967163..8de177c187536c68 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -79,6 +79,11 @@ Optional properties:
   - {cts,dsr,dcd,rng,rts,dtr,out1,out2}-gpios: Must contain a GPIO specifier,
     referring to the GPIO pin to be used as the UART's CTS, DSR, DCD, RNG, RTS,
     DTR, OUT1, or OUT2 line.
+  - renesas,uart-has-rtscts: The presence of this property indicates that the
+    UART has dedicated lines for RTS/CTS hardware flow control, and that
+    they are available for use (wired and enabled by pinmux configuration).
+    Note that this property is mutually-exclusive with "cts-gpios" and
+    "rts-gpios" above.
 
 Example:
 	aliases {
-- 
1.9.1

