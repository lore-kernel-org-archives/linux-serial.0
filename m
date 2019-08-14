From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] serial: mxs-auart: Don't check for mctrl_gpio_to_gpiod()
 returning error
Date: Wed, 14 Aug 2019 11:27:56 +0200
Message-ID: <20190814092757.13726-3-geert+renesas@glider.be>
References: <20190814092757.13726-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190814092757.13726-1-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-renesas-soc@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Since commit 1d267ea6539f2663 ("serial: mctrl-gpio: simplify init
routine"), mctrl_gpio_init() returns failure if the assignment to any
member of the gpio array results in an error pointer.
Since commit c359522194593815 ("serial: mctrl_gpio: Avoid probe failures
in case of missing gpiolib"), mctrl_gpio_to_gpiod() returns NULL in the
!CONFIG_GPIOLIB case.
Hence there is no longer a need to check for mctrl_gpio_to_gpiod()
returning an error value.  A simple NULL check is sufficient.

This follows the spirit of commit 445df7ff3fd1a0a9 ("serial: mctrl-gpio:
drop usages of IS_ERR_OR_NULL") in the mctrl-gpio core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/mxs-auart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4c188f4079b3ea68..e3452597068292f9 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -969,10 +969,8 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 
 }
 
-#define RTS_AT_AUART()	IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,	\
-							UART_GPIO_RTS))
-#define CTS_AT_AUART()	IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,	\
-							UART_GPIO_CTS))
+#define RTS_AT_AUART()	!mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS)
+#define CTS_AT_AUART()	!mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_CTS)
 static void mxs_auart_settermios(struct uart_port *u,
 				 struct ktermios *termios,
 				 struct ktermios *old)
-- 
2.17.1
