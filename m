From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [RFC PATCH] tty: serial: msm_serial: Don't reset uart on set_termios
Date: Mon, 13 Jun 2016 12:02:51 -0700
Message-ID: <1465844571-1229-1-git-send-email-bjorn.andersson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, David Brown <david.brown@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Upon opening the tty, uart_open() ends up calling msm_set_baud_rate()
which resets the uart block. If this happens as we're coming out of
msm_console_write() a full fifo worth of console output will be
discarded.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

As reported here:
https://bugs.96boards.org/show_bug.cgi?id=378

 drivers/tty/serial/msm_serial.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b7d80bd57db9..93a10ac44933 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -813,23 +813,6 @@ static unsigned int msm_get_mctrl(struct uart_port *port)
 	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR | TIOCM_RTS;
 }
 
-static void msm_reset(struct uart_port *port)
-{
-	struct msm_port *msm_port = UART_TO_MSM(port);
-
-	/* reset everything */
-	msm_write(port, UART_CR_CMD_RESET_RX, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_TX, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_ERR, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_BREAK_INT, UART_CR);
-	msm_write(port, UART_CR_CMD_RESET_CTS, UART_CR);
-	msm_write(port, UART_CR_CMD_SET_RFR, UART_CR);
-
-	/* Disable DM modes */
-	if (msm_port->is_uartdm)
-		msm_write(port, 0, UARTDM_DMEN);
-}
-
 static void msm_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	unsigned int mr;
@@ -972,7 +955,6 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 	msm_write(port, 10, UART_TFWR);
 
 	msm_write(port, UART_CR_CMD_PROTECTION_EN, UART_CR);
-	msm_reset(port);
 
 	/* Enable RX and TX */
 	msm_write(port, UART_CR_TX_ENABLE | UART_CR_RX_ENABLE, UART_CR);
-- 
2.5.0
