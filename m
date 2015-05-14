From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/6] serial: sirf: fix the issue that HW flow control doesn't
 work for BT
Date: Thu, 14 May 2015 06:45:22 +0000
Message-ID: <1431585926-10746-2-git-send-email-21cnbao@gmail.com>
References: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431585926-10746-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: Qipan Li <Qipan.Li@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-serial@vger.kernel.org

From: Qipan Li <Qipan.Li@csr.com>

>From HW spec, when rxfifo's data is less than AFC_RX_THD(RX threshhold), RTS
signal is active. otherwise, RTS signal is inactive.

Crrently the RX threshhold is set as zero, so RTS has no chance to be
active. This patch replaces the default 0 by a positive number.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 1d0d47f..48cceaf 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -344,7 +344,8 @@ static void sirfsoc_uart_enable_ms(struct uart_port *port)
 	if (sirfport->uart_reg->uart_type == SIRF_REAL_UART) {
 		wr_regl(port, ureg->sirfsoc_afc_ctrl,
 				rd_regl(port, ureg->sirfsoc_afc_ctrl) |
-				SIRFUART_AFC_TX_EN | SIRFUART_AFC_RX_EN);
+				SIRFUART_AFC_TX_EN | SIRFUART_AFC_RX_EN |
+				SIRFUART_AFC_CTRL_RX_THD);
 		if (!sirfport->is_atlas7)
 			wr_regl(port, ureg->sirfsoc_int_en_reg,
 					rd_regl(port, ureg->sirfsoc_int_en_reg)
-- 
2.3.5
