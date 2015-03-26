From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 2/6] tty: serial: atmel: use atmel_io.h to provide on-chip IO
Date: Thu, 26 Mar 2015 11:45:50 +0000
Message-ID: <1427370354-21247-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@lists.codethink.co.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, nicolas.ferre@atmel.com, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, hskinnemoen@gmail.com, Jiri Slaby <jslaby@suse.cz>, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, egtvedt@samfundet.no
List-Id: linux-serial@vger.kernel.org

Use <linux/atmel_io.h> to provide IO accessors which work on both
AVR32 and ARM for on-chip peripherals.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.cz>
CC: linux-serial@vger.kernel.org
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
---
 drivers/tty/serial/atmel_serial.c | 63 +++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 40ef95f..eed0700 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -38,6 +38,7 @@
 #include <linux/of_gpio.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/atmel_io.h>
 #include <linux/atmel_pdc.h>
 #include <linux/atmel_serial.h>
 #include <linux/uaccess.h>
@@ -88,44 +89,36 @@ static void atmel_stop_rx(struct uart_port *port);
 
 #define ATMEL_ISR_PASS_LIMIT	256
 
-#ifdef CONFIG_AVR32
-#define __atserial_writel	__raw_writel
-#define __atserial_readl	__raw_readl
-#else
-#define __atserial_writel	writel_relaxed
-#define __atserial_readl	readl_relaxed
-#endif
-
 /* UART registers. CR is write-only, hence no GET macro */
-#define UART_PUT_CR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_US_CR)
-#define UART_GET_MR(port)	__atserial_readl((port)->membase + ATMEL_US_MR)
-#define UART_PUT_MR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_US_MR)
-#define UART_PUT_IER(port,v)	__atserial_writel(v, (port)->membase + ATMEL_US_IER)
-#define UART_PUT_IDR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_US_IDR)
-#define UART_GET_IMR(port)	__atserial_readl((port)->membase + ATMEL_US_IMR)
-#define UART_GET_CSR(port)	__atserial_readl((port)->membase + ATMEL_US_CSR)
-#define UART_GET_CHAR(port)	__atserial_readl((port)->membase + ATMEL_US_RHR)
-#define UART_PUT_CHAR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_US_THR)
-#define UART_GET_BRGR(port)	__atserial_readl((port)->membase + ATMEL_US_BRGR)
-#define UART_PUT_BRGR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_US_BRGR)
-#define UART_PUT_RTOR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_US_RTOR)
-#define UART_PUT_TTGR(port, v)	__atserial_writel(v, (port)->membase + ATMEL_US_TTGR)
-#define UART_GET_IP_NAME(port)	__atserial_readl((port)->membase + ATMEL_US_NAME)
-#define UART_GET_IP_VERSION(port) __atserial_readl((port)->membase + ATMEL_US_VERSION)
+#define UART_PUT_CR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_CR)
+#define UART_GET_MR(port)	atmel_oc_readl((port)->membase + ATMEL_US_MR)
+#define UART_PUT_MR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_MR)
+#define UART_PUT_IER(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_IER)
+#define UART_PUT_IDR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_IDR)
+#define UART_GET_IMR(port)	atmel_oc_readl((port)->membase + ATMEL_US_IMR)
+#define UART_GET_CSR(port)	atmel_oc_readl((port)->membase + ATMEL_US_CSR)
+#define UART_GET_CHAR(port)	atmel_oc_readl((port)->membase + ATMEL_US_RHR)
+#define UART_PUT_CHAR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_THR)
+#define UART_GET_BRGR(port)	atmel_oc_readl((port)->membase + ATMEL_US_BRGR)
+#define UART_PUT_BRGR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_BRGR)
+#define UART_PUT_RTOR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_RTOR)
+#define UART_PUT_TTGR(port, v)	atmel_oc_writel(v, (port)->membase + ATMEL_US_TTGR)
+#define UART_GET_IP_NAME(port)	atmel_oc_readl((port)->membase + ATMEL_US_NAME)
+#define UART_GET_IP_VERSION(port) atmel_oc_readl((port)->membase + ATMEL_US_VERSION)
 
  /* PDC registers */
-#define UART_PUT_PTCR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_PDC_PTCR)
-#define UART_GET_PTSR(port)	__atserial_readl((port)->membase + ATMEL_PDC_PTSR)
-
-#define UART_PUT_RPR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_PDC_RPR)
-#define UART_GET_RPR(port)	__atserial_readl((port)->membase + ATMEL_PDC_RPR)
-#define UART_PUT_RCR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_PDC_RCR)
-#define UART_PUT_RNPR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_PDC_RNPR)
-#define UART_PUT_RNCR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_PDC_RNCR)
-
-#define UART_PUT_TPR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_PDC_TPR)
-#define UART_PUT_TCR(port,v)	__atserial_writel(v, (port)->membase + ATMEL_PDC_TCR)
-#define UART_GET_TCR(port)	__atserial_readl((port)->membase + ATMEL_PDC_TCR)
+#define UART_PUT_PTCR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_PDC_PTCR)
+#define UART_GET_PTSR(port)	atmel_oc_readl((port)->membase + ATMEL_PDC_PTSR)
+
+#define UART_PUT_RPR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_PDC_RPR)
+#define UART_GET_RPR(port)	atmel_oc_readl((port)->membase + ATMEL_PDC_RPR)
+#define UART_PUT_RCR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_PDC_RCR)
+#define UART_PUT_RNPR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_PDC_RNPR)
+#define UART_PUT_RNCR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_PDC_RNCR)
+
+#define UART_PUT_TPR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_PDC_TPR)
+#define UART_PUT_TCR(port,v)	atmel_oc_writel(v, (port)->membase + ATMEL_PDC_TCR)
+#define UART_GET_TCR(port)	atmel_oc_readl((port)->membase + ATMEL_PDC_TCR)
 
 struct atmel_dma_buffer {
 	unsigned char	*buf;
-- 
2.1.4
