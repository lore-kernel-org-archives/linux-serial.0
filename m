From: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
Subject: [PATCH] serial: 8250_dw: get index of serial line from DT aliases
Date: Thu, 30 Oct 2014 15:58:49 +0100
Message-ID: <1414681129-10578-1-git-send-email-julien.chauveau@neo-technologies.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
List-Id: linux-serial@vger.kernel.org

Get index of serial line from device tree using function of_alias_get_id().
If no alias is found, the 8250 core takes care of incrementing the line number.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 drivers/tty/serial/8250/8250_dw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index beea6ca..5416355 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -293,6 +293,11 @@ static int dw8250_probe_of(struct uart_port *p,
 	if (!of_property_read_u32(np, "reg-shift", &val))
 		p->regshift = val;
 
+	/* get index of serial line, if found in DT aliases */
+	val = of_alias_get_id(np, "serial");
+	if (val >= 0)
+		p->line = val;
+
 	/* clock got configured through clk api, all done */
 	if (p->uartclk)
 		return 0;
-- 
2.1.0
