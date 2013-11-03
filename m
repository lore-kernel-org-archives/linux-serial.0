From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] serial: pl011: remove redundant early amba_ports declaration
Date: Sun,  3 Nov 2013 18:38:12 +0200
Message-ID: <d4b3369bcc83cb33275661041faab1815775ceec.1383496607.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Baruch Siach <baruch@tkos.co.il>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This early amba_ports declaration was introduced by commit c16d51a32 (amba
pl011: workaround for uart registers lockup) for use in the pl011_lockup_wa()
routine. This routine was later removed by commit 4fd0690bb (serial: pl011:
implement workaround for CTS clear event issue).

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/tty/serial/amba-pl011.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index aaa2286..4a50d92 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -112,8 +112,6 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
-static struct uart_amba_port *amba_ports[UART_NR];
-
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
-- 
1.8.4.rc3
