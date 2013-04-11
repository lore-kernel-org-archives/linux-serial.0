From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/30] tty: serial/samsung: fix modular build
Date: Thu, 11 Apr 2013 02:04:49 +0200
Message-ID: <1365638712-1028578-8-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

There are a few bugs in the samsung serial driver when built as a
loadable module, which makes the console code unavailable, as well as
giving no access to the 'printascii' early debug function. This adds
the appropriate compile time conditionals.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung.c | 4 ++--
 drivers/tty/serial/samsung.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 729a60d..a3277ca 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -894,7 +894,7 @@ console_initcall(s3c24xx_serial_console_init);
 #define S3C24XX_SERIAL_CONSOLE NULL
 #endif
 
-#ifdef CONFIG_CONSOLE_POLL
+#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
 static int s3c24xx_serial_get_poll_char(struct uart_port *port);
 static void s3c24xx_serial_put_poll_char(struct uart_port *port,
 			 unsigned char c);
@@ -918,7 +918,7 @@ static struct uart_ops s3c24xx_serial_ops = {
 	.request_port	= s3c24xx_serial_request_port,
 	.config_port	= s3c24xx_serial_config_port,
 	.verify_port	= s3c24xx_serial_verify_port,
-#ifdef CONFIG_CONSOLE_POLL
+#if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_CONSOLE_POLL)
 	.poll_get_char = s3c24xx_serial_get_poll_char,
 	.poll_put_char = s3c24xx_serial_put_poll_char,
 #endif
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 1a4bca3..00a499e 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -76,7 +76,9 @@ struct s3c24xx_uart_port {
 #define wr_regb(port, reg, val) __raw_writeb(val, portaddr(port, reg))
 #define wr_regl(port, reg, val) __raw_writel(val, portaddr(port, reg))
 
-#ifdef CONFIG_SERIAL_SAMSUNG_DEBUG
+#if defined(CONFIG_SERIAL_SAMSUNG_DEBUG) && \
+    defined(CONFIG_DEBUG_LL) && \
+    !defined(MODULE)
 
 extern void printascii(const char *);
 
-- 
1.8.1.2
