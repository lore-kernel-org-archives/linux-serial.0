From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 37/65] serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling
Date: Thu, 14 Feb 2019 21:10:53 -0500
Message-ID: <20190215021121.177674-37-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tomonori Sakita <tomonori.sakita@sord.co.jp>, Atsushi Nemoto <atsushi.nemoto@sord.co.jp>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Tomonori Sakita <tomonori.sakita@sord.co.jp>

[ Upstream commit 815d835b7ba46685c316b000013367dacb2b461b ]

Using over-sampling ratio, lpuart can accept baud rate upto uartclk / 4.

Signed-off-by: Tomonori Sakita <tomonori.sakita@sord.co.jp>
Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3f8d1274fc85..61003eedd7cd 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1691,7 +1691,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* ask the core to calculate the divisor */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
-- 
2.19.1
