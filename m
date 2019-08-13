From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 09/14] serial: tegra: set maximum num of uart ports to 8
Date: Tue, 13 Aug 2019 12:19:55 +0200
Message-ID: <20190813101955.GN1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6yHiY5vv/BiPjcMt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565609303-27000-10-git-send-email-kyarlagadda@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com, jslaby@suse.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Shardar Shariff Md <smohammed@nvidia.com>
List-Id: linux-serial@vger.kernel.org


--6yHiY5vv/BiPjcMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:18PM +0530, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
>=20
> Set maximum number of UART ports to 8 as older chips have 7 ports and
> Tergra194 and later chips will have 8 ports. Add this info to chip data
> and register uart driver in platform driver probe.
>=20
> Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/seria=
l-tegra.c
> index e0379d9..329923c 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -62,7 +62,7 @@
>  #define TEGRA_UART_TX_TRIG_4B			0x20
>  #define TEGRA_UART_TX_TRIG_1B			0x30
> =20
> -#define TEGRA_UART_MAXIMUM			5
> +#define TEGRA_UART_MAXIMUM			8
> =20
>  /* Default UART setting when started: 115200 no parity, stop, 8 data bit=
s */
>  #define TEGRA_UART_DEFAULT_BAUD			115200
> @@ -87,6 +87,7 @@ struct tegra_uart_chip_data {
>  	bool	allow_txfifo_reset_fifo_mode;
>  	bool	support_clk_src_div;
>  	bool	fifo_mode_enable_status;
> +	int	uart_max_port;
>  };
> =20
>  struct tegra_uart_port {
> @@ -1323,6 +1324,7 @@ static struct tegra_uart_chip_data tegra20_uart_chi=
p_data =3D {
>  	.allow_txfifo_reset_fifo_mode	=3D true,
>  	.support_clk_src_div		=3D false,
>  	.fifo_mode_enable_status	=3D false,
> +	.uart_max_port			=3D 5,
>  };
> =20
>  static struct tegra_uart_chip_data tegra30_uart_chip_data =3D {
> @@ -1330,6 +1332,7 @@ static struct tegra_uart_chip_data tegra30_uart_chi=
p_data =3D {
>  	.allow_txfifo_reset_fifo_mode	=3D false,
>  	.support_clk_src_div		=3D true,
>  	.fifo_mode_enable_status	=3D false,
> +	.uart_max_port			=3D 5,
>  };
> =20
>  static struct tegra_uart_chip_data tegra186_uart_chip_data =3D {
> @@ -1337,6 +1340,7 @@ static struct tegra_uart_chip_data tegra186_uart_ch=
ip_data =3D {
>  	.allow_txfifo_reset_fifo_mode	=3D false,
>  	.support_clk_src_div		=3D true,
>  	.fifo_mode_enable_status	=3D true,
> +	.uart_max_port			=3D 5,

You say in the commit message that the older chips have 7 ports, but
here you say they have 5. Which one is it?

>  };
> =20
>  static const struct of_device_id tegra_uart_of_match[] =3D {
> @@ -1386,6 +1390,7 @@ static int tegra_uart_probe(struct platform_device =
*pdev)
>  	u->type =3D PORT_TEGRA;
>  	u->fifosize =3D 32;
>  	tup->cdata =3D cdata;
> +	tegra_uart_driver.nr =3D cdata->uart_max_port;
> =20
>  	platform_set_drvdata(pdev, tup);
>  	resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1411,6 +1416,13 @@ static int tegra_uart_probe(struct platform_device=
 *pdev)
>  		return PTR_ERR(tup->rst);
>  	}
> =20
> +	ret =3D uart_register_driver(&tegra_uart_driver);
> +	if (ret < 0) {
> +		pr_err("Could not register %s driver\n",
> +		       tegra_uart_driver.driver_name);
> +		return ret;
> +	}

I don't think this is the right place for this. You're going to try to
register the driver once for each instance of the Tegra UART that will
be probed.

I'm surprised that this works at all because there's a BUG_ON() early
in uart_register_driver() that checks for the existence of drv->state,
which means that the second instance of tegra_uart_probe() should
trigger that and cause the kernel to crash.

I think it's better to either create an additional of_device_id table
that is used to match on the top-level node's compatible string and
which only contains the maximum number of ports for the given SoC, or
you could add code to tegra_uart_init() that counts the number of ports
that do match and initialize tegra_uart_driver.nr using that number. It
would something like this:

	unsigned int count =3D 0;

	for_each_matching_node(np, &tegra_uart_of_match)
		count++;

	tegra_uart_driver.nr =3D count;

You could also add additional checks in the loop, perhaps something
like:

	for_each_matching_node(np, &tegra_uart_of_match)
		if (of_device_is_available(np))
			count++

Though that would prevent any UARTs from getting added via dynamic
device tree manipulation.

Thierry

> +
>  	u->iotype =3D UPIO_MEM32;
>  	ret =3D platform_get_irq(pdev, 0);
>  	if (ret < 0) {
> @@ -1472,13 +1484,6 @@ static int __init tegra_uart_init(void)
>  {
>  	int ret;
> =20
> -	ret =3D uart_register_driver(&tegra_uart_driver);
> -	if (ret < 0) {
> -		pr_err("Could not register %s driver\n",
> -			tegra_uart_driver.driver_name);
> -		return ret;
> -	}
> -
>  	ret =3D platform_driver_register(&tegra_uart_platform_driver);
>  	if (ret < 0) {
>  		pr_err("Uart platform driver register failed, e =3D %d\n", ret);
> --=20
> 2.7.4
>=20

--6yHiY5vv/BiPjcMt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1SjsgACgkQ3SOs138+
s6GqXg/+NqGJwKhw2nj6tpNZg3ykfwbqXlLcPpA/uRSgYEWHoS/NVI2dGYI3/oOn
opBCKPAvPtvc9SeStwOuFK/qW5Ltn+yI3l+2wboMdMKJq04gNiSUs6CbBo17htAg
V+L/FDBa+W4dJ/tfBtjW75AW0eBN98MPbrS058dNCLH/W62wVFpMQqaMTqOZo8ib
u0Xxk056X9Lzd287Btm0YHY7s/kpF4wsRC6KZoV6cARjStgfYK4h9lVrgOau7CeM
yoJWC9wuWvCYeC7C3b+zEhrVNHrAh5V09k/ywnTeV8/lbbPjmCP0fL4Q4tMFixow
RFY9ij6JjcywcV1a0ig/EIjRlrMQLMmYXnnt8Q2F8qDpDezKEMk3yaaPNku6x/Vm
JNiX9k+arX1NBAdvbtfYiXqWGI7cIhNCVybNL78fP8oS8wUQe+is1pmUksABvQR+
10Z6qVbq8KXaUI9Icv4nq24RRHZlD9mbUvdocQ56k7ttwg6xGQkjGbPYg6pAf87D
RwnOByaLOiOVa9XZ0yVGRLNMVKHiCvio3V0QX6d5Krsfg7JvcprJTvijcKWawZLb
WtqBIGWiEUDi83+S8+ikjrMo/kvwhkOfpo+TQ7+mJfC8LdibuJTrQgTfbe+8mwVP
v/p+/oXl/TuET8yQZl6en1xTLk+FVV5X+Deoh4rK6lBp7Wf9aDM=
=GSjq
-----END PGP SIGNATURE-----

--6yHiY5vv/BiPjcMt--
