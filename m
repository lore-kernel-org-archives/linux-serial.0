From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] serial: 8250: don't bind to SMSC IrCC IR port
Date: Sun, 02 Aug 2015 23:11:52 +0200
Message-ID: <55BE8798.40302@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

SMSC IrCC SIR/FIR port should not be bound to by
(legacy) serial driver so its own driver (smsc-ircc2)
can bind to it.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/tty/serial/8250/8250_pnp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 50a09cd..61fd3d3 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -364,6 +364,11 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	/* Winbond CIR port, should not be probed. We should keep track
 	   of it to prevent the legacy serial driver from probing it */
 	{	"WEC1022",		CIR_PORT	},
+	/*
+	 * SMSC IrCC SIR/FIR port, should not be probed by serial driver
+	 * as well so its own driver can bind to it.
+	 */
+	{	"SMCF010",		CIR_PORT	},
 	{	"",			0	}
 };
 
