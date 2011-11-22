From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/13] tty/serial: Prevent drop of DCD on suspend for Tegra UARTs
Date: Mon, 21 Nov 2011 17:11:36 -0800
Message-ID: <1321924303-26475-6-git-send-email-gregkh@suse.de>
References: <20111122005917.GD25420@kroah.com>
 <1321924303-26475-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42082 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513Ab1KVBNK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Nov 2011 20:13:10 -0500
In-Reply-To: <1321924303-26475-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Doug Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Doug Anderson <dianders@chromium.org>

On Tegra UARTs (except UART1), the DTR / DCD / DSR lines are not
externally accessible.  Instead, the DTR line internally appears to be
looped back to be the input to the DCD and DSR lines.  The net effect
of this is that when we drop DTR (like when we suspend), we'll see DCD
drop too.  ...and when we see DCD drop, we treat that as a hangup.

In order to prevent this hangup from occurring at every sleep, we need
to force DTR to remain high on Tegra UARTs.

This patch uses the mcr_mask / mcr_force fields, which were originally
added for the kludge ALPHA_KLUDGE_MCR.  Using these fields does not
prevent us from removing ALPHA_KLUDGE_MCR--we can just remove the "if"
tests I have added and always init mcr_mask / mcr_force from the
serial8250_config.

NOTE: If we have people that are using UARTA on a Tegra and need to
control DTR, we'll need to either add a separate port type for UARTA
or we'll need to add some tegra-specific code to detect whether the
DTR needs to be left high.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250.c |   14 ++++++++++++++
 drivers/tty/serial/8250.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index eeadf1b..2b0a4b6 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -308,6 +308,8 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 |
 				  UART_FCR_T_TRIG_01,
 		.flags		= UART_CAP_FIFO | UART_CAP_RTOIE,
+		.mcr_mask	= ~UART_MCR_DTR,
+		.mcr_force	= UART_MCR_DTR,
 	},
 	[PORT_XR17D15X] = {
 		.name		= "XR17D15X",
@@ -1229,6 +1231,10 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	up->port.fifosize = uart_config[up->port.type].fifo_size;
 	up->capabilities = uart_config[up->port.type].flags;
 	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
+	if (!ALPHA_KLUDGE_MCR) {
+		up->mcr_mask = uart_config[up->port.type].mcr_mask;
+		up->mcr_force = uart_config[up->port.type].mcr_force;
+	}
 
 	if (up->port.type == PORT_UNKNOWN)
 		goto out;
@@ -1987,6 +1993,10 @@ static int serial8250_startup(struct uart_port *port)
 	up->port.fifosize = uart_config[up->port.type].fifo_size;
 	up->tx_loadsz = uart_config[up->port.type].tx_loadsz;
 	up->capabilities = uart_config[up->port.type].flags;
+	if (!ALPHA_KLUDGE_MCR) {
+		up->mcr_mask = uart_config[up->port.type].mcr_mask;
+		up->mcr_force = uart_config[up->port.type].mcr_force;
+	}
 	up->mcr = 0;
 
 	if (up->port.iotype != up->cur_iotype)
@@ -2793,6 +2803,10 @@ serial8250_init_fixed_type_port(struct uart_8250_port *up, unsigned int type)
 	up->port.fifosize = uart_config[type].fifo_size;
 	up->capabilities = uart_config[type].flags;
 	up->tx_loadsz = uart_config[type].tx_loadsz;
+	if (!ALPHA_KLUDGE_MCR) {
+		up->mcr_mask = uart_config[type].mcr_mask;
+		up->mcr_force = uart_config[type].mcr_force;
+	}
 }
 
 static void __init
diff --git a/drivers/tty/serial/8250.h b/drivers/tty/serial/8250.h
index 6edf4a6..1f75100 100644
--- a/drivers/tty/serial/8250.h
+++ b/drivers/tty/serial/8250.h
@@ -35,6 +35,8 @@ struct serial8250_config {
 	unsigned short	tx_loadsz;
 	unsigned char	fcr;
 	unsigned int	flags;
+	unsigned char	mcr_mask;
+	unsigned char	mcr_force;
 };
 
 #define UART_CAP_FIFO	(1 << 8)	/* UART has FIFO */
-- 
1.7.7.3

