From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 REBASED 09/10] serial/arc: Enable DT based earlycon
Date: Tue, 24 Jun 2014 13:55:14 +0530
Message-ID: <1403598315-1429-10-git-send-email-vgupta@synopsys.com>
References: <1403598315-1429-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403598315-1429-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Paul Bolle <pebolle@tiscali.nl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Francois.Bedard@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-serial@vger.kernel.org

This allows a param less earlycon to pick up the earlyconsole from
chosen/stdout-path

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 drivers/tty/serial/arc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 435de4f2af3b..d9900cb3e7b6 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -579,6 +579,7 @@ static int __init arc_early_console_setup(struct earlycon_device *dev,
 	return 0;
 }
 EARLYCON_DECLARE(arc_uart, arc_early_console_setup);
+OF_EARLYCON_DECLARE(arc_uart, "snps,arc-uart", arc_early_console_setup);
 
 #endif	/* CONFIG_SERIAL_ARC_CONSOLE */
 
-- 
1.8.3.2
