From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH] serial: samsung: wait for transfer completion before clock
 disable
Date: Tue, 28 Oct 2014 12:19:59 +0100
Message-ID: <1414495199-15559-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch adds waiting until transmit buffer and shifter will be empty
before clock disabling.

Without this fix it's possible to have clock disabled while data was
not transmited yet, which causes unproper state of TX line and problems
in following data transfers.

Cc: <stable@vger.kernel.org> # v2.6.26+
Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c78f43a..587d63b 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -559,11 +559,15 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 			      unsigned int old)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	int timeout = 10000;
 
 	ourport->pm_level = level;
 
 	switch (level) {
 	case 3:
+		while (--timeout && !s3c24xx_serial_txempty_nofifo(port))
+			udelay(100);
+
 		if (!IS_ERR(ourport->baudclk))
 			clk_disable_unprepare(ourport->baudclk);
 
-- 
1.9.1
