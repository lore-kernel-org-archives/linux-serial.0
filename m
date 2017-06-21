From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 9/9] of: document rs485 bindings for Atmel USART, Freescale UARTs and OMAP UART
Date: Wed, 21 Jun 2017 12:21:30 +0200
Message-ID: <20170621102130.21024-10-u.kleine-koenig@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170621102130.21024-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The drivers support the rs485 binding described in rs485.txt, this commit
just makes that explicit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt  | 1 +
 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 1 +
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt   | 1 +
 Documentation/devicetree/bindings/serial/omap_serial.txt  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index e6e6142e33ac..7c0d6b2f53e4 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -24,6 +24,7 @@ Optional properties:
 	- dma-names: "rx" for RX channel, "tx" for TX channel.
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
   capable USARTs.
+- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
 
 <chip> compatible description:
 - at91rm9200:  legacy USART support
diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
index 574c3a2c77d5..860a9559839a 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
@@ -9,6 +9,7 @@ Optional properties:
 - fsl,irda-mode : Indicate the uart supports irda mode
 - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
                   in DCE mode by default.
+- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Please check Documentation/devicetree/bindings/serial/serial.txt
 for the complete list of generic properties.
diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index c95005efbcb8..4eca15378584 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -14,6 +14,7 @@ Required properties:
 Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
+- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Note: Optional properties for DMA support. Write them both or both not.
 
diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 7a71b5de77d6..43eac675f21f 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -19,6 +19,7 @@ Optional properties:
 - dmas : DMA specifier, consisting of a phandle to the DMA controller
          node and a DMA channel number.
 - dma-names : "rx" for receive channel, "tx" for transmit channel.
+- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Example:
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
