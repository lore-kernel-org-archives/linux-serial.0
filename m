From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 05/14] serial: tegra: flush the RX fifo on frame error
Date: Tue, 27 Aug 2019 09:29:41 +0000
Message-ID: <SN6PR12MB2734D923E15A855CB1E2B7BEC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
 <20190813094832.GJ1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813094832.GJ1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shardar Mohammed <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:19 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 05/14] serial: tegra: flush the RX fifo on frame erro=
r
>=20
> On Mon, Aug 12, 2019 at 04:58:14PM +0530, Krishna Yarlagadda wrote:
> > From: Shardar Shariff Md <smohammed@nvidia.com>
> >
> > FIFO reset/flush code implemented now does not follow programming
> > guidelines. RTS line has to be turned off while flushing fifos to
> > avoid new transfers. Also check LSR bits UART_LSR_TEMT and
> UART_LSR_DR
> > to confirm fifos are flushed.
>=20
> You use inconsistent spelling for FIFO here.
Will fix in next version and take care of this in all patches

>=20
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index ae7225c..f6a3f4e 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -266,6 +266,10 @@ static void tegra_uart_wait_sym_time(struct
> > tegra_uart_port *tup,  static void tegra_uart_fifo_reset(struct
> > tegra_uart_port *tup, u8 fcr_bits)  {
> >  	unsigned long fcr =3D tup->fcr_shadow;
> > +	unsigned int lsr, tmout =3D 10000;
> > +
> > +	if (tup->rts_active)
> > +		set_rts(tup, false);
> >
> >  	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
> >  		fcr |=3D fcr_bits & (UART_FCR_CLEAR_RCVR |
> UART_FCR_CLEAR_XMIT); @@
> > -289,6 +293,17 @@ static void tegra_uart_fifo_reset(struct tegra_uart_p=
ort
> *tup, u8 fcr_bits)
> >  	 * to propagate, otherwise data could be lost.
> >  	 */
> >  	tegra_uart_wait_cycle_time(tup, 32);
> > +
> > +	do {
> > +		lsr =3D tegra_uart_read(tup, UART_LSR);
> > +		if (lsr | UART_LSR_TEMT)
> > +			if (!(lsr & UART_LSR_DR))
>=20
> Can't both of these go on the same line?
>=20
> Thierry
>=20
They can be. Will fix in next version
KY

> > +				break;
> > +		udelay(1);
> > +	} while (--tmout);
> > +
> > +	if (tup->rts_active)
> > +		set_rts(tup, true);
> >  }
> >
> >  static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned
> > int baud)
> > --
> > 2.7.4
> >
