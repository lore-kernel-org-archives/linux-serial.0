From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] MAINTAINERS: update entry for atmel_serial driver
Date: Wed, 28 Sep 2016 17:47:35 +0200
Message-ID: <20160928154735.25265-1-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, richard.genoud@gmail.com, jslaby@suse.cz, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

Change maintainer for the serial driver found on most of the
Microchip / Atmel MPUs and take advantage of the move to rename
and reorder the entry.
I'm happy that Richard is taking over the maintenance of this
driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 MAINTAINERS | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e39dacd77c0e..06c17717a004 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2140,11 +2140,6 @@ M:	Ludovic Desroches <ludovic.desroches@atmel.com>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
 
-ATMEL AT91 / AT32 SERIAL DRIVER
-M:	Nicolas Ferre <nicolas.ferre@atmel.com>
-S:	Supported
-F:	drivers/tty/serial/atmel_serial.c
-
 ATMEL AT91 SAMA5D2-Compatible Shutdown Controller
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
@@ -7930,6 +7925,12 @@ T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 S:	Supported
 F:	arch/microblaze/
 
+MICROCHIP / ATMEL AT91 / AT32 SERIAL DRIVER
+M:	Richard Genoud <richard.genoud@gmail.com>
+S:	Maintained
+F:	drivers/tty/serial/atmel_serial.c
+F:	include/linux/atmel_serial.h
+
 MICROCHIP / ATMEL ISC DRIVER
 M:	Songjun Wu <songjun.wu@microchip.com>
 L:	linux-media@vger.kernel.org
-- 
2.9.0
