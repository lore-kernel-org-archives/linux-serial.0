From: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v5 1/6] MAINTAINERS: add at91 usart mfd driver
Date: Mon, 4 Jun 2018 19:59:38 +0300
Message-ID: <20180604165943.31381-2-radu.pirea@microchip.com>
References: <20180604165943.31381-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180604165943.31381-1-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee.jones@linaro.org, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e2a2fddbd19..12203d07c6af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9160,6 +9160,7 @@ M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
 MICROCHIP / ATMEL DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
@@ -9192,6 +9193,14 @@ S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 
+MICROCHIP AT91 USART MFD DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
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
2.17.1
