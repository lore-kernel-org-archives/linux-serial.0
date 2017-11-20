From: Shuyu Wei <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH][RFC] 8250_dw: unregister dw8250_set_termios for rk3188 chip
Date: Mon, 20 Nov 2017 22:49:21 +0800
Message-ID: <20171120144920.k4fbzidwus5t2kwa@home.dogben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

dw8250_set_termios is causing problems for rk3188 on my radxa board.
It's using a fixed clock at 24M, not baud*16 in dw8250_set_termios.
I'm not sure if other rk3xxx chips are facing the same problem.

Signed-off-by Wei Shuyu <wsy-flSAGy4ZnMjQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/8250/8250_dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5bb0c42c88dd..e760a5c1f3f6 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -340,6 +340,9 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 			data->skip_autocfg = true;
 		}
 #endif
+		if (of_device_is_compatible(np, "rockchip,rk3188-uart")) {
+			p->set_termios = NULL;
+		}
 		if (of_device_is_big_endian(p->dev->of_node)) {
 			p->iotype = UPIO_MEM32BE;
 			p->serial_in = dw8250_serial_in32be;
-- 
2.15.0
