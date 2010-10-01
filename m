From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH 8/8] altera_uart: Don't use plain integer as NULL pointer
Date: Fri, 1 Oct 2010 17:23:13 +0400
Message-ID: <20101001132313.GH25897@oksana.dev.rtsoft.ru>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fixes sparse warning.

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
 drivers/serial/altera_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/altera_uart.c b/drivers/serial/altera_uart.c
index 304181c..f50097e 100644
--- a/drivers/serial/altera_uart.c
+++ b/drivers/serial/altera_uart.c
@@ -460,7 +460,7 @@ static int __init altera_uart_console_setup(struct console *co, char *options)
 	if (co->index < 0 || co->index >= CONFIG_SERIAL_ALTERA_UART_MAXPORTS)
 		return -EINVAL;
 	port = &altera_uart_ports[co->index].port;
-	if (port->membase == 0)
+	if (!port->membase)
 		return -ENODEV;
 
 	if (options)
-- 
1.7.0.5
