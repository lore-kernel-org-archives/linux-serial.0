From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 06/14] serial: tegra: report error to upper tty layer
Date: Tue, 27 Aug 2019 09:29:44 +0000
Message-ID: <SN6PR12MB273439430F80C358B6DB663DC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-7-git-send-email-kyarlagadda@nvidia.com>
 <20190813095219.GK1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813095219.GK1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shardar Mohammed <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:22 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;=20
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman=20
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-=20
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-=20
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed=20
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 06/14] serial: tegra: report error to upper tty=20
> layer
>=20
> On Mon, Aug 12, 2019 at 04:58:15PM +0530, Krishna Yarlagadda wrote:
> > Report overrun/parity/frame/break errors to top tty layer. Add=20
> > support to ignore break character if IGNBRK is set.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index f6a3f4e..7ab81bb 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -374,13 +374,21 @@ static char tegra_uart_decode_rx_error(struct
> tegra_uart_port *tup,
> >  			tup->uport.icount.frame++;
> >  			dev_err(tup->uport.dev, "Got frame errors\n");
> >  		} else if (lsr & UART_LSR_BI) {
> > -			dev_err(tup->uport.dev, "Got Break\n");
> > -			tup->uport.icount.brk++;
> > -			/* If FIFO read error without any data, reset Rx FIFO
> */
> > +			/*
> > +			 * Break error
> > +			 * If FIFO read error without any data, reset Rx FIFO
> > +			 */
> >  			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
> >  				tegra_uart_fifo_reset(tup,
> UART_FCR_CLEAR_RCVR);
> > +			if (tup->uport.ignore_status_mask & UART_LSR_BI)
> > +				return TTY_BREAK;
> > +			flag =3D TTY_BREAK;
> > +			tup->uport.icount.brk++;
> > +			dev_err(tup->uport.dev, "Got Break\n");
>=20
> I know this is preexisting, but why do we want to output an error=20
> message in these cases. Isn't it perfectly legal for this to happen?
>=20
> Thierry
>=20
It is valid to have breaks for sysrq requests. But they also indicate possi=
ble mismatch in baud rate. So warning user as this could be potential issue=
. I will change this to dev_dbg to avoid spamming user in valid cases.

KY
> >  		}
> > +		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
> >  	}
> > +
> >  	return flag;
> >  }
> >
> > @@ -562,6 +570,9 @@ static void tegra_uart_handle_rx_pio(struct
> tegra_uart_port *tup,
> >  			break;
> >
> >  		flag =3D tegra_uart_decode_rx_error(tup, lsr);
> > +		if (flag !=3D TTY_NORMAL)
> > +			continue;
> > +
> >  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
> >  		tup->uport.icount.rx++;
> >
> > @@ -1224,6 +1235,8 @@ static void tegra_uart_set_termios(struct
> uart_port *u,
> >  	/* Ignore all characters if CREAD is not set */
> >  	if ((termios->c_cflag & CREAD) =3D=3D 0)
> >  		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> > +	if (termios->c_iflag & IGNBRK)
> > +		tup->uport.ignore_status_mask |=3D UART_LSR_BI;
> >
> >  	spin_unlock_irqrestore(&u->lock, flags);  }
> > --
> > 2.7.4
> >
