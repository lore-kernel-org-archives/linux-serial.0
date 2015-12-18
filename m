From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: atmel: remove module device table
Date: Fri, 18 Dec 2015 15:49:59 +0100
Message-ID: <1540393.QjMdSgnH0N@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

A recent patch removed most of the module-specific code from the atmel
serial driver, but left the MODULE_DEVICE_TABLE in place, so we can't
build it any more:

drivers/tty/serial/atmel_serial.c:192:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
drivers/tty/serial/atmel_serial.c:192:1: warning: parameter names (without types) in function declaration

This removes the table as well to avoid the error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 50e785a0ea73..1c0884d8ef32 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -188,8 +188,6 @@ static const struct of_device_id atmel_serial_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-usart" },
 	{ /* sentinel */ }
 };
-
-MODULE_DEVICE_TABLE(of, atmel_serial_dt_ids);
 #endif
 
 static inline struct atmel_uart_port *
