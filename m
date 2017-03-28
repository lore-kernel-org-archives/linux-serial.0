From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv3 01/10] tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
Date: Tue, 28 Mar 2017 17:59:30 +0200
Message-ID: <20170328155939.31566-2-sre@kernel.org>
References: <20170328155939.31566-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170328155939.31566-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The UPF_BOOT_AUTOCONF flag is needed for proper
flow control support.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Hi,

This patch can be queued independently - there is no compile time dependency
regarding nokia-bluetooth. Also 8250_omap.c can be used with nokia-bluetooth
(I use this driver nowadays), which does flow control right already.

-- Sebastian
---
 drivers/tty/serial/omap-serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6c6f82ad8d5c..a4734649a0f0 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1597,6 +1597,9 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 
 	of_property_read_u32(dev->of_node, "clock-frequency",
 					 &omap_up_info->uartclk);
+
+	omap_up_info->flags = UPF_BOOT_AUTOCONF;
+
 	return omap_up_info;
 }
 
-- 
2.11.0
