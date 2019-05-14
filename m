From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 3/7] tty: max310x: Don't pass stacked buffers to SPI
Date: Tue, 14 May 2019 13:14:11 +0300
Message-ID: <20190514101415.26754-4-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

SPI transfer tx/rx buffers must be DMA-safe and the structure
documentation clearly states this. Data declared on the system stack isn't
DMA-safe [1]. Instead at least kernel memory should be used for the
buffers. In order to fix this here we can create the buffers at the device
probing stage and use them without any synchronization, since batch
read/write methods are called from non-reentrant contexts - either from
rx-event IRQ threaded handler or from the tx workqueue item.

[1] Documentation/DMA-API-HOWTO.txt

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 527f1476c24a..0e3dc89c459b 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -258,6 +258,10 @@ struct max310x_one {
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+
+	u8 wr_header;
+	u8 rd_header;
+	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
 	container_of(_port, struct max310x_one, port)
@@ -608,11 +612,11 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
-	u8 header[] = { (port->iobase + MAX310X_THR_REG) | MAX310X_WRITE_BIT };
+	struct max310x_one *one = to_max310x_port(port);
 	struct spi_transfer xfer[] = {
 		{
-			.tx_buf = &header,
-			.len = sizeof(header),
+			.tx_buf = &one->wr_header,
+			.len = sizeof(one->wr_header),
 		}, {
 			.tx_buf = txbuf,
 			.len = len,
@@ -623,11 +627,11 @@ static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
-	u8 header[] = { port->iobase + MAX310X_RHR_REG };
+	struct max310x_one *one = to_max310x_port(port);
 	struct spi_transfer xfer[] = {
 		{
-			.tx_buf = &header,
-			.len = sizeof(header),
+			.tx_buf = &one->rd_header,
+			.len = sizeof(one->rd_header),
 		}, {
 			.rx_buf = rxbuf,
 			.len = len,
@@ -638,8 +642,8 @@ static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int l
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int sts, ch, flag, i;
-	u8 buf[MAX310X_FIFO_SIZE];
 
 	if (port->read_status_mask == MAX310X_LSR_RXOVR_BIT) {
 		/* We are just reading, happily ignoring any error conditions.
@@ -654,7 +658,7 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 		 * */
 
 		sts = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
-		max310x_batch_read(port, buf, rxlen);
+		max310x_batch_read(port, one->rx_buf, rxlen);
 
 		port->icount.rx += rxlen;
 		flag = TTY_NORMAL;
@@ -666,7 +670,8 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 		}
 
 		for (i = 0; i < rxlen; ++i) {
-			uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT, buf[i], flag);
+			uart_insert_char(port, sts, MAX310X_LSR_RXOVR_BIT,
+					 one->rx_buf[i], flag);
 		}
 
 	} else {
@@ -1298,6 +1303,10 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
+		/* Initialize SPI-transfer buffers */
+		s->p[i].wr_header = (s->p[i].port.iobase + MAX310X_THR_REG) |
+				    MAX310X_WRITE_BIT;
+		s->p[i].rd_header = (s->p[i].port.iobase + MAX310X_RHR_REG);
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
-- 
2.21.0
