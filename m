From: Krzysztof Kozlowski <kozik.server@gmail.com>
Subject: [PATCH-stable] serial: samsung: Bring back removed variable to fix compilation
Date: Thu, 18 May 2017 14:31:17 +0200
Message-ID: <1495110677-31174-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-serial@vger.kernel.org

By mistake commit 500fcc08a32b ("serial: samsung: Add missing checks for
dma_map_single failure") removes a local variable which is still used by
code.  After backporting the commit to stable, compilation fails:

	drivers/tty/serial/samsung.c: In function ‘s3c24xx_serial_request_dma’:
	drivers/tty/serial/samsung.c:909:45: error: ‘flags’ undeclared (first use in this function)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Fix for stable-rc commit:
bc3ac2299c4873cdc7f9bf3c867c23e9714a036f
---
 drivers/tty/serial/samsung.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ca0bcd7fd61f..43c84c9bb904 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -859,6 +859,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
 static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
 {
 	struct s3c24xx_uart_dma	*dma = p->dma;
+	unsigned long flags;
 	int ret;
 
 	/* Default slave configuration parameters */
-- 
2.7.4
