From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH 1/5] tty: serial: msm: remove braces {} in msm_serial.c
Date: Tue,  5 Aug 2014 13:21:59 +0530
Message-ID: <1407225124-25074-2-git-send-email-kiran.padwal@smartplayin.com>
References: <1407225124-25074-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1407225124-25074-1-git-send-email-kiran.padwal@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: davidb@codeaurora.org
Cc: dwalker@fifo99.com, bryanh@codeaurora.org, sboyd@codeaurora.org, gregkh@linuxfoundation.org, jslaby@suse.cz, kiran.padwal@smartplayin.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

fixed below checkpatch.pl warning:

WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/tty/serial/msm_serial.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 0da0b54..6c7300b 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -190,11 +190,10 @@ static void handle_rx(struct uart_port *port)
 		/* Mask conditions we're ignorning. */
 		sr &= port->read_status_mask;
 
-		if (sr & UART_SR_RX_BREAK) {
+		if (sr & UART_SR_RX_BREAK)
 			flag = TTY_BREAK;
-		} else if (sr & UART_SR_PAR_FRAME_ERR) {
+		else if (sr & UART_SR_PAR_FRAME_ERR)
 			flag = TTY_FRAME;
-		}
 
 		if (!uart_handle_sysrq_char(port, c))
 			tty_insert_flip_char(tport, c, flag);
-- 
1.7.9.5
