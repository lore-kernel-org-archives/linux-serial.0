From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH RFC 0/7] serial: imx: fix RTS and RTS/CTS handling
Date: Fri, 14 Jun 2019 15:11:27 +0300
Message-ID: <1560514294-29111-1-git-send-email-sorganov@gmail.com>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190614072801.3187-1-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Dear Sascha,

I think these patches deliver simpler end result and are more complete
than what you just posted. In particular, the

  serial: imx: set_mctrl(): correctly restore autoRTS state

addresses exactly the issue your patch is about, but in a slightly
simpler manner.

The patches are not tested yet, so I've put RFC in the header. Just my
2 cents. I can obviously re-roll them on top of your work later, if
required.

Sergey Organov (7):
  serial: imx: fix locking in set_termios()
  serial: imx: set_termios(): factor-out 'ucr2' initial value
  serial: imx: set_termios(): clarify RTS/CTS bits calculation
  serial: imx: set_termios(): do not enable autoRTS if RTS is unset
  serial: imx: set_termios(): preserve RTS state
  serial: imx: set_mctrl(): correctly restore autoRTS state
  serial: imx: get rid of imx_uart_rts_auto()

 drivers/tty/serial/imx.c | 93 ++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

-- 
2.10.0.1.g57b01a3
