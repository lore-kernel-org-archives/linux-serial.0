From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v4 1/5] ARM: at91/dt: add a new DT property to support FIFOs
 on Atmel USARTs
Date: Thu, 2 Jul 2015 15:18:09 +0200
Message-ID: <600fa97640902a0a222901db18305749f57984e5.1435842688.git.cyrille.pitchen@atmel.com>
References: <cover.1435842688.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1435842688.git.cyrille.pitchen@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, alexandre.belloni@free-electrons.com, linux-serial@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This patch adds a new DT property, "atmel,fifo-size", to enable and set
the maximum number of data the RX and TX FIFOs can store on FIFO capable
USARTs.

Please be aware that the VERSION register can not be used to guess the
size of FIFOs. Indeed, for a given hardware version, the USARTs can be
integrated on Atmel SoCs with different FIFO sizes. Also the
"atmel,fifo-size" property is optional as older USARTs don't embed FIFO at
all.

Besides, the FIFO size can not be read or guessed from other registers:
When designing the FIFO feature, no dedicated registers were added to
store this size. Unsed spaces in the I/O register range are limited and
better reserved for future usages. Instead, the FIFO size of each
peripheral is documented in the programmer datasheet.

Finally, on a given SoC, there can be several instances of USART with
different FIFO sizes. This explain why we'd rather use a dedicated DT
property than use the "compatible" property.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/serial/atmel-usart.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
index 90787aa2e648..e6e6142e33ac 100644
--- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
@@ -22,6 +22,8 @@ Optional properties:
 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
 		Refer to dma.txt and atmel-dma.txt for details.
 	- dma-names: "rx" for RX channel, "tx" for TX channel.
+- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
+  capable USARTs.
 
 <chip> compatible description:
 - at91rm9200:  legacy USART support
@@ -57,4 +59,5 @@ Example:
 		dmas = <&dma0 2 0x3>,
 		       <&dma0 2 0x204>;
 		dma-names = "tx", "rx";
+		atmel,fifo-size = <32>;
 	};
-- 
1.8.2.2
