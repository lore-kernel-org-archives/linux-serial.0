From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/pch: use global div helper instead of creating a private one
Date: Thu, 26 May 2011 10:41:17 +0200
Message-ID: <1306399277-17094-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/pch_uart.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uar=
t.c
index f2cb750..ae28250 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -14,6 +14,7 @@
  *along with this program; if not, write to the Free Software
  *Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307=
, USA.
  */
+#include <linux/kernel.h>
 #include <linux/serial_reg.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -137,8 +138,6 @@ enum {
 #define PCH_UART_DLL		0x00
 #define PCH_UART_DLM		0x01
=20
-#define DIV_ROUND(a, b)	(((a) + ((b)/2)) / (b))
-
 #define PCH_UART_IID_RLS	(PCH_UART_IIR_REI)
 #define PCH_UART_IID_RDR	(PCH_UART_IIR_RRI)
 #define PCH_UART_IID_RDR_TO	(PCH_UART_IIR_RRI | PCH_UART_IIR_TOI)
@@ -316,7 +315,7 @@ static int pch_uart_hal_set_line(struct eg20t_port =
*priv, int baud,
 	unsigned int dll, dlm, lcr;
 	int div;
=20
-	div =3D DIV_ROUND(priv->base_baud / 16, baud);
+	div =3D DIV_ROUND_CLOSEST(priv->base_baud / 16, baud);
 	if (div < 0 || USHRT_MAX <=3D div) {
 		dev_err(priv->port.dev, "Invalid Baud(div=3D0x%x)\n", div);
 		return -EINVAL;
--=20
1.7.5.1
