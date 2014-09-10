From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 06/14] serial: bfin-uart: Fix auto CTS
Date: Wed, 10 Sep 2014 15:06:28 -0400
Message-ID: <1410375996-4693-7-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
 <1410375996-4693-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410375996-4693-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-serial@vger.kernel.org

Commit 64851636d568ae9f167cd5d1dcdbfe17e6eef73c,
serial: bfin-uart: Remove ASYNC_CTS_FLOW flag for hardware automatic CTS,
open-codes uart_handle_cts_change() when CONFIG_SERIAL_BFIN_HARD_CTSRTS
to skip start and stop tx.

But the CTS interrupt handler _still_ calls uart_handle_cts_change();
only call uart_handle_cts_change() if !CONFIG_SERIAL_BFIN_HARD_CTSRTS.

cc: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/bfin_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index fc9fbf3..7da9911 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -122,8 +122,9 @@ static irqreturn_t bfin_serial_mctrl_cts_int(int irq, void *dev_id)
 		if (!status)
 			uport->hw_stopped = 1;
 	}
-#endif
+#else
 	uart_handle_cts_change(uport, status & TIOCM_CTS);
+#endif
 
 	return IRQ_HANDLED;
 }
-- 
2.1.0
