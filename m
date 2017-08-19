From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] serial: earlycon: Only try fdt when specify 'earlycon' exactly
Date: Sat, 19 Aug 2017 09:43:17 +0800
Message-ID: <20170819014318.31631-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

When moving earlycon early_param handling to serial, the devicetree
earlycons enable condition changed slightly.

We used to only do that for 'console'/'earlycon', but now would also
for 'console='/'earlycon='.

Fix it by using the same condition like before.

Fixes: d503187b6cc4 (of/serial: move earlycon early_param handling to serial)
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/tty/serial/earlycon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index c3651540e1ba..335933e1822c 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -220,7 +220,7 @@ static int __init param_setup_earlycon(char *buf)
 		if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
 			earlycon_init_is_deferred = true;
 			return 0;
-		} else {
+		} else if (!buf) {
 			return early_init_dt_scan_chosen_stdout();
 		}
 	}
-- 
2.11.0
