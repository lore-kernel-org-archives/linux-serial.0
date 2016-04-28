From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] serial: tegra: Remove unused variable
Date: Thu, 28 Apr 2016 14:48:05 +0200
Message-ID: <1461847685-12405-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The local mcr variable is never used in the tegra_uart_set_mctrl()
function, so it should be removed.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 1d6fc60ed013..1dba6719db8d 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -206,10 +206,8 @@ static void set_dtr(struct tegra_uart_port *tup, bool active)
 static void tegra_uart_set_mctrl(struct uart_port *u, unsigned int mctrl)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
-	unsigned long mcr;
 	int dtr_enable;
 
-	mcr = tup->mcr_shadow;
 	tup->rts_active = !!(mctrl & TIOCM_RTS);
 	set_rts(tup, tup->rts_active);
 
-- 
2.8.0
