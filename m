From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] serial: 8250_omap: Add support for AM654 UART controller
Date: Tue, 19 Jun 2018 14:44:50 -0500
Message-ID: <20180619194450.6353-3-nm@ti.com>
References: <20180619194450.6353-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619194450.6353-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>, Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-serial@vger.kernel.org

AM654 uses a UART controller that is compatible (partially) with
existing 8250 UART, however, has a few differences with respect to DMA
support and control paths. Introduce a base definition that allows us
to build up the differences in follow on patches.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since RFC: Driver change has been split out with corresponding description.

RFC: https://patchwork.kernel.org/patch/10447641/

 drivers/tty/serial/8250/8250_omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 1b337fee07ed..a019286f8bb6 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1115,6 +1115,7 @@ static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
 static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
+	{ .compatible = "ti,am654-uart" },
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
 	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
-- 
2.15.1
