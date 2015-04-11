From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 1/2] drivers/tty/serial: altera: fix typos in #endif comments
Date: Sat, 11 Apr 2015 12:21:30 +0200
Message-ID: <1428747690-19948-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tklauser@distanz.ch, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pebolle@tiscalie.nl
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

Correct reference on CONFIG_SERIAL_ALTERA_{JTAG}UART_CONSOLE in
C-comment after #endif.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
I found this issue with ./scripts/checkkconfigsymbols.py
---
 drivers/tty/serial/altera_jtaguart.c | 2 +-
 drivers/tty/serial/altera_uart.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 0fefdd8931a2..32df2a0cb060 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -387,7 +387,7 @@ console_initcall(altera_jtaguart_console_init);
 
 #define	ALTERA_JTAGUART_CONSOLE	NULL
 
-#endif /* CONFIG_ALTERA_JTAGUART_CONSOLE */
+#endif /* CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE */
 
 static struct uart_driver altera_jtaguart_driver = {
 	.owner		= THIS_MODULE,
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index b2859fe07e14..fd87a6f574e3 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -493,7 +493,7 @@ console_initcall(altera_uart_console_init);
 
 #define	ALTERA_UART_CONSOLE	NULL
 
-#endif /* CONFIG_ALTERA_UART_CONSOLE */
+#endif /* CONFIG_SERIAL_ALTERA_UART_CONSOLE */
 
 /*
  *	Define the altera_uart UART driver structure.
-- 
2.1.0
