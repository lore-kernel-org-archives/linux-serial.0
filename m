From: Radu Pirea <radu_nicolae.pirea@upb.ro>
Subject: [PATCH v12 1/6] MAINTAINERS: add at91 usart mfd driver
Date: Tue,  4 Sep 2018 14:13:05 +0300
Message-ID: <20180904111310.4049-2-radu_nicolae.pirea@upb.ro>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com, richard.genoud@gmail.com, davem@davemloft.net, mchehab+samsung@kernel.org, akpm@linux-foundation.org, arnd@arndb.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Radu Pirea <radu.pirea@microchip.com>

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf4..8aeaa2cc3e14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9322,6 +9322,7 @@ M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
 MICROCHIP / ATMEL DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
@@ -9354,6 +9355,14 @@ S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 
+MICROCHIP AT91 USART MFD DRIVER
+M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/mfd/at91-usart.c
+F:	include/dt-bindings/mfd/at91-usart.h
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.18.0
