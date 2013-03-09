From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] tty: serial: mpc5xxx: fix PSC clock name bug
Date: Sat,  9 Mar 2013 12:43:54 +0100
Message-ID: <1362829434-1274-1-git-send-email-agust@denx.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:50605 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756804Ab3CILnz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 9 Mar 2013 06:43:55 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Anatolij Gustschin <agust@denx.de>

mpc512x platform clock code names PSC clocks as "pscX_mclk" but
the driver tries to get "pscX_clk" clock and this results in
errors like:

  mpc52xx-psc-uart 80011700.psc: Failed to get PSC clock entry!

The problem appears when opening ttyPSC devices other than the
system's serial console. Since getting and enabling the PSC clock
fails, uart port startup doesn't succeed and tty flag TTY_IO_ERROR
remains set causing further errors in tty ioctls, i.e.
'strace stty -F /dev/ttyPSC1' shows:

open("/dev/ttyPSC1", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
dup2(3, 0)                              = 0
close(3)                                = 0
fcntl64(0, F_GETFL)                     = 0x10800 (flags O_RDONLY|O_NONBLOCK|O_LARGEFILE)
fcntl64(0, F_SETFL, O_RDONLY|O_LARGEFILE) = 0
ioctl(0, TCGETS, 0xbff89038)            = -1 EIO (Input/output error)

Only request PSC clock names that the platform actually provides.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/tty/serial/mpc52xx_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index c0e1fad..018bad9 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -550,7 +550,7 @@ static int mpc512x_psc_clock(struct uart_port *port, int enable)
 		return 0;
 
 	psc_num = (port->mapbase & 0xf00) >> 8;
-	snprintf(clk_name, sizeof(clk_name), "psc%d_clk", psc_num);
+	snprintf(clk_name, sizeof(clk_name), "psc%d_mclk", psc_num);
 	psc_clk = clk_get(port->dev, clk_name);
 	if (IS_ERR(psc_clk)) {
 		dev_err(port->dev, "Failed to get PSC clock entry!\n");
-- 
1.7.5.4

