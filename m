From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 2/4] tty/serial: atmel: remove uneeded IS_ERR_OR_NULL calls
Date: Fri,  3 Mar 2017 15:17:02 +0100
Message-ID: <20170303141702.15331-1-richard.genoud@gmail.com>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Genoud <richard.genoud@gmail.com>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Since commit 1d267ea6539f ("serial: mctrl-gpio: simplify init routine"),
the mctrl_gpio_to_gpiod() function can't return an error anymore.
So, just testing for a NULL pointer is ok.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index ad6c2bdea481..e0f1955b3c7e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -315,32 +315,28 @@ static unsigned int atmel_get_lines_status(struct uart_port *port)
 
 	mctrl_gpio_get(atmel_port->gpios, &ret);
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_CTS))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
 		if (ret & TIOCM_CTS)
 			status &= ~ATMEL_US_CTS;
 		else
 			status |= ATMEL_US_CTS;
 	}
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DSR))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_DSR)) {
 		if (ret & TIOCM_DSR)
 			status &= ~ATMEL_US_DSR;
 		else
 			status |= ATMEL_US_DSR;
 	}
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_RI))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_RI)) {
 		if (ret & TIOCM_RI)
 			status &= ~ATMEL_US_RI;
 		else
 			status |= ATMEL_US_RI;
 	}
 
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DCD))) {
+	if (mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_DCD)) {
 		if (ret & TIOCM_CD)
 			status &= ~ATMEL_US_DCD;
 		else
