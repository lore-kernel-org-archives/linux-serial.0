From: Joakim Nordell <joakim.nordell@intel.com>
Subject: [PATCH] serial: core: cleanup in uart_get_baud_rate()
Date: Mon,  8 Jun 2015 14:56:51 +0200
Message-ID: <1433768211-4122-1-git-send-email-joakim.nordell@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Joakim Nordell <joakim.nordell@intel.com>
List-Id: linux-serial@vger.kernel.org

Align with coding guidelines:
Replaced a chain of "else if" by a switch case.

Signed-off-by: Joakim Nordell <joakim.nordell@intel.com>
---
This is my first contribution to the Linux kernel.
I think switch case is a better way to handle the
options compare to "else if".

 drivers/tty/serial/serial_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0b7bb12..c059d09 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -335,18 +335,29 @@ unsigned int
 uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		   struct ktermios *old, unsigned int min, unsigned int max)
 {
-	unsigned int try, baud, altbaud = 38400;
+	unsigned int try;
+	unsigned int baud;
+	unsigned int altbaud;
 	int hung_up = 0;
 	upf_t flags = port->flags & UPF_SPD_MASK;
 
-	if (flags == UPF_SPD_HI)
+	switch (flags) {
+	case UPF_SPD_HI:
 		altbaud = 57600;
-	else if (flags == UPF_SPD_VHI)
+		break;
+	case UPF_SPD_VHI:
 		altbaud = 115200;
-	else if (flags == UPF_SPD_SHI)
+		break;
+	case UPF_SPD_SHI:
 		altbaud = 230400;
-	else if (flags == UPF_SPD_WARP)
+		break;
+	case UPF_SPD_WARP:
 		altbaud = 460800;
+		break;
+	default:
+		altbaud = 38400;
+		break;
+	}
 
 	for (try = 0; try < 2; try++) {
 		baud = tty_termios_baud_rate(termios);
-- 
1.9.1
