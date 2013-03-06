From: Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 28/31] serial: ns16550: Remove unwanted cast
Date: Tue,  5 Mar 2013 16:40:02 -0800
Message-ID: <1362530405-10824-29-git-send-email-sjg@chromium.org>
References: <1362530405-10824-1-git-send-email-sjg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <u-boot-bounces@lists.denx.de>
In-Reply-To: <1362530405-10824-1-git-send-email-sjg@chromium.org>
List-Unsubscribe: <http://lists.denx.de/mailman/options/u-boot>,
	<mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <http://lists.denx.de/pipermail/u-boot>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <http://lists.denx.de/mailman/listinfo/u-boot>,
	<mailto:u-boot-request@lists.denx.de?subject=subscribe>
Sender: u-boot-bounces@lists.denx.de
Errors-To: u-boot-bounces@lists.denx.de
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Graeme Russ <graeme.russ@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Tom Rini <trini@ti.com>, Vadim Bendebury <vbendeb@chromium.org>
List-Id: linux-serial@vger.kernel.org

This cast does not seem correct, since we should be writing to a pointer,
not a ulong.

This fixes the following warning on nds32:

-ns16550.c:49: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v6:
- Add new patch to fix up ns16550 cast

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/serial/ns16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 87a0917..b2da8b3 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -46,7 +46,7 @@ void NS16550_init(NS16550_t com_port, int baud_divisor)
 					defined(CONFIG_AM33XX)
 	serial_out(0x7, &com_port->mdr1);	/* mode select reset TL16C750*/
 #endif
-	serial_out(UART_LCR_BKSE | UART_LCRVAL, (ulong)&com_port->lcr);
+	serial_out(UART_LCR_BKSE | UART_LCRVAL, &com_port->lcr);
 	serial_out(0, &com_port->dll);
 	serial_out(0, &com_port->dlm);
 	serial_out(UART_LCRVAL, &com_port->lcr);
-- 
1.8.1.3
