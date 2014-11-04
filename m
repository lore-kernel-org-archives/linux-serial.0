From: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
Subject: [PATCH v2] serial: 8250_dw: get index of serial line from DT aliases
Date: Tue,  4 Nov 2014 11:45:55 +0100
Message-ID: <1415097955-31966-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1414681129-10578-1-git-send-email-julien.chauveau@neo-technologies.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414681129-10578-1-git-send-email-julien.chauveau@neo-technologies.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
List-Id: linux-serial@vger.kernel.org

Get index of serial line from device tree using function of_alias_get_id().
If no alias is found, the 8250 core takes care of incrementing the line number.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
Changes since v1:
- use int type to get the value from of_alias_get_id (fix always true condition)

 drivers/tty/serial/8250/8250_dw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index beea6ca..d96fc78 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -258,6 +258,7 @@ static int dw8250_probe_of(struct uart_port *p,
 	struct uart_8250_port *up = up_to_u8250p(p);
 	u32			val;
 	bool has_ucv = true;
+	int id;
 
 	if (of_device_is_compatible(np, "cavium,octeon-3860-uart")) {
 #ifdef __BIG_ENDIAN
@@ -293,6 +294,11 @@ static int dw8250_probe_of(struct uart_port *p,
 	if (!of_property_read_u32(np, "reg-shift", &val))
 		p->regshift = val;
 
+	/* get index of serial line, if found in DT aliases */
+	id = of_alias_get_id(np, "serial");
+	if (id >= 0)
+		p->line = id;
+
 	/* clock got configured through clk api, all done */
 	if (p->uartclk)
 		return 0;
-- 
2.1.0
