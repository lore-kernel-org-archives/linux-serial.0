From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
Date: Wed,  6 Jun 2018 11:49:40 +0200
Message-ID: <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: matwey.kornilov@gmail.com, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

em485 gets lost during serial8250_register_8250_port().

Copy em485 to final uart port.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..c8c2b260c681 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -994,6 +994,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.rs485_config	= up->port.rs485_config;
 		uart->port.rs485	= up->port.rs485;
 		uart->dma		= up->dma;
+		uart->em485		= up->em485;
 
 		/* Take tx_loadsz from fifosize if it wasn't set separately */
 		if (uart->port.fifosize && !uart->tx_loadsz)
-- 
2.17.1
