From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 1/3] serial: imx: set_termios(): do not enable autoRTS
 if RTS is unset
Date: Fri, 19 Jul 2019 16:31:51 +0200
Message-ID: <20190719143151.gx43ndn2oy35h247@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1563526074-20399-1-git-send-email-sorganov@gmail.com>
 <1563526074-20399-2-git-send-email-sorganov@gmail.com>
 <20190719091143.uhjxeibtolgswq2l@pengutronix.de>
 <87h87idxq2.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87h87idxq2.fsf@osv.gnss.ru>
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
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Sergey,

On Fri, Jul 19, 2019 at 03:18:13PM +0300, Sergey Organov wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> > On Fri, Jul 19, 2019 at 11:47:52AM +0300, Sergey Organov wrote:
> >> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> >> index 57d6e6b..95d7984 100644
> >> --- a/drivers/tty/serial/imx.c
> >> +++ b/drivers/tty/serial/imx.c
> >> @@ -405,7 +405,8 @@ static void imx_uart_rts_inactive(struct imx_port =
*sport, u32 *ucr2)
> >>  /* called with port.lock taken and irqs caller dependent */
> >>  static void imx_uart_rts_auto(struct imx_port *sport, u32 *ucr2)
> >>  {
> >> -	*ucr2 |=3D UCR2_CTSC;
> >> +	if (*ucr2 & UCR2_CTS)
> >> +		*ucr2 |=3D UCR2_CTSC;
> >
> > I think this patch is wrong or the commit log is insufficient.
> > imx_uart_rts_auto() has only a single caller and there ucr2 & UCR2_CTS =
is
> > never true. And CTSC isn't restored anywhere, is it?
> =

> This is rebase to 'tty-next' branch, and you need to look at it in that
> context. There, ucr2 & UCR2_CTS does already make sense, due to previous
> fix that is already there.

I looked at 57d6e6b which is the file you patched. And there
imx_uart_rts_auto is only ever called with *ucr2 not having UCR2_CTS.

If you still think I'm wrong, please improve the commit log accordingly.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
