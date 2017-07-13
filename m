From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 2/9] serial: stm32: fix multi-ports management
Date: Thu, 13 Jul 2017 15:08:27 +0000
Message-ID: <1499958494-19354-3-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Gerald Baeza <gerald.baeza@st.com>

Correct management of multi-ports. Each port has
its own last residue value and its own alias.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 12 +++++++-----
 drivers/tty/serial/stm32-usart.h |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ebc49e4..a12d79c 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -111,14 +111,13 @@ static void stm32_receive_chars(struct uart_port *port, bool threaded)
 	unsigned long c;
 	u32 sr;
 	char flag;
-	static int last_res = RX_BUF_L;
 
 	if (port->irq_wake)
 		pm_wakeup_event(tport->tty->dev, 0);
 
-	while (stm32_pending_rx(port, &sr, &last_res, threaded)) {
+	while (stm32_pending_rx(port, &sr, &stm32_port->last_res, threaded)) {
 		sr |= USART_SR_DUMMY_RX;
-		c = stm32_get_char(port, &sr, &last_res);
+		c = stm32_get_char(port, &sr, &stm32_port->last_res);
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
@@ -694,8 +693,10 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 		return NULL;
 
 	id = of_alias_get_id(np, "serial");
-	if (id < 0)
-		id = 0;
+	if (id < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", id);
+		return NULL;
+	}
 
 	if (WARN_ON(id >= STM32_MAX_PORTS))
 		return NULL;
@@ -703,6 +704,7 @@ static struct stm32_port *stm32_of_get_stm32_port(struct platform_device *pdev)
 	stm32_ports[id].hw_flow_control = of_property_read_bool(np,
 							"st,hw-flow-ctrl");
 	stm32_ports[id].port.line = id;
+	stm32_ports[id].last_res = RX_BUF_L;
 	return &stm32_ports[id];
 }
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 0532b2f..65b4ffa 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -222,6 +222,7 @@ struct stm32_port {
 	struct dma_chan *tx_ch;  /* dma tx channel            */
 	dma_addr_t tx_dma_buf;   /* dma tx buffer bus address */
 	unsigned char *tx_buf;   /* dma tx buffer cpu address */
+	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
 };
-- 
1.9.1
