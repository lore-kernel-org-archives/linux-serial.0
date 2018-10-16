From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [RESEND PATCH 08/14] serial: lantiq: Replace clk_enable/clk_disable with clk generic API
Date: Tue, 16 Oct 2018 17:19:09 +0800
Message-ID: <20181016091915.19909-9-songjun.wu@linux.intel.com>
References: <20181016091915.19909-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016091915.19909-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, hauke.mehrtens@intel.com
Cc: gregkh@linuxfoundation.org, paul.burton@mips.com, jslaby@suse.com, Songjun Wu <songjun.wu@linux.intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The clk driver has introduced new clock APIs that replace
the existing clk_enable and clk_disable.
- clk_enable() APIs is replaced with clk_prepare_enable()
- clk_disable() API is replaced with clk_disable_unprepare()

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 4acdbdf8fe7a..34b1ef3c12ce 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -308,7 +308,7 @@ lqasc_startup(struct uart_port *port)
 	int retval;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
+		clk_prepare_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
 	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
@@ -376,7 +376,7 @@ lqasc_shutdown(struct uart_port *port)
 	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
 	if (!IS_ERR(ltq_port->clk))
-		clk_disable(ltq_port->clk);
+		clk_disable_unprepare(ltq_port->clk);
 }
 
 static void
@@ -630,7 +630,7 @@ lqasc_console_setup(struct console *co, char *options)
 	port = &ltq_port->port;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
+		clk_prepare_enable(ltq_port->clk);
 
 	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
-- 
2.11.0
