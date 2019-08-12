From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 01/14] serial: tegra: add internal loopback functionality
Date: Mon, 12 Aug 2019 16:58:10 +0530
Message-ID: <1565609303-27000-2-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Abel <aabel@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
List-Id: linux-serial@vger.kernel.org

From: Andreas Abel <aabel@nvidia.com>

Add the internal loopback functionality that can be enabled with
TIOCM_LOOP.

Signed-off-by: Andreas Abel <aabel@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d5269aa..19f4c24 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -4,7 +4,7 @@
  *
  * High-speed serial driver for NVIDIA Tegra SoCs
  *
- * Copyright (c) 2012-2013, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2019, NVIDIA CORPORATION.  All rights reserved.
  *
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
  */
@@ -192,16 +192,34 @@ static void set_dtr(struct tegra_uart_port *tup, bool active)
 	}
 }
 
+static void set_loopbk(struct tegra_uart_port *tup, bool active)
+{
+	unsigned long mcr = tup->mcr_shadow;
+
+	if (active)
+		mcr |= UART_MCR_LOOP;
+	else
+		mcr &= ~UART_MCR_LOOP;
+
+	if (mcr != tup->mcr_shadow) {
+		tegra_uart_write(tup, mcr, UART_MCR);
+		tup->mcr_shadow = mcr;
+	}
+}
+
 static void tegra_uart_set_mctrl(struct uart_port *u, unsigned int mctrl)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
-	int dtr_enable;
+	int enable;
 
 	tup->rts_active = !!(mctrl & TIOCM_RTS);
 	set_rts(tup, tup->rts_active);
 
-	dtr_enable = !!(mctrl & TIOCM_DTR);
-	set_dtr(tup, dtr_enable);
+	enable = !!(mctrl & TIOCM_DTR);
+	set_dtr(tup, enable);
+
+	enable = !!(mctrl & TIOCM_LOOP);
+	set_loopbk(tup, enable);
 }
 
 static void tegra_uart_break_ctl(struct uart_port *u, int break_ctl)
-- 
2.7.4
