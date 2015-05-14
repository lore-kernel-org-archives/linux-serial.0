From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 6/6] serial: sirf: assign console default index if users not
 set a valid one
Date: Thu, 14 May 2015 06:45:26 +0000
Message-ID: <1431585926-10746-6-git-send-email-21cnbao@gmail.com>
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

it seems this is a more typical behaviour from reviewing other console
drivers.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 0e43799..8d75962 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1236,7 +1236,7 @@ sirfsoc_uart_console_setup(struct console *co, char *options)
 	struct sirfsoc_uart_port *sirfport;
 	struct sirfsoc_register *ureg;
 	if (co->index < 0 || co->index >= SIRFSOC_UART_NR)
-		return -EINVAL;
+		co->index = 1;
 	sirfport = sirf_ports[co->index];
 	if (!sirfport)
 		return -ENODEV;
-- 
2.3.5
