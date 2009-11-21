From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [RFC PATCH 5/9] Serial: sc26xx - refactor register access
Date: Sat, 21 Nov 2009 14:40:11 +0100
Message-ID: <20091121134011.16090.14636.stgit@srv002.fuzzey.net>
References: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755000AbZKUNkP@vger.kernel.org>
In-Reply-To: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Sender: linux-kernel-owner@vger.kernel.org
To: tsbogend@alpha.franken.de, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add line number based register accessor functions.
Add command function which implements the inter command
delay required by datasheet.

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/serial/sc26xx.c |   44 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/sc26xx.c b/drivers/serial/sc26xx.c
index dc47d4f..1b47443 100644
--- a/drivers/serial/sc26xx.c
+++ b/drivers/serial/sc26xx.c
@@ -102,19 +102,45 @@ static struct uart_sc26xx_port *driver_info(struct uart_port *port)
 }
 
 /* access port register */
+static inline u8 read_sc_line(struct uart_port *p, int line, u8 reg)
+{
+	return readb(p->membase + line * 0x20 + reg);
+}
+
 static inline u8 read_sc_port(struct uart_port *p, u8 reg)
 {
-	return readb(p->membase + p->line * 0x20 + reg);
+	return read_sc_line(p, p->line, reg);
+}
+
+static inline void write_sc_line(struct uart_port *p, int line, u8 reg, u8 val)
+{
+	writeb(val, p->membase + line * 0x20 + reg);
 }
 
 static inline void write_sc_port(struct uart_port *p, u8 reg, u8 val)
 {
-	writeb(val, p->membase + p->line * 0x20 + reg);
+	write_sc_line(p, p->line, reg, val);
 }
 
 #define READ_SC_PORT(p, r)     read_sc_port(p, RD_PORT_##r)
 #define WRITE_SC_PORT(p, r, v) write_sc_port(p, WR_PORT_##r, v)
 
+static void write_cmd_line(struct uart_port *port, int line, u8 cmd)
+{
+	int i;
+
+	write_sc_line(port, line, WR_PORT_CR, cmd);
+
+	/* According to data sheet require 3 NOPs before next command */
+	for (i = 0; i < 3; i++)
+		write_sc_line(port, line, WR_PORT_CR, 0);
+}
+
+static inline void write_cmd_port(struct uart_port *port, u8 cmd)
+{
+	write_cmd_line(port, port->line, cmd);
+}
+
 static void sc26xx_enable_irq(struct uart_port *port, int mask)
 {
 	struct uart_sc26xx_port *up = driver_info(port);
@@ -337,9 +363,9 @@ static void sc26xx_enable_ms(struct uart_port *port)
 static void sc26xx_break_ctl(struct uart_port *port, int break_state)
 {
 	if (break_state == -1)
-		WRITE_SC_PORT(port, CR, CR_STRT_BRK);
+		write_cmd_port(port, CR_STRT_BRK);
 	else
-		WRITE_SC_PORT(port, CR, CR_STOP_BRK);
+		write_cmd_port(port, CR_STOP_BRK);
 }
 
 /* port->lock is not held.  */
@@ -349,8 +375,8 @@ static int sc26xx_startup(struct uart_port *port)
 	WRITE_SC(port, OPCR, 0);
 
 	/* reset tx and rx */
-	WRITE_SC_PORT(port, CR, CR_RES_RX);
-	WRITE_SC_PORT(port, CR, CR_RES_TX);
+	write_cmd_port(port, CR_RES_RX);
+	write_cmd_port(port, CR_RES_TX);
 
 	/* start rx/tx */
 	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
@@ -464,7 +490,7 @@ static void sc26xx_set_termios(struct uart_port *port, struct ktermios *termios,
 		break;
 	}
 
-	WRITE_SC_PORT(port, CR, CR_RES_MR);
+	write_cmd_port(port, CR_RES_MR);
 	WRITE_SC_PORT(port, MRx, mr1);
 	WRITE_SC_PORT(port, MRx, mr2);
 
@@ -472,8 +498,8 @@ static void sc26xx_set_termios(struct uart_port *port, struct ktermios *termios,
 	WRITE_SC_PORT(port, CSR, csr);
 
 	/* reset tx and rx */
-	WRITE_SC_PORT(port, CR, CR_RES_RX);
-	WRITE_SC_PORT(port, CR, CR_RES_TX);
+	write_cmd_port(port, CR_RES_RX);
+	write_cmd_port(port, CR_RES_TX);
 
 	WRITE_SC_PORT(port, CR, CR_ENA_TX | CR_ENA_RX);
 	while ((READ_SC_PORT(port, SR) & ((1 << 3) | (1 << 2))) != 0xc)
