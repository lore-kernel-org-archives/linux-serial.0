From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Patch: linux-2.5.34/drivers/serial/core.c console message fix
Date: Thu, 12 Sep 2002 03:44:40 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020912034440.A1477@baldur.yggdrasil.com>
Reply-To: "Adam J. Richter" <adam@yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: tytso@mit.edu
Cc: linux-serial@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Since approximately 2.5.29, the message that the serial module
prints under devfs when it finds a device has been slightly incorrect.
It has beening printing out the literal value a formatting string that
is supposed to include the unit number.  For example, for the built-in
serial ports, it would incorrectly print:

tts/%d0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/%d1 at I/O 0x2f8 (irq = 3) is a 16550A

	Whereas it should print (and did prior to ~2.5.29):

tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A

	The printk message was the only thing that was broken, as
far as I could tell.  The devfs entries had correct names (e.g.,
/dev/tts/0).

	The following patch fixes the printk.

	Ted, could you please let me know if you are going to shepherd
this Linus, or if you want me to submit it directly or if you you'd
prefer some other course of action.  Thanks in advance.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="serial.diff"

--- linux-2.5.34/drivers/serial/core.c	2002-09-09 10:35:05.000000000 -0700
+++ linux/drivers/serial/core.c	2002-09-12 03:35:25.000000000 -0700
@@ -1981,7 +1981,8 @@
 static inline void
 uart_report_port(struct uart_driver *drv, struct uart_port *port)
 {
-	printk("%s%d at ", drv->dev_name, port->line);
+	printk(drv->dev_name, port->line); /* dev_name can have a "%d" in it */
+	printk(" at ");
 	switch (port->iotype) {
 	case UPIO_PORT:
 		printk("I/O 0x%x", port->iobase);

--2fHTh5uZTiUOsy+g--
