From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] serial: 8250_dw: add ability to handle the peripheral clock
Date: Wed, 02 Jul 2014 11:32:25 +0200
Message-ID: <1678206.c13HhIevJ5@diego>
References: <3755576.qE86Ikox0a@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:35536 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbaGBJbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jul 2014 05:31:10 -0400
In-Reply-To: <3755576.qE86Ikox0a@diego>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Am Montag, 16. Juni 2014, 15:25:17 schrieb Heiko St=FCbner:
> First try to find the named clock variants then fall back to the alre=
ady
> existing handling of a nameless declared baudclk.
>=20
> This also adds the missing documentation for this already existing va=
riant.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

any comments?


Thanks
Heiko


> ---
>  .../bindings/serial/snps-dw-apb-uart.txt           | 31
> ++++++++++++++++++++++ drivers/tty/serial/8250/8250_dw.c             =
     |
> 31 +++++++++++++++++++--- 2 files changed, 59 insertions(+), 3 deleti=
ons(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uar=
t.txt
> b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt index
> f13f1c5..3601399 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
> @@ -4,7 +4,15 @@ Required properties:
>  - compatible : "snps,dw-apb-uart"
>  - reg : offset and length of the register set for the device.
>  - interrupts : should contain uart interrupt.
> +
> +Clock handling:
> +The clock rate of the input clock needs to be supplied by one of
>  - clock-frequency : the input clock frequency for the UART.
> +- clocks : phandle to the input clock
> +
> +The supplying peripheral clock can also be handled, needing a second
> property +- clock-names: tuple listing input clock names.
> +	Required elements: "baudclk", "apb_pclk"
>=20
>  Optional properties:
>  - reg-shift : quantity to shift the register offsets by.  If this pr=
operty
> is @@ -23,3 +31,26 @@ Example:
>  		reg-shift =3D <2>;
>  		reg-io-width =3D <4>;
>  	};
> +
> +Example with one clock:
> +
> +	uart@80230000 {
> +		compatible =3D "snps,dw-apb-uart";
> +		reg =3D <0x80230000 0x100>;
> +		clocks =3D <&baudclk>;
> +		interrupts =3D <10>;
> +		reg-shift =3D <2>;
> +		reg-io-width =3D <4>;
> +	};
> +
> +Example with two clocks:
> +
> +	uart@80230000 {
> +		compatible =3D "snps,dw-apb-uart";
> +		reg =3D <0x80230000 0x100>;
> +		clocks =3D <&baudclk>, <&apb_pclk>;
> +		clock-names =3D "baudclk", "apb_pclk";
> +		interrupts =3D <10>;
> +		reg-shift =3D <2>;
> +		reg-io-width =3D <4>;
> +	};
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c index 51b307a..024cd58 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -59,6 +59,7 @@ struct dw8250_data {
>  	int			last_mcr;
>  	int			line;
>  	struct clk		*clk;
> +	struct clk		*pclk;
>  	struct uart_8250_dma	dma;
>  };
>=20
> @@ -402,10 +403,25 @@ static int dw8250_probe(struct platform_device =
*pdev)
>  		return -ENOMEM;
>=20
>  	data->usr_reg =3D DW_UART_USR;
> -	data->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	data->clk =3D devm_clk_get(&pdev->dev, "baudclk");
> +	if (IS_ERR(data->clk))
> +		data->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (!IS_ERR(data->clk)) {
> -		clk_prepare_enable(data->clk);
> -		uart.port.uartclk =3D clk_get_rate(data->clk);
> +		err =3D clk_prepare_enable(data->clk);
> +		if (err)
> +			dev_warn(&pdev->dev, "could not enable optional baudclk: %d\n",
> +				 err);
> +		else
> +			uart.port.uartclk =3D clk_get_rate(data->clk);
> +	}
> +
> +	data->pclk =3D devm_clk_get(&pdev->dev, "apb_pclk");
> +	if (!IS_ERR(data->pclk)) {
> +		err =3D clk_prepare_enable(data->pclk);
> +		if (err) {
> +			dev_err(&pdev->dev, "could not enable apb_pclk\n");
> +			return err;
> +		}
>  	}
>=20
>  	data->dma.rx_chan_id =3D -1;
> @@ -451,6 +467,9 @@ static int dw8250_remove(struct platform_device *=
pdev)
>=20
>  	serial8250_unregister_port(data->line);
>=20
> +	if (!IS_ERR(data->pclk))
> +		clk_disable_unprepare(data->pclk);
> +
>  	if (!IS_ERR(data->clk))
>  		clk_disable_unprepare(data->clk);
>=20
> @@ -488,6 +507,9 @@ static int dw8250_runtime_suspend(struct device *=
dev)
>  	if (!IS_ERR(data->clk))
>  		clk_disable_unprepare(data->clk);
>=20
> +	if (!IS_ERR(data->pclk))
> +		clk_disable_unprepare(data->pclk);
> +
>  	return 0;
>  }
>=20
> @@ -495,6 +517,9 @@ static int dw8250_runtime_resume(struct device *d=
ev)
>  {
>  	struct dw8250_data *data =3D dev_get_drvdata(dev);
>=20
> +	if (!IS_ERR(data->pclk))
> +		clk_prepare_enable(data->pclk);
> +
>  	if (!IS_ERR(data->clk))
>  		clk_prepare_enable(data->clk);

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
