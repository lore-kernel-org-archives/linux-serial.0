From: Ralf Baechle <ralf@linux-mips.org>
Subject: Rename Sibyte duart devices?
Date: Mon, 3 Dec 2007 13:08:18 +0000
Message-ID: <20071203130818.GA6466@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:56836 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbXLCNKV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Dec 2007 08:10:21 -0500
Received: from localhost.localdomain ([127.0.0.1]:42119 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023547AbXLCNKT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Dec 2007 13:10:19 +0000
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Devices created by udev have been named duart? instead of the common
ttyS?.  This is a nuisance because it requires changes to all sorts of
config files such as /etc/inittab, /etc/securetty etc. to work.  I
suggest to kill the problem by the root by something like the below
patch.  Comments?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/serial/sb1250-duart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/sb1250-duart.c b/drivers/serial/sb1250-duart.c
index 2d6c08b..0defbd6 100644
--- a/drivers/serial/sb1250-duart.c
+++ b/drivers/serial/sb1250-duart.c
@@ -897,7 +897,7 @@ static int __init sbd_console_setup(struct console *co, char *options)
 
 static struct uart_driver sbd_reg;
 static struct console sbd_console = {
-	.name	= "duart",
+	.name	= "ttyS",
 	.write	= sbd_console_write,
 	.device	= uart_console_device,
 	.setup	= sbd_console_setup,
@@ -925,7 +925,7 @@ console_initcall(sbd_serial_console_init);
 static struct uart_driver sbd_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "serial",
-	.dev_name	= "duart",
+	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= SB1250_DUART_MINOR_BASE,
 	.nr		= DUART_MAX_CHIP * DUART_MAX_SIDE,
