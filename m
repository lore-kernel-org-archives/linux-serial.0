From: Sebastian Frias <sf84@laposte.net>
Subject: [PATCH v2] use callbacks to access UART_DLL/UART_DLM
Date: Fri, 18 Dec 2015 11:46:21 +0100
Message-ID: <5673E3FD.8080001@laposte.net>
References: <5672D89A.4090307@laposte.net> <yw1xoadpcbbn.fsf@unicorn.mansr.com> <5672F9C9.1010601@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5672F9C9.1010601@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>
Cc: =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>, Jon Anders Haugum <jonah@omegav.ntnu.no>
List-Id: linux-serial@vger.kernel.org

---

Some UART HW has a single register combining UART_DLL/UART_DLM
(this was probably forgotten in the change that introduced the
callbacks, commit b32b19b8ffc05cbd3bf91c65e205f6a912ca15d9)

Fixes: b32b19b8ffc0

Signed-off-by: Sebastian Frias <sf84@laposte.net>
---
  drivers/tty/serial/8250/8250_port.c |   17 ++++++-----------
  1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c 
b/drivers/tty/serial/8250/8250_port.c
index 52d82d2..827eb6f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -713,22 +713,17 @@ static int size_fifo(struct uart_8250_port *up)
   */
  static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
  {
-	unsigned char old_dll, old_dlm, old_lcr;
+	unsigned char old_lcr;
  	unsigned int id;
+	unsigned int old_dl;

  	old_lcr = serial_in(p, UART_LCR);
  	serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
+	old_dl = serial_dl_read(p);
+	serial_dl_write(p, 0);
+	id = serial_dl_read(p);
+	serial_dl_write(p, old_dl);

-	old_dll = serial_in(p, UART_DLL);
-	old_dlm = serial_in(p, UART_DLM);
-
-	serial_out(p, UART_DLL, 0);
-	serial_out(p, UART_DLM, 0);
-
-	id = serial_in(p, UART_DLL) | serial_in(p, UART_DLM) << 8;
-
-	serial_out(p, UART_DLL, old_dll);
-	serial_out(p, UART_DLM, old_dlm);
  	serial_out(p, UART_LCR, old_lcr);

  	return id;
-- 
1.7.10.4
