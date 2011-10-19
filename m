From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] tty/serial: atmel_serial: bootconsole removed from
	auto-enumerates
Date: Wed, 19 Oct 2011 11:36:20 +0200
Message-ID: <1319016980-10355-1-git-send-email-nicolas.ferre@atmel.com>
References: <1318981651741@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318981651741@kroah.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, gregkh@suse.de
Cc: grant.likely@secretlab.ca, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Auto-enumerate mechanism conflicts with bootconsoles: remove
the usage counter for this type of consoles.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 30d8c77..9988c0c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1676,7 +1676,6 @@ static int __init atmel_console_init(void)
 		int id = pdata->num;
 		struct atmel_uart_port *port = &atmel_ports[id];
 
-		set_bit(id, &atmel_ports_in_use);
 		port->backup_imr = 0;
 		port->uart.line = id;
 
-- 
1.7.5.4
