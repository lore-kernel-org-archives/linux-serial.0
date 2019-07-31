From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v2 14/23] tty: serial: fsl_lpuart: Use cpu_relax() instead of barrier()
Date: Wed, 31 Jul 2019 10:30:36 -0700
Message-ID: <20190731173045.11718-15-andrew.smirnov@gmail.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731173045.11718-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Stefan Agner <stefan@agner.ch>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use cpu_relax() instead of barrier() in a tight polling loops to make
them a bit more idiomatic. Should also improve things on ARM64 a bit
since cpu_relax() will expand into "yield" instruction there.

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
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index eb748ef85da7..58043e01a242 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -553,14 +553,14 @@ static void lpuart_wait_bit_set(struct uart_port *port, unsigned int offset,
 				u8 bit)
 {
 	while (!(readb(port->membase + offset) & bit))
-		barrier();
+		cpu_relax();
 }
 
 static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
 				  u32 bit)
 {
 	while (!(lpuart32_read(port, offset) & bit))
-		barrier();
+		cpu_relax();
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
-- 
2.21.0
