From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] serial: 8250_fintek: Make fintek_8250_set_termios static
Date: Tue, 19 Mar 2019 23:16:46 +0800
Message-ID: <20190319151646.17988-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-serial@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/tty/serial/8250/8250_fintek.c:306:6: warning:
 symbol 'fintek_8250_set_termios' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 79a4958..31c91c2 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -303,8 +303,9 @@ static void fintek_8250_goto_highspeed(struct uart_8250_port *uart,
 	}
 }
 
-void fintek_8250_set_termios(struct uart_port *port, struct ktermios *termios,
-			struct ktermios *old)
+static void fintek_8250_set_termios(struct uart_port *port,
+				    struct ktermios *termios,
+				    struct ktermios *old)
 {
 	struct fintek_8250 *pdata = port->private_data;
 	unsigned int baud = tty_termios_baud_rate(termios);
-- 
2.7.4
