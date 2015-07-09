From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH REBASED RESEND] tty/early: make serial8250_early_{in,out} static again
Date: Thu, 9 Jul 2015 11:50:38 +0530
Message-ID: <1436422838-4512-1-git-send-email-vgupta@synopsys.com>
References: <1435145184-32303-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435145184-32303-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

Commit ed71871bed719 ("tty/8250_early: Turn serial_in/serial_out into
weak symbols") made these routines weak to allow platform specific
Big endian override

However recent updates to core, specifically ebc5e20082 ("serial:
of_serial: Support big-endian register accesses") and 6e63be3fee14
("serial: earlycon: Add support for big-endian MMIO accesses") means
that round about way to overide the early serial accessors is no longer
needed.

Cc: <linux-serial@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Noam Camus <noamc@ezchip.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 drivers/tty/serial/8250/8250_early.c | 4 ++--
 include/linux/serial_8250.h          | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 771dda29a0f8..faed05f25bc2 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -35,7 +35,7 @@
 #include <asm/io.h>
 #include <asm/serial.h>
 
-unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offset)
+static unsigned int __init serial8250_early_in(struct uart_port *port, int offset)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
@@ -51,7 +51,7 @@ unsigned int __weak __init serial8250_early_in(struct uart_port *port, int offse
 	}
 }
 
-void __weak __init serial8250_early_out(struct uart_port *port, int offset, int value)
+static void __init serial8250_early_out(struct uart_port *port, int offset, int value)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ba82c07feb95..9075712db8d8 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -136,8 +136,6 @@ void serial8250_resume_port(int line);
 
 extern int early_serial_setup(struct uart_port *port);
 
-extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
-extern void serial8250_early_out(struct uart_port *port, int offset, int value);
 extern int early_serial8250_setup(struct earlycon_device *device,
 					 const char *options);
 extern void serial8250_do_set_termios(struct uart_port *port,
-- 
1.9.1
