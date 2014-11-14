From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH] serial: mxs-auart: fix gpio change detection on interrupt
Date: Fri, 14 Nov 2014 23:24:33 +0100
Message-ID: <1416003873-9576-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:52585 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161920AbaKNWWV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2014 17:22:21 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, Janusz Uzycki <j.uzycki@elproma.com.pl>

mxs_auart_modem_status() did't detect gpio's state change
because s->mctrl_prev was modified before by mctrl_gpio_get().
The patch introduces mctrl_temp variable to fix the bug.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

Two patches were missed during movements between our internal repos.
The 1/2 patch is required against commits:
  f9e42397d79b ("serial: mxs-auart: add interrupts for modem control lines")
  36a262782b04 ("serial: mxs-auart: enable PPS support")
I've done build-test for the next only before.
I should have done hardware test also for the next, sorry.
Now it is tested for the next on real hardware too.

---
 drivers/tty/serial/mxs-auart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 840c1f7..c556116 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -798,6 +798,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
 	u32 istat;
 	struct mxs_auart_port *s = context;
+	u32 mctrl_temp = s->mctrl_prev;
 	u32 stat = readl(s->port.membase + AUART_STAT);
 
 	istat = readl(s->port.membase + AUART_INTR);
@@ -817,7 +818,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 	    irq == s->gpio_irq[UART_GPIO_DSR] ||
 	    irq == s->gpio_irq[UART_GPIO_RI])
 		mxs_auart_modem_status(s,
-				mctrl_gpio_get(s->gpios, &s->mctrl_prev));
+				mctrl_gpio_get(s->gpios, &mctrl_temp));
 
 	if (istat & AUART_INTR_CTSMIS) {
 		if (CTS_AT_AUART() && s->ms_irq_enabled)
-- 
1.7.11.3

