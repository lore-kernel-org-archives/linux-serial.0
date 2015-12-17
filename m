From: Sebastian Frias <sf84@laposte.net>
Subject: [PATCH] use callbacks to access UART_DLL/UART_DLM
Date: Thu, 17 Dec 2015 16:45:30 +0100
Message-ID: <5672D89A.4090307@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm@opensource.se>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

---
resending as plain-text
---
  drivers/tty/serial/8250/8250_core.c |   17 +++++++----------
  1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c 
b/drivers/tty/serial/8250/8250_core.c
index 2c46a21..9ca863c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -791,22 +791,19 @@ static int size_fifo(struct uart_8250_port *up)
   */
  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
  {
-    unsigned char old_dll, old_dlm, old_lcr;
+    unsigned char old_lcr;
      unsigned int id;
+    unsigned int old_dl;

      old_lcr = serial_in(p, UART_LCR);
-    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
-
-    old_dll = serial_in(p, UART_DLL);
-    old_dlm = serial_in(p, UART_DLM);

-    serial_out(p, UART_DLL, 0);
-    serial_out(p, UART_DLM, 0);
+    serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);

-    id = serial_in(p, UART_DLL) | serial_in(p, UART_DLM) << 8;
+    old_dl = serial_dl_read(p);
+    serial_dl_write(p, 0);
+    id = serial_dl_read(p);
+    serial_dl_write(p, old_dl);

-    serial_out(p, UART_DLL, old_dll);
-    serial_out(p, UART_DLM, old_dlm);
      serial_out(p, UART_LCR, old_lcr);

      return id;
-- 
1.7.10.4
