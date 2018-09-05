From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH 1/2] tty: serial: imx: add lock for registers save/restore
Date: Wed, 5 Sep 2018 01:20:32 +0000
Message-ID: <DB3PR0402MB3916F184893B6C6D2881F4EFF5020@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
 <20180904203205.yboqvzkkrm6g7go5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904203205.yboqvzkkrm6g7go5@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-serial@vger.kernel.org

Hi, Uwe

Anson Huang
Best Regards!


> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Wednesday, September 5, 2018 4:32 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: gregkh@linuxfoundation.org; jslaby@suse.com;
> linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH 1/2] tty: serial: imx: add lock for registers save/re=
store
>=20
> Hello,
>=20
> On Thu, Aug 09, 2018 at 06:06:08PM +0800, Anson Huang wrote:
> > In noirq suspend/resume stage with no_console_suspend enabled,
> > .imx_console_write() may be called to print out log_buf message by
> > .printk(), so there will be race condition between
> > .imx_console_write() and .serial_imx_save/restore_context(),
> > need to add lock to protect the registers save/restore operations.
>=20
> The function names changes some time ago. Also I'd drop the leading dots =
in
> the names which I would understand as members in a struct.
>=20
> Is this a theoretical issue, or did you see actual breakage?
=20
I will update the function name and remove the dots.

And we did see actual breakage during stress test, although the reproduce r=
ate
is NOT that high, but the issue came out and fixed by this patch.=20

>=20
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/tty/serial/imx.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > 239c0fa..a09ccef 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -2376,9 +2376,12 @@ static int imx_uart_remove(struct
> > platform_device *pdev)
> >
> >  static void imx_uart_restore_context(struct imx_port *sport)  {
> > +	unsigned long flags;
> > +
> >  	if (!sport->context_saved)
> >  		return;
>=20
> Is it safe to check .context_saved without holding the lock?
=20
Ah, my mistake, will put the check inside the lock. Please help
review V2 patch set, thanks.

Anson.

>=20
> > +	spin_lock_irqsave(&sport->port.lock, flags);
> >  	imx_uart_writel(sport, sport->saved_reg[4], UFCR);
> >  	imx_uart_writel(sport, sport->saved_reg[5], UESC);
> >  	imx_uart_writel(sport, sport->saved_reg[6], UTIM); @@ -2390,11
> > +2393,15 @@ static void imx_uart_restore_context(struct imx_port *sport=
)
> >  	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
> >  	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
> >  	sport->context_saved =3D false;
> > +	spin_unlock_irqrestore(&sport->port.lock, flags);
> >  }
> >
> >  static void imx_uart_save_context(struct imx_port *sport)  {
> > +	unsigned long flags;
> > +
> >  	/* Save necessary regs */
> > +	spin_lock_irqsave(&sport->port.lock, flags);
> >  	sport->saved_reg[0] =3D imx_uart_readl(sport, UCR1);
> >  	sport->saved_reg[1] =3D imx_uart_readl(sport, UCR2);
> >  	sport->saved_reg[2] =3D imx_uart_readl(sport, UCR3); @@ -2406,6
> > +2413,7 @@ static void imx_uart_save_context(struct imx_port *sport)
> >  	sport->saved_reg[8] =3D imx_uart_readl(sport, UBMR);
> >  	sport->saved_reg[9] =3D imx_uart_readl(sport, IMX21_UTS);
> >  	sport->context_saved =3D true;
> > +	spin_unlock_irqrestore(&sport->port.lock, flags);
> >  }
> >
> >  static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C74
> a28e347934451a59bf08d612a57f8c%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C636716899353510311&amp;sdata=3DlByZDd%2BbQitjEf%2FaiN3
> e26El3ErT0fnmvaKCqckF7Qc%3D&amp;reserved=3D0  |
