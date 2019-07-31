From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 06/23] tty: serial: fsl_lpuart: Drop unnecessary uart_write_wakeup()
Date: Wed, 31 Jul 2019 10:30:28 -0700
Message-ID: <20190731173045.11718-7-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Uart_write_wakeup() will already be called as a part of
lpuart*_transmit_buffer() call, so there doesn't seem to be a reason
to call it again right after.

It also appears that second uart_write_wakeup() might potentially
cause unwanted write wakeup when transmitting an x_char. See commit
5e42e9a30cda ("serial: imx: Fix x_char handling and tx flow control")
where this problem was fixed in a very similarly structured i.MX UART
driver.

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
 drivers/tty/serial/fsl_lpuart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 57c5825f5de7..c35f81df0cff 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -798,9 +798,6 @@ static void lpuart_txint(struct lpuart_port *sport)
 	else
 		lpuart_transmit_buffer(sport);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
-- 
2.21.0
