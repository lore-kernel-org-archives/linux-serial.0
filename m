From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 11/45] tty: serial: msm_serial: avoid system lockup condition
Date: Fri, 19 Jul 2019 00:12:30 -0400
Message-ID: <20190719041304.18849-11-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

[ Upstream commit ba3684f99f1b25d2a30b6956d02d339d7acb9799 ]

The function msm_wait_for_xmitr can be taken with interrupts
disabled. In order to avoid a potential system lockup - demonstrated
under stress testing conditions on SoC QCS404/5 - make sure we wait
for a bounded amount of time.

Tested on SoC QCS404.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/msm_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7dc8272c6b15..9027455c6be1 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -391,10 +391,14 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
+	unsigned int timeout = 500000;
+
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
 		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
 			break;
 		udelay(1);
+		if (!timeout--)
+			break;
 	}
 	msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
 }
-- 
2.20.1
