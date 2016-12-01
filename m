From: David Howells <dhowells@redhat.com>
Subject: [PATCH 32/39] Annotate hardware config module parameters in
 drivers/tty/
Date: Thu, 01 Dec 2016 12:33:54 +0000
Message-ID: <148059563433.31612.11409694377610141671.stgit@warthog.procyon.org.uk>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gnomes@lxorguk.ukuu.org.uk, minyard@acm.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in drivers/tty/.

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jslaby@suse.com>
cc: linux-serial@vger.kernel.org
---

 drivers/tty/cyclades.c              |    4 ++--
 drivers/tty/moxa.c                  |    2 +-
 drivers/tty/mxser.c                 |    2 +-
 drivers/tty/rocket.c                |   10 +++++-----
 drivers/tty/serial/8250/8250_core.c |    4 ++--
 drivers/tty/synclink.c              |    6 +++---
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 5e4fa9206861..104f09c58163 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -156,8 +156,8 @@ static unsigned int cy_isa_addresses[] = {
 static long maddr[NR_CARDS];
 static int irq[NR_CARDS];
 
-module_param_array(maddr, long, NULL, 0);
-module_param_array(irq, int, NULL, 0);
+module_param_hw_array(maddr, long, iomem, NULL, 0);
+module_param_hw_array(irq, int, irq, NULL, 0);
 
 #endif				/* CONFIG_ISA */
 
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 60d37b225589..055acf6acfc0 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -179,7 +179,7 @@ MODULE_FIRMWARE("c320tunx.cod");
 
 module_param_array(type, uint, NULL, 0);
 MODULE_PARM_DESC(type, "card type: C218=2, C320=4");
-module_param_array(baseaddr, ulong, NULL, 0);
+module_param_hw_array(baseaddr, ulong, ioport, NULL, 0);
 MODULE_PARM_DESC(baseaddr, "base address");
 module_param_array(numports, uint, NULL, 0);
 MODULE_PARM_DESC(numports, "numports (ignored for C218)");
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 69294ae154be..80770da545dd 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -183,7 +183,7 @@ static int ttymajor = MXSERMAJOR;
 
 MODULE_AUTHOR("Casper Yang");
 MODULE_DESCRIPTION("MOXA Smartio/Industio Family Multiport Board Device Driver");
-module_param_array(ioaddr, ulong, NULL, 0);
+module_param_hw_array(ioaddr, ulong, ioport, NULL, 0);
 MODULE_PARM_DESC(ioaddr, "ISA io addresses to look for a moxa board");
 module_param(ttymajor, int, 0);
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b0cc47c77b40..44f6c3383c33 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -250,15 +250,15 @@ static int sReadAiopNumChan(WordIO_t io);
 
 MODULE_AUTHOR("Theodore Ts'o");
 MODULE_DESCRIPTION("Comtrol RocketPort driver");
-module_param(board1, ulong, 0);
+module_param_hw(board1, ulong, ioport, 0);
 MODULE_PARM_DESC(board1, "I/O port for (ISA) board #1");
-module_param(board2, ulong, 0);
+module_param_hw(board2, ulong, ioport, 0);
 MODULE_PARM_DESC(board2, "I/O port for (ISA) board #2");
-module_param(board3, ulong, 0);
+module_param_hw(board3, ulong, ioport, 0);
 MODULE_PARM_DESC(board3, "I/O port for (ISA) board #3");
-module_param(board4, ulong, 0);
+module_param_hw(board4, ulong, ioport, 0);
 MODULE_PARM_DESC(board4, "I/O port for (ISA) board #4");
-module_param(controller, ulong, 0);
+module_param_hw(controller, ulong, ioport, 0);
 MODULE_PARM_DESC(controller, "I/O port for (ISA) rocketport controller");
 module_param(support_low_speed, bool, 0);
 MODULE_PARM_DESC(support_low_speed, "1 means support 50 baud, 0 means support 460400 baud");
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 240a361b674f..414af45dc16e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1188,7 +1188,7 @@ module_exit(serial8250_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
 
-module_param(share_irqs, uint, 0644);
+module_param_hw(share_irqs, uint, other, 0644);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
 
 module_param(nr_uarts, uint, 0644);
@@ -1198,7 +1198,7 @@ module_param(skip_txen_test, uint, 0644);
 MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
 
 #ifdef CONFIG_SERIAL_8250_RSA
-module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
+module_param_hw_array(probe_rsa, ulong, ioport, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
 #endif
 MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index c13e27ecb0b7..71dd598d76a0 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -869,9 +869,9 @@ static int txholdbufs[MAX_TOTAL_DEVICES];
 	
 module_param(break_on_load, bool, 0);
 module_param(ttymajor, int, 0);
-module_param_array(io, int, NULL, 0);
-module_param_array(irq, int, NULL, 0);
-module_param_array(dma, int, NULL, 0);
+module_param_hw_array(io, int, ioport, NULL, 0);
+module_param_hw_array(irq, int, irq, NULL, 0);
+module_param_hw_array(dma, int, dma, NULL, 0);
 module_param(debug_level, int, 0);
 module_param_array(maxframe, int, NULL, 0);
 module_param_array(txdmabufs, int, NULL, 0);
