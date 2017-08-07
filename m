From: Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] tty: serial: msm: Move request_irq to the end of startup
Date: Mon,  7 Aug 2017 11:51:25 +0530
Message-ID: <1502086885-8390-1-git-send-email-neeraju@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, sramana@codeaurora.org, Neeraj Upadhyay <neeraju@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Move the request_irq() call to the end of the msm_startup(),
so that we don't handle interrupts while msm_startup() is
running. This avoids potential races while initialization
is in progress. For example, consider below scenario
where rx handler reads the intermediate value of dma->chan,
set in msm_request_rx_dma(), and tries to do dma mapping,
which results in data abort.

uart_port_startup()
  msm_startup()
   request_irq()
   ...
   msm_request_rx_dma()
    ...
    dma->chan = dma_request_slave_channel_reason(dev, "rx");
    <UART RX IRQ>
     msm_uart_irq()
      msm_handle_rx_dm()
       msm_start_rx_dma()
        dma->desc = dma_map_single()
         <data abort>

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 6788e75..1db79ee 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1175,11 +1175,6 @@ static int msm_startup(struct uart_port *port)
 	snprintf(msm_port->name, sizeof(msm_port->name),
 		 "msm_serial%d", port->line);
 
-	ret = request_irq(port->irq, msm_uart_irq, IRQF_TRIGGER_HIGH,
-			  msm_port->name, port);
-	if (unlikely(ret))
-		return ret;
-
 	msm_init_clock(port);
 
 	if (likely(port->fifosize > 12))
@@ -1206,7 +1201,21 @@ static int msm_startup(struct uart_port *port)
 		msm_request_rx_dma(msm_port, msm_port->uart.mapbase);
 	}
 
+	ret = request_irq(port->irq, msm_uart_irq, IRQF_TRIGGER_HIGH,
+			  msm_port->name, port);
+	if (unlikely(ret))
+		goto err_irq;
+
 	return 0;
+
+err_irq:
+	if (msm_port->is_uartdm)
+		msm_release_dma(msm_port);
+
+	clk_disable_unprepare(msm_port->pclk);
+	clk_disable_unprepare(msm_port->clk);
+
+	return ret;
 }
 
 static void msm_shutdown(struct uart_port *port)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
