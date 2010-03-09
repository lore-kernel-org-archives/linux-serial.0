From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/13] serial: bfin_sport_uart: rename
	early platform driver class string
Date: Tue,  9 Mar 2010 12:25:32 -0500
Message-ID: <1268155540-8241-6-git-send-email-vapier@gentoo.org>
References: <1268155540-8241-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1268155540-8241-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Clarifies command line set up for devices between consoles and early
devices.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/serial/bfin_sport_uart.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/bfin_sport_uart.c b/drivers/serial/bfin_sport_uart.c
index 18bc4a3..5101e38 100644
--- a/drivers/serial/bfin_sport_uart.c
+++ b/drivers/serial/bfin_sport_uart.c
@@ -526,6 +526,8 @@ struct uart_ops sport_uart_ops = {
 static struct sport_uart_port *bfin_sport_uart_ports[BFIN_SPORT_UART_MAX_PORTS];
 
 #ifdef CONFIG_SERIAL_BFIN_SPORT_CONSOLE
+#define CLASS_BFIN_SPORT_CONSOLE	"bfin-sport-console"
+
 static int __init
 sport_uart_console_setup(struct console *co, char *options)
 {
@@ -787,7 +789,7 @@ static struct platform_driver sport_uart_driver = {
 
 #ifdef CONFIG_SERIAL_BFIN_SPORT_CONSOLE
 static __initdata struct early_platform_driver early_sport_uart_driver = {
-	.class_str = DRV_NAME,
+	.class_str = CLASS_BFIN_SPORT_CONSOLE,
 	.pdrv = &sport_uart_driver,
 	.requested_id = EARLY_PLATFORM_ID_UNSET,
 };
@@ -796,7 +798,8 @@ static int __init sport_uart_rs_console_init(void)
 {
 	early_platform_driver_register(&early_sport_uart_driver, DRV_NAME);
 
-	early_platform_driver_probe(DRV_NAME, BFIN_SPORT_UART_MAX_PORTS, 0);
+	early_platform_driver_probe(CLASS_BFIN_SPORT_CONSOLE,
+		BFIN_SPORT_UART_MAX_PORTS, 0);
 
 	register_console(&sport_uart_console);
 
-- 
1.7.0.2
