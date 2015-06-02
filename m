From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH linux-next 1/4] ARM: at91/dt: add new DT properties for Atmel usart
Date: Tue, 2 Jun 2015 16:18:21 +0200
Message-ID: <6fe7914a2c39245ac9a05cdb9962b88c409ec1a4.1433253787.git.cyrille.pitchen@atmel.com>
References: <cover.1433253787.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1433253787.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

add 3 new properties:
- "atmel,fifo-size": to enable FIFO support
- "atmel,rts-low-threshold" and "atmel,rts-high-threshold": to control
  the hardware handshake flow control.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 90787aa..6158418 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -22,6 +22,21 @@ Optional properties:
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
 		Refer to dma.txt and atmel-dma.txt for details.
 	- dma-names: "rx" for RX channel, "tx" for TX channel.
+- atmel,fifo-size: size of the TX and RX FIFOs. That is to say the maximum
+  number of data each FIFO can store. A positive size enables FIFO support.
+  A zero size or a missing property disables FIFO support.
+- atmel,rts-low-threshold: when the RX FIFO level, ie the number of data
+  available to be read from the RX FIFO, crosses down this threshold the RTS
+  line is driven to low level to tell the remote peer that it can (re)start
+  sending new data.
+- atmel,rts-high-threshold: when the RX FIFO level crosses up this threshold,
+  the RTS line is driven to high level to tell the remote peer that it should
+  stop sending new data.
+
+0 < rts-low-threshold < rts-high-threshold <= fifo-size
+
+These two thresholds are only used when both the FIFO support and the hardware
+handshake mode are enabled.
 
 <chip> compatible description:
 - at91rm9200:  legacy USART support
-- 
1.8.2.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
