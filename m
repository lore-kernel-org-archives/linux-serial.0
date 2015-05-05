From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/8] serial: tegra: Add delay after enabling FIFO mode
Date: Tue, 5 May 2015 15:17:53 +0100
Message-ID: <1430835479-6613-3-git-send-email-jonathanh@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430835479-6613-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

For all tegra devices (up to t210), there is a hardware issue that
requires software to wait for 3 UART clock periods after enabling
the TX fifo, otherwise data could be lost.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 9e08d3f07509..0d9d7ceb1dbb 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -885,6 +885,16 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	tup->fcr_shadow |= TEGRA_UART_TX_TRIG_16B;
 	tegra_uart_write(tup, tup->fcr_shadow, UART_FCR);
 
+	/* Dummy read to ensure the write is posted */
+	tegra_uart_read(tup, UART_SCR);
+
+	/*
+	 * For all tegra devices (up to t210), there is a hardware issue that
+	 * requires software to wait for 3 UART clock periods after enabling
+	 * the TX fifo, otherwise data could be lost.
+	 */
+	tegra_uart_wait_cycle_time(tup, 3);
+
 	/*
 	 * Initialize the UART with default configuration
 	 * (115200, N, 8, 1) so that the receive DMA buffer may be
-- 
1.9.1
