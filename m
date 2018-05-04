From: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 1/6] MAINTAINERS: add at91 usart mfd driver
Date: Fri, 4 May 2018 18:47:09 +0300
Message-ID: <20180504154714.5109-2-radu.pirea@microchip.com>
References: <20180504154714.5109-1-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180504154714.5109-1-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: lee.jones@linaro.org, broonie@kernel.org, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, jslaby@suse.com, gregkh@linuxfoundation.org, richard.genoud@gmail.com, Radu Pirea <radu.pirea@microchip.com>
List-Id: linux-serial@vger.kernel.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e2a2fddbd19..ca06c6f58299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9192,6 +9192,13 @@ S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 
+MICROCHIP AT91 USART MFD DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/mfd/at91-usart.c
+F:	include/dt-bindings/mfd/at91-usart.h
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.17.0
