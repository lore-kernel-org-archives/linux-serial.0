From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v7 3/3] serial: imx: get rid of imx_uart_rts_auto()
Date: Mon, 29 Jul 2019 11:29:34 +0200
Message-ID: <20190729092934.4gjeqtj3q4wkgt6j@pengutronix.de>
References: <20190614072801.3187-1-s.hauer@pengutronix.de>
 <1564167161-3972-1-git-send-email-sorganov@gmail.com>
 <1564167161-3972-4-git-send-email-sorganov@gmail.com>
 <20190726192940.jy4frulgbetf5d2v@pengutronix.de>
 <87wog1xlf8.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87wog1xlf8.fsf@osv.gnss.ru>
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

On Mon, Jul 29, 2019 at 12:03:07PM +0300, Sergey Organov wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
> =

> > On Fri, Jul 26, 2019 at 09:52:41PM +0300, Sergey Organov wrote:
> >> Called in only one place, for RS232, it only obscures things, as it
> >> doesn't go well with 2 similar named functions,
> >> imx_uart_rts_inactive() and imx_uart_rts_active(), that both are
> >> RS485-specific.
> >
> > I don't share the critic. IMHO the name is fine. imx_uart_rts_inactive
> > sets rts to its inactive level,
> > imx_uart_rts_active() to its active level
> =

> Not exactly, in fact both do more than that, in a similar manner.

They both handle mctrl-gpio, the autorts stuff isn't available for that,
so we could fix that by letting rts-auto set the RTS gpio to active.

> > imx_uart_rts_auto() lets the output drive automatically by the
> > receiver.
> =

> And this one was different and it was rather confusing when I've tried
> to grok the logic of the driver.
> =

> > The name started to be a bit wrong in patch 1 of the series however.
> =

> The function was different from first two even before the patch, as it
> does not do any of those additional things the first two do.
> =

> > And I still object removing this function because with the semantic
> > this function got in patch 1 it is suiteable to be used in
> > imx_uart_set_mctrl().
> =

> It is not, as it does require change to be used there, as we've already
> seen, and then it becomes very different function from what it was at
> the beginning.
> =

> Even then, the end result I've shown you when attempting to somehow prese=
rve
> some re-incarnation of this function still seems more cumbersome to me
> than the end result of these patches.
> =

> That said, this a matter of taste and style, not correctness, and could
> be changed as a follow-up, not to risk breaking already tested patch
> series.

*shrug* I stop caring here.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
