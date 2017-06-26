From: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 20/20] serial: stm32: fix rx interrupt handling in startup
Date: Mon, 26 Jun 2017 12:49:17 +0000
Message-ID: <1498481318-1894-21-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>

When stm32 dma is used, Data register has to be read in order
to clear the RXNE interrupt in case we received data before
usart probe.

Signed-off-by: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>
---
 drivers/tty/serial/stm32-usart.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 06a92c8..b1f3aab 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -568,9 +568,18 @@ static int stm32_startup(struct uart_port *port)
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	const char *name = to_platform_device(port->dev)->name;
-	u32 val;
+	u32 val, sr, dr;
 	int ret;
 
+	sr = readl_relaxed(port->membase + ofs->isr);
+
+	if ((sr & USART_SR_RXNE) && (stm32_port->rx_ch))
+		ret = readl_relaxed_poll_timeout_atomic(port->membase +
+							ofs->rdr,
+							dr,
+							!(sr & USART_SR_RXNE),
+							10, 100000);
+
 	ret = request_threaded_irq(port->irq, stm32_interrupt,
 				   stm32_threaded_interrupt,
 				   IRQF_NO_SUSPEND, name, port);
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
