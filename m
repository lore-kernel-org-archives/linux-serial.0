From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] serial: Don't check for mctrl_gpio_to_gpiod() returning
 error
Date: Wed, 14 Aug 2019 11:27:54 +0200
Message-ID: <20190814092757.13726-1-geert+renesas@glider.be>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Richard Genoud <richard.genoud@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-renesas-soc@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

Since commit 1d267ea6539f2663 ("serial: mctrl-gpio: simplify init
routine"), mctrl_gpio_init() returns failure if the assignment to any
member of the gpio array results in an error pointer.
Since commit c359522194593815 ("serial: mctrl_gpio: Avoid probe failures
in case of missing gpiolib"), mctrl_gpio_to_gpiod() returns NULL in the
!CONFIG_GPIOLIB case.
Hence there is no longer a need to check in serial drivers if
mctrl_gpio_to_gpiod() returns an error value.  A simple NULL check is
sufficient.

This series follows the spirit of commit 445df7ff3fd1a0a9 ("serial:
mctrl-gpio: drop usages of IS_ERR_OR_NULL") in the mctrl-gpio core.

Thanks!

Geert Uytterhoeven (3):
  serial: atmel: Don't check for mctrl_gpio_to_gpiod() returning error
  serial: mxs-auart: Don't check for mctrl_gpio_to_gpiod() returning
    error
  serial: sh-sci: Don't check for mctrl_gpio_to_gpiod() returning error

 drivers/tty/serial/atmel_serial.c | 12 ++++--------
 drivers/tty/serial/mxs-auart.c    |  6 ++----
 drivers/tty/serial/sh-sci.c       | 12 +++++-------
 3 files changed, 11 insertions(+), 19 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
