From: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH 09/14] serial: tegra: set maximum num of uart ports to 8
Date: Tue, 27 Aug 2019 09:30:42 +0000
Message-ID: <SN6PR12MB273486EC7A958CFA427C0B37C3A00@SN6PR12MB2734.namprd12.prod.outlook.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
 <20190813101955.GN1137@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813101955.GN1137@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shardar Mohammed <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Tuesday, August 13, 2019 3:50 PM
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;=20
> mark.rutland@arm.com; Jonathan Hunter <jonathanh@nvidia.com>; Laxman=20
> Dewangan <ldewangan@nvidia.com>; jslaby@suse.com; linux-=20
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-=20
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Shardar Mohammed=20
> <smohammed@nvidia.com>
> Subject: Re: [PATCH 09/14] serial: tegra: set maximum num of uart=20
> ports to 8
>=20
> On Mon, Aug 12, 2019 at 04:58:18PM +0530, Krishna Yarlagadda wrote:
> > From: Shardar Shariff Md <smohammed@nvidia.com>
> >
> > Set maximum number of UART ports to 8 as older chips have 7 ports=20
> > and
> > Tergra194 and later chips will have 8 ports. Add this info to chip=20
> > data and register uart driver in platform driver probe.
> >
> > Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> > Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> > ---
> >  drivers/tty/serial/serial-tegra.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/tty/serial/serial-tegra.c
> > b/drivers/tty/serial/serial-tegra.c
> > index e0379d9..329923c 100644
> > --- a/drivers/tty/serial/serial-tegra.c
> > +++ b/drivers/tty/serial/serial-tegra.c
> > @@ -62,7 +62,7 @@
> >  #define TEGRA_UART_TX_TRIG_4B			0x20
> >  #define TEGRA_UART_TX_TRIG_1B			0x30
> >
> > -#define TEGRA_UART_MAXIMUM			5
> > +#define TEGRA_UART_MAXIMUM			8
> >
> >  /* Default UART setting when started: 115200 no parity, stop, 8 data b=
its */
> >  #define TEGRA_UART_DEFAULT_BAUD			115200
> > @@ -87,6 +87,7 @@ struct tegra_uart_chip_data {
> >  	bool	allow_txfifo_reset_fifo_mode;
> >  	bool	support_clk_src_div;
> >  	bool	fifo_mode_enable_status;
> > +	int	uart_max_port;
> >  };
> >
> >  struct tegra_uart_port {
> > @@ -1323,6 +1324,7 @@ static struct tegra_uart_chip_data
> tegra20_uart_chip_data =3D {
> >  	.allow_txfifo_reset_fifo_mode	=3D true,
> >  	.support_clk_src_div		=3D false,
> >  	.fifo_mode_enable_status	=3D false,
> > +	.uart_max_port			=3D 5,
> >  };
> >
> >  static struct tegra_uart_chip_data tegra30_uart_chip_data =3D { @@
> > -1330,6 +1332,7 @@ static struct tegra_uart_chip_data
> tegra30_uart_chip_data =3D {
> >  	.allow_txfifo_reset_fifo_mode	=3D false,
> >  	.support_clk_src_div		=3D true,
> >  	.fifo_mode_enable_status	=3D false,
> > +	.uart_max_port			=3D 5,
> >  };
> >
> >  static struct tegra_uart_chip_data tegra186_uart_chip_data =3D { @@
> > -1337,6 +1340,7 @@ static struct tegra_uart_chip_data
> tegra186_uart_chip_data =3D {
> >  	.allow_txfifo_reset_fifo_mode	=3D false,
> >  	.support_clk_src_div		=3D true,
> >  	.fifo_mode_enable_status	=3D true,
> > +	.uart_max_port			=3D 5,
>=20
> You say in the commit message that the older chips have 7 ports, but=20
> here you say they have 5. Which one is it?
>=20
> >  };
> >
> >  static const struct of_device_id tegra_uart_of_match[] =3D { @@=20
> > -1386,6
> > +1390,7 @@ static int tegra_uart_probe(struct platform_device *pdev)
> >  	u->type =3D PORT_TEGRA;
> >  	u->fifosize =3D 32;
> >  	tup->cdata =3D cdata;
> > +	tegra_uart_driver.nr =3D cdata->uart_max_port;
> >
> >  	platform_set_drvdata(pdev, tup);
> >  	resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@
> > -1411,6 +1416,13 @@ static int tegra_uart_probe(struct=20
> > platform_device
> *pdev)
> >  		return PTR_ERR(tup->rst);
> >  	}
> >
> > +	ret =3D uart_register_driver(&tegra_uart_driver);
> > +	if (ret < 0) {
> > +		pr_err("Could not register %s driver\n",
> > +		       tegra_uart_driver.driver_name);
> > +		return ret;
> > +	}
>=20
> I don't think this is the right place for this. You're going to try to=20
> register the driver once for each instance of the Tegra UART that will be=
 probed.
>=20
> I'm surprised that this works at all because there's a BUG_ON() early=20
> in
> uart_register_driver() that checks for the existence of drv->state,=20
> which means that the second instance of tegra_uart_probe() should=20
> trigger that and cause the kernel to crash.
>=20
> I think it's better to either create an additional of_device_id table=20
> that is used to match on the top-level node's compatible string and=20
> which only contains the maximum number of ports for the given SoC, or=20
> you could add code to
> tegra_uart_init() that counts the number of ports that do match and=20
> initialize tegra_uart_driver.nr using that number. It would something lik=
e this:
>=20
> 	unsigned int count =3D 0;
>=20
> 	for_each_matching_node(np, &tegra_uart_of_match)
> 		count++;
>=20
> 	tegra_uart_driver.nr =3D count;
>=20
> You could also add additional checks in the loop, perhaps something
> like:
>=20
> 	for_each_matching_node(np, &tegra_uart_of_match)
> 		if (of_device_is_available(np))
> 			count++
>=20
> Though that would prevent any UARTs from getting added via dynamic=20
> device tree manipulation.
>=20
> Thierry
>=20
Multiple port entries does result in failures which I missed. I will fix th=
is
as suggested.
KY
> > +
> >  	u->iotype =3D UPIO_MEM32;
> >  	ret =3D platform_get_irq(pdev, 0);
> >  	if (ret < 0) {
> > @@ -1472,13 +1484,6 @@ static int __init tegra_uart_init(void)  {
> >  	int ret;
> >
> > -	ret =3D uart_register_driver(&tegra_uart_driver);
> > -	if (ret < 0) {
> > -		pr_err("Could not register %s driver\n",
> > -			tegra_uart_driver.driver_name);
> > -		return ret;
> > -	}
> > -
> >  	ret =3D platform_driver_register(&tegra_uart_platform_driver);
> >  	if (ret < 0) {
> >  		pr_err("Uart platform driver register failed, e =3D %d\n", ret);
> > --
> > 2.7.4
> >
