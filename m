From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH 3/4] serial: 8250_dw: Add UPF_FIXED_TYPE to flags
Date: Wed, 22 Jul 2015 12:34:58 +0300
Message-ID: <1437557699-25722-4-git-send-email-noamc@ezchip.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437557699-25722-2-git-send-email-noamc@ezchip.com>
 <1437557699-25722-3-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437557699-25722-3-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, gregkh@linuxfoundation.org, jslaby@suse.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

Always add UPF_FIXED_TYPE to flags so autoconf() will be skipped.
We do that since autoconf() performs many writes to LCR that cause
BUSY interrupt.
The problem with such interrupt is that driver is not yet called to
request_irq() and generic IRQ subsystem will mask the UART line.

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
 drivers/tty/serial/8250/8250_dw.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1a57105..620f983 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -362,6 +362,14 @@ static int dw8250_probe_of(struct uart_port *p,
 	if (has_ucv)
 		dw8250_setup_port(up);
 
+	/* Writing to LCR may cause BUSY interrupt before we
+	 * register the IRQ line.
+	 * Currently autoconf() uses several writes to LCR.
+	 * In order to avoid calling to autoconf() always add
+	 * following flag.
+	 */
+	p->flags |= UPF_FIXED_TYPE;
+
 	/* if we have a valid fifosize, try hooking up DMA here */
 	if (p->fifosize) {
 		up->dma = &data->dma;
-- 
1.7.1
