From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/6] serial: 8250_dw: add support for clocks property
 when using DeviceTree
Date: Fri, 15 Mar 2013 20:48:09 +0100
Message-ID: <51437AF9.2050007@free-electrons.com>
References: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com> <1362694460-1919-2-git-send-email-maxime.ripard@free-electrons.com> <20130315125615.GA27560@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56601 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab3COTsM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Mar 2013 15:48:12 -0400
In-Reply-To: <20130315125615.GA27560@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kevin@allwinnertech.com, sunny@allwinnertech.com, shuge@allwinnertech.com, =?ISO-8859-1?Q?Emilio_?= =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Heikki

Le 15/03/2013 13:56, Heikki Krogerus a =E9crit :
>> @@ -137,8 +140,15 @@ static int dw8250_probe_of(struct uart_port *p)
>>  		p->regshift =3D val;
>> =20
>>  	if (of_property_read_u32(np, "clock-frequency", &val)) {
>> -		dev_err(p->dev, "no clock-frequency property set\n");
>> -		return -EINVAL;
>> +		/* Get clk rate through clk driver if present */
>> +		data->clk =3D clk_get(p->dev, NULL);
>> +		if (IS_ERR(data->clk)) {
>> +			dev_err(p->dev, "clk or clock-frequency not defined\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		clk_prepare_enable(data->clk);
>> +		val =3D clk_get_rate(data->clk);
>=20
> Don't get the clk here..
>=20
>>  	}
>>  	p->uartclk =3D val;
>> =20
>> @@ -300,6 +310,12 @@ static int dw8250_probe(struct platform_device =
*pdev)
>=20
> Get it here so it is then handled for also others besides DT users.
> And prefer devm_clk_get(). Something like this:
>=20
>         ...
>         uart.port.membase =3D ioremap(regs->start, resource_size(regs=
));
>         if (!uart.port.membase)
>                 return -ENOMEM;
>=20
> +       data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +       	return -ENOMEM;
> +       =20
> +       data->clk =3D devm_clk_get(&pdev->dev, NULL);
> +       clk_prepare_enable(data->clk);
> +
>         uart.port.iotype =3D UPIO_MEM;
>         uart.port.serial_in =3D dw8250_serial_in;
>         uart.port.serial_out =3D dw8250_serial_out;
> +       uart.port.private_data =3D data;
> +       uart.port.uartclk =3D clk_get_rate(data->clk);
>=20
>   	dw8250_setup_port(&uart);
>         ...=20
>=20
> Then in dw8250_probe_of() you need to use the "clock-frequency"
> property only when p->uartclk is 0.

Thanks for your feedback.
Emilio made a new version of this patch, I'll send it soon.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
