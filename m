From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 2/4] serial: 8250: Copy mctrl when register port.
Date: Wed,  6 Jun 2018 11:49:37 +0200
Message-ID: <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: matwey.kornilov@gmail.com, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

RS485 can modify mctrl on startup, especially when RTS_AFTER_SEND is on
TIOCM_RTS is set, then need to keep it set when registering port.

Copy mctrl to new port too.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index c8c2b260c681..c8e62fbd6570 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -993,6 +993,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.unthrottle	= up->port.unthrottle;
 		uart->port.rs485_config	= up->port.rs485_config;
 		uart->port.rs485	= up->port.rs485;
+		uart->port.mctrl	= up->port.mctrl;
 		uart->dma		= up->dma;
 		uart->em485		= up->em485;
 
-- 
2.17.1
