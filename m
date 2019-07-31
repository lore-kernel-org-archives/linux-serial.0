From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 07/23] tty: serial: fsl_lpuart: Fix issue in software flow control
Date: Wed, 31 Jul 2019 10:30:29 -0700
Message-ID: <20190731173045.11718-8-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Although I haven't observed this bug in practice, it seems that the
code for handling x_char of LPUART is pretty much identical to that of
i.MX. So the fix found in commit 7e2fb5aa8d81 ("serial: imx: Fix issue
in software flow control"):

    serial: imx: Fix issue in software flow control

    After send out x_char in UART driver, x_char needs to be cleared
    by UART driver itself, otherwise data in TXFIFO can no longer be
    sent out.
    Also tx counter needs to be increased to keep track of correct
    number of transmitted data.

    Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

should apply here as well.

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
 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c35f81df0cff..8657addbfd1c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -782,6 +782,8 @@ static void lpuart_txint(struct lpuart_port *sport)
 			lpuart32_write(&sport->port, sport->port.x_char, UARTDATA);
 		else
 			writeb(sport->port.x_char, sport->port.membase + UARTDR);
+		sport->port.icount.tx++;
+		sport->port.x_char = 0;
 		goto out;
 	}
 
-- 
2.21.0
