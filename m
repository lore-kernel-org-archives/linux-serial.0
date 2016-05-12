From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 2/3] tty: serial: msm: Only configure MND registers on hw that has it
Date: Wed, 11 May 2016 18:02:27 -0700
Message-ID: <20160512010228.21548-3-sboyd@codeaurora.org>
References: <20160512010228.21548-1-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160512010228.21548-1-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

The registers that msm_serial_set_mnd_regs() writes only exist on
the non-uartdm hardware, so let's return early here if this
function is called on uartdm hardware. This also prevents us from
messing up the uartclk variable if the uartclk rate happens to be
19.2 or 4.8 MHz.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 28b8ac423de1..a051dc5def24 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -232,6 +232,15 @@ static void msm_serial_set_mnd_regs_tcxoby4(struct uart_port *port)
 
 static void msm_serial_set_mnd_regs(struct uart_port *port)
 {
+	struct msm_port *msm_port = UART_TO_MSM(port);
+
+	/*
+	 * These registers don't exist so we change the clk input rate
+	 * on uartdm hardware instead
+	 */
+	if (msm_port->is_uartdm)
+		return;
+
 	if (port->uartclk == 19200000)
 		msm_serial_set_mnd_regs_tcxo(port);
 	else if (port->uartclk == 4800000)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
