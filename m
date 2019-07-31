From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 09/23] tty: serial: fsl_lpuart: Drop no-op bit opearation
Date: Wed, 31 Jul 2019 10:30:31 -0700
Message-ID: <20190731173045.11718-10-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The check for termios->c_cflag & CRTSCTS ensure that if we reach else
branch, CRTSCTS in termios->c_cflag is already going to be
cleard. Doing so explicitly there is not necessary. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-imx@nxp.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/fsl_lpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ed6d3f836c93..b3cc44548b34 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1650,12 +1650,10 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (sport->port.rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
-	if (termios->c_cflag & CRTSCTS) {
+	if (termios->c_cflag & CRTSCTS)
 		modem |= (UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-	} else {
-		termios->c_cflag &= ~CRTSCTS;
+	else
 		modem &= ~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-	}
 
 	if (termios->c_cflag & CSTOPB)
 		termios->c_cflag &= ~CSTOPB;
-- 
2.21.0
