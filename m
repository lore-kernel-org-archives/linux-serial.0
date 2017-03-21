From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 04/11] tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
Date: Tue, 21 Mar 2017 23:32:09 +0100
Message-ID: <20170321223216.11733-5-sre@kernel.org>
References: <20170321223216.11733-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321223216.11733-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The UPF_BOOT_AUTOCONF flag is needed for proper
flow control support.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
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
