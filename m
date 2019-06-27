From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/7] serial: imx: fix locking in set_termios()
Date: Thu, 27 Jun 2019 07:05:20 +0200
Message-ID: <20190627050520.n7grqfspfypmff4e@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1561558293-7683-1-git-send-email-sorganov@gmail.com>
 <1561558293-7683-2-git-send-email-sorganov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1561558293-7683-2-git-send-email-sorganov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergey Organov <sorganov@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hello,

On Wed, Jun 26, 2019 at 05:11:27PM +0300, Sergey Organov wrote:
> imx_uart_set_termios() called imx_uart_rts_active(), or
> imx_uart_rts_inactive() before taking port->port.lock.
> =

> As a consequence, sport->port.mctrl that these functions modify
> could have been changed without holding port->port.lock.
> =

> Moved locking of port->port.lock above the calls to fix the issue.
> =

> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
