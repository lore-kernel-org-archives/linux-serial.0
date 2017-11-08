From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/5] dt-bindings: serial: Add common rs485 binding for RTS
 polarity
Date: Wed, 8 Nov 2017 11:32:34 +0100
Message-ID: <60d6ef2cf6c599d2d8717250fe52a0ccb1272be8.1510134353.git.lukas@wunner.de>
References: <cover.1510134353.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510134353.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>, Michal Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

rs485 allows for robust half-duplex serial communication.  It is often
implemented by attaching an rs485 transceiver to a UART.  The UART's
RTS line is wired to the transceiver's Transmit Enable pin and
determines whether the transceiver is sending or receiving.

Examples for such transceivers are Maxim MAX13451E and TI SN65HVD1781A:
https://datasheets.maximintegrated.com/en/ds/MAX13450E-MAX13451E.pdf
http://www.ti.com/lit/ds/symlink/sn65hvd1781a-q1.pdf

In the devicetree, the transceiver itself is not represented, only the
UART is.  A few rs485-specific dt-bindings already exist and these go
into the UART's device node.

This commit adds a binding to set the RTS polarity.  Most (if not all)
transceivers require the Transmit Enable pin be driven high for sending,
but in some cases boards may negate the pin and RTS must then be driven
low.  Consequently the polarity defaults to active high but can be
inverted with the newly added "rs485-rts-active-low" binding.

Document this binding in rs485.txt and in the two drivers fsl-imx-uart
and fsl-lpuart that are about to be amended with support for it.

Curiously, the omap_serial driver defaults to active low and already
supports an "rs485-rts-active-high" binding to invert the polarity.
This is left unchanged to retain compatibility, but the binding is
herewith documented.

Cc: Mark Jackson <mpfj-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Cc: Michał Oleszczyk <oleszczyk.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 3 ++-
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt   | 3 ++-
 Documentation/devicetree/bindings/serial/omap_serial.txt  | 1 +
 Documentation/devicetree/bindings/serial/rs485.txt        | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
index 860a9559839a..89b92c1314cf 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
@@ -9,7 +9,8 @@ Optional properties:
 - fsl,irda-mode : Indicate the uart supports irda mode
 - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
                   in DCE mode by default.
-- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
+- rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
+  linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Please check Documentation/devicetree/bindings/serial/serial.txt
 for the complete list of generic properties.
diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 59567b51cf09..6bd3f2e93d61 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -16,7 +16,8 @@ Required properties:
 Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
-- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
+- rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
+  linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Note: Optional properties for DMA support. Write them both or both not.
 
diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 43eac675f21f..4b0f05adb228 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -20,6 +20,7 @@ Optional properties:
          node and a DMA channel number.
 - dma-names : "rx" for receive channel, "tx" for transmit channel.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
+- rs485-rts-active-high: drive RTS high when sending (default is low).
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
index b8415936dfdb..b7c29f74ebb2 100644
--- a/Documentation/devicetree/bindings/serial/rs485.txt
+++ b/Documentation/devicetree/bindings/serial/rs485.txt
@@ -12,6 +12,7 @@ Optional properties:
   * b is the delay between end of data sent and rts signal in milliseconds
       it corresponds to the delay after sending data and actual release of the line.
   If this property is not specified, <0 0> is assumed.
+- rs485-rts-active-low: drive RTS low when sending (default is high).
 - linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
   feature at boot time. It can be disabled later with proper ioctl.
 - rs485-rx-during-tx: empty property that enables the receiving of data even
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
