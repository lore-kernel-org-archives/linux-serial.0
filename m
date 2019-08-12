From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 04/14] serial: tegra: protect IER against LCR.DLAB
Date: Mon, 12 Aug 2019 16:58:13 +0530
Message-ID: <1565609303-27000-5-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Ahung Cheng <ahcheng@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

From: Ahung Cheng <ahcheng@nvidia.com>

The IER and DLH registers occupy the same address space, selected by
the LCR.DLAB bit. Hence, add port lock to protect IER when LCR.DLAB bit
is set.

Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d908465..ae7225c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -296,6 +296,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 	unsigned long rate;
 	unsigned int divisor;
 	unsigned long lcr;
+	unsigned long flags;
 	int ret;
 
 	if (tup->current_baud == baud)
@@ -315,6 +316,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 		divisor = DIV_ROUND_CLOSEST(rate, baud * 16);
 	}
 
+	spin_lock_irqsave(&tup->uport.lock, flags);
 	lcr = tup->lcr_shadow;
 	lcr |= UART_LCR_DLAB;
 	tegra_uart_write(tup, lcr, UART_LCR);
@@ -327,6 +329,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 
 	/* Dummy read to ensure the write is posted */
 	tegra_uart_read(tup, UART_SCR);
+	spin_unlock_irqrestore(&tup->uport.lock, flags);
 
 	tup->current_baud = baud;
 
-- 
2.7.4
