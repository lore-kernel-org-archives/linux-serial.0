From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 10/57] serial: uartps: console_setup() can't be placed to init section
Date: Fri, 29 Mar 2019 21:28:03 -0400
Message-ID: <20190330012854.32212-10-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Michal Simek <michal.simek@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

[ Upstream commit 4bb1ce2350a598502b23088b169e16b43d4bc639 ]

When console device is rebinded, console_setup() is called again.
But marking it as __init means that function will be clear after boot is
complete. If console device is binded again console_setup() is not found
and error "Unable to handle kernel paging request at virtual address"
is reported.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0e3627289047..77efa0a43fe7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1223,7 +1223,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
  *
  * Return: 0 on success, negative errno otherwise.
  */
-static int __init cdns_uart_console_setup(struct console *co, char *options)
+static int cdns_uart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = console_port;
 
-- 
2.19.1
