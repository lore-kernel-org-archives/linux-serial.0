From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 3/4] tty/serial: mxs-auart: remove uneeded IS_ERR_OR_NULL calls
Date: Fri,  3 Mar 2017 15:20:31 +0100
Message-ID: <20170303142031.16101-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Genoud <richard.genoud@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-kernel@vger.kernel.org, Janusz Uzycki <j.uzycki@elproma.com.pl>, linux-serial@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
the mctrl_gpio_to_gpiod() function can't return an error anymore.
So, just testing for a NULL pointer is ok.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6989b227d134..541933d8a5c6 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -973,10 +973,8 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 
 }
 
-#define RTS_AT_AUART()	IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,	\
-							UART_GPIO_RTS))
-#define CTS_AT_AUART()	IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(s->gpios,	\
-							UART_GPIO_CTS))
+#define RTS_AT_AUART() (mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_RTS) == NULL)
+#define CTS_AT_AUART() (mctrl_gpio_to_gpiod(s->gpios, UART_GPIO_CTS) == NULL)
 static void mxs_auart_settermios(struct uart_port *u,
 				 struct ktermios *termios,
 				 struct ktermios *old)
