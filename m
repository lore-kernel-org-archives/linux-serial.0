From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/2] serial: imx: disable the receiver ready interrupt for imx_stop_rx
Date: Fri, 23 May 2014 12:32:54 +0800
Message-ID: <1400819575-20435-2-git-send-email-b32955@freescale.com>
References: <1400819575-20435-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400819575-20435-1-git-send-email-b32955@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>
List-Id: linux-serial@vger.kernel.org

This patch disables the receiver ready interrupt for imx_stop_rx.
It reduces the interrupt numbers when the uart is going to close
or suspend.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index ed6cdf7..6026101 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -440,6 +440,10 @@ static void imx_stop_rx(struct uart_port *port)
 
 	temp = readl(sport->port.membase + UCR2);
 	writel(temp & ~UCR2_RXEN, sport->port.membase + UCR2);
+
+	/* disable the `Receiver Ready Interrrupt` */
+	temp = readl(sport->port.membase + UCR1);
+	writel(temp & ~UCR1_RRDYEN, sport->port.membase + UCR1);
 }
 
 /*
-- 
1.7.8
