From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v2] serial: core: remove baud_rates when serial console setup
Date: Mon,  4 Jan 2016 15:54:46 +0800
Message-ID: <1451894086-20435-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org, linux-rockchip@lists.infradead.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-serial@vger.kernel.org

Currently, when tring to set up a serial console with a higher
baud rate, it would fallback to 921600.

Tested-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

Changes in v2:
remove baud_rates as Alan's suggestion.

 drivers/tty/serial/serial_core.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index def5199..150547c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1892,26 +1892,6 @@ uart_parse_options(char *options, int *baud, int *parity, int *bits, int *flow)
 }
 EXPORT_SYMBOL_GPL(uart_parse_options);
 
-struct baud_rates {
-	unsigned int rate;
-	unsigned int cflag;
-};
-
-static const struct baud_rates baud_rates[] = {
-	{ 921600, B921600 },
-	{ 460800, B460800 },
-	{ 230400, B230400 },
-	{ 115200, B115200 },
-	{  57600, B57600  },
-	{  38400, B38400  },
-	{  19200, B19200  },
-	{   9600, B9600   },
-	{   4800, B4800   },
-	{   2400, B2400   },
-	{   1200, B1200   },
-	{      0, B38400  }
-};
-
 /**
  *	uart_set_options - setup the serial console parameters
  *	@port: pointer to the serial ports uart_port structure
@@ -1927,7 +1907,6 @@ uart_set_options(struct uart_port *port, struct console *co,
 {
 	struct ktermios termios;
 	static struct ktermios dummy;
-	int i;
 
 	/*
 	 * Ensure that the serial console lock is initialised
@@ -1942,16 +1921,8 @@ uart_set_options(struct uart_port *port, struct console *co,
 
 	memset(&termios, 0, sizeof(struct ktermios));
 
-	termios.c_cflag = CREAD | HUPCL | CLOCAL;
-
-	/*
-	 * Construct a cflag setting.
-	 */
-	for (i = 0; baud_rates[i].rate; i++)
-		if (baud_rates[i].rate <= baud)
-			break;
-
-	termios.c_cflag |= baud_rates[i].cflag;
+	termios.c_cflag |= CREAD | HUPCL | CLOCAL;
+	tty_termios_encode_baud_rate(&termios, baud, baud);
 
 	if (bits == 7)
 		termios.c_cflag |= CS7;
-- 
2.1.4
