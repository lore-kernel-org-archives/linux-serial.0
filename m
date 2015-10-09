From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] serial: tegra: Remove unnecessary return statements
Date: Fri, 9 Oct 2015 14:50:00 +0100
Message-ID: <1444398602-24020-3-git-send-email-jonathanh@nvidia.com>
References: <1444398602-24020-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444398602-24020-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Some functions in the serial-tegra driver have unnecessary return
statements at the end of a void function and so remove them.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 38b49f447bd7..42583484d4b2 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -186,7 +186,6 @@ static void set_rts(struct tegra_uart_port *tup, bool active)
 		tegra_uart_write(tup, mcr, UART_MCR);
 		tup->mcr_shadow = mcr;
 	}
-	return;
 }
 
 static void set_dtr(struct tegra_uart_port *tup, bool active)
@@ -202,7 +201,6 @@ static void set_dtr(struct tegra_uart_port *tup, bool active)
 		tegra_uart_write(tup, mcr, UART_MCR);
 		tup->mcr_shadow = mcr;
 	}
-	return;
 }
 
 static void tegra_uart_set_mctrl(struct uart_port *u, unsigned int mctrl)
@@ -217,7 +215,6 @@ static void tegra_uart_set_mctrl(struct uart_port *u, unsigned int mctrl)
 
 	dtr_enable = !!(mctrl & TIOCM_DTR);
 	set_dtr(tup, dtr_enable);
-	return;
 }
 
 static void tegra_uart_break_ctl(struct uart_port *u, int break_ctl)
@@ -511,7 +508,6 @@ static void tegra_uart_stop_tx(struct uart_port *u)
 	async_tx_ack(tup->tx_dma_desc);
 	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
 	tup->tx_in_progress = 0;
-	return;
 }
 
 static void tegra_uart_handle_tx_pio(struct tegra_uart_port *tup)
@@ -523,7 +519,6 @@ static void tegra_uart_handle_tx_pio(struct tegra_uart_port *tup)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&tup->uport);
 	tegra_uart_start_next_tx(tup);
-	return;
 }
 
 static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
@@ -545,8 +540,6 @@ static void tegra_uart_handle_rx_pio(struct tegra_uart_port *tup,
 		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
 			tty_insert_flip_char(tty, ch, flag);
 	} while (1);
-
-	return;
 }
 
 static void tegra_uart_copy_rx_to_tty(struct tegra_uart_port *tup,
@@ -691,7 +684,6 @@ static void tegra_uart_handle_modem_signal_change(struct uart_port *u)
 	/* Will start/stop_tx accordingly */
 	if (msr & UART_MSR_DCTS)
 		uart_handle_cts_change(&tup->uport, msr & UART_MSR_CTS);
-	return;
 }
 
 static irqreturn_t tegra_uart_isr(int irq, void *data)
@@ -799,7 +791,6 @@ static void tegra_uart_stop_rx(struct uart_port *u)
 		tty_flip_buffer_push(port);
 		tty_kref_put(tty);
 	}
-	return;
 }
 
 static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
@@ -1077,7 +1068,6 @@ static void tegra_uart_flush_buffer(struct uart_port *u)
 	tup->tx_bytes = 0;
 	if (tup->tx_dma_chan)
 		dmaengine_terminate_all(tup->tx_dma_chan);
-	return;
 }
 
 static void tegra_uart_shutdown(struct uart_port *u)
@@ -1217,7 +1207,6 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	tegra_uart_read(tup, UART_IER);
 
 	spin_unlock_irqrestore(&u->lock, flags);
-	return;
 }
 
 static const char *tegra_uart_type(struct uart_port *u)
-- 
2.1.4
