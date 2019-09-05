From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] serial: sprd: correct the wrong sequence of arguments
Date: Thu,  5 Sep 2019 15:41:51 +0800
Message-ID: <20190905074151.5268-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The sequence of arguments which was passed to handle_lsr_errors() didn't
match the parameters defined in that function, &lsr was passed to flag
and &flag was passed to lsr, this patch fixed that.

Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index c4d8c77c1261..4eb5dbfbc46d 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -609,7 +609,7 @@ static inline void sprd_rx(struct uart_port *port)
 
 		if (lsr & (SPRD_LSR_BI | SPRD_LSR_PE |
 			   SPRD_LSR_FE | SPRD_LSR_OE))
-			if (handle_lsr_errors(port, &lsr, &flag))
+			if (handle_lsr_errors(port, &flag, &lsr))
 				continue;
 		if (uart_handle_sysrq_char(port, ch))
 			continue;
-- 
2.20.1
