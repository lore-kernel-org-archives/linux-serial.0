From: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 3/6] MAINTAINERS: add at91 usart spi driver
Date: Fri, 4 May 2018 18:47:11 +0300
Message-ID: <20180504154714.5109-4-radu.pirea@microchip.com>
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
index ca06c6f58299..9243b9007966 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9199,6 +9199,13 @@ S:	Supported
 F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-at91-usart.c
+F:	Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.17.0
