From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH V2 01/12] serial: tegra: add support to ignore read
Date: Wed, 4 Sep 2019 10:12:56 +0530
Message-ID: <1567572187-29820-2-git-send-email-kyarlagadda@nvidia.com>
References: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567572187-29820-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

Add support to ignore read characters if CREAD flag is not set.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 82a8d51..9c15c87 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -547,6 +547,9 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 
 		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
 			tty_insert_flip_char(tty, ch, flag);
+
+		if (tup->uport.ignore_status_mask & UART_LSR_DR)
+			continue;
 	} while (1);
 }
 
@@ -565,6 +568,10 @@ static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
 		dev_err(tup->uport.dev, "No tty port\n");
 		return;
 	}
+
+	if (tup->uport.ignore_status_mask & UART_LSR_DR)
+		return;
+
 	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
 				TEGRA_UART_RX_DMA_BUFFER_SIZE, DMA_FROM_DEVICE);
 	copied = tty_insert_flip_string(tty,
@@ -1193,6 +1200,11 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
 	tegra_uart_read(tup, UART_IER);
 
+	tup->uport.ignore_status_mask = 0;
+	/* Ignore all characters if CREAD is not set */
+	if ((termios->c_cflag & CREAD) == 0)
+		tup->uport.ignore_status_mask |= UART_LSR_DR;
+
 	spin_unlock_irqrestore(&u->lock, flags);
 }
 
-- 
2.7.4
