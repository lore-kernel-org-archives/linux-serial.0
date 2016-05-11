From: Pramod Gurav <pramod.gurav@linaro.org>
Subject: [PATCH] tty: serial: msm: Remove duplicate handling of clocks
Date: Wed, 11 May 2016 14:30:29 +0530
Message-ID: <1462957229-17567-1-git-send-email-pramod.gurav@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, andy.gross@linaro.org, gregkh@linuxfoundation.org, davidb@codeaurora.org, jslaby@suse.com
Cc: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

msm_serial driver provides a .pm callback to the serial core to enable
and disable clock resource in suspend/resume path. This function is
also called before msm_startup. msm_startup also enables the clocks which
is not needed. Hence remove the duplcate clock operation from msm_startup
and msm_shutdown. Same is done in console setup to get rid of duplicate
clock operation.

Tested on DB410C console.

Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index dcde955..73c3217 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -959,15 +959,6 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 	return baud;
 }
 
-static void msm_init_clock(struct uart_port *port)
-{
-	struct msm_port *msm_port = UART_TO_MSM(port);
-
-	clk_prepare_enable(msm_port->clk);
-	clk_prepare_enable(msm_port->pclk);
-	msm_serial_set_mnd_regs(port);
-}
-
 static int msm_startup(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
@@ -982,7 +973,7 @@ static int msm_startup(struct uart_port *port)
 	if (unlikely(ret))
 		return ret;
 
-	msm_init_clock(port);
+	msm_serial_set_mnd_regs(port);
 
 	if (likely(port->fifosize > 12))
 		rfr_level = port->fifosize - 12;
@@ -1021,8 +1012,6 @@ static void msm_shutdown(struct uart_port *port)
 	if (msm_port->is_uartdm)
 		msm_release_dma(msm_port);
 
-	clk_disable_unprepare(msm_port->clk);
-
 	free_irq(port->irq, port);
 }
 
@@ -1451,7 +1440,7 @@ static int __init msm_console_setup(struct console *co, char *options)
 	if (unlikely(!port->membase))
 		return -ENXIO;
 
-	msm_init_clock(port);
+	msm_serial_set_mnd_regs(port);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-- 
1.8.2.1
