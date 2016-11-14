From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] Revert "tty: serial: 8250: add CON_CONSDEV to flags"
Date: Mon, 14 Nov 2016 10:53:41 +0800
Message-ID: <1479092021-14885-1-git-send-email-chenhc@lemote.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Matthew Leach <matthew.leach@codethink.co.uk>, Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org, Ce Sun <sunc@lemote.com>
List-Id: linux-serial@vger.kernel.org

This reverts commit d03516df837587368fc6e75591f6329c072b9eb5. From
Documentation/serial-console.txt we can know that serial port becomes
the system console only when it appears in the kernel parameters as the
last console device. But commit d03516df837587 adds a CON_CONSDEV flag
to univ8250_console and breaks this convention. After that either we
use "console=tty console=ttyS0" or "console=ttyS0 console=tty", serial
port will always be the system console.

Cc: stable@vger.kernel.org
Signed-off-by: Ce Sun <sunc@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 240a361..e8819aa 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -675,7 +675,7 @@ static struct console univ8250_console = {
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.match		= univ8250_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_CONSDEV,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
 	.index		= -1,
 	.data		= &serial8250_reg,
 };
-- 
2.7.0
