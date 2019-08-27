From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 03/14] serial: tegra: avoid reg access when clk disabled
Date: Tue, 27 Aug 2019 09:29:31 +0000
Message-ID: <SN6PR12MB2734315A9D5DEB8EDE008D2DC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-4-git-send-email-kyarlagadda@nvidia.com>
 <20190813094556.GH1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813094556.GH1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ahung Cheng <ahcheng@nvidia.com>, Shardar Mohammed <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: linux-tegra-owner@vger.kernel.org <linux-tegra-=20
> owner@vger.kernel.org> On Behalf Of Thierry Reding
> Sent: Tuesday, August 13, 2019 3:16 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;=20
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman=20
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-=20
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-=20
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Ahung Cheng=20
> <ahcheng@nvidia.com>; Shardar Mohammed <smohammed@nvidia.com>
> Subject: Re: [PATCH 03/14] serial: tegra: avoid reg access when clk=20
> disabled
>=20
> On Mon, Aug 12, 2019 at 04:58:12PM +0530, Krishna Yarlagadda wrote:
> > From: Ahung Cheng <ahcheng@nvidia.com>
> >
> > This avoids two race conditions from the UART shutdown sequence both=20
> > leading to 'Machine check error in AXI2APB' and kernel oops.
> >
> > One was that the clock was disabled before the DMA was terminated=20
> > making it possible for the DMA callbacks to be called after the=20
> > clock was disabled. These callbacks could write to the UART=20
> > registers causing timeout.
> >
> > The second was that the clock was disabled before the UART was=20
> > completely flagged as closed. This is done after the shutdown is=20
> > called and a new write could be started after the clock was disabled.
> > tegra_uart_start_pio_tx could be called causing timeout.
> >
> > Given that the baud rate is reset at the end of shutdown sequence,=20
> > this fix is to examine the baud rate to avoid register access from=20
> > both race conditions.
> >
> > Besides, terminate the DMA before disabling the clock.
> >
> > Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
> > Signed-off-by: Shardar Mohammed <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index 93d299e..d908465 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -126,6 +126,8 @@ struct tegra_uart_port {
> >
> >  static void tegra_uart_start_next_tx(struct tegra_uart_port *tup);=20
> > static int tegra_uart_start_rx_dma(struct tegra_uart_port *tup);
> > +static void tegra_uart_dma_channel_free(struct tegra_uart_port *tup,
> > +					bool dma_to_memory);
> >
> >  static inline unsigned long tegra_uart_read(struct tegra_uart_port *tu=
p,
> >  		unsigned long reg)
> > @@ -458,6 +460,9 @@ static void tegra_uart_start_next_tx(struct
> tegra_uart_port *tup)
> >  	unsigned long count;
> >  	struct circ_buf *xmit =3D &tup->uport.state->xmit;
> >
> > +	if (WARN_ON(!tup->current_baud))
> > +		return;
>=20
> Are the race conditions that you are describing something which can be=20
> triggered by the user? If so, it's not a good idea to use a WARN_ON,=20
> because that could lead to some userspace spamming the log with these,=20
> potentially on purpose.
>=20
> Thierry
>=20
These are triggered by user events. I will remove WARN_ON

 KY
> > +
> >  	tail =3D (unsigned long)&xmit->buf[xmit->tail];
> >  	count =3D CIRC_CNT_TO_END(xmit->head, xmit->tail,
> UART_XMIT_SIZE);
> >  	if (!count)
> > @@ -829,6 +834,12 @@ static void tegra_uart_hw_deinit(struct
> tegra_uart_port *tup)
> >  	tup->current_baud =3D 0;
> >  	spin_unlock_irqrestore(&tup->uport.lock, flags);
> >
> > +	tup->rx_in_progress =3D 0;
> > +	tup->tx_in_progress =3D 0;
> > +
> > +	tegra_uart_dma_channel_free(tup, true);
> > +	tegra_uart_dma_channel_free(tup, false);
> > +
> >  	clk_disable_unprepare(tup->uart_clk);
> >  }
> >
> > @@ -1066,12 +1077,6 @@ static void tegra_uart_shutdown(struct
> uart_port *u)
> >  	struct tegra_uart_port *tup =3D to_tegra_uport(u);
> >
> >  	tegra_uart_hw_deinit(tup);
> > -
> > -	tup->rx_in_progress =3D 0;
> > -	tup->tx_in_progress =3D 0;
> > -
> > -	tegra_uart_dma_channel_free(tup, true);
> > -	tegra_uart_dma_channel_free(tup, false);
> >  	free_irq(u->irq, tup);
> >  }
> >
> > --
> > 2.7.4
> >
