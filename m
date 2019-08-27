From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 02/14] serial: tegra: add support to ignore read
Date: Tue, 27 Aug 2019 09:29:21 +0000
Message-ID: <SN6PR12MB2734D67C01A97D87D1735EDBC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-3-git-send-email-kyarlagadda@nvidia.com>
 <20190813094208.GG1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813094208.GG1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shardar Mohammed <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: linux-tegra-owner@vger.kernel.org <linux-tegra-
> owner@vger.kernel.org> On Behalf Of Thierry Reding
> Sent: Tuesday, August 13, 2019 3:12 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 02/14] serial: tegra: add support to ignore read
>=20
> On Mon, Aug 12, 2019 at 04:58:11PM +0530, Krishna Yarlagadda wrote:
> > From: Shardar Shariff Md <smohammed@nvidia.com>
> >
> > Add support to ignore read characters if CREAD flag is not set.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index 19f4c24..93d299e 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -542,6 +542,9 @@ static void tegra_uart_handle_rx_pio(struct
> tegra_uart_port *tup,
> >  		ch =3D (unsigned char) tegra_uart_read(tup, UART_RX);
> >  		tup->uport.icount.rx++;
> >
> > +		if (tup->uport.ignore_status_mask & UART_LSR_DR)
> > +			continue;
> > +
> >  		if (!uart_handle_sysrq_char(&tup->uport, ch) && tty)
> >  			tty_insert_flip_char(tty, ch, flag);
>=20
> Is it a good idea to ignore even sysrq characters if CREAD is not set?
> According to termios, CREAD enables the receiver, so technically if it is=
n't set
> you can't even receive sysrq characters. But I don't know if there are an=
y
> rules regarding this.
>=20
> Is this the same way that other drivers work?
>=20
> Thierry
>=20
Looked into few drivers and sysrq characters are not ignored. This driver d=
oes
not support console driver. So this might not be needed.

KY
> >  	} while (1);
> > @@ -562,6 +565,10 @@ static void tegra_uart_copy_rx_to_tty(struct
> tegra_uart_port *tup,
> >  		dev_err(tup->uport.dev, "No tty port\n");
> >  		return;
> >  	}
> > +
> > +	if (tup->uport.ignore_status_mask & UART_LSR_DR)
> > +		return;
> > +
> >  	dma_sync_single_for_cpu(tup->uport.dev, tup->rx_dma_buf_phys,
> >  				TEGRA_UART_RX_DMA_BUFFER_SIZE,
> DMA_FROM_DEVICE);
> >  	copied =3D tty_insert_flip_string(tty, @@ -1190,6 +1197,11 @@ static
> > void tegra_uart_set_termios(struct uart_port *u,
> >  	tegra_uart_write(tup, tup->ier_shadow, UART_IER);
> >  	tegra_uart_read(tup, UART_IER);
> >
> > +	tup->uport.ignore_status_mask =3D 0;
> > +	/* Ignore all characters if CREAD is not set */
> > +	if ((termios->c_cflag & CREAD) =3D=3D 0)
> > +		tup->uport.ignore_status_mask |=3D UART_LSR_DR;
> > +
> >  	spin_unlock_irqrestore(&u->lock, flags);  }
> >
> > --
> > 2.7.4
> >
