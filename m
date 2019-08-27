From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 08/14] serial: tegra: check for FIFO mode enabled status
Date: Tue, 27 Aug 2019 09:29:53 +0000
Message-ID: <SN6PR12MB273448A314407D72A764D76EC3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-9-git-send-email-kyarlagadda@nvidia.com>
 <20190813100357.GM1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813100357.GM1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shardar Mohammed <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: linux-tegra-owner@vger.kernel.org <linux-tegra-
> owner@vger.kernel.org> On Behalf Of Thierry Reding
> Sent: Tuesday, August 13, 2019 3:34 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 08/14] serial: tegra: check for FIFO mode enabled sta=
tus
>=20
> On Mon, Aug 12, 2019 at 04:58:17PM +0530, Krishna Yarlagadda wrote:
> > Chips prior to Tegra186 needed delay of 3 UART clock cycles to avoid
> > data loss. This issue is fixed in Tegra186 and a new flag is added to
> > check if fifo mode is enabled. chip data updated to check if this flag
> > is available for a chip. Tegra186 has new compatible to enable this
> > flag.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 52
> > ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 46 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index 7ab81bb..e0379d9 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -72,6 +72,8 @@
> >  #define TEGRA_TX_PIO				1
> >  #define TEGRA_TX_DMA				2
> >
> > +#define TEGRA_UART_FCR_IIR_FIFO_EN		0x40
> > +
> >  /**
> >   * tegra_uart_chip_data: SOC specific data.
> >   *
> > @@ -84,6 +86,7 @@ struct tegra_uart_chip_data {
> >  	bool	tx_fifo_full_status;
> >  	bool	allow_txfifo_reset_fifo_mode;
> >  	bool	support_clk_src_div;
> > +	bool	fifo_mode_enable_status;
> >  };
> >
> >  struct tegra_uart_port {
> > @@ -263,6 +266,22 @@ static void tegra_uart_wait_sym_time(struct
> tegra_uart_port *tup,
> >  			tup->current_baud));
> >  }
> >
> > +static int tegra_uart_is_fifo_mode_enabled(struct tegra_uart_port
> > +*tup)
>=20
> I think this is a bad name. "is" makes it sound like this will return a b=
oolean
> value. Also, this doesn't really check whether FIFO mode is enabled, but
> rather it waits for the FIFO mode to become enabled.
> Perhaps, then, a better name would be
>=20
> 	tegra_uart_wait_fifo_mode_enabled()
>=20
> ?
>=20
Sounds good. Will make changes

> > +{
> > +	unsigned long iir;
> > +	unsigned int tmout =3D 100;
> > +
> > +	do {
> > +		iir =3D tegra_uart_read(tup, UART_IIR);
> > +		if (iir & TEGRA_UART_FCR_IIR_FIFO_EN)
> > +			return 0;
> > +		udelay(1);
> > +	} while (--tmout);
> > +	dev_err(tup->uport.dev, "FIFO mode not enabled\n");
>=20
> I'd push this out to callers. That way this function becomes useful in
> situations where you don't want to output an error.
>=20
> > +
> > +	return -EIO;
>=20
> -ETIMEDOUT?
>=20
> Thierry
>=20
Will push this to caller and change the error code
KY
> > +}
> > +
> >  static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8
> > fcr_bits)  {
> >  	unsigned long fcr =3D tup->fcr_shadow; @@ -282,6 +301,8 @@ static
> void
> > tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
> >  		tegra_uart_write(tup, fcr, UART_FCR);
> >  		fcr |=3D UART_FCR_ENABLE_FIFO;
> >  		tegra_uart_write(tup, fcr, UART_FCR);
> > +		if (tup->cdata->fifo_mode_enable_status)
> > +			tegra_uart_is_fifo_mode_enabled(tup);
> >  	}
> >
> >  	/* Dummy read to ensure the write is posted */ @@ -918,12 +939,19
> @@
> > static int tegra_uart_hw_init(struct tegra_uart_port *tup)
> >  	/* Dummy read to ensure the write is posted */
> >  	tegra_uart_read(tup, UART_SCR);
> >
> > -	/*
> > -	 * For all tegra devices (up to t210), there is a hardware issue that
> > -	 * requires software to wait for 3 UART clock periods after enabling
> > -	 * the TX fifo, otherwise data could be lost.
> > -	 */
> > -	tegra_uart_wait_cycle_time(tup, 3);
> > +	if (tup->cdata->fifo_mode_enable_status) {
> > +		ret =3D tegra_uart_is_fifo_mode_enabled(tup);
> > +		if (ret < 0)
> > +			return ret;
> > +	} else {
> > +		/*
> > +		 * For all tegra devices (up to t210), there is a hardware
> > +		 * issue that requires software to wait for 3 UART clock
> > +		 * periods after enabling the TX fifo, otherwise data could
> > +		 * be lost.
> > +		 */
> > +		tegra_uart_wait_cycle_time(tup, 3);
> > +	}
> >
> >  	/*
> >  	 * Initialize the UART with default configuration @@ -1294,12
> > +1322,21 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data =
=3D
> {
> >  	.tx_fifo_full_status		=3D false,
> >  	.allow_txfifo_reset_fifo_mode	=3D true,
> >  	.support_clk_src_div		=3D false,
> > +	.fifo_mode_enable_status	=3D false,
> >  };
> >
> >  static struct tegra_uart_chip_data tegra30_uart_chip_data =3D {
> >  	.tx_fifo_full_status		=3D true,
> >  	.allow_txfifo_reset_fifo_mode	=3D false,
> >  	.support_clk_src_div		=3D true,
> > +	.fifo_mode_enable_status	=3D false,
> > +};
> > +
> > +static struct tegra_uart_chip_data tegra186_uart_chip_data =3D {
> > +	.tx_fifo_full_status		=3D true,
> > +	.allow_txfifo_reset_fifo_mode	=3D false,
> > +	.support_clk_src_div		=3D true,
> > +	.fifo_mode_enable_status	=3D true,
> >  };
> >
> >  static const struct of_device_id tegra_uart_of_match[] =3D { @@ -1310,=
6
> > +1347,9 @@ static const struct of_device_id tegra_uart_of_match[] =3D {
> >  		.compatible	=3D "nvidia,tegra20-hsuart",
> >  		.data		=3D &tegra20_uart_chip_data,
> >  	}, {
> > +		.compatible     =3D "nvidia,tegra186-hsuart",
> > +		.data		=3D &tegra186_uart_chip_data,
> > +	}, {
> >  	},
> >  };
> >  MODULE_DEVICE_TABLE(of, tegra_uart_of_match);
> > --
> > 2.7.4
> >
